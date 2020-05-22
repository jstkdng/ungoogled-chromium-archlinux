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

# Send files to obs
AUTH="authorization: Basic ${OBS_AUTH}"
declare -a FILES=(PKGBUILD _service)

for FILE in "${FILES[@]}"
do
    URL="https://api.opensuse.org/source/home:justkidding:arch/ungoogled-chromium/${FILE}?rev=upload"
    curl -XPUT -H 'Content-Type: application/octet-stream' -H "${AUTH}" --data-binary "@${FILE}" $URL
done
curl -XPOST -H "${AUTH}" "https://api.opensuse.org/source/home:justkidding:arch/ungoogled-chromium" -F "cmd=commit"
