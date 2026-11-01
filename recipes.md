# Recipes

**Outcome: four working arrangements,
each assembled from steps the earlier
chapters verified — nothing in this
chapter asks you to trust a command
the lab has not run in some form.**

## 1. A private editor on one machine

The arrangement chapters 3 to 5 built,
as one sitting's work:

```bash
mkdir editor-home && cd editor-home
# config.yaml, written by you:
#   bind-addr: 127.0.0.1:8080
#   auth: password
#   password: <one you choose and keep>
#   cert: false
#   disable-telemetry: true
/path/to/code-server --config ./config.yaml \
    --user-data-dir ./user-data \
    --extensions-dir ./extensions \
    ~/your-project
```

Sign in at `http://127.0.0.1:8080`.
Reach it from elsewhere through an
SSH tunnel (chapter 10) rather than
by rebinding. Verified end to end in
transcripts `t03` to `t07`.

## 2. The throwaway sandbox

For opening an untrusted download or
a stranger's archive "just to look":
a folder you are prepared to delete,
on loopback, with authentication off
*because nothing else is in reach* —
the one honest use of chapter 8's
third way:

```bash
mkdir -p /scratch/peek
# config-none.yaml:
#   bind-addr: 127.0.0.1:18083
#   auth: none
#   cert: false
/path/to/code-server --config ./config-none.yaml \
    --user-data-dir ./scratch-data /scratch/peek
```

Remember what the mode means even
here: the editor's terminal runs as
*you*, so an untrusted project's
scripts are only as contained as your
account is. Disposable folder, yes;
disposable account, no. When done,
stop the server and delete the whole
sandbox, data folder included.
(Verified in transcript `t13`.)

## 3. Check on it like a system

Save the lab's checker beside your
config and run it whenever the server
"feels" wrong:

```bash
code-server-lab/check-server.sh \
    http://127.0.0.1:8080 your-password \
    /home/you/your-project/README.md
```

It walks health, the stranger
redirect, a real login and a real
file fetch, and stops at the first
failure — which is nearly always
where the actual problem is.
A `{"status":"expired"}` from the
health step alone is not a failure;
chapter 4 explains the heartbeat.

## 4. The hashed-password upgrade

When a working setup's config file
starts travelling — into backups,
into a dotfiles repo — upgrade it in
place, five minutes, no other change:

```bash
cd /path/to/code-server-4.144.0-linux-amd64
./lib/node -e "const a=require('./node_modules/argon2'); \
  a.hash('your-password').then(h=>console.log(h))"
```

Replace the `password:` line with
`hashed-password:` and the hash,
restart, and sign in with the same
password as before — chapter 8's
transcripts (`t09` to `t11`) show the
log line changing from `Using password`
to `Using hashed-password`, and
nothing else changing at all.
