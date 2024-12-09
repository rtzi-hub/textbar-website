import json
import boto3
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('TextBarEntries')

def lambda_handler(event, context):
    # Scan the DynamoDB table
    response = table.scan()
    items = response.get('Items', [])

    # Parse the timestamp field and sort the items by it
    sorted_items = sorted(items, key=lambda x: datetime.strptime(x['timestamp'], '%H:%M %d.%m.%Y'), reverse=True)

    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps(sorted_items)
    }
