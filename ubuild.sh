#!/bin/bash

cd /projects/autoSD/u-boot-enric/
git archive --prefix=u-boot-ti-2023.10/ -o ~/rpmbuild/SOURCES/u-boot-ti-2023.10.tar.xz HEAD

cd /projects/autoSD/uboot-tools/
cp uboot-tools.spec ~/rpmbuild/SPECS/
cp *.patch aarch*s ~/rpmbuild/SOURCES/

rpmbuild -ba ~/rpmbuild/SPECS/uboot-tools.spec

cd /projects/autoSD/uboot-tools/
mkdir -p build
cd build
rpm2cpio ~/rpmbuild/RPMS/noarch/uboot-images-armv8-2023.10-1.0.el9.noarch.rpm | cpio -idmv
