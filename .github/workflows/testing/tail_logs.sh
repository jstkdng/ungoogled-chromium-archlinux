#!/bin/bash

tail -F logfile&
PID=$!

# wait for build to finish
while [ ! -f done_build ]
do
    sleep 2
done

kill -TERM $PID
