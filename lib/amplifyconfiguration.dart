const amplifyconfig = '''{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "pandacustomersmaster": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://fvdfhzv5snhn7eo62xzyz6ytgi.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-tvp27jdvtnbr7avnnzfrvfcxe4"
                }
            }
        }
    }
}''';


/*
  '''{ "API":{
  "aws_appsync_region": "us-east-1",
  "aws_appsync_graphqlEndpoint": "https://fvdfhzv5snhn7eo62xzyz6ytgi.appsync-api.us-east-1.amazonaws.com/graphql",
  "aws_appsync_authenticationType": "API_KEY", 
  "aws_appsync_apiKey": "da2-tvp27jdvtnbr7avnnzfrvfcxe4"
  }
}''';

*/

/*{
  aws_appsync_region: 'us-east-1', // (optional) - AWS AppSync region
  aws_appsync_graphqlEndpoint:
    'https://<app-id>.appsync-api.<region>.amazonaws.com/graphql', // (optional) - AWS AppSync endpoint
  aws_appsync_authenticationType: 'AMAZON_COGNITO_USER_POOLS', // (optional) - Primary AWS AppSync authentication type
  graphql_endpoint: 'https://www.yourdomain.com/graphql', // (optional) - Custom GraphQL endpoint
  aws_appsync_apiKey: 'da2-xxxxxxxxxxxxxxxxxxxxxxxxxx', // (optional) - AWS AppSync API Key
  graphql_endpoint_iam_region: 'us-east-1' // (optional) - Custom IAM region
}*/