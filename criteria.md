# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's workspace is two stock files and its password an
   invented fixture, printed openly because it guards nothing.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 12 names what the tool
   cannot do: one shared password and no user accounts, an
   extension registry that is not Microsoft's marketplace and
   never will be for some extensions, no scripted write access
   over plain HTTP (the lab's POST was refused with 405), the
   weight of a full editor at 678 MB unpacked, a health
   endpoint whose "expired" means idle rather than broken, and
   telemetry and update checks that talk by default until
   switched off.
8. **The ethics rule is in the text, early.** code-server puts
   a full editor *and a terminal with your account's powers*
   behind one password on a web page, so chapter 1 and the
   README state the line before any procedure depends on it:
   run it only on machines and networks you control, keep
   password authentication on unless another boundary already
   authenticates you, and put HTTPS or a tunnel in front of it
   before it crosses any network you do not own. The lab itself
   never left loopback, and its `auth: none` run was made on
   loopback precisely to show why that mode must not travel.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is a 2-CPU, 7.7 GB Ubuntu 24.04 sandbox,
shared with other work while the lab ran. code-server
**4.144.0** (build `ee31cdbe02c07b3ba718007f221d14c890696c61`,
carrying Code **1.144.0**) was installed from the official
release archive `code-server-4.144.0-linux-amd64.tar.gz`
(231,422,956 bytes, SHA-256
`710f749c40a0f3d0ab3be09c0de65314e5c2907cc50646f5fbc0f24c0e8fba2d`)
and run unmodified, unpacked to 678 MB. All runs bound
`127.0.0.1` on the lab's assigned port; the lab had **no
browser**, so the interactive editor could not be exercised,
and nothing in this guide claims it was. All transcripts live
in `code-server-lab/transcripts/`; the lab's configs and
fixture workspace are in `code-server-lab/` beside them, and
its checking script is `code-server-lab/check-server.sh`.

Run for real, with transcripts as evidence:

- Download, hash, unpack, `--version` (both version numbers),
  and the full `--help` option surface (t00, t01).
- The default config file the first run writes to
  `~/.config/code-server/config.yaml`, read back with its
  generated password masked: loopback 127.0.0.1:8080, password
  auth, `cert: false` (t13).
- A five-line lab config (loopback, password auth, telemetry
  disabled) and a two-file fixture workspace; server startup
  with the full log read line by line (t02, t03).
- `/healthz` before any client: HTTP 200 with
  `{"status":"expired","lastHeartbeat":0}`; after a login,
  `{"status":"alive",...}` (t04, t05).
- The unauthenticated front door: 302 to `/login`, the login
  page's title and welcome heading (t04).
- Signing in with curl: a wrong password returns 200 and no
  cookie; the right password returns 302 and a
  `code-server-session` cookie whose value is an argon2id
  hash (t05).
- The authenticated front door: an 83-byte redirect naming
  `?folder=<absolute path>`, then the 5,842-byte workbench
  loader page with its renderer markers (t06, t07).
- Reading a file through the session's own route
  (`/vscode-remote-resource`): exact bytes with the cookie,
  401 without it, and a POST to the same route refused with
  405 "Unsupported method POST", no file created (t06, t07).
- Extensions from the command line: the first
  `--install-extension editorconfig.editorconfig` failed with
  a TLS disconnect error (exit 1, registry separately verified
  healthy); the identical retry installed v0.18.2;
  `--list-extensions --show-versions` and the on-disk folder
  agree (t08).
- Hashed passwords: an argon2 hash generated with the Node
  and argon2 library bundled in the tarball; a config using
  `hashed-password` whose log line changes to match; the
  plain password still signs in (302) and a file fetch
  behind that session returns the fixture's bytes (t09–t11).
- Failure: a second instance on the same port exits 1 with
  `listen EADDRINUSE` (t11).
- `auth: none`: startup log "Authentication is disabled",
  the front door redirecting straight to the open folder,
  and the file route serving bytes with no cookie at all
  (t12, t13).

Documented only — described from the project's documentation,
not run, and the text does not claim otherwise:

- The interactive editor session itself (chapter 6): typing,
  completion, search, source control, settings, and the
  integrated terminal in use. The lab verified the login,
  the loader page and the HTTP surface around the session;
  the manual checks chapter 6 hands to the reader cover the
  rest.
- HTTPS in every form: the self-signed certificate `cert:
  true` generates, real certificates, and reverse proxies;
  the wider bind addresses, tunnels and mesh networks of
  chapter 10 beyond the loopback end the lab ran.
- Install routes other than the tarball: the install script,
  npm, the Docker image (the sandbox has no containers) and
  system packages.
- The neighbour tools of chapter 11 (Microsoft's Remote-SSH
  and Remote Tunnels, OpenVSCode Server, the cloud IDEs) —
  characterised, not run or benchmarked.
- Open VSX as the default registry and the licensing reason
  some Microsoft extensions are unavailable: stated from the
  project's documentation. The lab verified installs *work*
  from the default registry; it did not audit the registry.
- `--github-auth` and the file-download/upload disable
  switches: present in the verified `--help` (t01), their
  behaviour described, not exercised.

Fixtures are this guide's own and deliberately generic: a
stock Python greeting, a plain Markdown note, and a password
invented for the lab and printed in the text. The lab ran
only on loopback, was never exposed to any network, and every
server it started was stopped when the lab finished.
