#!/bin/bash

docker build --rm=true -t iide/datastore_img .
docker run -d --name datastore iide/datastore_img
