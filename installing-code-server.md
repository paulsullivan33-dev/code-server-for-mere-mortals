# Installing code-server

**Outcome: a `code-server` program on
your machine that can state its
version, and a clear picture of the
config file it writes before you ask
it to.** Everything in this chapter is
unpacked files; nothing is installed
into the system.

## The release download

The lab installed code-server
**4.144.0** from the project's GitHub
releases (`github.com/coder/code-server`).
There is one archive per platform —
`code-server-4.144.0-linux-amd64.tar.gz`
for an ordinary 64-bit Linux PC, with
matching builds for ARM machines,
macOS and a standalone variant. The
lab's download was 231,422,956 bytes
(about 221 MB) with this SHA-256:

```text
710f749c40a0f3d0ab3be09c0de65314e5c2907cc50646f5fbc0f24c0e8fba2d
```

Checking a download against the hash
the project publishes is a thirty-second
habit that catches truncated and
tampered files alike; transcript `t00`
keeps the lab's numbers.

Unpacked, the archive is self-contained
and not small — 678 MB on disk, because
it carries a complete VS Code:

```text
code-server-4.144.0-linux-amd64/
  bin/code-server    the program you run
  lib/node           its own Node.js runtime
  lib/vscode/        the editor itself
  out/               the server code
  node_modules/      its libraries
```

No package manager, no administrator
rights, and deleting the folder removes
code-server completely — the same
pattern as any well-mannered tarball.

## The check

```bash
./code-server-4.144.0-linux-amd64/bin/code-server --version
```

```text
4.144.0 ee31cdbe02c07b3ba718007f221d14c890696c61 with Code 1.144.0
```

Two versions in one line, and both
matter: **4.144.0** is code-server's own
version, and **Code 1.144.0** is the
version of VS Code inside it. Extension
compatibility questions are answered by
the second number; server behaviour
questions by the first.

## The config file it writes first

Watch what the lab's very first
`--version` printed *before* the
version:

```text
info  Wrote default config file to /home/hatch/.config/code-server/config.yaml
```

Before it has served a single page,
code-server creates its default config
file if none exists. The file it wrote
(transcript `t13`) contains:

```yaml
bind-addr: 127.0.0.1:8080
auth: password
password: <a long random password it generated>
cert: false
```

Three facts in that little file shape
the rest of this guide. The default
address is **loopback only** — the
server starts life reachable only from
its own machine, which is the right
default for a tool like this. The
default authentication is a password.
And the password is **generated**, not
chosen: if you ever start code-server
and cannot sign in, that file is where
the password it invented is written
down. Chapter 13 returns to that trap.

This guide will not use that default
config. From chapter 4 on, the lab —
and you — keep an explicit config file
beside the work and pass it with
`--config`, so the address, port and
password in force are always the ones
in view.

## The other ways in, honestly labelled

The project also offers a one-line
install script, an npm package, a
Docker image and packages for several
systems. The lab ran none of them: the
sandbox has no containers, and this
guide's rule is to teach what it
verified. They are documented-only
here — the tarball above is the route
every later chapter assumes.
