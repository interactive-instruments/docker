#!/bin/bash

docker build --rm=true -t de.ii/datastore_img .
docker run -d --name datastore de.ii/datastore_img
