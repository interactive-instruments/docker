#!/bin/bash

docker run --volumes-from datastore --name basex-server -d -p 41984:1984 de.ii/basex-server_img
