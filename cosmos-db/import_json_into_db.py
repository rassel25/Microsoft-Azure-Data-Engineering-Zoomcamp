import sys
from azure.cosmos import CosmosClient, PartitionKey, exceptions
import json
from tqdm import tqdm

# Constants for database and JSON files
DATABASE_ID = 'yelp'
REVIEW_JSON = './datasets/yelp_academic_dataset_review.json'
TIP_JSON = './datasets/yelp_academic_dataset_tip.json'
CHECKIN_JSON = './datasets/yelp_academic_dataset_checkin.json'

def create_database(client, database_id):
    try:
        return client.create_database_if_not_exists(id=database_id)
    except exceptions.CosmosHttpResponseError as e:
        print(f'Error creating database: {e.message}')
        return None

def create_container(database, container_id, partition_key):
    try:
        return database.create_container_if_not_exists(
            id=container_id,
            partition_key=PartitionKey(path=partition_key),
            offer_throughput=400
        )
    except exceptions.CosmosHttpResponseError as e:
        print(f'Error creating container {container_id}: {e.message}')
        return None

def import_jsonl_data_into_db(container, jsonl_file_path, start_index=0, end_index=None):
    print(f'Importing data from {jsonl_file_path} starting from index {start_index} to index {end_index}')
    with open(jsonl_file_path, 'r') as file:
        total_lines = start_index - end_index
        file.seek(0)

        for _ in range(start_index):
            next(file)

        for i, line in tqdm(enumerate(file, start=start_index), total=(end_index - start_index), desc=f"Importing {jsonl_file_path}"):
            if end_index is not None and i >= end_index:
                break

            item = json.loads(line)
            item['id'] = f'item{i}'
            container.upsert_item(item)


def main():
    if len(sys.argv) != 6:
        print("Usage: python script.py <endpoint> <key> <review | tip | checkin> <start_index> <end_index>")
        sys.exit(1)

    endpoint = sys.argv[1]
    key = sys.argv[2]
    data_type = sys.argv[3]
    start_index = int(sys.argv[4])
    end_index = int(sys.argv[5]) or None

    client = CosmosClient(endpoint, {'masterKey': key})

    db = create_database(client, DATABASE_ID)
    if db is None:
        return

    containers_info = {
        'review': '/review_id',
        'tip': '/user_id',
        'checkin': '/business_id',
    }

    container = create_container(db, data_type, containers_info[data_type])
    if container is not None:
        json_file = f'./datasets/yelp_academic_dataset_{data_type}.json'
        import_jsonl_data_into_db(container, json_file, start_index, end_index)

if __name__ == '__main__':
    main()

# python3 import_json_into_db.py $ACCOUNT_URI $ACCOUNT_KEY review 0 100000