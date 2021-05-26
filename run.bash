#/bin/bash

helm template charts \
-f test-rke-config.yaml \
--set-string rkeConfig.cloud_provider.vsphereCloudProvider.virtual_center."d2p-aaavcen01\.tdmp-server\.local".user=sysen \
--set-string rkeConfig.cloud_provider.vsphereCloudProvider.virtual_center."d2p-aaavcen01\.tdmp-server\.local".password=xxxxx \
--name-template demo --debug
