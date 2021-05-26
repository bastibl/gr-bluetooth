# Copyright 2011,2012 Free Software Foundation, Inc.
#
# This file is a part of gr-bluetooth
#
# GNU Radio is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# GNU Radio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

########################################################################
# Setup library
########################################################################
include(GrPlatform) #define LIB_SUFFIX
find_package(BTBB REQUIRED)

list(APPEND bluetooth_sources
    tun.cc
    multi_block.cc
    multi_hopper_impl.cc
    multi_LAP_impl.cc
    multi_sniffer_impl.cc
    multi_UAP_impl.cc
    packet_impl.cc
    piconet_impl.cc
)

set(bluetooth_sources "${bluetooth_sources}" PARENT_SCOPE)
if(NOT bluetooth_sources)
    MESSAGE(STATUS "No C++ sources... skipping lib/")
    return()
endif(NOT bluetooth_sources)

add_library(gnuradio-bluetooth SHARED ${bluetooth_sources})
target_link_libraries(gnuradio-bluetooth
    btbb
    ${Boost_LIBRARIES}
    gnuradio::gnuradio-runtime
    gnuradio::gnuradio-blocks
    gnuradio::gnuradio-filter
    gnuradio::gnuradio-fft
    Volk::volk)
target_include_directories(gnuradio-bluetooth
    PUBLIC ${Boost_INCLUDE_DIR}
    PUBLIC ${LIBBTBB_INCLUDE_DIR}
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../include>
    PUBLIC $<INSTALL_INTERFACE:include>
  )
set_target_properties(gnuradio-bluetooth PROPERTIES DEFINE_SYMBOL "gnuradio_bluetooth_EXPORTS")

if(APPLE)
    set_target_properties(gnuradio-bluetooth PROPERTIES
        INSTALL_NAME_DIR "${CMAKE_INSTALL_PREFIX}/lib"
    )
endif(APPLE)

########################################################################
# Install built library files
########################################################################
include(GrMiscUtils)
GR_LIBRARY_FOO(gnuradio-bluetooth)

########################################################################
# Print summary
########################################################################
message(STATUS "Using install prefix: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "Building for version: ${VERSION} / ${LIBVER}")

########################################################################
# Build and register unit test
########################################################################
include(GrTest)

# If your unit tests require special include paths, add them here
#include_directories()
# List all files that contain Boost.UTF unit tests here
list(APPEND test_bluetooth_sources
)
# Anything we need to link to for the unit tests go here
list(APPEND GR_TEST_TARGET_DEPS gnuradio-bluetooth)

if(NOT test_bluetooth_sources)
    MESSAGE(STATUS "No C++ unit tests... skipping")
    return()
endif(NOT test_bluetooth_sources)

foreach(qa_file ${test_bluetooth_sources})
    GR_ADD_CPP_TEST("bluetooth_${qa_file}"
        ${CMAKE_CURRENT_SOURCE_DIR}/${qa_file}
    )
endforeach(qa_file)
