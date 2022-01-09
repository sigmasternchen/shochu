#!/bin/bash

_methods=()
_paths=()
_handlers=()
_routeNo=0
_404="_default404"

route() {
	_methods+=("$1")
	_paths+=("$2")
	_handlers+=("$3")
	_routeNo=$((_routeNo+1))
}

_default404() {
	status 404
	endHeaders
	echo "File not found"
}

_matchPaths() {
	actual="$1"
	search="$2"

	# TODO: add wildcards
	test "$actual" = "$search"
	return
}

router() {
	for ((i=0; i<$_routeNo; i++ )); do
		if test "${_methods[$i]}" != "$REQUEST_METHOD"; then
			continue
		fi
		if _matchPaths "$pathInfo" "${_paths[$i]}"; then
			"${_handlers[$i]}" # todo add arguments
			return
		fi
	done

	"$_404"
}
