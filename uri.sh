#!/bin/bash

urldecode() {
	: "${*//+/ }"
	echo -e "${_//%/\\x}"
}

_query() {
	tr '&' '\n' | grep -e "^$1=" | cut -d= -f2 | while read d; do
		urldecode "$d"
	done
}

queryString() {
	echo "$QUERY_STRING" | _query "$1"
}

_formData=""

cacheFormData() {
	if test -z "$_formData"; then
		_formData="$(cat)"
	fi
}

formData() {
	if test -z "$_formData"; then
		_formData="$(cat)"
	fi

	echo "$_formData" | _query "$1"
}

pathInfo=$(echo "$REQUEST_URI" | cut -d? -f1)
