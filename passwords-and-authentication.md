# Passwords and Authentication

**Outcome: all three of code-server's
ways in, run and compared — a plain
password in the config, the same
password stored as a hash, and no
authentication at all — so the choice
between them is one you make with the
consequences in view.**

## Way one: the password in the config

```yaml
auth: password
password: lab-fixture-password-42
```

This is what chapters 4 and 5 ran.
The secret sits in the config file in
readable form, which makes the file
itself a credential: anyone who can
read it can sign in as you. The server
understands this, which is why
`--password` on the command line is
refused by design — the help text
states the password "can only be
passed in via $PASSWORD or the config
file", so it never lands in a process
list or a shell history. The startup
log confirms the arrangement each run:
`Using password from ./config.yaml`.

## Way two: the same password, hashed

The config can hold a scramble instead
of the secret:

```yaml
auth: password
hashed-password: $argon2id$v=19$m=65536,t=3,p=4$...
```

`hashed-password` takes precedence
over `password` when both exist. The
lab made its hash with the argon2
library code-server itself bundles,
using the copy of Node that ships in
the tarball (transcript `t09`):

```bash
./lib/node -e "const a=require('./node_modules/argon2'); \
  a.hash('your-password').then(h=>console.log(h))"
```

(run from inside the unpacked folder;
the full hash went into the lab's
config and this guide prints only its
shape, because a hash of a real
password is still a thing to treat
carefully — it can be attacked offline
at whatever speed the attacker's
hardware allows.)

The proof it works is the same proof
as chapter 4, repeated (transcripts
`t10`, `t11`): the startup log reads
`Using hashed-password from
./config-hashed.yaml`, the plain
password still signs in with a 302,
and a file fetch behind that session
returns the fixture's bytes. What the
hash buys you is narrow and real: the
config file can now be shown, backed
up or committed to a private notes
repo without handing over the password
itself. What it does not buy is any
change at the door — signing in works
exactly the same, and a weak password
is still weak, hashed or not.

## Way three: none — and what "none" means

```yaml
auth: none
```

The lab ran this too, on the same
loopback port, and the transcript
(`t13`) is the shortest security
lecture in this guide. The startup
log says `Authentication is disabled`.
The front door redirects *straight*
to the open folder — no login page at
all. And the file route that answered
401 to a stranger in chapter 5 hands
over the file with **no cookie at
all**, because there is no longer
anything to check.

`auth: none` is not a bug or a trap;
it is a deliberate mode for situations
where something else is already the
door — a server reachable only from
its own machine, or one sitting behind
a tunnel or proxy that authenticates
before forwarding. The rule is in the
reading of the transcript: with
`none`, *the network is the password*.
If anything you did not intend can
reach the port, it has your editor
and your terminal. Never set it to
widen access; set it only when the
boundary genuinely lives elsewhere.

## The standing advice

One password, shared by every browser
you sign in from, means there is
nothing to revoke per device: change
the password in the config, restart,
and every old session's cookie stops
matching. Do that if a device is lost
or a password leaks. And keep the
config file's own permissions in mind
— `chmod 600 config.yaml` is a fair
price for a file that holds a door
key, in plain or hashed form alike.
