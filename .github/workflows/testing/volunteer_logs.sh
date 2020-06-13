#!/bin/bash
tail -F /tmp/distccd.log&
go run $GITHUB_WORKSPACE/.github/workflows/server.go
