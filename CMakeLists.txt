CMAKE_MINIMUM_REQUIRED(VERSION 3.14)
PROJECT(Barracuda)

SET (PROGRAM_VERSION_MAJOR 0)
SET (PROGRAM_VERSION_MINOR 1)
SET (PROGRAM_VERSION_PATCH 0)

CONFIGURE_FILE (
  "${PROJECT_SOURCE_DIR}/ProgramConfig.h.in"
  "${PROJECT_SOURCE_DIR}/ProgramConfig.h")

# Setup flags for compilers
IF(UNIX)
  MESSAGE(status "Setting GCC flags")
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fexceptions -g -Wall")
ELSEIF(MSVC)
  MESSAGE(status "Setting MSVC flags")
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHc")
ENDIF()
SET(CMAKE_EXPORT_COMPILE_COMMANDS ON)
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
IF(UNIX)
  SET(BOOST_LIBRARYDIR         "/usr/lib64")
ELSEIF(MSVC)
  SET(BOOST_ROOT               "c:/Jopa/HOME/Projekty/boost/boost_1_69_0")
ENDIF()

FIND_PACKAGE(Boost REQUIRED COMPONENTS date_time)
INCLUDE_DIRECTORIES("${Boost_INCLUDE_DIRS}")

MESSAGE("==============================================================")
MESSAGE("                        ..:: BOOST ::..                       ")
MESSAGE("==============================================================")
MESSAGE("Boost_FOUND:                ${Boost_FOUND}")
MESSAGE("Boost_VERSION:              ${Boost_VERSION}")
MESSAGE("BOOST_ROOT:                 ${BOOST_ROOT}")
MESSAGE("Boost_INCLUDE_DIRS:         ${Boost_INCLUDE_DIRS}")
MESSAGE("Boost_LIBRARY_DIRS:         ${Boost_LIBRARY_DIRS}")
MESSAGE("Boost_LIBRARIES:            ${Boost_LIBRARIES}")
MESSAGE("==============================================================")

#=====================
# ..:: QT5 SETUP ::..
#=====================

FIND_PACKAGE(Qt5 COMPONENTS REQUIRED Core Gui Widgets)
INCLUDE_DIRECTORIES("${Qt5Widgets_INCLUDE_DIRS}")

MESSAGE("==============================================================")
MESSAGE("                   ..:: Qt5 Widgets::..                       ")
MESSAGE("==============================================================")
MESSAGE("Qt5Widgets_FOUND:           ${Qt5Widgets_FOUND}")
MESSAGE("Qt5Widgets_VERSION:         ${Qt5Widgets_VERSION}")
MESSAGE("Qt5Widgets_INCLUDE_DIRS:    ${Qt5Widgets_INCLUDE_DIRS}")
MESSAGE("Qt5Widgets_LIBRARIES:       ${Qt5Widgets_LIBRARIES}")
MESSAGE("==============================================================")

SET(CMAKE_INCLUDE_CURRENT_DIR ON)

SET(project_sources
  mainwindow.cpp
  main.cpp)

SET(project_headers
  mainwindow.h)

SET(project_ui
  mainwindow.ui)

# wrap the ui file to a c++ header
qt5_wrap_ui(ui_wrap ${project_ui})
qt5_wrap_cpp(moc_sources ${project_headers})

#=====================
# ..:: Visual Studio Setup ::..
#=====================

ADD_EXECUTABLE(${PROJECT_NAME}
  ${project_sources}
  ${project_headers}
  ${ui_wrap}
  ${moc_sources})

TARGET_LINK_LIBRARIES(${PROJECT_NAME}
  PUBLIC
  ${Boost_LIBRATIES}
  Qt5::Core
  Qt5::Gui
  Qt5::Widgets)

# auto copy dlls if on windows
if(MSVS)
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:Qt5::Core> $<TARGET_FILE_DIR:${PROJECT_NAME}>
    COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:Qt5::Gui> $<TARGET_FILE_DIR:${PROJECT_NAME}>
    COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:Qt5::Widgets> $<TARGET_FILE_DIR:${PROJECT_NAME}> )
  
  add_custom_target(setupMSVS2015x64BuildEnv
    COMMAND c:/WINDOWS/system32/cmd.exe ARGS /k "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86_amd64)
    #COMMAND "C:\WINDOWS\system32\cmd.exe /k \"\"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\vcvarsall.bat\"\" x86_amd64")

  add_dependencies(setupMSVS2015x64BuildEnv ${PROJECT_NAME})
endif()
