# ungoogled-chromium-archlinux

Arch Linux packaging for [ungoogled-chromium](//github.com/Eloston/ungoogled-chromium).

## Downloads

Available in the AUR as `ungoogled-chromium`
	* NOTE: `ungoogled-chromium-bin` is *not* officially part of ungoogled-chromium. Please submit all issues to the maintainer of the PKGBUILD.


You can also use my repository. I added some additional patches and I try to update this as soon as Eloston releases a
new version.
To use it first import my gpg key to your pacman keyring:
```bash
$ sudo pacman-key -r 3DEA62513C8035383A245A12E5786B42E8E5D565
$ sudo pacman-key --lsign-key 3DEA62513C8035383A245A12E5786B42E8E5D565
```
And edit your /etc/pacman.conf adding this lines:
```
[jk-aur]
Server = https://repo.vin.ovh/arch/$arch
```


Alternatively, [get builds from the Contributor Binaries website](//ungoogled-software.github.io/ungoogled-chromium-binaries/).

**Source Code**: It is recommended to use a tag. You may also use `master`, but it is for development and may not be stable.

## Building

Install the base-devel group with pacman and clone this repository:
```
$ sudo pacman -Sy base-devel
$ git clone https://github.com/jstkdng/ungoogled-chromium-archlinux.git
$ cd ungoogled-chromium-archlinux
```
After that just run makepkg and wait. It might take 4 to 6 hours (depending on your processor) to compile chromium.
Finally just install the resulting .pkg.tar.xz
```
$ sudo pacman -U ungoogled-chromium-*-x86_64.pkg.tar.xz
```

## Developer info

TODO

Patches are in GNU Quilt format.

GN flags in `flags.archlinux.gn` are appended to `flags.gn` from the ungoogled-chromium repo before GN is run.

Useful script `devutils/update_platform_patches.py` in ungoogled-chromium repo to update patches.

## Useful flags
The binary /usr/bin/chromium is a launcher that will read the flags in your ~/.config/chromium-flags.conf and pass them
to the main chromium binary located in /usr/lib/chromium. Adding these lines will enable gpu acceleration and change
chromium's ui to a nice dark color.
```
--ignore-gpu-blacklist
--enable-gpu-rasterization
--enable-native-gpu-memory-buffers
--enable-accelerated-mjpeg-decode
--enable-zero-copy
--enable-accelerated-video
--force-dark-mode
--enable-features=WebUIDarkMode
```
You still need to setup hardware acceleration in your arch installation, to do that, read this wiki page:
[Hardware video acceleration](https://wiki.archlinux.org/index.php/Hardware_video_acceleration)

## License

See [LICENSE](LICENSE)
