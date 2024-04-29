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
    "blueprintId": "310d7ce0-02fe-4de5-8f02-d2658fd3689f",
    "blueprintRevision": "main"
  },
  "projectId": "6422fc97-70f0-4358-a24f-04ebde645a52",
  "name": "api workflow",
  "preventAutoDeploy": true,
  "workspaceName": ""
}
'
