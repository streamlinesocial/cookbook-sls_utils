#!/usr/bin/env bash

/usr/bin/env ssh -o "StrictHostKeyChecking=no" -i "<%= @deploy_key_path %>" $1 $2
