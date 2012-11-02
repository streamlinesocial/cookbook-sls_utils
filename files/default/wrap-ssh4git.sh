#!/usr/bin/env bash

/usr/bin/env ssh -o "StrictHostKeyChecking=no" -i "/srv/.ssh/id_deploy" $1 $2
