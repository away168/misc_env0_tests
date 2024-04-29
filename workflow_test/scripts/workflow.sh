set -x

curl --request POST \
    --url https://api.env0.com/environments \
    -u $ENV0_API_KEY:$ENV0_API_SECRET \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --data '
{
"configurationChanges": {
    "type": 0,
    "name": "PREFIX",
    "value": "foobar2024APR28"
},
"deployRequest": {
    "ttl": {
    "type": "INFINITE"
    },
    "deploymentType": "deploy",
    "blueprintId": "9e6d1c38-ada0-4922-acd0-aa83b372da65",
    "blueprintRevision": "main",
    "subEnvironments": {
    "vpc": {
        "revision": "",
        "workspaceName": "vpc-2025-apr-28-726pm",
        "configurationChanges":[
            {
                "type": 0,
                "name": "ENV0_TERRAFORM_CONFIG_FILE_PATH",
                "value": "vpc.tfvars"
            }
        ]
    },
    "eks": {
        "revision": "",
        "workspaceName": "eks-2025-apr-28-726pm",
        "configurationChanges":[{
            "type": 0,
            "name": "ENV0_TERRAFORM_CONFIG_FILE_PATH",
            "value": "eks.tfvars"
        }
        ]
    }
    }
},
"projectId": "6422fc97-70f0-4358-a24f-04ebde645a52",
"name": "api workflow apr28 727pm",
"preventAutoDeploy": true,
"workspaceName": "2025-apr-28-workflowapi726"
}
'
