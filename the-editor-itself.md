# The Editor Itself

**Outcome: you know what loads after
the login, what the working session
consists of, and — just as plainly —
which parts of this chapter were
verified by the lab and which are
described from the project's
documentation, because the lab had no
browser.**

## The line through this chapter

Everything up to here was proven with
scripts. This chapter crosses into the
browser, and the guide's rule applies:
each claim states its evidence. The
lab verified the login, the redirects,
the 5,842-byte workbench loader page
and the file route behind the session
(chapters 4 and 5). What that page
*becomes* once a browser runs it is
documented-only, and this chapter says
so rather than dressing documentation
up as experience.

## What loads

When the loader page runs, it downloads
the rest of the workbench — the editor
program, several megabytes of scripts
and styles shipped in the tarball's
`lib/vscode` folder — and opens a
persistent connection to the server.
From then on the session is live, not
page-by-page: the server pushes file
changes, terminal output and extension
activity to the browser as they
happen, and the browser sends back
keystrokes, saves and commands. This
is why the file write of chapter 5
could not be done with curl: it
travels this connection, which the
loader negotiates with tokens a plain
HTTP client does not hold.

## Working in it (documented)

From the project's documentation, the
session that loads is VS Code as its
users know it, with nothing important
amputated:

- The **explorer** shows the folder you
  named; files open in tabs, edit with
  the usual highlighting, completion
  and multi-cursor behaviour, and save
  back to the server's disk.
- The **integrated terminal** opens a
  real shell on the server, as your
  account — the fact chapter 1's
  warning rests on. Commands run where
  the files are, with the server's
  tools, not the browser device's.
- **Search** runs across the folder on
  the server, so it is as fast as the
  server, not the network.
- **Source control** shows the folder's
  Git state if it is a repository, and
  extensions add the rest.
- **Settings** sync is the server's own
  affair: your preferences live in the
  user data folder on the server, so
  every browser you sign in from gets
  the same editor.

Two practical consequences follow, and
both are stated in the documentation
and consistent with everything the lab
did verify. The browser device needs
almost nothing — a modern browser and
a keyboard you can stand — because
every heavy thing happens on the
server. And a dropped connection is a
pause, not a loss: the server holds
the session (its `--reconnection-grace-time`
default is three hours), and reloading
the page rejoins it.

## What a mortal should check by hand

Since the lab could not, you should —
once, on first install, in this order.
Sign in and confirm the folder that
opens is the one you named. Open the
terminal and run `whoami` and `pwd`:
the answers should be your account and
your folder *on the server* — the
single clearest proof of where you
are working. Edit a file, save it,
then look at the file on the server
from outside the editor and confirm
your change is on its disk. Those
three checks take a minute and cover
exactly the ground scripts could not.
