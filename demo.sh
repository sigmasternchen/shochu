#!/bin/bash

. base.sh

route GET / index
index() {
	endHeaders

	echo "Hello World"
}

route GET /foo foobar
foobar() {
	status 417
	endHeaders

	echo "bar"
}

route GET /debug debug
debug() {
	endHeaders

	echo "$pathInfo"
	set
}

router
