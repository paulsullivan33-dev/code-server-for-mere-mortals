# Your First Login

**Outcome: a running server on a
loopback port, a signed-in session,
and three checks — the startup log,
the health endpoint and the login
itself — that each prove a different
part of it works.**

## The lab's config

The lab's config file, kept inside its
own folder (`code-server-lab/config.yaml`):

```yaml
bind-addr: 127.0.0.1:18083
auth: password
password: lab-fixture-password-42
cert: false
disable-telemetry: true
```

Five lines, each deliberate. The
address is loopback (`127.0.0.1`), so
nothing off the machine can reach it
yet — exposure is chapter 10's
decision, never an accident. The port
is the lab's to use. The password is a
throwaway fixture invented for the lab
and printed here on purpose; yours
should be neither throwaway nor
printed anywhere. `cert: false` says
plain HTTP, acceptable only because
loopback traffic never crosses a
network. And telemetry is off from the
start (chapter 9 explains the switches).

The lab also made a two-file fixture
workspace — `hello.py` and `notes.md`,
stock files invented for the purpose —
so the editor has something ordinary
to open.

## Starting it

```bash
./code-server --config ./config.yaml \
    --user-data-dir ./user-data \
    --extensions-dir ./extensions \
    ./workspace
```

The last argument is the folder to
open. The startup log (transcript
`t03`) is the first check — read it
the way this guide reads every receipt:

```text
info  code-server 4.144.0 ee31cdbe02c07b3ba718007f221d14c890696c61
info  Using user-data-dir /home/hatch/workspace/code-server-labwork/user-data
info  Using config file ./config.yaml
info  HTTP server listening on http://127.0.0.1:18083/
info    - Authentication is enabled
info      - Using password from ./config.yaml
info    - Not serving HTTPS
info  Session server listening on .../user-data/code-server-ipc.sock
```

Config file in use, address listening,
authentication enabled *and sourced
from that file*, HTTPS honestly
absent. If any line disagrees with the
config you wrote, the log — not the
config — is describing the server you
actually have.

## The health check that sounds broken

```bash
curl http://127.0.0.1:18083/healthz
```

```text
{"status":"expired","lastHeartbeat":0}
```

This looks like a failure and is not
one. `/healthz` answers whether a
client has checked in *recently*; a
fresh server has never had a client,
so it reports `expired` with a
heartbeat of zero — while still
returning HTTP 200, because the server
itself is fine. After the lab signed
in, the same address answered
`{"status":"alive","lastHeartbeat":...}`
(transcript `t05`). Read it as "how
long since anyone used this", not as
"is it up" — the HTTP 200 is the "is
it up".

## Strangers get the login page

```bash
curl -o /dev/null -w "%{http_code}" http://127.0.0.1:18083/
```

answers **302**, a redirect to
`/login`, and the login page itself
carries the title `code-server login`
and a *Welcome to code-server* heading
(transcript `t04`). Nothing of the
editor is served before signing in —
that redirect is the boundary working.

## Signing in, including doing it wrong

The login form accepts a POST of one
field, `password`, which a script can
do exactly as a browser does:

```bash
# the wrong password first, on purpose
curl -o /dev/null -w "%{http_code}" \
    -X POST -d "password=wrong-password" \
    http://127.0.0.1:18083/login
# -> 200

# then the right one, keeping the cookie
curl -c cookies.txt -o /dev/null -w "%{http_code}" \
    -X POST -d "password=lab-fixture-password-42" \
    http://127.0.0.1:18083/login
# -> 302
```

The difference is worth learning,
because a browser hides it: a **wrong
password gets 200** — the login page
again, with an error on it, and no
cookie. A **right password gets 302**
— a redirect onward — and a
`Set-Cookie` header. In the lab's
cookie file, the cookie's value began
`%24argon2id%24...`: URL-escaped
`$argon2id$`, the hash format of
chapter 2, not the password itself
(transcript `t05`).

`code-server-lab/check-server.sh`
packages all four checks from this
chapter — health, redirect, login,
and a file fetch from the next one —
into one script that fails loudly at
the first step that stops working.
