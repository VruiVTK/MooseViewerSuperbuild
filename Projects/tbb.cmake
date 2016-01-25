set(TBB_ROOT
  ${CMAKE_BINARY_DIR}/TBB
  CACHE INTERNAL ""
)

if(WIN32)
  if(CMAKE_SIZEOF_VOID_P EQUAL 8) # 64 bit arch
    set(tbb_archdir intel64)
  else()
    set(tbb_archdir ia32)
  endif()
  if(MSVC10)
    set(tbb_vsdir vc10)
  elseif(MSVC11)
    set(tbb_vsdir vc11)
  elseif(MSVC12)
    set(tbb_vsdir vc12)
  else()
    message(FATAL_ERROR "tbb does not support your Visual Studio compiler. "
                        "Please use a system version.")
  endif()
  set(tbb_libdir "lib/${tbb_archdir}/${tbb_vsdir}")
  set(tbb_libsuffix ${CMAKE_IMPORT_LIBRARY_SUFFIX})
elseif(APPLE)
  set(tbb_libdir "lib")
  set(tbb_libsuffix ${CMAKE_SHARED_LIBRARY_SUFFIX})
else()
  if(CMAKE_SIZEOF_VOID_P EQUAL 8) # 64 bit arch
    set(tbb_archdir intel64)
  else()
    set(tbb_archdir ia32)
  endif()
  # Assume gcc >= 4.4. Change to gcc4.1 if needed.
  set(tbb_libdir "lib/${tbb_archdir}/gcc4.4")
  set(tbb_libsuffix "${CMAKE_SHARED_LIBRARY_SUFFIX}*")
endif()

set(tbb_ver "44_20150728oss")
if(WIN32)
  set(tbb_file "tbb${tbb_ver}_win.zip")
  set(tbb_md5 "e7bbf293cdb5a50ca81347c80168956d")
elseif(APPLE)
  set(tbb_file "tbb${tbb_ver}_osx.tgz")
  set(tbb_md5 "a767d7a8b375e6b054e44e2317d806b8")
else()
  set(tbb_file "tbb${tbb_ver}_lin_0.tgz")
  set(tbb_md5 "ab5df80a65adf423b14637a1f35814b2")
endif()

ExternalProject_Add(
  TBB
  PREFIX "${TBB_ROOT}"
  STAMP_DIR "${TBB_ROOT}/stamp"
  SOURCE_DIR "${TBB_ROOT}/src"
  BINARY_DIR "${TBB_ROOT}/bld"
  URL "http://www.paraview.org/files/dependencies/${tbb_file}"
  URL_MD5 "${tbb_md5}"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND
    "${CMAKE_COMMAND}"
    "-Dsource_location:PATH=<SOURCE_DIR>"
    "-Dinstall_location:PATH=<BINARY_DIR>"
    "-Dlibdir:STRING=${tbb_libdir}"
    "-Dlibsuffix:STRING=${tbb_libsuffix}"
    "-Dlibsuffixshared:STRING=${CMAKE_SHARED_LIBRARY_SUFFIX}"
    "-Dlibprefix:STRING=${CMAKE_SHARED_LIBRARY_PREFIX}"
    -P "${CMAKE_CURRENT_LIST_DIR}/tbb.install.cmake"
)
