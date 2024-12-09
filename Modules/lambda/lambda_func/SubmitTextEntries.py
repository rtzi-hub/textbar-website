import json
import boto3
from uuid import uuid4
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('TextBarEntries')

def lambda_handler(event, context):
    try:
        text = event.get('text', '').strip()
        if not text:
            return {
                "statusCode": 400,
                "body": "Text cannot be empty.",
                "headers": {
                    "Content-Type": "application/json"
                }
            }

        entry_id = str(uuid4())
        timestamp = datetime.utcnow().strftime("%H:%M %d.%m.%Y")

        table.put_item(Item={'id': entry_id, 'text': text, 'timestamp': timestamp})

        return {
            "statusCode": 201,
            "body": {
                "id": entry_id,
                "text": text,
                "timestamp": timestamp
            },
            "headers": {
                "Content-Type": "application/json"
            }
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": {
                "error": str(e)
            },
            "headers": {
                "Content-Type": "application/json"
            }
        }
