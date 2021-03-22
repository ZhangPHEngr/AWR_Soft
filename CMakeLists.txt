#声明 CMAKE最低版本 要求
cmake_minimum_required(VERSION 3.10)

#设置工程名
project(AWR_Soft)


#添加CUDA编译配置信息
FIND_PACKAGE(CUDA REQUIRED)
INCLUDE_DIRECTORIES(${CUDA_INCLUDE_DIRS})
INCLUDE(/usr/share/cmake-3.10/Modules/FindCUDA.cmake)

#添加头文件搜索路径
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include)

#添加当前目录下的文件到指定变量中
file(GLOB CU ${PROJECT_SOURCE_DIR}/src/*.cu)
file(GLOB CPP ${PROJECT_SOURCE_DIR}/src/*.cpp ${PROJECT_SOURCE_DIR}/src/*.c)
file(GLOB HPP ${PROJECT_SOURCE_DIR}/include/*.hpp ${PROJECT_SOURCE_DIR}/include/*.h)
#打印消息
message(STATUS "cu file:" ${CU})
message(STATUS "cpp file:" ${CPP})
message(STATUS "hpp file:" ${HPP})

#设置可执行文件输出路径
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
#生成可执行文件
CUDA_ADD_EXECUTABLE(${PROJECT_NAME} main.cpp ${CPP} ${CU} ${HPP})



