#!/bin/sh

if [ "$TRAVIS_BRANCH" == "development" ]; then
  docker login -e $DOCKER_EMAIL -u $DOCKER_ID -p $DOCKER_PASSWORD
  docker pull $DOCKER_ID/$USERS
  docker pull $DOCKER_ID/$USERS_DB
fi

docker-compose -f docker-compose-ci.yml up -d --build