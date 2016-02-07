#!/bin/bash
set -e

set_option() {
    CONF_FILE=${3-postgresql.conf}
    sedEscapedValue="$(echo "$2" | sed 's/[\/&]/\\&/g')"
    sed -ri "s/^#?($1\s*=\s*)\S+/\1'$sedEscapedValue'/" "$PGDATA/$CONF_FILE"
}

if [ "$1" = 'postgres' ]; then
    # look specifically for PG_VERSION, as it is expected in the DB dir
    if [ -s "$PGDATA/PG_VERSION" ]; then
        rm -rf $PGDATA
    fi

    mkdir -p "$PGDATA"
    chmod 700 "$PGDATA"
    chown -R postgres "$PGDATA"

    chmod g+s /run/postgresql
    chown -R postgres /run/postgresql

    : ${POSTGRES_USER:=postgres}
    : ${POSTGRES_DB:=$POSTGRES_USER}
    export POSTGRES_USER POSTGRES_DB

    gosu postgres env PGPASSWORD=$POSTGRES_PASSWORD pg_basebackup -h $MASTER_HOST -p $MASTER_PORT -D $PGDATA -U $POSTGRES_USER -w -X stream
    set_option 'hot_standby' 'on'
    set_option 'wal_level' 'minimal'
    set_option 'max_wal_senders' '0'
    set_option 'wal_keep_segments' '0'
    cat > $PGDATA/recovery.conf <<-EOF
standby_mode = on
primary_conninfo = "host=$MASTER_HOST port=$MASTER_PORT user=$POSTGRES_USER password=$POSTGRES_PASSWORD"
EOF

    echo
    echo 'PostgreSQL slave init process complete; ready for start up.'
    echo

    exec gosu postgres "$@"
fi

exec "$@"
