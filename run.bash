#/bin/bash

helm template charts \
-f test-gce-rke.yaml \
--name-template demo --debug
