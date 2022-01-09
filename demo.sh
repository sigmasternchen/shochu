#!/bin/bash

. utils.sh
. uri.sh
. router.sh
. mysql.sh
. credentials.sh
. shinden/engine.sh

connect "$mysqlHost" "$mysqlUser" "$mysqlPassword" "$mysqlDB"

route GET / index
index() {
	header "Content-Type" "text/html"
	endHeaders

	title="Test"
	users=($(echo "SELECT * FROM users" | query | getColumns 2))

	template "templates/demo.html.templ" ""
}



route GET /debug debug
debug() {
	endHeaders

	echo "$pathInfo"
	set
}

router
