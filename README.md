# 🚧 Test repo please ignore 🚧

>[!NOTE]
>All quotes in this text are of "massive sarcasm quotes" kind.

This repo is a playground to get myself familiar with GitHub's CI/CD to build and draft releases there; testing not on a real project with real users, but on a thing that is structured "similar" to my repos I'd like to set up CI/CD for — with MelonLoader mods for Unity games, having its own caveats, like not distributing random Unity DLLs the mods depend on to be built and run. It's probably not very useful (or useful at all) for anyone else.

I'm still not sure "having the accessibly via non-public URL only shared to actual workers" is completely okay, but they have to get these _somewhere_, and I'd like to at least experiment with this.

If you're still interested, below is a quick rundown on what this repo is about.

# Contents
This repo consists of two parts that mock different parts of actual mod projects I have.

## "Mod solution"
`Bnfour.WorkflowTesting.Proper.slnx` is a solution for the actual mod projects for a given repo. It has one project, `SomeAssembly`, that is a placeholder to an actual MelonLoader mod, and is published in releases.

### The "app"
`SomeAssembly` is a console app, not a classlib like mods it imitates — it's not really important, I just wanted something runnable.

When run, it just outputs a copypasta into stdout.

The app has a dependency on some DLL not distributed in releases for some _mysterious_ reason, and would not run or build without it. See later sections on the DLL itself.

### The "tests"
Just there to add a step to the workflow. Not that any of my projects has good coverage.

### Helper scripts
Just some bash scripts that mock other bash scripts that originally automated the stuff I did by hand to create a release asset .zip on my local machine; these will probably get updated to run on a runner VM later.

TODO what they actually do, like zipping the "mod" assembly and its runtime config

## "External dependency"
`CompletelyExternal/Reference.csproj` is source for an "external" DLL that provides some utility for the actual app. It's here just so the repo is self-sufficient, and is never built directly. Instead, I'm supposed to provide the binary for runners "somehow". The solution I've come up with is to host it at non-disclosed URL, provided to runners as repo secret, so it's accessible to these only, but nowhere else.

In real projects those DLLs would be things like MelonLoader, its custom Harmony, game assemblies, and random Unity libraries. I think the latter two are not okay to distribute, the users are supposed to have these as well.

While I do dump all the dependencies MelonLoader install generates to the `references` folder, a ripgrep call like
```bash
rg -o --no-filename --no-line-number --no-heading "\.\./references/(.*\.dll)" -r '$1' | sort -u
```
can be used to get filenames of DLLs that are actually referenced. If the runner build fails because of missing one, just re-run and add missing ones to the upload.

The "library" itself is a single method to format the copypasta like [this website](https://stallman-copypasta.github.io/). Original credit goes to rms, _the_ free software man.

# Actual workflow
TODO a small section on this later when i get it working?
like what, build, pack, draft a release, upload packed thing as a release asset, then i write "funny" release notes and publish the finished release, maybe even set it up to be immutable

# License
0BSD. Do whatever.
