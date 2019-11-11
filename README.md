# Shows on-demand Main service

## Overview
Shows on Demand is a SaaS POC that serves video shows on demand by using a Web client that provides user access to available shows. By using the Web Client user can register into the service and what a series of available shows on demand.
 
The service is composed of various services that are described below. These services have been developed in Python3 using Flask and Postgres as the storage engine at the moment of this writing but the technology is also dependent on the Could Platform selected. Notice that at the moment only the backend services are the one existing the POC but the service is composed for various backend and web client services which are described below. All backend service exposes a REST API to interact with the functionality and resources that they expose.
 
The Shows on Demand relies heavily on an architecture similar to [Video on Demand on AWS](https://aws.amazon.com/solutions/video-on-demand-on-aws/) in order to convert into stream ready video shows and make the videos available for on-demand consumption. Despite, not being a key feature for the POC in the document are few parts that cover the idea of using a "Video On Demand architecture".

For more details Read the POC [High Level Design](docs/hld.md).

## Local Setup

In order to locally run the service the repositories should be cloned in your local environment in the same location and once cloned change to the shows-on-demand-main project and run the docker-compose up --build command to run the service.

### Dependencies
* Python 3.6.x
* Postgres
* Docker 19.03.4

### Running the service

```bash
$ git clone https://github.com/guidocecilio/shows-on-demand-main.git
$ git clone https://github.com/guidocecilio/shows-on-demand-admin.git
$ git clone https://github.com/guidocecilio/shows-on-demand-users.git
$ cd shows-on-demand-main
$ docker-compose up --build
``` 

## Devel
The current microservice template has been taken from the [Flask Microservices](https://github.com/testdrivenio/flask-microservices-main) template and still a work on progress.
At the moment the Show on-demand POC works in local dev using `docker-compose up`.

This repository covers:
* The local development deployment using `docker-compose up` (Implemented)
* CI\CD setup with Travis (In progress)
* Deployment to AWS using EC2 with CludFormation (In progress)
* E2E Integration test to ensure the whole sercvice work as expected (Each microservice should be functional to be implemented)

Once the containers are deployed and running the APIs can be checked by visiting
the following URLs:
* http://localhost:3032/api-docs/ Shows REST API
* http://localhost:3033/api-docs/ Auth and Users REST API

## Future considerations
The POC is being developed to be deployed on AWS EC2 but also considering 
deployments unsing:
* Amazone Elastic Kubernetes (EKS)
* Microsoft Azure
* Google Compute Engine
* Google Container Engine (Kubernetes)
* Digital Ocean
* Heroku