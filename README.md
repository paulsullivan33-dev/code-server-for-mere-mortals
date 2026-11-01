# code-server for Mere Mortals

A code editor usually lives on the
machine in front of you. **code-server**
moves it. It runs Microsoft's **VS Code**
editor on a server — a spare machine in
the corner, a small cloud box, a home
server — and you use it from an ordinary
**web browser**, anywhere you can reach
that server. The files, the extensions
and the terminal all live on the server;
the browser is just a window. Close the
laptop, open a tablet, and the same
editor is sitting where you left it.

There is a price for that convenience,
and this guide states it before anything
else, because everything else follows
from it: **the login page is the only
door, and behind it is not just an
editor — it is a terminal with your
account's full powers on that machine.**
Whoever signs in can read every file you
can read and run every command you can
run. So the password matters, the
network it listens on matters, and
chapter 10 is about exposure before it
is about convenience. Used on machines
and networks you control, it is a
genuinely useful tool. Used carelessly,
it is a shell with a web page in front
of it.

The lab behind this guide ran the real
thing: **code-server 4.144.0** (carrying
Code 1.144.0), the official release
tarball, on a small Linux machine,
bound to a loopback port with password
authentication. Against it the lab
signed in with a wrong password and the
right one, read the session cookie it
hands back, fetched the workbench page
a browser would load, read real files
back through the server's own web
routes — and proved those same routes
refuse strangers. It installed an
extension from the command line (after
one honest network failure), swapped
the plain password in the config file
for an argon2 hash and signed in again,
ran a copy with authentication switched
off to show exactly what that means,
and started a second copy on the same
port to watch it fail.

What the lab could not do, it did not
fake. It had no browser to click with,
so the *interactive* editor — typing,
completions, the integrated terminal in
use, debugging — is taught from the
project's documentation and labelled as
such wherever it appears. Everything
around that experience that a script
*can* touch — installing, signing in,
the pages served, the files read, the
extensions installed, the ways in and
the ways it breaks — was run for real,
and the transcripts are the evidence.
`criteria.md` keeps the full ledger.

## What this guide covers

- [**What code-server is**](what-code-server-is.md) —
  the mental model: an editor that lives
  on a server and is used through a
  browser, and why the login page is a
  security boundary, not a formality
- [**The moving parts**](the-moving-parts.md) —
  the server program, the workbench it
  serves, the config file, the user data
  folder, extensions, and the session
  cookie — and which part holds what
- [**Installing code-server**](installing-code-server.md) —
  the release tarball, what is inside
  it, the version check, and the default
  config file the first run writes
- [**Your first login**](your-first-login.md) —
  starting the server, reading its log,
  the health endpoint, and signing in —
  including what a wrong password looks
  like
- [**Opening a folder**](opening-a-folder.md) —
  the folder argument, the redirect that
  names it, the workbench page, and
  reading a file back through the web
  surface — plus the write that plain
  HTTP refuses
- [**The editor itself**](the-editor-itself.md) —
  what loads in the browser and what
  working in it is like, labelled
  honestly as the documented half of
  the guide
- [**Extensions**](extensions.md) —
  installing and listing extensions from
  the command line, the registry they
  come from, and the install that failed
  once before it worked
- [**Passwords and authentication**](passwords-and-authentication.md) —
  the three ways in: a password in the
  config, the same password hashed, and
  no authentication at all — each one run
- [**Configuration**](configuration.md) —
  the config file and the flags that
  mirror it, where the state lives, and
  the telemetry and update-check switches
- [**Putting it on a network**](putting-it-on-a-network.md) —
  bind addresses, HTTPS, tunnels and
  reverse proxies, and the order to do
  them in — exposure first, convenience
  second
- [**Recipes**](recipes.md) — a private
  editor on one machine, a throwaway
  no-password sandbox, a scripted health
  check, and a hashed-password setup
- [**The neighbours**](the-neighbours.md) —
  Microsoft's own remote options,
  OpenVSCode Server, cloud IDEs, and the
  SSH-and-terminal-editor route: what
  each does that code-server doesn't
- [**Limits**](limits.md) — one shared
  password for everyone, extensions that
  are not in its registry, writes that
  are not plain HTTP, and the weight of
  carrying a whole editor
- [**Troubleshooting**](troubleshooting.md) —
  the port already in use, the login
  that quietly returns the form, the
  health check that says "expired", and
  the generated password you never chose
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Running code-server for a team. It has
exactly one password and no accounts;
chapter 12 is plain about that, and the
multi-user tools are pointed at, not
taught. The Docker image and the
one-line install script are described
from the documentation, not run — the
lab used the release tarball, and this
guide's commands are the tarball's.
Being a VS Code tutorial is also out:
this guide gets the editor running,
secured and understood; how to edit
well in it is another guide's job.

## How to use this guide

Read chapter 1 for the model and
chapter 2 before installing anything —
knowing which part holds what turns
later confusion into a named problem,
and knowing what the login page guards
turns chapter 10 from advice into
obviousness. Chapters 3 to 5 get you a
running server and a signed-in session
in one sitting. The lab's transcripts
live in `code-server-lab/transcripts/`;
its config files and fixture workspace
are `code-server-lab/config.yaml` and
`code-server-lab/hello.py`, and its
checking script is
`code-server-lab/check-server.sh`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [Helix for Mere Mortals](https://paulsullivan33-dev.github.io/helix-for-mere-mortals/)
- [SSH for Mere Mortals](https://paulsullivan33-dev.github.io/ssh-for-mere-mortals/)
- [Tailscale for Mere Mortals](https://paulsullivan33-dev.github.io/tailscale-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/code-server-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/code-server-for-mere-mortals/blob/main/LICENSE-CODE).
