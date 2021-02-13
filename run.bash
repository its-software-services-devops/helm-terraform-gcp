#/bin/bash

helm template charts \
-f test-value.yaml \
--name-template demo --debug
