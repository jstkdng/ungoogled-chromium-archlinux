#!/bin/bash
tail -F /tmp/distccd.log&
go run server.go
