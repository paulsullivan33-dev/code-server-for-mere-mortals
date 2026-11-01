# Opening a Folder

**Outcome: you understand what the
server does with the folder you name,
you can read a file back out of it
through the server's own web routes
without a browser, and you know
exactly where plain HTTP stops and
the live browser session begins.**

## The folder is an argument, not a setting

code-server opens what you name on the
command line:

```bash
./code-server --config ./config.yaml ./workspace
```

A folder, or a `.code-workspace` file
if you keep one. Leave the argument
off and it reopens whatever was open
last (the `--ignore-last-opened` flag
exists for when you do not want that).
There is no step where you "import" a
project: the folder on the server's
disk *is* the project, which is the
whole point of running the editor on
the machine that holds the files.

## Two redirects, then the editor

Signed in and asking for `/`, the lab
did not get a page. It got 83 bytes:

```text
Found. Redirecting to ./?folder=/home/hatch/workspace/code-server-labwork/workspace
```

The server redirects the front door to
the same address with the folder named
in the query string — `?folder=<the
absolute path>`. Following it returned
the real thing: HTTP 200 and a 5,842-byte
page (transcript `t07`). That page is
the **workbench loader**: it carries
Microsoft's copyright header, a
`code/didStartRenderer` timing mark,
the icons that let a browser offer
code-server as an installable web app,
and the scripts that then download the
editor proper and open a live
connection back to the server. A
browser does all of that invisibly in
about a second; seeing the two hops
once, by hand, is how you know what
the browser is doing for you.

## Reading a file back out

The workbench talks to the server over
its live connection, but one plain web
route is reachable with nothing more
than the session cookie — the route
the editor itself uses when you ask it
to download a file:

```bash
curl -b cookies.txt \
  "http://127.0.0.1:18083/vscode-remote-resource?path=/home/hatch/workspace/code-server-labwork/workspace/hello.py"
```

```python
# A stock fixture program for the lab workspace.
def greet(name):
    return f"Hello, {name}!"
...
```

The exact bytes of the file, served by
the editor's own server (transcript
`t06`). Two checks make that result
mean something. The same request
**without** the cookie answers **401** —
the route is inside the boundary, not
beside it. And the second fixture file
fetched the same way under the hashed
config of chapter 8, which is how the
lab knew that sign-in was real and not
a leftover cookie.

## The write that HTTP refuses

The lab then tried to *create* a file
the same way, POSTing content at the
same route. The answer is one of the
most instructive lines in this guide:

```text
Unsupported method POST
```

— HTTP **405**, and no file appeared
in the workspace (transcript `t07`).
That route is a download route. Edits,
saves, new files, terminal commands:
all of those travel over the live
connection the workbench opens after
it loads, not over plain request-and-
response HTTP. This is the honest
shape of the tool, and the lab's
characterisation of the whole guide
follows from it — everything *around*
the editor can be scripted and proven;
the editing itself happens in a
browser session, and chapter 6 treats
it that way rather than pretending a
curl command was a keystroke.
