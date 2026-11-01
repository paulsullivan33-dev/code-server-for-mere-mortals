#!/usr/bin/env bash
# check-server.sh — prove a code-server is up, that its login
# works, and that it will hand back a file you name.
#
# Usage:
#   ./check-server.sh BASE_URL PASSWORD FILE_PATH
# Example (the lab's own values):
#   ./check-server.sh http://127.0.0.1:18083 lab-fixture-password-42 /home/you/project/hello.py
#
# Exits 0 and prints OK lines as each check passes; exits 1 at
# the first failure, saying which check failed. Uses a throwaway
# cookie jar in the current directory (cookies-check.txt).
set -u
base="${1:?usage: check-server.sh BASE_URL PASSWORD FILE_PATH}"
password="${2:?usage: check-server.sh BASE_URL PASSWORD FILE_PATH}"
file_path="${3:?usage: check-server.sh BASE_URL PASSWORD FILE_PATH}"
jar="cookies-check.txt"

echo "1. health endpoint"
curl -s "$base/healthz" || { echo "FAIL: no answer from $base"; exit 1; }
echo

echo "2. the front door sends strangers to the login page"
code=$(curl -s -o /dev/null -w "%{http_code} %{redirect_url}" "$base/")
echo "   GET / -> $code"
case "$code" in *"/login") echo "   OK: redirected to login";; *) echo "FAIL: expected a redirect to /login"; exit 1;; esac

echo "3. sign in with the password"
code=$(curl -s -c "$jar" -o /dev/null -w "%{http_code}" -X POST -d "password=$password" "$base/login")
echo "   POST /login -> $code"
[ "$code" = "302" ] || { echo "FAIL: expected 302 after a good login (a wrong password gets 200)"; exit 1; }

echo "4. fetch a file through the session"
curl -s -b "$jar" "$base/vscode-remote-resource?path=$file_path" | head -3
echo "   OK if the lines above are the top of $file_path"
