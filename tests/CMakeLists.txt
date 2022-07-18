CMAKE_MINIMUM_REQUIRED(VERSION 3.1)
PROJECT(Tests)




#添加包含头文件路径
INCLUDE_DIRECTORIES(
    ${SPDLOG_INCLUDE_DIR}
    ${CMAKE_SOURCE_DIR}/src/test_product_code         	#项目的源码目录
    ${PROJECT_SOURCE_DIR}           					#测试的源码目录
    ${GTEST_INCLUDE_DIR}            					#gtest头文件目录
	${CMAKE_SOURCE_DIR}/src/calculate         	#项目的源码目录
	${CMAKE_SOURCE_DIR}/src/Configure 
)
MESSAGE(STATUS ${GTEST_INCLUDE_DIR})

#添加需要链接的库文件目录
LINK_DIRECTORIES(
    ${SPDLOG_LIBRARY_DIR}
    ${GTEST_LIBRARY_DIR}            #gtest库目录
)

# 递归遍历头文件
file(GLOB_RECURSE testHeaderFiles "${PROJECT_SOURCE_DIR}/*.hpp" "${PROJECT_SOURCE_DIR}/*.h")
# 递归遍历源文件
file(GLOB_RECURSE testSrcFiles "${PROJECT_SOURCE_DIR}/*.cpp" "${PROJECT_SOURCE_DIR}/*.c")
MESSAGE(STATUS ${testHeaderFiles})

# 递归遍历头文件
file(GLOB_RECURSE SrcHeaderFiles 
	"${CMAKE_SOURCE_DIR}/src/Configure/*.hpp"
	"${CMAKE_SOURCE_DIR}/src/calculate/*.hpp"  
	"${CMAKE_SOURCE_DIR}/src/*.h"
	)
# 递归遍历源文件
file(GLOB_RECURSE SrcSrcFiles 
	"${CMAKE_SOURCE_DIR}/src/Configure/*.cpp" 
	"${CMAKE_SOURCE_DIR}/src/calculate/*.cpp"
	)

# 编译所有源文件
add_executable(testAPP
	${testHeaderFiles}          #功能文件夹的头文件
	${testSrcFiles}             #功能软件的所有源文件
	#${logger}
	#${MemTrack}
	${SrcHeaderFiles}          #功能文件夹的头文件
	${SrcSrcFiles}             #功能软件的所有源文件
	)


# 链接库文件
target_link_libraries(testAPP
	#PkgConfig::GLIB
	#PkgConfig::DBUS  
	#PkgConfig::SQLITE3
	#${JSONC_LIBS}
	#${libIPCProtocol_LIBS}
	#${JSONCPP_LIBS}
	#${CURL_LIBS}
	#${LIBZIP_LIBS}
	#${libcryptopp_LIBS}
	#${LIBEMB_LIBS}
	${GTEST_LIBS}               #链接gtest等库gmock gtest pthread
	#rkdb
	#gdbus
	#pthread
	)

#安装可执行文件到bin目录
INSTALL(TARGETS testAPP
            ARCHIVE DESTINATION lib
            LIBRARY DESTINATION lib
            RUNTIME DESTINATION bin)


MESSAGE(STATUS "测试CMakeLists.txt完成")