#!/bin/bash


if [ "${INST_LINVER}" = "$(pacman -Si ${INST_LINVAR}-headers | grep Version | awk '{ print $3 }')" ]; then
 pacman -S --noconfirm --needed ${INST_LINVAR}-headers
else
 pacman -U --noconfirm --needed https://archive.archlinux.org/packages/l/${INST_LINVAR}-headers/${INST_LINVAR}-headers-${INST_LINVER}-x86_64.pkg.tar.zst
fi
