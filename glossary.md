# Glossary

**argon2** — the password-hashing
method code-server uses. It scrambles
a password one-way, deliberately
slowly, so a stolen hash is expensive
to attack. Its output begins
`$argon2id$`, which is how you
recognise it in a config file or a
cookie.

**bind address** — the network address
and port a server listens on.
`127.0.0.1` hears only the machine
itself; a LAN address hears that
network; `0.0.0.0` hears every
interface the machine has.

**config file** — code-server's YAML
settings file (`bind-addr`, `auth`,
`password`, and the rest). Every
command-line flag has a matching key
in it.

**cookie** — a small token a server
asks a browser to keep and present
with each request. code-server's is
named `code-server-session`, and its
value is an argon2 hash of the
password, not the password itself.

**extensions directory** — the folder
holding installed extensions, one
subfolder each; chosen with
`--extensions-dir`.

**hashed password** — a password
stored as its argon2 scramble
(`hashed-password:` in the config).
The server can check a password
against it without being able to
recover the password from it.

**health endpoint** — `/healthz`, the
address that answers whether clients
have checked in recently. `expired`
means "nobody lately", not "broken".

**loopback** — the `127.0.0.1`
address: a machine talking to itself.
Traffic on it never crosses a real
network, which is why this guide's
lab lived there.

**Open VSX** — the open extension
registry code-server installs from,
run under the Eclipse Foundation, in
place of Microsoft's marketplace.

**self-signed certificate** — an HTTPS
certificate a server makes for itself.
It encrypts, but no authority vouches
for it, so browsers warn — correctly.

**session** — one signed-in
relationship between a browser and
the server, carried by the session
cookie and a live connection once the
editor loads.

**user data directory** — the folder
holding settings, logs and the
session socket; chosen with
`--user-data-dir`. Preferences live
here; projects never do.

**VSIX** — the packaged form of a VS
Code extension, a file ending
`.vsix`, installable directly for
machines that cannot reach a
registry.

**workbench** — VS Code's own name
for the editor window as a whole: the
explorer, the editing area, the panel
and the terminal, served to your
browser as web pages and scripts.

**workspace** — the folder (or
`.code-workspace` file) a session has
open: the project, as the editor sees
it.
