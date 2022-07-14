# **Docker Compose CI** ##

This reusable workflow is intended to generically handle continuous integration (CI) for dockerized applications. \
It does so by running the following steps:
- Docker registry login
- Docker compose build image
- Docker compose run tests (optional)
- Docker push

## **Variables & Sercrets** ##

**Variables**:
- compose_file: The path to the main compose file containing the "prod" definition of the service. Usually ```./docker-compose.yaml```
- run_test: A boolean to indicate if there are tests and if they should be run
- additional_compose_files: A literal block scalar with one or more additional compose files to utilize during tests
- test_service_name: The name of the test service to run
- tags: A literal block scalar with one or more tags to push to you repository
 
**Secrets**:
- docker_registry_uid: The username for the docker registry that we're targeting
- docker_registry_pwd: The password/PAT for the docker registry that we're targeting


## **Demo pipeline** ##

```yaml
name: demo-ci

on: [workflow_dispatch]


jobs:
  ci:
    name: Demo CI
    uses: Tsanton/templates/.github/workflows/compose-ci.yaml@master
    with:
      compose_file: ./docker-compose.yaml
      additional_compose_files: |
        ./docker-compose.testing.yaml
        ./docker-compose.ci-testing.yaml
      tags: |
        latest
        ${{ github.run_number }}
      run_test: true
      test_service_name: testsuite
    secrets:
      docker_registry_uid: ${{ secrets.docker_hub_registry_uid }}
      docker_registry_pwd: ${{ secrets.docker_hub_registry_pwd }}
```