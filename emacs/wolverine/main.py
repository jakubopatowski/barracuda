import re
import os


class MakefileParser:

    target_pattern = 'TARGET\\s*=\\s*(\\w*)'
    defines_pattern = 'DEFINES\\s*=\\s*(.*)'
    define_pattern = '-D(\\S*)'
    cxx_flags_pattern = 'CXXFLAGS\\s*=\\s(.*)'
    cxx_flag_pattern = '(?:^|\\s)([^\\$\\s]\\S*[^\\$\\s])'
    includes_pattern = 'INCPATH\\s*=\\s(.*)'
    include_pattern = '\\"(\\S*)\\"'
    target_type_pattern = '\\#\\s*Template:\\s*([\\w]*)'

    def __init__(self, makefile_path):
        self.makefile_path = makefile_path

    def parse_file(self):
        if os.path.isfile(self.makefile_path):
            with open(self.makefile_path) as makefile:
                makefile_data = makefile.read()

            # targets
            list_of_targets = re.findall(self.target_pattern, makefile_data)

            # defines
            defines = re.findall(self.defines_pattern, makefile_data)
            list_of_defines = re.findall(self.define_pattern, defines[0])

            # cxx flags
            cxx_flags = re.findall(self.cxx_flags_pattern, makefile_data)
            list_of_cxx_flags = re.findall(self.cxx_flag_pattern, cxx_flags[0])

            # includes
            includes = re.findall(self.includes_pattern, makefile_data)
            list_of_includes = re.findall(self.include_pattern, includes[0])

            # target type
            target_type = re.findall(self.target_type_pattern, makefile_data)

            print('list_of_targets:')
            print(list_of_targets)

            print('list_of_defines:')
            print(list_of_defines)

            print('list_of_cxx_flags:')
            print(list_of_cxx_flags)

            print('list_of_includes:')
            print(list_of_includes)

            print('target_type:')
            print(target_type)

    def make_cmake(self, path_to_cmake):
        cmake = open(path_to_cmake, 'w')
        cmake.write('cmake_minimum_required(VERSION 3.1...3.15)\n')
        cmake.write('\n')
        cmake.write('if(${CMAKE_VERSION} VERSION_LESS 3.12)\n')
        cmake.write('    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}')
        cmake.write('.${CMAKE_MINOR_VERSION})\n')
        cmake.write('endif()\n')
        cmake.write('\\n')


project = 'radosc'
makefile_path = os.path.join('makefile')

makefile_parser = MakefileParser(makefile_path)
makefile_parser.parse_file()
makefile_parser.make_cmake('CMakeLists.txt')
