# Putting It on a Network

**Outcome: you can take a code-server
from loopback-only to reachable from
your other machines, in an order that
never leaves it open along the way —
and you know which of these steps the
lab verified and which are documented.**

Everything before this chapter ran on
`127.0.0.1`, where the only client
possible is the machine itself. That
was deliberate. This chapter widens
access one deliberate step at a time.
The lab verified the loopback end of
every arrangement below and the
behaviour of the flags involved; the
wider-network forms are assembled
from the project's documentation and
labelled as such — the sandbox the lab
ran in has no second machine to reach
it from, and the guide does not
pretend otherwise.

## Step one: a wider bind address, same rules

`bind-addr` decides whose packets the
server answers at all:

```yaml
bind-addr: 0.0.0.0:18083
```

`0.0.0.0` means every network interface
the machine has — the home network
cable *and* anything else attached.
A specific address (the machine's LAN
address, or a VPN address) binds only
that face, and is the better habit.
Nothing else changes: the password is
still the password, the login page is
still the door. Do this only together
with step two.

## Step two: HTTPS before it crosses anything

On loopback, plain HTTP was fine —
the bytes never crossed a wire. The
moment they do, the session cookie of
chapter 2 travels with every request,
and anyone who can watch the traffic
can replay it. code-server's own
answer is its `cert` key:

```yaml
cert: true
```

With `cert` set and no certificate
provided, the help text states it
generates a **self-signed** one —
better than plaintext, with a browser
warning to click through, and a
fingerprint you can compare by hand.
With real files it uses yours:

```yaml
cert: /path/to/cert.pem
cert-key: /path/to/key.pem
```

How you *get* a real certificate —
a public name with Let's Encrypt, or
a private certificate authority for
home names — is a topic of its own;
this guide's rule stops at the order
of operations: **encryption on before
exposure, never after**. (Documented:
the lab's runs were loopback HTTP, as
every transcript shows.)

## Step three, the alternative: do not expose it at all

Often the best answer to "how do I
reach it from elsewhere" is "you do
not; a tunnel reaches it for you".
Three shapes, all documented-only here
and each with a guide of its own in
this series where marked:

- **An SSH tunnel** — sign in to the
  server over SSH and forward its
  loopback port to your machine. The
  server stays bound to `127.0.0.1`,
  SSH is the door and the encryption,
  and code-server never learns the
  internet exists. For one person and
  one server this is the arrangement
  this guide recommends first.
- **A private mesh network** such as
  Tailscale: bind code-server to the
  machine's mesh address only, and it
  is reachable from exactly your
  devices, nowhere else. (See the
  Tailscale guide in this series.)
- **A public tunnel or reverse proxy**
  such as a Cloudflare Tunnel: for when
  you truly need a public address.
  Then the tunnel's own access controls
  become part of your door, the
  password stops being the *only*
  lock, and `--trusted-origins` and the
  proxy settings in `t01`'s help become
  reading worth doing slowly. (See the
  Cloudflare Tunnel guide.)

## What never to do

Never bind `0.0.0.0` with `auth: none`.
Never expose plain HTTP beyond
loopback. And never treat "nobody
knows the address" as a control: port
scanners know every address. The lab
ran the `auth: none` transcript on
loopback precisely so its consequence
is on record — take chapter 8's word
for what it looks like one network
wider, and do not run that experiment
yourself.
