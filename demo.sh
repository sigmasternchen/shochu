#!/bin/bash

. utils.sh
. uri.sh
. router.sh
. mysql.sh
. cookies.sh
. sessions.sh
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

route GET /session session
session() {
	startSession
	endHeaders
	
	value="$(queryString "val")"
	if test ! -z "$value"; then
		setSession "$value"
		echo "saved to session"
	else
		getSession
	fi
}

route GET /debug debug
debug() {
	endHeaders

	echo "$pathInfo"
	set
}

router
