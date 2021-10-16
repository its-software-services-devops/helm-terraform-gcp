#!/bin/bash

helm template ../charts \
-f test-static-only.yaml \
--name-template demo --debug
