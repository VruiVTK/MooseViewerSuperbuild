# This script fetches and builds MooseViewer

SET(MooseViewer_ROOT
  "${CMAKE_BINARY_DIR}/MooseViewer"
  )

SET(MooseViewer_CMAKE_ARGS
  "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
  "-DVRUI_PKGCONFIG_DIR:PATH=${VRUI_ROOT}/pkgconfig"
  "-DVTK_DIR:PATH=${VTK_ROOT}/bld"
  "-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}"
  "-DvtkVRUI_INCLUDE_DIRS=${vtkVRUI_ROOT}/src"
  # TODO find a more flexible way of finding the library:
  "-DvtkVRUI_LIBRARIES=${vtkVRUI_ROOT}/bld/lib/libvtkVRUI.a"
  )

ExternalProject_Add(
  MooseViewer
  DEPENDS VRUI VTK vtkVRUI
  PREFIX "${MooseViewer_ROOT}"
  STAMP_DIR "${MooseViewer_ROOT}/stamp"
  GIT_REPOSITORY "https://github.com/VruiVTK/MooseViewer.git"
  GIT_TAG "master"
  #  UPDATE_COMMAND ${GIT_EXECUTABLE} pull
  SOURCE_DIR "${MooseViewer_ROOT}/src"
  BINARY_DIR "${MooseViewer_ROOT}/bld"
  CMAKE_ARGS ${MooseViewer_CMAKE_ARGS}
  )

