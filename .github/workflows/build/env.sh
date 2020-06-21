#/bin/bash
shopt -s dotglob

echo "==> Installing required packages"
pacman -Syu jq

echo "==> Copying build files..."
cp -r * /home/build
chown -R build /home/build

echo "==> Copying makepkg.conf..."
rm /etc/makepkg.conf
cp .github/workflows/build/makepkg.conf /etc/makepkg.conf
