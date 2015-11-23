#!/bin/bash

cd /srv/bas-api

function setup_config() {
    echo "DATABASE = {"                         >  config.py
    echo "    'hostname': '${MYSQL_HOST}',"     >> config.py
    echo "    'database': '${MYSQL_DB}',"       >> config.py
    echo "    'port': ${MYSQL_PORT},"           >> config.py
    echo "    'username': '${MYSQL_USER}',"     >> config.py
    echo "    'password': '${MYSQL_PASS}',"     >> config.py
    echo "}"                                    >> config.py
}

# setup the config.py
echo "Ensure config file is correct..."
[ -f config.py ] || setup_config
echo "Done."

# make sure we have something to run
echo "Ensure wsgi file is correctly configured..."
[ -f bas-api.py ] || cp -a bas-api.wsgi.TEMPLATE bas-api.py
echo "Done."

# import schema only if db is empty
if [ $(mysql -Nr -h ${MYSQL_HOST} -P ${MYSQL_PORT} -u ${MYSQL_USER} -p${MYSQL_PASS} ${MYSQL_DB} -e 'show tables;' | wc -l) -le 6 ]; then
    echo "Warning! All tables will be wiped out!"
    echo "Starting in 10 seconds. Hit Ctrl+C to abort..."
    sleep 10
    mysql -h ${MYSQL_HOST} -P ${MYSQL_PORT} -u ${MYSQL_USER} -p${MYSQL_PASS} ${MYSQL_DB} < sql/schema.sql
    echo "Done. Database is initialized."
else
    echo "Database looks initialized already."
fi

# run updates
. /srv/bin/activate
echo "Running updates."
sh update-tenders.sh
sh update-contracts.sh
echo "Done."
