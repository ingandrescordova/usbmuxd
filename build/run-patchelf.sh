#!/bin/sh

# Patch the so dependencies for all executables in the out directory 
# Redirect from libimobiledevice.so.6 to libimobiledevice.so,
# and change the out folder in the rpath to ${ORIGIN}
# (this will be the setup in our target environment)
#
# For more info, see:
# https://github.com/NixOS/patchelf
# http://man7.org/linux/man-pages/man8/ld.so.8.html

patchelf=patchelf-0.9/src/patchelf

for f in $HOME/out/sbin/*; do
   chmod +w $f

   $patchelf --set-rpath '${ORIGIN}' $f
   $patchelf --remove-needed libimobiledevice.so.6 $f
   $patchelf --add-needed libimobiledevice.so $f

   readelf -d $f
done