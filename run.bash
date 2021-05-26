#/bin/bash

helm template charts \
-f test-vsphere-rke.yaml \
--name-template demo --debug
