# This script fetches and builds VRUI

SET (VRUI_ROOT
  ${CMAKE_BINARY_DIR}/VRUI
  CACHE INTERNAL ""
  )

file(MAKE_DIRECTORY "${VRUI_ROOT}/pkgconfig")
file(MAKE_DIRECTORY "${VRUI_ROOT}/bld")

set(debugFlag)
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set(debugFlag "DEBUG=1")
endif()

set(patchDir "${CMAKE_SOURCE_DIR}/Projects/patches")

ExternalProject_Add (
  VRUI
  PREFIX "${VRUI_ROOT}"
  STAMP_DIR "${VRUI_ROOT}/stamp"
  URL "http://idav.ucdavis.edu/~okreylos/ResDev/Vrui/Vrui-3.1-002.tar.gz"
  URL_HASH SHA1=3c4ded4ed18e4a16394cdc1d625d7d0f4f84b108
  UPDATE_COMMAND ""
  PATCH_COMMAND "${CMAKE_COMMAND}" -E copy "${patchDir}/VRUI_src.GLMotif.ListBox.h" "${VRUI_ROOT}/src/GLMotif/ListBox.h"
  SOURCE_DIR "${VRUI_ROOT}/src"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${CMAKE_BUILD_TOOL} ${debugFlag} INSTALLDIR=${VRUI_ROOT}/bld PKGCONFIGINSTALLDIR=${VRUI_ROOT}/pkgconfig
  INSTALL_COMMAND ${CMAKE_BUILD_TOOL} ${debugFlag} INSTALLDIR=${VRUI_ROOT}/bld PKGCONFIGINSTALLDIR=${VRUI_ROOT}/pkgconfig install
  BUILD_IN_SOURCE 1
  )
