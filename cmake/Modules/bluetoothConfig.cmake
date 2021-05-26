INCLUDE(FindPkgConfig)
PKG_CHECK_MODULES(PC_BLUETOOTH bluetooth)

FIND_PATH(
    BLUETOOTH_INCLUDE_DIRS
    NAMES bluetooth/api.h
    HINTS $ENV{BLUETOOTH_DIR}/include
        ${PC_BLUETOOTH_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    BLUETOOTH_LIBRARIES
    NAMES gnuradio-bluetooth
    HINTS $ENV{BLUETOOTH_DIR}/lib
        ${PC_BLUETOOTH_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
          )

include("${CMAKE_CURRENT_LIST_DIR}/bluetoothTarget.cmake")

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(BLUETOOTH DEFAULT_MSG BLUETOOTH_LIBRARIES BLUETOOTH_INCLUDE_DIRS)
MARK_AS_ADVANCED(BLUETOOTH_LIBRARIES BLUETOOTH_INCLUDE_DIRS)
