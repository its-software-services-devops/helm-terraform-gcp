#!/bin/bash

helm template ../charts \
-f test-onprem-rke.yaml \
--name-template demo --debug
