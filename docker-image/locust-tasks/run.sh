#!/bin/bash

# Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


LOCUST_HOST="'https://firestore.googleapis.com/v1/projects/ellu---mobile-apps---develop/databases/(default)/documents'"
LOCUST_USERS='1'
LOCUST_SPAWN_RATE='1'
LOCUST="locust"
LOCUST_MODE=${LOCUST_MODE:-standalone}

if [[ "$LOCUST_MODE" = "master" ]]; then
    LOCUS_OPTS="-H=$LOCUST_HOST -u $LOCUST_USERS -r $LOCUST_SPAWN_RATE -f $1 --master"
elif [[ "$LOCUST_MODE" = "worker" ]]; then
    LOCUS_OPTS="-H=$LOCUST_HOST -u $LOCUST_USERS -r $LOCUST_SPAWN_RATE -f $1 --slave --master-host=$LOCUST_MASTER"
fi

echo "$LOCUST $LOCUS_OPTS"

cd locust-tasks/ellu-load-testing && $LOCUST $LOCUS_OPTS
