import re
import os


class MakefileParser:

    line_continue_pattern = r'\\\n'
    # co robi r ?
    target_pattern = 'TARGET\\s*=\\s*(\\w*)'
    defines_pattern = 'DEFINES\\s*=\\s*(.*)'
    define_pattern = '-D(\\S*)'
    cxx_flags_pattern = 'CXXFLAGS\\s*=\\s(.*)'
    cxx_flag_pattern = '(?:^|\\s)([^\\$\\s]\\S*[^\\$\\s])'
    includes_pattern = 'INCPATH\\s*=\\s(.*)'
    include_pattern = '\\"(\\S*)\\"'
    target_type_pattern = '\\#\\s*Template:\\s*([\\w]*)'
    sources_pattern = 'SOURCES\\s*=\\s*(.*)'
    # source_pattern =

    def __init__(self, makefile_path):
        self.makefile_path = makefile_path

    def parse_file(self):
        if os.path.isfile(self.makefile_path):
            with open(self.makefile_path) as makefile:
                makefile_data = makefile.read()

            # delete line continuations
            makefile_data = re.sub(self.line_continue_pattern, '',
                                   makefile_data)

            new_makefile = open('new_makefile', 'w')
            new_makefile.write(makefile_data)
            new_makefile.close()

            # targets
            self.list_of_targets = re.findall(self.target_pattern,
                                              makefile_data)
            print('list_of_targets:', self.list_of_targets)

            # defines
            defines = re.findall(self.defines_pattern, makefile_data)
            self.list_of_defines = re.findall(self.define_pattern,
                                              defines[0])
            print('list_of_defines:', self.list_of_defines)

            # cxx flags
            cxx_flags = re.findall(self.cxx_flags_pattern, makefile_data)
            self.list_of_cxx_flags = re.findall(self.cxx_flag_pattern,
                                                cxx_flags[0])
            print('list_of_cxx_flags:', self.list_of_cxx_flags)

            # includes
            includes = re.findall(self.includes_pattern, makefile_data)
            self.list_of_includes = re.findall(self.include_pattern,
                                               includes[0])
            print('list_of_includes:', self.list_of_includes)

            # target type
            self.target_type = re.findall(self.target_type_pattern,
                                          makefile_data)
            print('target_type:', self.target_type)

            # sources
            sources = re.findall(self.sources_pattern, makefile_data)
            self.list_of_sources = sources[0].split()
            print('sources:', self.list_of_sources)

    def make_cmake(self, path_to_cmake):
        cmake = open(path_to_cmake, 'w')
        cmake.write('cmake_minimum_required(VERSION 3.1...3.15)\n')
        cmake.write('\n')
        cmake.write('if(${CMAKE_VERSION} VERSION_LESS 3.12)\n')
        cmake.write('    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}')
        cmake.write('.${CMAKE_MINOR_VERSION})\n')
        cmake.write('endif()\n')
        cmake.write('\n')
        cmake.write('if(MSVC)\n')
        cmake.write('    message(status \"Setting MSVC flags\")\n')
        cmake.write('    set(CMAKE_CXX_FLAGS\n')
        for cxx_flag in self.list_of_cxx_flags:
            cmake.write('        ')
            cmake.write(cxx_flag)
            cmake.write('\n')
        for define in self.list_of_defines:
            cmake.write('        -D')
            cmake.write(define)
            cmake.write('\n')

        cmake.write('    )\n')
        cmake.write('endif()\n')
        cmake.write('set(CMAKE_EXPORT_COMPILE_COMMANDS ON)\n')
        cmake.write('message(status "** CMAKE_CXX_FLAGS: ')
        cmake.write('${CMAKE_CXX_FLAGS}")\n')
        cmake.write('set(project_sources\n')
        for source in self.list_of_sources:
            cmake.write('    ')
            cmake.write(source)
            cmake.write('\n')

        cmake.write(')\n')
        if self.target_type[0] == 'lib':
            cmake.write('add_library(${PROJECT_NAME}\n')
            cmake.write('    ${project_sources})\n')

        cmake.write('target_include_directories(${PROJECT_NAME}\n')
        for include in self.list_of_includes:
            cmake.write('    ')
            cmake.write(include)
            cmake.write('\n')

        cmake.write(')\n')


project = 'radosc'
makefile_path = os.path.join('makefile')

makefile_parser = MakefileParser(makefile_path)
makefile_parser.parse_file()
makefile_parser.make_cmake('CMakeLists.txt')
