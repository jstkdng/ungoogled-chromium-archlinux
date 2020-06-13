#/bin/bash
shopt -s dotglob
cp -r * /home/build
chown -R build /home/build
rm /etc/makepkg.conf
cp .github/workflows/build/makepkg.conf /etc/makepkg.conf
