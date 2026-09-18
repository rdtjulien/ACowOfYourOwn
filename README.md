# whalesay

A cow in a container. The starting point for µLab 1 of
[302 Data infrastructures](https://oesteban.github.io/isc-302-2026-2027-slides).

**Press "Use this template", not "Fork."** You want a repository you own, because
the workflow below publishes an image under *your* account, and a fork cannot do
that: on a pull request from a fork GitHub downgrades the token to read-only.

## What to do

```bash
git checkout -b group-N
# write group-N.cow
docker build -t my_whale .
docker run --rm my_whale -f group-N "hi from group N"
git add group-N.cow && git commit -m "add: group N's cow" && git push -u origin group-N
```

Then open a pull request against `main` **in your own repository** and watch the
*Actions* tab.

Cow templates worth stealing: <https://github.com/paulkaefer/cowsay-files>.

## What the workflow does

`.github/workflows/image.yml` has two triggers and one set of steps:

| Event | Builds | Publishes |
|---|---|---|
| `pull_request` | yes | **no** |
| `push` to `main` | yes | yes, to `ghcr.io/<you>/<repo>` |

So the pull-request run proves the image still assembles, and merging is what
puts it in the registry. Nothing is built on your laptop.

Two details that are easy to miss, and both of them bite:

- `permissions: packages: write` is what makes the publish legal. Without it the
  push fails with a 403, and the message does not say why.
- `ghcr.io` rejects uppercase, while GitHub keeps the case of your username. The
  workflow lowercases the name rather than assuming yours is already lowercase.

## After the first publish

A new package is **private** by default, even from a public repository. To let
anyone pull it:

> your profile → **Packages** → the package → *Package settings* →
> **Change visibility** → Public

Then, from any machine, with no login:

```bash
docker run --rm ghcr.io/<someone-else>/whalesay -f their-cow "moo"
```

## Licence

`cowsay` is Tony Monroe's, under the terms in [LICENSE](LICENSE). The Docker cow
is from the original `docker/whalesay`.
