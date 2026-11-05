#!/usr/bin/env bash

# This script creates a signed tag for a commit it runs from:
# - committer identity is whoever authored the base commit (me, basically)
# - the key is provided via repo secrets (should match the committer)

# for the ease of automation, the signing key lacks a passphrase
# (it's not like a passphrase being another repo secret would matter in case these are compromised)

# grab author name and email from latest commit
author=$(git show --no-patch --format=%an HEAD)
email=$(git show --no-patch --format=%ae HEAD)

# set up the key itself
key="$RUNNER_TEMP/tag-signing.key"
pubkey="$key.pub"
echo "$SIGNING_KEY" > "$key"
chmod 600 "$key"

ssh-keygen -y -f "$key" > "$pubkey"

# set up git: identity and signing key
git config --local user.name "$author"
git config --local user.email "$email"
git config --local gpg.format ssh
git config --local user.signingkey "$pubkey"
# shellcheck disable=2154 # new_version's written to GITHUB_ENV in an earlier script
git tag -s "v$new_version" -m "Release $new_version. This is an automatically created tag."
git push origin "v$new_version"
