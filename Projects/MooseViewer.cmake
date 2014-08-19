# This script fetches and builds MooseViewer

SET(MooseViewer_ROOT
  "${CMAKE_BINARY_DIR}/MooseViewer"
  )

SET(MooseViewer_CMAKE_ARGS
  -DVRUI_PKGCONFIG_DIR:PATH=${VRUI_ROOT}/pkgconfig
  -DVTK_DIR:PATH=${VTK_ROOT}/bld
  -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}
  )

ExternalProject_Add(
  MooseViewer
  DEPENDS VRUI VTK
  PREFIX "${MooseViewer_ROOT}"
  STAMP_DIR "${MooseViewer_ROOT}/stamp"
  GIT_REPOSITORY "https://github.com/VruiVTK/MooseViewer.git"
  GIT_TAG "master"
  #  UPDATE_COMMAND ${GIT_EXECUTABLE} pull
  SOURCE_DIR "${MooseViewer_ROOT}/src"
  BINARY_DIR "${MooseViewer_ROOT}/bld"
  CMAKE_ARGS ${MooseViewer_CMAKE_ARGS}
  )

