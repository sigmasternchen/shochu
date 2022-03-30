#!/bin/bash

getCookie() {
	local key="$1"
	echo "$HTTP_COOKIE" | tr ';' $'\n' | grep -e "^$1=" | cut -d= -f2 | sed -r 's/\s*$//g' 
}

setCookie() {
	local key="$1"
	local value="$2"
	local attributes="$3"
	header "Set-Cookie" "$key=$value; $attributes"
}
