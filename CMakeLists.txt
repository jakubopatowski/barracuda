cmake_minimum_required(VERSION 3.1...3.15)

if(${CMAKE_VERSION} VERSION_LESS 3.12)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()

project(Barracuda)

set (PROGRAM_VERSION_MAJOR 0)
set (PROGRAM_VERSION_MINOR 1)
set (PROGRAM_VERSION_PATCH 0)

configure_file (
  "${PROJECT_SOURCE_DIR}/ProgramConfig.h.in"
  "${PROJECT_SOURCE_DIR}/ProgramConfig.h")

# Setup flags for compilers
if(UNIX)
  message(status "Setting GCC flags")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fexceptions -g -Wall")
elseif(MSVC)
  message(status "Setting MSVC flags")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHc")
endif()
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
message(status "** CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")

#=====================
#..:: BOOST SETUP ::..
#=====================

# set boost includes
set(Boost_USE_STATIC_LIBS      OFF)  # only find static libs
set(Boost_USE_DEBUG_LIBS       ON)   # ignore debug libs and
set(Boost_USE_RELEASE_LIBS     OFF)  # only find release libs
set(Boost_USE_MULTITHREADED    ON)
set(Boost_USE_STATIC_RUNTIME   OFF)
if(UNIX)
  set(BOOST_LIBRARYDIR         "/usr/lib64")
elseif(MSVC)
  set(BOOST_ROOT               "c:/Jopa/HOME/Projekty/boost/boost_1_69_0")
endif()

find_package(Boost REQUIRED COMPONENTS date_time)

message("==============================================================")
message("                        ..:: BOOST ::..                       ")
message("==============================================================")
message("Boost_FOUND:                ${Boost_FOUND}")
message("Boost_VERSION:              ${Boost_VERSION}")
message("BOOST_ROOT:                 ${BOOST_ROOT}")
message("Boost_INCLUDE_DIRS:         ${Boost_INCLUDE_DIRS}")
message("Boost_LIBRARY_DIRS:         ${Boost_LIBRARY_DIRS}")
message("Boost_LIBRARIES:            ${Boost_LIBRARIES}")
message("==============================================================")

#=====================
# ..:: QT5 SETUP ::..
#=====================

find_package(Qt5 COMPONENTS REQUIRED Core Gui Widgets)

message("==============================================================")
message("                   ..:: Qt5 Widgets::..                       ")
message("==============================================================")
message("Qt5Widgets_FOUND:           ${Qt5Widgets_FOUND}")
message("Qt5Widgets_VERSION:         ${Qt5Widgets_VERSION}")
message("Qt5Widgets_INCLUDE_DIRS:    ${Qt5Widgets_INCLUDE_DIRS}")
message("Qt5Widgets_LIBRARIES:       ${Qt5Widgets_LIBRARIES}")
message("==============================================================")

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(project_sources
  mainwindow.cpp
  main.cpp)

set(project_headers
  mainwindow.h)

set(project_ui
  mainwindow.ui)

# wrap the ui file to a c++ header
qt5_wrap_ui(ui_wrap ${project_ui})
qt5_wrap_cpp(moc_sources ${project_headers})

message("==============================================================")
message("                  ..:: nlohmann_json ::..                     ")
message("==============================================================")

set(CMAKE_PREFIX_PATH "~/Projekty/json/build")
find_package(nlohmann_json 3.2.0 REQUIRED)

#=====================
# ..:: Visual Studio Setup ::..
#=====================

add_executable(${PROJECT_NAME}
  ${project_sources}
  ${project_headers}
  ${ui_wrap}
  ${moc_sources})

target_link_libraries(${PROJECT_NAME}
  PRIVATE
  ${Boost_LIBRARIES}
  Qt5::Core
  Qt5::Gui
  Qt5::Widgets
  nlohmann_json::nlohmann_json)

target_include_directories(${PROJECT_NAME}
  PRIVATE
  ${PROJECT_SOURCE_DIR}
  ${Boost_INCLUDE_DIRS}
  ${Qt5Widgets_INCLUDE_DIRS})

# auto copy dlls if on windows
if(MSVS)
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:Qt5::Core> $<TARGET_FILE_DIR:${PROJECT_NAME}>
    COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:Qt5::Gui> $<TARGET_FILE_DIR:${PROJECT_NAME}>
    COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:Qt5::Widgets> $<TARGET_FILE_DIR:${PROJECT_NAME}> )
endif()
