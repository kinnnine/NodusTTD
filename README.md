# NodusTTD

OpenTTD Modification for the web that's capable of playing offline with additional features, served as a PWA.

## Building

Using GitHub Action is recommended, however can be done inside any Linux distribution that has below requirements/packages available.

### Requirements

- Bash, tar, diff, patch, make
- Docker Engine
- Git

First, get the source code (`git clone https://github.com/kinnnine/NodusTTD`).

### Building (static web self-hosting)

Everything you need to serve the files are inside the `/dist` folder.

```
cd NodusTTD
make
```

Finally, now you can use any HTTP server for playing (like nginx, apache or just python3 HTTP server).

```
cd dist
python3 -m http.server
```

### Developing

NodusTTD doesn't contain full OpenTTD source code files but uses patch files instead, for smaller codebase and maintenance.

When you execute `make` or `make prepare` will use `git clone` to obtain OpenTTD source code.

For development, we prepare a folder called `OpenTTD_work` using `prepareDev`, it will of course also run `prepare`.

```
cd NodusTTD
make prepareDev
```

Any files changes must go into `OpenTTD_work` not `OpenTTD_base`, for `OpenTTD_base` we use for patching and building.

After you're done, use `genPatches` to update `patches` folder contents, it will contain changed files as a patch files.

```
make genPatches
```

Finally run `make` again to test it out.

## License

Anything inside this repository, but excluding OpenTTD source code upon obtaining, building and developing are under MIT License.
