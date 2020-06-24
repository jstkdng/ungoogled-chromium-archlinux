#!/bin/bash
set -e

declare -a FILES=(PKGBUILD _service)
declare -A PROJECTS=(
    [master]=ungoogled-chromium
    [ozone]=ungoogled-chromium-ozone
    [dev]=ungoogled-chromium-git
)

# Generate _service file
cat > "$GITHUB_WORKSPACE/_service" << EOF
<services>
  <service name="download_url">
    <param name="protocol">https</param>
    <param name="host">commondatastorage.googleapis.com</param>
    <param name="path">/chromium-browser-official/chromium-${pkgver}.tar.xz</param>
    <param name="filename">chromium-${pkgver}.tar.xz</param>
  </service>
  <service name="download_url">
    <param name="protocol">https</param>
    <param name="host">github.com</param>
    <param name="path">/foutrelis/chromium-launcher/archive/v6.tar.gz</param>
    <param name="filename">chromium-launcher-6.tar.gz</param>
  </service>
  <service name="download_url">
    <param name="protocol">https</param>
    <param name="host">github.com</param>
    <param name="path">/Eloston/ungoogled-chromium/archive/${_ungoogled_ver}.zip</param>
    <param name="filename">ungoogled-chromium-${_ungoogled_ver}.zip</param>
  </service>
  <service name="tar_scm">
    <param name="scm">git</param>
    <param name="url">git://github.com/jstkdng/ungoogled-chromium-archlinux</param>
    <param name="revision">master</param>
    <param name="extract">chromium.install</param>
    <param name="extract">chromium-drirc-disable-10bpc-color-configs.conf</param>
    <param name="extract">*.patch</param>
  </service>
</services>
EOF

# make temporary directory
TMP=$(mktemp -d)
cp "${FILES[@]}" $TMP
cd $TMP

# decide which project to use
BRANCH=${GITHUB_REF##*/}
if [ -z ${GITHUB_HEAD_REF+x} ]; then
    BRANCH=${GITHUB_HEAD_REF##*/}
fi
OBS_PROJECT=${PROJECTS[$BRANCH]}

source PKGBUILD

# Add required dependencies for OBS
newdeps=$(printf "'%s' " "${depends[@]}")
makedeps=$(printf "'%s' " "${makedepends[@]}")

makedeps=$(printf '%s\n' "${makedeps//\'java-runtime-headless\'/}")
makedeps="${makedeps}'jack' 'jre-openjdk-headless'"

sed -r -i \
    -e '/^depends=/,/[)]$/cdepends=('"${newdeps}"')' \
    -e '/^depends[+]=/d' \
    -e '/^makedepends=/,/[)]$/cmakedepends=('"${makedeps}"')' \
    "PKGBUILD"

# Send files to obs
AUTH="authorization: Basic ${OBS_AUTH}"
BASE_URL="https://api.opensuse.org/source/home:justkidding:arch/${OBS_PROJECT}"
for FILE in "${FILES[@]}"
do
    URL="${BASE_URL}/${FILE}?rev=upload"
    curl -XPUT -H 'Content-Type: application/octet-stream' -H "${AUTH}" --data-binary "@${FILE}" $URL
done
curl -XPOST -H "${AUTH}" "${BASE_URL}" -F "cmd=commit"
