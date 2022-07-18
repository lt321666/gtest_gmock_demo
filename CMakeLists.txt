CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

#--------------------------------------------
# Project setting
#--------------------------------------------
SET(PROJECT_ROOT ${CMAKE_CURRENT_SOURCE_DIR})
SET(AUTHOR "\"${AUTHOR}\"")
SET(BOOK_TIME "\"${BOOK_TIME}\"")
SET(TPROJECT_VERSION ${PROJECT_VERSION})
SET(PROJECT_VERSION "\"${PROJECT_VERSION}\"")
SET(EMAIL "\"${EMAIL}\"")

configure_file ("${PROJECT_ROOT}/scripts/conf/version.hpp.in" "${PROJECT_ROOT}/src/common/version.hpp")

INCLUDE(cmake/messagecolor.cmake)

PROJECT(sample_project)

OPTION(BUILD_TESTS "Build with tests" ON)


#--------------------------------------------
# Show default config path
#--------------------------------------------
MESSAGE(INFO "--------------------------------")
MESSAGE(STATUS "Build sample_project: ${TPROJECT_VERSION}")
MESSAGE(STATUS "Build with tests: ${BUILD_TESTS}")
MESSAGE(STATUS "Build install prefix: ${CMAKE_INSTALL_PREFIX}")
MESSAGE(STATUS "Build root prefix: ${PROJECT_ROOT}")
IF (NOT CMAKE_TOOLCHAIN_FILE)
    MESSAGE(STATUS "CMAKE_TOOLCHAIN_FILE: ${CMAKE_TOOLCHAIN_FILE}")
ENDIF()

# 添加预定义宏 
MESSAGE(INFO "--------------------------------")
# 是否打印输出
option(ENABLE_TRACE_PRINTF "option for trace" ON)
if (ENABLE_TRACE_PRINTF) 
	add_definitions(-DENABLE_TRACE_PRINTF)
endif(ENABLE_TRACE_PRINTF)
# 是否打印日志
option(ENABLE_LOG_PRINTF "option for log" ON)
if (ENABLE_LOG_PRINTF) 
	add_definitions(-DENABLE_LOG_PRINTF)
endif(ENABLE_LOG_PRINTF)
MESSAGE(STATUS "option for trace : ${ENABLE_TRACE_PRINTF}")
MESSAGE(STATUS "option for log : ${ENABLE_LOG_PRINTF}")
#--------------------------------------------
# Set default build to debug
#--------------------------------------------
IF(NOT CMAKE_BUILD_TYPE)
    SET(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose Release or Debug" FORCE)
ENDIF()

MESSAGE(STATUS "Build type: " ${CMAKE_BUILD_TYPE})


#--------------------------------------------
# Set compilation options
#--------------------------------------------
MESSAGE(INFO "--------------------------------")
INCLUDE(cmake/toolchain_options.cmake)
INCLUDE(cmake/load_gtest.cmake)
INCLUDE(cmake/load_spdlog.cmake)

IF (CMAKE_SYSTEM_NAME MATCHES "Linux")
    IF(NOT YOUR_TARGET_OS)
        SET(YOUR_TARGET_OS linux)
    ENDIF()
    IF(NOT YOUR_TARGET_ARCH)
        SET(YOUR_TARGET_ARCH x86-64)
    ENDIF()
ELSEIF (CMAKE_SYSTEM_NAME MATCHES "Windows")
    IF(NOT YOUR_TARGET_OS)
        SET(YOUR_TARGET_OS windows)
    ENDIF()
    IF(NOT YOUR_TARGET_ARCH)
        SET(YOUR_TARGET_ARCH x86-64)
    ENDIF()
ENDIF (CMAKE_SYSTEM_NAME MATCHES "Linux")

MESSAGE(STATUS "Your system is : ${CMAKE_SYSTEM}")
MESSAGE(STATUS "Your target os : ${YOUR_TARGET_OS}")
MESSAGE(STATUS "Your target arch : ${YOUR_TARGET_ARCH}")

# 配置安装项
MESSAGE(INFO "--------------------------------")
SET(CMAKE_INSTALL_PREFIX "${PROJECT_ROOT}/bin")
MESSAGE(STATUS "Set Build install prefix : ${CMAKE_INSTALL_PREFIX}")

#--------------------------------------------
# Load 3rdparty
#--------------------------------------------
MESSAGE(INFO "--------------------------------")
LOAD_LIBGTEST(YOUR_TARGET_OS YOUR_TARGET_ARCH)
LOAD_LIBSPDLOG(YOUR_TARGET_OS YOUR_TARGET_ARCH)

#--------------------------------------------
# Build 3rdparty
#--------------------------------------------
MESSAGE(INFO "--------------------------------")
#--------------------------------------------
ADD_SUBDIRECTORY(3rdparty)

# Build application
#--------------------------------------------
# MESSAGE(INFO "--------------------------------")
# ADD_SUBDIRECTORY(src)


IF(BUILD_TESTS)
    MESSAGE(INFO "--------------------------------")
    ADD_SUBDIRECTORY(tests)
ENDIF()


