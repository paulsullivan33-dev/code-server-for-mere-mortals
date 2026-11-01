# Limits

**Outcome: the edges of the tool,
named plainly — most of them met
already in the lab, collected here so
none of them surprises you later.**

## One door, one identity

There is exactly one password and no
concept of users. Everyone who signs
in is the same person as far as the
server is concerned — same files, same
terminal, same account on the machine.
There is no per-person revocation, no
read-only mode for a guest, and no
record of who did what. Fine for one
person with several browsers; the
wrong tool for a team, however small,
however trusted.

## The registry is not the marketplace

Extensions come from Open VSX
(chapter 7). Most of the shelf is
there; some of it — Microsoft's own
extensions above all — never will be,
for licensing reasons no setting can
change. If a workflow depends on one
of those, code-server is not a
workaround; it is a dead end, and it
is kinder to learn that from this
chapter than from a failed install.

## Editing is a browser session, not an API

The lab mapped this boundary with
curl (chapter 5): signing in, page
loads and file *downloads* are plain
HTTP, but writes come back
`405 Unsupported method`. There is no
scripted "open this file and change
that line" surface in what the lab
could reach; automation goes through
the files themselves and other tools,
not through the editor. The editor is
for a person in a browser.

## It is a whole editor, and weighs like one

678 MB unpacked on disk, a Node
runtime and a full VS Code per server.
On a healthy small server that is
nothing; on the smallest boards it is
a real share of the machine, and two
servers for two configurations means
two of everything. The terminal-editor
route of chapter 11 stays lighter by
an order of magnitude, forever.

## The health endpoint does not mean what it says

`/healthz` reports the last client's
heartbeat, so a freshly started,
perfectly healthy server answers
`expired` (chapter 4). Anyone wiring
it into an alerter without knowing
that will be paged by a healthy
machine at every restart. The HTTP
200 is the liveness signal; the JSON
is a usage signal.

## Defaults that talk

Until switched off (chapter 9), the
server sends telemetry and checks
GitHub for updates every six hours.
Both are disclosed in the help text,
neither is hidden, and a careful
reader still deserves to meet them in
this chapter rather than in a packet
capture.

## One machine's account, all of it

The limit underneath the others,
repeated from chapter 1 because this
is the chapter people reread: a
session is your whole account on that
machine — every file it can read,
every command it can run, including
the ones that administer the machine
itself if your account has sudo. The
password is not protecting an editor.
It is protecting a login. Set it up
that way.
