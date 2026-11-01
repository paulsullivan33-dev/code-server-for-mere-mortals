# The Neighbours

**Outcome: you can say what each
alternative does that code-server
doesn't — and what it gives up to do
it — so staying or switching is a
decision, not a habit.** Everything in
this chapter is characterised from the
projects' documentation; none of it
was run in this guide's lab.

## Microsoft's own remote routes

VS Code on the desktop can itself work
on remote files, two ways. **Remote -
SSH** opens a folder on a machine you
can SSH to, running a small server
there that the desktop editor drives.
**Remote Tunnels** goes the other way:
a machine runs Microsoft's tunnel
service and you edit it from desktop
VS Code or from `vscode.dev` in a
browser, signing in with a Microsoft
or GitHub account. What they do that
code-server doesn't: the genuine
Microsoft marketplace, Microsoft's own
extensions (Python's full tooling
among them), and an account-based door
with no password file of yours to
guard. What they ask in return: the
official VS Code build rather than
the open one, accounts with Microsoft
and GitHub as part of your toolchain,
and trust in a tunnel somebody else
operates. For many people that trade
is obviously right; code-server exists
for the people it isn't.

## OpenVSCode Server

The nearest neighbour of all: the
VSCodium community's server build of
the same open-source editor, aiming
to be the plain upstream server with
the least added on top. If code-server
is VS Code with Coder's choices —
its login, its config file, its
update checks — OpenVSCode Server is
closer to the editor's own defaults,
and correspondingly leaves more of
the surrounding arrangement (including
authentication in front of it) to
you. Same registry, same limits,
different temperament.

## The cloud IDEs

GitHub Codespaces, Gitpod and their
kin host the whole thing: no server of
yours, an editor in a browser billed
by the hour, environments spun up
from a repository in a minute. What
they do that code-server doesn't is
*everything operational* — capacity,
backups, disposal. What they give up
is the premise of this guide: your
files and your shell live on someone
else's computer, under someone else's
account, for a subscription. For work
that is already public code on GitHub,
that can be an excellent trade. For a
home server's worth of private work,
it answers a question you did not ask.

## SSH, tmux and a terminal editor

The oldest route, and the one this
series' other guides teach: sign in
with SSH, keep sessions alive with
tmux, edit with Vim, Neovim or Helix
in the terminal. What it does that
code-server doesn't: it works over a
modem-grade connection, on any server
however small, with no 678 MB editor
and no web attack surface beyond SSH
itself — and SSH's key authentication
is stronger than any password form.
What it gives up is the thing itself:
no graphical editor, no browser
convenience, a real learning curve.
Plenty of the people code-server is
for started here and keep both: the
tunnel recipe in chapter 10 is
literally this route carrying the
other one.

## The honest summary

code-server's niche is the middle:
your machine, your network, a real
editor in a browser, one program to
run and one password to guard. Every
neighbour beats it on *something* —
marketplace completeness, operational
effort, account-based access, weight.
None of them beat it on all of those
at once while keeping the files, the
shell and the door on your side of
the wall.
