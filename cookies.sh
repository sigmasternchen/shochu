#!/bin/bash

getCookie() {
	key="$1"
	echo "$HTTP_COOKIE" | tr ';' $'\n' | grep -e "^$1=" | cut -d= -f2 | sed -r 's/\s*$//g' 
}

setCookie() {
	key="$1"
	value="$2"
	attributes="$3"
	header "Set-Cookie" "$key=$value; $attributes"
}
