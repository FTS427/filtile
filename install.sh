#!/bin/sh

BUILD_MODE=release
PKGNAME=filtile
INSTALL_DOC=no
MANDB_DIR=/usr/share/man

cargo build --${BUILD_MODE}

if [ -e target/${BUILD_MODE}/${PKGNAME} ]; then
	mv target/${BUILD_MODE}/${PKGNAME} "${HOME}/.local/bin"
fi

if [ $INSTALL_DOC == "yes" ]; then
	echo "Manaul doc installation start..."
	scdoc < doc/${PKGNAME}.1.scd | gzip -9 > ${MANDB_DIR}/man1/${PKGNAME}.1.gz
fi

