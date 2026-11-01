# What code-server Is

You have a project — a folder of code,
notes and half-finished scripts — and it
lives on a machine that is not the one
in front of you. A home server. A small
rented box. A desktop in another room
that is always on. The usual answers
are to copy the files back and forth,
or to sign in over SSH and use whatever
editor happens to be installed there.

**code-server is a third answer: run
the editor itself on that machine, and
use it through a web browser.** The
editor is VS Code — Microsoft's popular
editor, in the open-source build — and
code-server (made by Coder) wraps it in
a small web server. You start it on the
machine that holds your files, open its
address in a browser, sign in with a
password, and there is the editor:
your folder, your extensions, an
integrated terminal, all running on
the server. The browser draws the
pictures and sends your keystrokes;
nothing about the project needs to
live on the device you are holding.

That is the whole idea, and it is
genuinely convenient. A cheap laptop or
a tablet becomes a perfectly good
workstation. The editor stays open —
with its terminals and its state — when
you close the lid and come back from
another room, or another network.

## The honest catch, up front

An editor with an integrated terminal
is not a text box. It is your account
on that machine, wearing an editor's
clothes: anyone signed in can open the
terminal and run any command you could
run, and read or change any file you
could. code-server's defence, by
default, is **one password** in front
of all of it.

So this guide treats the login page as
what it is — a security boundary — and
says the rule once, here, before any
procedure depends on it:

- Run it on machines and networks you
  control.
- Password authentication on, always,
  unless the only route to it is a
  loopback port or a private tunnel
  that already authenticates you.
- HTTPS (or a tunnel that provides it)
  before it crosses any network you do
  not own outright.

Chapter 10 works through that properly.
None of it is a reason not to use the
tool; it is the reason to set it up
deliberately instead of by accident.

## A first taste

After installing (chapter 3) and
writing a five-line config file
(chapter 4), starting it is one line:

```bash
./code-server --config ./config.yaml ./my-project
```

and the receipt it prints is the one
this guide keeps coming back to:

```text
info  HTTP server listening on http://127.0.0.1:18083/
info    - Authentication is enabled
info      - Using password from ./config.yaml
```

An address, a listening server, and
authentication confirmed in the same
breath. Open the address, type the
password, and the editor loads with
`my-project` already open.

## What it is not

code-server is not a collaboration
tool: everyone who signs in uses the
same password and the same account —
there are no users, no permissions, no
audit trail of who did what (chapter 12
is plain about this). It is not a cloud
IDE: nothing is hosted for you, there
is no account to create with Coder, and
when your server is off, your editor is
off. It is not a remote desktop: only
the editor crosses the wire, not the
whole machine's screen. And it is not
the official VS Code *binary* — it is
built from the same open-source code,
which matters in exactly one place a
reader will feel: its extension
registry is the open one, not
Microsoft's marketplace (chapter 7).

## Who it is for

The person with a home server and a
light laptop. The maker whose project
lives on a Raspberry Pi-class machine
that has no screen. The developer who
wants the same editor, in the same
state, from the desk, the couch and
the road. The common thread is one
person, one server they control, and
work that is easier when the editor
lives where the files do.
