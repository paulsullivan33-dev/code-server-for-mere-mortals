# Troubleshooting

**Outcome: the failures this guide's
lab actually met, plus the ones its
transcripts explain, each with the
check that names it.** Work the checks
in order; each one rules a part in or
out, in the order the parts are met on
the way in.

## "Address already in use" at startup

```text
error listen EADDRINUSE: address already in use 127.0.0.1:18083
```

The lab produced this on purpose
(transcript `t11`): a second
code-server cannot share a port with
the first. Either the first one is
your real server — stop starting a
second — or it is a leftover from a
session you forgot, which you stop
and replace. Exit code 1, no partial
state; the error is one of the polite
ones.

## The login page keeps coming back

You type the password, the form
returns, no error you can see. Two
suspects, in order. **The password is
wrong** — remember the shape from
chapter 4: wrong gets the form again
(HTTP 200 to a script), right gets a
redirect (302), and a browser makes
those look deceptively alike. Retype
it from the config file, do not trust
memory. **You are editing the wrong
config** — check the startup log's
`Using config file` line and the
`Using password from` line beneath
it; the server reads the file it
names, not the file you have open.

## "I never set a password at all"

Then code-server set one for you: the
default config written on first run
(chapter 3) contains a generated
password in plain text at
`~/.config/code-server/config.yaml`.
Read it there, sign in with it, and
then move to an explicit config of
your own as this guide teaches.

## The health check says "expired"

Almost certainly nothing is wrong —
the endpoint reports the last
client's heartbeat, and a fresh or
idle server has none to report
(chapter 4). Check the HTTP status:
200 means the server answered. Only
treat `expired` as news if clients
are actively using the editor and
the heartbeat stays at zero.

## An extension install fails with a TLS error

```text
Client network socket disconnected before secure TLS connection was established
```

The lab met this once (transcript
`t08`) with the registry verifiably
healthy. It is a connection dropped
mid-handshake, and the remedy is
uninteresting on purpose: check the
machine's network, run the identical
command again. Only if it fails
repeatedly is it worth suspecting
more — a proxy the machine needs, or
a network that intercepts TLS — and
the `.vsix` route of chapter 7 exists
for exactly that world.

## The wrong folder opens

You named a folder and the editor
opened a different one — usually the
one from *last* time. The folder
argument is positional and easy to
lose behind flags in a long command;
and with no argument, reopening the
last folder is the designed behaviour.
Name the folder as the final argument,
or add `--ignore-last-opened` when
you want an empty window instead.
The redirect of chapter 5 shows the
truth: the path in `?folder=` is the
folder the server opened, whatever
you intended.

## A browser warning about the certificate

Expected, if you turned on `cert`
without providing one: the server
generated a self-signed certificate
(chapter 10), and the browser is
correct that no authority vouches for
it. On your own network the check
that matters is the fingerprint,
compared against the server itself.
Anywhere wider, use a real
certificate and let this warning be
the thing that stops you shipping
the self-signed one to other people.
