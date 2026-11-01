# Configuration

**Outcome: you can predict a running
server's whole arrangement from its
config file, move its state folders
where you want them, and switch off
the two kinds of phoning home it does
by default.**

## One file, mirrored by flags

code-server's rule is simple enough to
state in one line: **every flag maps
directly to a key in the config file**.
`--bind-addr` is `bind-addr:`,
`--disable-telemetry` is
`disable-telemetry: true`, and so on
through the whole list in transcript
`t01`'s help output. Settings given on
the command line override the file for
that run; settings given nowhere fall
back to the defaults chapter 3 showed
being written on first run. When a
server behaves unexpectedly, the
startup log's `Using config file ...`
line names the file actually in force
— read that before editing the file
you *meant* it to use.

The keys this guide has used, gathered:

```yaml
bind-addr: 127.0.0.1:18083   # where it listens; $PORT can override the port
auth: password               # password or none (chapter 8)
password: ...                # or hashed-password: (chapter 8)
cert: false                  # true or a path turns on HTTPS (chapter 10)
disable-telemetry: true      # chapter 9's switches, below
```

## Where the state lives

Three directories, three jobs — worth
keeping separate in your mind because
they have different backup values:

- **Config** (`--config`, default
  `~/.config/code-server/config.yaml`):
  the arrangement. Tiny, precious,
  contains a credential in plain or
  hashed form.
- **User data** (`--user-data-dir`,
  default `~/.local/share/code-server`):
  settings, logs, the session socket.
  Losing it costs your preferences.
- **Extensions** (`--extensions-dir`,
  default inside user data): the add-ons
  of chapter 7. Losing it costs a
  re-download.

Your project folders are in none of
these; they are wherever you keep your
work, and code-server only visits them.

## The two phone-homes, and their switches

By default code-server does two things
on the network beyond serving you.
**Telemetry**: anonymous usage data to
the project, off with
`--disable-telemetry` or
`disable-telemetry: true` — the lab's
config set it from the first run.
**Update check**: every six hours it
asks GitHub for the latest release and,
per the help text, notifies you once a
week when a newer one exists; off with
`--disable-update-check`. Neither is
sinister, and the update check is
arguably a safety feature, but a tool
that can open your files should not
surprise you with its own traffic —
now neither will.

Two more switches belong in a
careful setup's vocabulary, stated in
the help and documented-only here:
`--disable-file-downloads` and
`--disable-file-uploads` close the
file-transfer routes (chapter 5's
download route among them) for
servers where viewing should not mean
copying away, and `--github-auth`
supplies a GitHub token, through
`$GITHUB_TOKEN` or the config only,
for editor features that talk to
GitHub on your behalf.

## Reading a live server's mind

Given an unfamiliar running server,
three checks reconstruct its
arrangement: the startup log (config
file, bind address, auth source,
HTTPS or not), the config file it
names (the secrets and switches), and
`--list-extensions` pointed at its
extensions directory (the add-ons).
The lab's transcripts are, in effect,
those three checks run in order.
