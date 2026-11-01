# Extensions

**Outcome: an extension installed and
listed from the command line — no
browser involved — and a clear account
of where extensions come from, which
is not where a desktop VS Code user
expects.**

## Installing from the command line

Extensions have a two-part name,
`publisher.name`, and one flag:

```bash
./code-server --user-data-dir ./user-data \
    --extensions-dir ./extensions \
    --install-extension editorconfig.editorconfig
```

The lab's transcript (`t08`) keeps
both attempts, because the first one
is the instructive one:

```text
Error while installing extensions: Client network socket disconnected before secure TLS connection was established
```

— exit 1, nothing installed, and a
separate check showing the registry
itself answering fine. A network
interruption mid-handshake, not a bad
name or a broken tool. The same
command, run again, answered:

```text
Extension 'editorconfig.editorconfig' v0.18.2 was successfully installed.
```

Lesson kept plainly: an extension
install is a download, downloads fail
transiently, and the correct response
to that error is to check the network
and retry once before suspecting
anything deeper. Chapter 13 lists it
as a named trap for the same reason.

## Proving it landed

Two independent witnesses. The tool's
own list:

```bash
./code-server --user-data-dir ./user-data \
    --extensions-dir ./extensions \
    --list-extensions --show-versions
# editorconfig.editorconfig@0.18.2
```

and the folder on disk, where the
extension sits as
`editorconfig.editorconfig-0.18.2-universal`
beside the `extensions.json` registry
file. When the list and the folder
agree, the extension is installed;
the editor will pick it up when it
next loads. `--uninstall-extension`
with the same two-part name reverses
the process, and `--install-extension`
accepts a `.vsix` file downloaded by
hand for machines where the registry
is out of reach — that route is
documented-only here; the registry
route above is the one the lab ran.

## Where they come from: Open VSX

Desktop VS Code installs extensions
from Microsoft's marketplace. Builds
from the open-source code — which is
what code-server is — are not licensed
to use that marketplace, so
code-server installs from **Open VSX**,
the open, vendor-neutral registry run
under the Eclipse Foundation. Most
popular extensions are published
there by their own authors, and for
most readers the shelf feels complete.

The edge is real, though, and chapter
12 states it as a limit: a minority of
extensions are Microsoft's own and
marketplace-only — the best-known
being parts of Microsoft's Python and
remote-development tooling — and those
cannot be installed here at all, by
any route the project supports. If
your work depends on one specific
extension, check Open VSX for it
*before* building your workflow on
code-server, not after.
