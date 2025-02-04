# OBS CMake Windows defaults module

include_guard(GLOBAL)

set(OBS_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(OBS_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/rundir")

set(OBS_PLUGIN_DESTINATION obs-plugins/64bit)
set(OBS_DATA_DESTINATION data)
set(OBS_CMAKE_DESTINATION cmake)
set(OBS_SCRIPT_PLUGIN_DESTINATION "${OBS_DATA_DESTINATION}/obs-scripting/64bit")

set(OBS_EXECUTABLE_DESTINATION bin/64bit)
set(OBS_LIBRARY_DESTINATION lib)
set(OBS_INCLUDE_DESTINATION include)
# Set relative paths used by OBS for self-discovery
set(OBS_PLUGIN_PATH "../../${CMAKE_INSTALL_LIBDIR}/obs-plugins/64bit")
set(OBS_SCRIPT_PLUGIN_PATH "../../${OBS_DATA_DESTINATION}/obs-scripting/64bit")
set(OBS_DATA_PATH "../../${OBS_DATA_DESTINATION}")

# Enable find_package targets to become globally available targets
set(CMAKE_FIND_PACKAGE_TARGETS_GLOBAL TRUE)

include(buildspec)
include(cpackconfig)

set(RESOURCE_OUTPUT_DIR "${OBS_EXECUTABLE_DESTINATION}")
file(MAKE_DIRECTORY ${RESOURCE_OUTPUT_DIR})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/.deps/obs-deps-2023-06-22-x64/bin/ffmpeg.exe ${RESOURCE_OUTPUT_DIR}/../../rundir/Release/bin/64bit/ffmpeg.exe COPYONLY)
# need ffmpeg.exe

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  execute_process(
    COMMAND
      "${CMAKE_COMMAND}" -S ${CMAKE_CURRENT_SOURCE_DIR} -B ${CMAKE_SOURCE_DIR}/build_x86 -A Win32 -G
      "${CMAKE_GENERATOR}" -DCMAKE_SYSTEM_VERSION:STRING='${CMAKE_SYSTEM_VERSION}' -DOBS_CMAKE_VERSION:STRING=3.0.0
      -DVIRTUALCAM_GUID:STRING=${VIRTUALCAM_GUID} -DCMAKE_MESSAGE_LOG_LEVEL=${CMAKE_MESSAGE_LOG_LEVEL}
      -DENABLE_CCACHE=${ENABLE_CCACHE}
    RESULT_VARIABLE _process_result COMMAND_ERROR_IS_FATAL ANY)
endif()
