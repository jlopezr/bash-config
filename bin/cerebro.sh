#!/usr/bin/env bash
docker run --rm -p 9000:9000 lmenezes/cerebro &
BACK_PID=$!
sleep 10
open "http://localhost:9000/#/overview?host=http:%2F%2Fhost.docker.internal:9200"
wait $BACK_PID
