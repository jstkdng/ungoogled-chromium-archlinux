#!/bin/bash
source PKGBUILD
newdeps=$(printf "'%s' " "${depends[@]}")
makedeps=$(printf "'%s' " "${makedepends[@]}")

# append required dependencies
makedeps=$(printf '%s\n' "${makedeps//\'java-runtime-headless\'/}")
makedeps="${makedeps}'jack' 'jre-openjdk-headless'"

sed -r -i \
    -e '/^depends=/,/[)]$/cdepends=('"${newdeps}"')' \
    -e '/^depends[+]=/d' \
    -e '/^makedepends=/,/[)]$/cmakedepends=('"${makedeps}"')' \
    "PKGBUILD"
