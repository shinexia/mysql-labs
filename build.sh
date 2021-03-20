#!/bin/bash

cd $(dirname $0) || exit $?

ROOT_DIR=$(pwd)

MYSQL_SERVER_SRC_DIR=${ROOT_DIR}/mysql-server
MYSQL_SERVER_BLD_DIR=${ROOT_DIR}/build
MYSQL_SERVER_DST_DIR=${ROOT_DIR}/dist/mysql

BOOST_SRC_DIR=${ROOT_DIR}/boost
BOOST_DST_DIR=${ROOT_DIR}/dist/boost

function build_boost() {
    cd ${BOOST_SRC_DIR}
    ./bootstrap.sh --prefix=${BOOST_DST_DIR}
    ./b2 install
}

function build_mysql() {
    mkdir -p ${MYSQL_SERVER_BLD_DIR} && cd ${MYSQL_SERVER_BLD_DIR}
    cmake ${MYSQL_SERVER_SRC_DIR} -DWITH_BOOST=${BOOST_DST_DIR}/include -DCMAKE_INSTALL_PREFIX=${MYSQL_SERVER_DST_DIR}
    make -j$(nproc)
    make install
}

case $1 in

build_boost)
    build_boost
    ;;

build)
    build_mysql
    ;;

*)
    echo "usage $0 build"
    exit 1
    ;;

esac
