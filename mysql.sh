#!/bin/bash

_mysqlHost=
_mysqlUser=
_mysqlPass=
_mysqlDB=

connect() {
	_mysqlHost="$1"
	_mysqlUser="$2"
	_mysqlPass="$3"
	_mysqlDB="$4"
}

_mysqlDo() {
	mysql -h "$_mysqlHost" -u "$_mysqlUser" -p"$_mysqlPass" -B "$_mysqlDB"
}

execute() {
	_mysqlDo > /dev/null
}

query() {
	_mysqlDo | tail -n +2
}

escape() {
	echo "$1" |
		sed 's/\\/\\\\/g' |
		sed "s/'/\\'/g" |
		sed 's/\"/\\\"/g' |
		sed 's/\n/\\n/g' |
		sed 's/\r/\\r/g' |
		sed 's/\t/\\t/g' |
		sed 's/\Z/\\Z/g' |
		sed 's/%/\\%/g' |
		sed 's/_/\\_/g'
}

getColumns() {
	cut -d$'\t' -f "$1"
}
