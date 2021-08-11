#!/usr/bin/env sh
set -e

if [ $MYSQL_ADDR ] && [ $MYSQL_DB ] && [ $MYSQL_USER ] && [ $MYSQL_PASSWORD ]; then
  echo "MYSQL_ADDR: ${MYSQL_ADDR}"
  echo "MYSQL_USER: ${MYSQL_USER}"
  export MYSQL_DSN="${MYSQL_USER}:${MYSQL_PASSWORD}@tcp(${MYSQL_ADDR})/${MYSQL_DB}"
fi

if [ $RABBIT_ADDR ] && [ $RABBIT_USER ] && [ $RABBIT_PASSWORD ]; then
  echo "RABBIT_ADDR: ${RABBIT_ADDR}"
  echo "RABBIT_USER: ${RABBIT_USER}"
  export RABBIT_URL="amqp://${RABBIT_USER}:${RABBIT_PASSWORD}@${RABBIT_ADDR}"
fi

exec "$@"
