#! /bin/sh

INSTALL=install
INSTALL_FLAGS='-c -D '

RM=rm
RM_FLAGS='-f '

AIMAKE_D='aimake.d'

SRC_PATH=$(dirname $(which $0))
SRC_BIN_PATH=${SRC_PATH}/bin
SRC_ETC_PATH=${SRC_PATH}/etc
SRC_RES_PATH=${SRC_PATH}/etc
SRC_PLATFORM_PATH=${SRC_RES_PATH}/${AIMAKE_D}

TAR_PATH=/usr/local
TAR_BIN_PATH=${TAR_PATH}/bin
TAR_ETC_PATH=/etc
TAR_RES_PATH=${TAR_PATH}/etc
TAR_PLATFORM_PATH=${TAR_RES_PATH}/${AIMAKE_D}

AIMAKE='aimake '
AIMAKE_ETC='aimakerc '
AIMAKE_RES="${AIMAKE_D}/main.mk "
AIMAKE_PLATFOTM='android darwin ios linux mingw '
AIMAKE_PLATFOTM_RES='build_all.mk  build_executable.mk  build_shared_library.mk  build_static_library.mk  init.mk '

AIMAKE_android_RES=${AIMAKE_PLATFOTM_RES}
AIMAKE_darwin_RES=${AIMAKE_PLATFOTM_RES}
AIMAKE_ios_RES=${AIMAKE_PLATFOTM_RES}
AIMAKE_linux_RES=${AIMAKE_PLATFOTM_RES}
AIMAKE_mingw_RES=${AIMAKE_PLATFOTM_RES}
AIMAKE_ios_RES+='auto.sh rlipo.sh '

AIMAKERC_FILE="${TAR_ETC_PATH}/aimakerc"

while getopts 'ciu' OPT
do
    case ${OPT} in
    c)
        OPERATION=check
    ;;
    i)
        OPERATION=install
    ;;
    u)
        OPERATION=uninstall
    ;;
    *)
        exit 1
    ;;
    esac
done

if [ "${OPERATION}" = '' ]
then
    OPERATION=install
fi

case ${OPERATION} in
install)
    echo ${INSTALL} ${INSTALL_FLAGS} ${SRC_BIN_PATH}/${AIMAKE} ${TAR_BIN_PATH}/${AIMAKE}
    ${INSTALL} ${INSTALL_FLAGS} ${SRC_BIN_PATH}/${AIMAKE} ${TAR_BIN_PATH}/${AIMAKE}

    for FILE in ${AIMAKE_ETC}
    do
        echo ${INSTALL} ${INSTALL_FLAGS} ${SRC_ETC_PATH}/${FILE} ${TAR_ETC_PATH}/${FILE}
        ${INSTALL} ${INSTALL_FLAGS} ${SRC_ETC_PATH}/${FILE} ${TAR_ETC_PATH}/${FILE}
    done

    for FILE in ${AIMAKE_RES}
    do
        echo ${INSTALL} ${INSTALL_FLAGS} ${SRC_RES_PATH}/${FILE} ${TAR_RES_PATH}/${FILE}
        ${INSTALL} ${INSTALL_FLAGS} ${SRC_RES_PATH}/${FILE} ${TAR_RES_PATH}/${FILE}
    done

    for PLATFORM in ${AIMAKE_PLATFOTM}
    do
        PLATFOTM_RES=$(echo AIMAKE_${PLATFORM}_RES)
        for FILE in $(eval echo \$${PLATFOTM_RES})
        do
            echo ${INSTALL} ${INSTALL_FLAGS} ${SRC_PLATFORM_PATH}/${PLATFORM}/${FILE} ${TAR_PLATFORM_PATH}/${PLATFORM}/${FILE}
            ${INSTALL} ${INSTALL_FLAGS} ${SRC_PLATFORM_PATH}/${PLATFORM}/${FILE} ${TAR_PLATFORM_PATH}/${PLATFORM}/${FILE}
        done
    done

    echo "echo aimake_home=${TAR_RES_PATH}/${AIMAKE_D} >${AIMAKERC_FILE}"
    echo aimake_home=${TAR_RES_PATH}/${AIMAKE_D} >${AIMAKERC_FILE}
;;
uninstall)
    echo ${RM} ${RM_FLAGS} ${TAR_BIN_PATH}/${AIMAKE}
    ${RM} ${RM_FLAGS} ${TAR_BIN_PATH}/${AIMAKE}

    for FILE in ${AIMAKE_RES}
    do
        echo ${RM} ${RM_FLAGS} ${TAR_ETC_PATH}/${FILE}
        ${RM} ${RM_FLAGS} ${TAR_ETC_PATH}/${FILE}
    done

    for PLATFORM in ${AIMAKE_PLATFOTM}
    do
        PLATFOTM_RES=$(echo AIMAKE_${PLATFORM}_RES)
        for FILE in $(eval echo \$${PLATFOTM_RES})
        do
            echo ${RM} ${RM_FLAGS} ${TAR_PLATFORM_PATH}/${PLATFORM}/${FILE}
            ${RM} ${RM_FLAGS} ${TAR_PLATFORM_PATH}/${PLATFORM}/${FILE}
        done
    done
;;
*)
;;
esac
