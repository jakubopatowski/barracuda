CMAKE_MINIMUM_REQUIRED(VERSION 3.14)
PROJECT(Barracuda)

SET (PROGRAM_VERSION_MAJOR 0)
SET (PROGRAM_VERSION_MINOR 1)
SET (PROGRAM_VERSION_PATCH 0)

CONFIGURE_FILE (
  "${PROJECT_SOURCE_DIR}/ProgramConfig.h.in"
  "${PROJECT_SOURCE_DIR}/ProgramConfig.h")

# Setup flags for compilers
if (UNIX)
  MESSAGE(status "Setting GCC flags")
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fexceptions -g -Wall")
else()
  MESSAGE(status "Setting MSVC flags")
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHc")
endif()
MESSAGE(status "** CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")

# set project includes
INCLUDE_DIRECTORIES("${PROJECT_SOURCE_DIR}")

#=====================
#..:: BOOST SETUP ::..
#=====================

# set boost includes
SET(Boost_USE_STATIC_LIBS      OFF)  # only find static libs
SET(Boost_USE_DEBUG_LIBS       ON)   # ignore debug libs and
SET(Boost_USE_RELEASE_LIBS     OFF)  # only find release libs
SET(Boost_USE_MULTITHREADED    ON)
SET(Boost_USE_STATIC_RUNTIME   OFF)
SET(BOOST_LIBRARYDIR           "/usr/lib64")

FIND_PACKAGE(Boost REQUIRED COMPONENTS date_time)

# project setup
MESSAGE("==============================================================")
MESSAGE("                        ..:: BOOST ::..                       ")
MESSAGE("==============================================================")
MESSAGE("PROJEDT_BINARY_DIR:         ${PROJECT_BINARY_DIR}")
MESSAGE("BOOST_ROOT:                 ${BOOST_ROOT}")
MESSAGE("BOOST_INCLUDEDIR:           ${BOOST_INCLUDEDIR}")
MESSAGE("BOOST_LIBRARYDIR:           ${BOOST_LIBRARYDIR}")
MESSAGE("Boost_FOUND:                ${Boost_FOUND}")
MESSAGE("Boost_INCLUDE_DIRS:         ${Boost_INCLUDE_DIRS}")
MESSAGE("Boost_LIBRARY_DIRS:         ${Boost_LIBRARY_DIRS}")
MESSAGE("Boost_LIBRARIES:            ${Boost_LIBRARIES}")
MESSAGE("==============================================================")

ADD_EXECUTABLE(${PROJECT_NAME}
  main.cpp)

TARGET_LINK_LIBRARIES(${PROJECT_NAME}
  ${Boost_LIBRATIES})
