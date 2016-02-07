#!/bin/bash

set -e

set_option() {
    sedEscapedValue="$(echo "$2" | sed 's/[\/&]/\\&/g')"
    sed -ri "s/^#?($1\s*=\s*)\S+/\1'$sedEscapedValue'/" "$PGDATA/postgresql.conf"
}


set_option 'wal_level' 'hot_standby'
set_option 'max_wal_senders' '5'
set_option 'wal_keep_segments' '10'

#WAL_ARCHIVE=$PGDATA/wal_archive
#mkdir -p $WAL_ARCHIVE
#set_option 'archive_mode' 'on'
#set_option 'archive_command' "test ! -f $WAL_ARCHIVE/%f && cp %p $WAL_ARCHIVE/%f"

gosu postgres psql --username postgres <<-EOSQL
	ALTER USER "$POSTGRES_USER" WITH REPLICATION;
EOSQL

if [ "$POSTGRES_PASSWORD" ]; then
    authMethod=md5
else
    authMethod=trust
fi

{ echo; echo "host replication $POSTGRES_USER 0.0.0.0/0 $authMethod"; } >> "$PGDATA/pg_hba.conf"

