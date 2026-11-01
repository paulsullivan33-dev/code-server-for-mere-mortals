# The Moving Parts

**Outcome: you can name each part of a
running code-server, say where its
state lives on disk, and point at the
piece responsible when something
misbehaves.** Six parts, and only six,
do all the work in this guide.

## The server program

One program, `code-server`, unpacked
from the release tarball. It is a
**Node.js** application that carries
its own copy of Node inside the tarball
(the `lib/node` file), so it does not
ask your system for a JavaScript
runtime. It listens on one address and
port, serves the editor, checks
passwords, and brokers everything the
browser asks for. When you stop it,
everything stops; there is no separate
database or daemon behind it.

## The workbench

The editor itself — the part Microsoft
calls the **workbench**: the window
with the file explorer on the left,
the editing area, the panel with the
terminal. code-server serves the
workbench as web pages and scripts
from a folder in the tarball (`lib/`).
Your browser downloads that page once
and then talks to the server over a
live connection to open files, save
them, and run terminal sessions. The
lab fetched this page and measured it:
a small loader page of 5,842 bytes that
pulls in the rest (transcript `t07`).

## The config file

A short **YAML** file — plain text,
`key: value` lines — that answers the
questions the server asks at startup:
what address to bind, which kind of
authentication, what the password is,
whether to use HTTPS. Its default home
is `~/.config/code-server/config.yaml`,
and chapter 3 shows the one code-server
writes for you on its very first run.
Every command-line flag has a matching
key in this file, and chapter 9 maps
them. The lab kept its config beside
its work instead, with `--config`,
which is the tidier habit this guide
teaches.

## The user data folder

Settings, keybindings, installed-
extension state, logs, and the little
socket the session machinery uses —
kept in the **user data directory**,
by default `~/.local/share/code-server`.
Delete it and code-server forgets your
preferences but not your files; your
project folders live wherever you put
them and are never inside this folder.
The lab pointed `--user-data-dir` at a
folder of its own, for the same reason
as the config: one folder to inspect,
one folder to throw away.

## Extensions

VS Code's add-ons — language support,
linters, themes — live in the
**extensions directory** (default
`~/.local/share/code-server/extensions`),
one folder per extension. They are
managed two ways that share that same
folder: by clicking in the editor, or
by command line, which chapter 7 runs
for real. Extensions come from the
**Open VSX** registry, the open
extension library, rather than
Microsoft's marketplace — a licensing
distinction with practical edges,
covered in chapters 7 and 12.

## The session cookie

When you sign in, the server hands
your browser a **cookie** named
`code-server-session`. Its value is not
your password: it is an **argon2 hash**
— a one-way scramble — of it, and the
server checks each request against
that scramble. The lab read its own
cookie file after signing in and
matched the format (transcript `t05`).
The cookie is the whole of "being
signed in": clear it, or let it
expire, and you are back at the login
page. It is also why signing in is
worth doing over HTTPS anywhere the
network is not yours — the cookie, not
the password, is what travels with
every request after the first.

## How they fit together

```text
browser ──HTTPS or HTTP──▶ code-server ──reads──▶ config file
   ▲                          │  │
   │ workbench page           │  ├──▶ user data folder (state)
   │ and live session         │  ├──▶ extensions folder (add-ons)
   └──session cookie──────────┘  └──▶ your project folders (the work)
```

Your files are the only irreplaceable
part. Everything else — config, state,
extensions — can be rebuilt by
reinstalling and signing in again,
which is worth knowing before you
worry about backing the wrong folder
up.
