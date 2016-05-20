# This script fetches and builds the vtkVRUI core lib

set(vtkVRUI_ROOT "${CMAKE_BINARY_DIR}/vtkVRUI")

set(vtkVRUI_CMAKE_ARGS
  -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
  -DVRUI_PKGCONFIG_DIR:PATH=${VRUI_ROOT}/pkgconfig
  -DVTK_DIR:PATH=${VTK_ROOT}/bld
  -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}
)

ExternalProject_Add(
  vtkVRUI
  DEPENDS VRUI VTK
  PREFIX "${vtkVRUI_ROOT}"
  STAMP_DIR "${vtkVRUI_ROOT}/stamp"
  GIT_REPOSITORY "https://github.com/VruiVTK/vtkVRUI.git"
  GIT_TAG "master"
  #  UPDATE_COMMAND ${GIT_EXECUTABLE} pull
  SOURCE_DIR "${vtkVRUI_ROOT}/src"
  BINARY_DIR "${vtkVRUI_ROOT}/bld"
  CMAKE_ARGS ${vtkVRUI_CMAKE_ARGS}
  INSTALL_COMMAND
)

