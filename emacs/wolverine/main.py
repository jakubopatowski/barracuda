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

            print(list_of_targets)
            print(list_of_defines)
            print(list_of_cxx_flags)
            print(list_of_includes)
            print(target_type)

    def make_cmake(self, path_to_cmake):
        cmake = open(path_to_cmake, 'w')
        cmake.write()


project = 'radosc'
makefile_path = os.path.join('c:\\', 'Projekty', 'trunk',
                             'win32-msvc2015_d', project,
                             'qt4', 'makefile')

makefile_parser = MakefileParser(makefile_path)
makefile_parser.parse_file()
