#!/bin/bash

cd $(dirname $0) || exit $?

ROOT_DIR=$(pwd)

MYSQL_SERVER_SRC_DIR=${ROOT_DIR}/mysql-server
MYSQL_SERVER_BLD_DIR=${ROOT_DIR}/build
MYSQL_SERVER_DST_DIR=${ROOT_DIR}/dist/mysql-server

BOOST_DIR=/data/opt/boost

function build_mysql() {
    mkdir -p ${MYSQL_SERVER_BLD_DIR} && cd ${MYSQL_SERVER_BLD_DIR}
    cmake ${MYSQL_SERVER_SRC_DIR} \
        -DWITH_BOOST=${BOOST_DIR} \
        -DDOWNLOAD_BOOST=1 \
        -DCMAKE_INSTALL_PREFIX=${MYSQL_SERVER_DST_DIR}
    make -j$(nproc)
    mkdir -p ${MYSQL_SERVER_DST_DIR}
    make install
}

function clean_all() {
    rm -frv build dist
}

case $1 in

build)
    build_mysql
    ;;

clean)
    clean_all
    ;;

*)
    echo "usage $0 build|clean"
    exit 1
    ;;

esac
