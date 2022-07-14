# **Docker Compose CI** ##

This reusable workflow is intended to generically handle continuous integration (CI) for dockerized applications. \
It does so by running the following steps:
- Checking out the respository from which the remote workflow is called
- Logging in to AWS so we can utilize the AWS cli
- Deploying a new task definition & updating our service to serve the new task definition

## **Variables & Sercrets** ##

**Variables**:
- aws_region: The region our cluster is deployed in. Something along the lines of "eu-north-1"
- cluster_name: The name of the ECS cluster we're deploying into
- service_name: The name of the ECS service we're deploying into
- task_definition_path: The ```<path>/<to>/task-definition.json``` file
 
**Secrets**:
- aws_access_key_id: The AWS api access key
- aws_secret_access_key: The AWS api access key secret


## **Demo pipeline** ##

```yaml
name: ecs-cd

on: [workflow_dispatch]

jobs:
  cd-demo:
    name: CD demo
    uses: Tsanton/templates/.github/workflows/ecs-cd.yaml@master
    with:
      aws_region: eu-north-1
      cluster_name: demo-cluster
      service_name: demo-python-api
      task_definition_path: ./task-definition.json
    secrets:
      aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

## **ToDo** ##

- Handle Canary Deployments (see terraform resource aws_lb_listener_rule.action.forward.target_group.weight)
    - Rebalancing weights
    - Comitting to deployment and deprovisioning old
        - Sidestep with parameter weight?
        - If reject run sidestep?
