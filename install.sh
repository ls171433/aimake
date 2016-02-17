#! /bin/sh

INSTALL=install
INSTALL_FLAGS='-c -D'

RM=rm
RM_FLAGS='-f'

SRC_DIR=$(dirname $(which $0))
BIN_DIR=/usr/local/bin
ETC_DIR=/etc

AIMAKE_SH='aimake'
AIMAKE_RES='main.mk'
AIMAKE_PLATFOTMS='android darwin ios linux mingw'
AIMAKE_PLATFOTM_RES='build_all.mk  build_executable.mk  build_shared_library.mk  build_static_library.mk  init.mk'

AIMAKE_android_RES=${AIMAKE_PLATFOTM_RES}
AIMAKE_darwin_RES=${AIMAKE_PLATFOTM_RES}
AIMAKE_ios_RES="${AIMAKE_PLATFOTM_RES} auto.sh rlipo.sh"
AIMAKE_linux_RES=${AIMAKE_PLATFOTM_RES}
AIMAKE_mingw_RES=${AIMAKE_PLATFOTM_RES}

echo ${INSTALL} ${INSTALL_FLAGS} ${SRC_DIR}/${AIMAKE_SH} ${BIN_DIR}/${AIMAKE_SH}
${INSTALL} ${INSTALL_FLAGS} ${SRC_DIR}/${AIMAKE_SH} ${BIN_DIR}/${AIMAKE_SH}

for FILE in ${AIMAKE_RES}
do
    echo ${INSTALL} ${INSTALL_FLAGS} ${SRC_DIR}/${FILE} ${BIN_DIR}/${FILE}
    ${INSTALL} ${INSTALL_FLAGS} ${SRC_DIR}/${FILE} ${BIN_DIR}/${FILE}
done

for PLATFORM in ${AIMAKE_PLATFOTMS}
do
    PLATFOTM_RES=$(echo AIMAKE_${PLATFORM}_RES)
    for FILE in $(eval echo \$${PLATFOTM_RES})
    do
        echo ${INSTALL} ${INSTALL_FLAGS} ${SRC_DIR}/${PLATFORM}/${FILE} ${BIN_DIR}/${PLATFORM}/${FILE}
        ${INSTALL} ${INSTALL_FLAGS} ${SRC_DIR}/${PLATFORM}/${FILE} ${BIN_DIR}/${PLATFORM}/${FILE}
    done
done
