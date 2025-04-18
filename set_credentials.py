import json
import os

def load_credentials(file_path):
    with open(file_path, 'r') as file:
        return json.load(file)

def main():
    credentials = load_credentials('./keys/credentials.json')
    print(f"export ARM_CLIENT_ID='{credentials['appId']}'")
    print(f"export ARM_CLIENT_SECRET='{credentials['password']}'")
    print(f"export ARM_TENANT_ID='{credentials['tenant']}'")
    print(f"export ARM_SUBSCRIPTION_ID='{credentials['subscription']}'")
    print("export RES_GROUP=dtcdezca-rg")
    print("export ACCT_NAME=dtcdezca-nosql")
    print("export DOC_ENDPOINT='https://dtcdezca-nosql-eastus.documents.azure.com:443/'")

if __name__ == "__main__":
    main()