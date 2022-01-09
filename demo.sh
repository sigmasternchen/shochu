#!/bin/bash

. base.sh
. mysql.sh
. credentials.sh

connect "$mysqlHost" "$mysqlUser" "$mysqlPassword" "$mysqlDB"

route GET / index
index() {
	endHeaders

	echo "Users:"
	echo "SELECT * FROM users" | query | getColumns 2
}

route GET /debug debug
debug() {
	endHeaders

	echo "$pathInfo"
	set
}

router
