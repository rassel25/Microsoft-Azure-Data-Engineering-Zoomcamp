import json

def convert_jsonl_to_json(jsonl_file_path, json_file_path):
    # Open the JSONL file and read lines
    with open(jsonl_file_path, 'r') as file:
        jsonl_content = file.readlines()

    # Convert each line into a JSON object and add to a list
    json_content = [json.loads(line) for line in jsonl_content]

    # Write the list of JSON objects to a JSON file
    with open(json_file_path, 'w') as file:
        json.dump(json_content, file, indent=4)


jsonl_file_path = './datasets/yelp_academic_dataset_business.json'
json_file_path = './datasets/business.json'

convert_jsonl_to_json(jsonl_file_path, json_file_path)