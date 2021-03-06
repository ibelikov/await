#!/usr/bin/env bats
@test "successful redis connection" {
	run await redis://redis
	[ $status -eq 0 ]

	run await -r 1 redis://redis
	[ $status -eq 0 ]

	run await -i 0.5 redis://redis
	[ $status -eq 0 ]

	run await -r 1 -i 0.5 redis://redis
	[ $status -eq 0 ]

	run await -r 1 -i 0.5 redis://redis -- -t 1
	[ $status -eq 0 ]

	run await -r 1 -i 0.5 redis://redis -- --timeout 1
	[ $status -eq 0 ]
}

@test "unsuccessful redis connection" {
	run await -r 2 redis://unknown
	[ $status -eq 2 ]
}

@test "successful mongodb connection" {
	run await mongodb://mongodb
	[ $status -eq 0 ]

	run await -r 1 mongodb://mongodb
	[ $status -eq 0 ]

	run await -i 0.5 mongodb://mongodb
	[ $status -eq 0 ]

	run await -r 1 -i 0.5 mongodb://mongodb
	[ $status -eq 0 ]

	run await -r 1 -i 0.5 mongodb://mongodb -- -t 1
	[ $status -eq 0 ]

	run await mongodb://mongodb -- -t 1
	[ $status -eq 0 ]

	run await mongodb://mongodb -- --timeout 1
	[ $status -eq 0 ]
}

@test "unsuccessful mongodb connection" {
	run await -r 2 mongodb://unknown
	[ $status -eq 2 ]
}

@test "successful http connection" {
	run await http://http
	[ $status -eq 0 ]

	run await -r 5 http://http
	[ $status -eq 0 ]

	run await -i 0.5 http://http
	[ $status -eq 0 ]

	run await -r 5 -i 0.5 http://http
	[ $status -eq 0 ]

	run await -- http://http -m 5
	[ $status -eq 0 ]

	run await -r 2 -i 0.5 -- http://http -m 5
	[ $status -eq 0 ]
}

@test "unsuccessful http connection" {
	run await -r 2 http://unknown
	[ $status -eq 2 ]
}

@test "successful dynamodb connection" {
	run await dynamodb://dynamodb:8000
	[ $status -eq 0 ]

	run await -r 2 dynamodb://dynamodb:8000
	[ $status -eq 0 ]

	run await -i 0.5 dynamodb://dynamodb:8000
	[ $status -eq 0 ]

	run await -r 2 -i 0.5 dynamodb://dynamodb:8000
	[ $status -eq 0 ]

	run await -r 2 -i 0.5 dynamodb://dynamodb:8000 -- -t 1
	[ $status -eq 0 ]

	run await dynamodb://dynamodb:8000 -- -t 1
	[ $status -eq 0 ]

	run await dynamodb://dynamodb:8000 -- --timeout 1
	[ $status -eq 0 ]
}

@test "unsuccessful dynamodb connection" {
	run await -r 2 dynamodb://unknown:8000
	[ $status -eq 2 ]
}

@test "successful mysql connection" {
	run await mysql://root:secret@mysql:3306
	[ $status -eq 0 ]

	run await -r 5 mysql://root:secret@mysql:3306
	[ $status -eq 0 ]

	run await  -i 0.5 mysql://root:secret@mysql:3306
	[ $status -eq 0 ]

	run await -r 5 -i 0.5 mysql://root:secret@mysql:3306
	[ $status -eq 0 ]

	run await -r 5 -i 0.5 mysql://root:secret@mysql:3306 -- -t 1
	[ $status -eq 0 ]

	run await mysql://root:secret@mysql:3306 -- -t 1
	[ $status -eq 0 ]

	run await mysql://root:secret@mysql:3306 -- --timeout 1
	[ $status -eq 0 ]
}

@test "unsuccessful mysql" {
	run await -r 1 mysql://unknown
	[ $status -eq 2 ]
}

<<<<<<< HEAD
@test "successful memcached connection" {
	run await memcached://memcached:11211
	[ $status -eq 0 ]

=======
@test "successful postgresql connection with retry" {
	run await -r 5 postgresql://postgres:secret@postgresql:5432
	[ $status -eq 0 ]
}

@test "unsuccessful postgresql connection with retry" {
	run await -r 1 postgresql://unknown
	[ $status -eq 1 ]
}

@test "successful memcached connection with retry" {
>>>>>>> 90db1c4... PostgreSQL support
	run await -r 2 memcached://memcached:11211
	[ $status -eq 0 ]

	run await -i 0.5 memcached://memcached:11211
	[ $status -eq 0 ]

	run await -r 2 -i 0.5 memcached://memcached:11211
	[ $status -eq 0 ]

	run await -r 2 -i 0.5 memcached://memcached:11211 -- -t 1
	[ $status -eq 0 ]

	run await memcached://memcached:11211 -- -t 1
	[ $status -eq 0 ]

	run await memcached://memcached:11211 -- --timeout 1
	[ $status -eq 0 ]
}

@test "unsuccessful memcached connection" {
	run await -r 2 memcached://unknown:11211
	[ $status -eq 2 ]
}

@test "successfull command" {
	run await cmd -- true
	[ $status -eq 0 ]

	run await -r 2 cmd -- true
	[ $status -eq 0 ]

	run await -i 2 cmd -- true
	[ $status -eq 0 ]

	run await -r 2 -i 1 cmd -- true
	[ $status -eq 0 ]
}

@test "unsuccessfull command with retry" {
	run await -r 2 cmd -- false
	[ $status -eq 2 ]
}

@test "cmd without a command" {
	run await cmd
	[ $status -eq 1 ]
	echo "${output}" | grep -Fi 'usage'

	run await cmd --
	[ $status -eq 1 ]
	echo "${output}" | grep -Fi 'usage'
}

@test "aws CLI is included in the image" {
	run aws --version
	[ $status -eq 0 ]
}
