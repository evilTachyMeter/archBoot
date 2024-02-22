# this is important
after updating the PKGBUILD file, git clone the repo, go into my-metapackages directory and run:
```bash
mkdir -p ./chroots
mkarchroot -C /etc/pacman.conf ./chroots/root base-devel
makechrootpkg -cur ./chroots
```
this will buld a new package file that cam be installed with pacman -U <filename>.tar.**
