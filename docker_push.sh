#!/bin/sh

if [ -z "$TRAVIS_PULL_REQUEST" ] || [ "$TRAVIS_PULL_REQUEST" == "false" ]
then

  if [ "$TRAVIS_BRANCH" == "development" ]
  then
    docker login -e $DOCKER_EMAIL -u $DOCKER_ID -p $DOCKER_PASSWORD
    export TAG=$TRAVIS_BRANCH
    export REPO=$DOCKER_ID
  fi

  if [ "$TRAVIS_BRANCH" == "staging" ] || \
     [ "$TRAVIS_BRANCH" == "production" ]
  then
    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
    unzip awscli-bundle.zip
    ./awscli-bundle/install -b ~/bin/aws
    export PATH=~/bin:$PATH
    # add AWS_ACCOUNT_ID, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY environment vars
    eval $(aws ecr get-login --region us-east-1)
    export TAG=$TRAVIS_BRANCH
    export REPO=$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
  fi

  if [ "$TRAVIS_BRANCH" == "staging" ]
  then
    export SECRET_KEY="my_precious"
  fi

  if [ "$TRAVIS_BRANCH" == "production" ]
  then
    export DATABASE_URL="$AWS_RDS_URI"
    export SECRET_KEY="$PRODUCTION_SECRET_KEY"
  fi

  if [ "$TRAVIS_BRANCH" == "development" ] || \
     [ "$TRAVIS_BRANCH" == "staging" ] || \
     [ "$TRAVIS_BRANCH" == "production" ]
  then
    # admin
    if [ "$TRAVIS_BRANCH" == "production" ]
    then
      docker build $USERS_REPO -t $USERS:$COMMIT -f Dockerfile-prod
    else
      docker build $USERS_REPO -t $USERS:$COMMIT
    fi
    docker tag $USERS:$COMMIT $REPO/$USERS:$TAG
    docker push $REPO/$USERS:$TAG
    # admin db
    docker build $USERS_DB_REPO -t $USERS_DB:$COMMIT
    docker tag $USERS_DB:$COMMIT $REPO/$USERS_DB:$TAG
    docker push $REPO/$USERS_DB:$TAG
  fi

fi