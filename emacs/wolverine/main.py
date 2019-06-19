import mmap
import re
import os

target_pattern = b'TARGET\\s*=\\s*(\\w*)'
defines_pattern = b'DEFINES\\s*=\\s*(.*)'
define_pattern = b'-D(\\S*)'
cxx_flags_pattern = b'CXXFLAGS\\s*=\\s(.*)'
cxx_flag_pattern = b'(?:^|\\s)([^\\$\\s]\\S*[^\\$\\s])'
includes_pattern = b'INCPATH\\s*=\\s(.*)'
include_pattern = b'\\"(\\S*)\\"'

projects = os.listdir('c:/Projekty/trunk/src')
makefile_name = 'makefile'
cmakelists_name = 'CMakeLists.txt'
for project in projects:
    project_path = os.path.join('c:\\', 'Projekty', 'trunk', 'src', project)
    makefile_path = os.path.join('c:\\', 'Projekty', 'trunk',
                                 'win32-msvc2015_d', project, 'qt4')
    makefile_file = os.path.join(makefile_path, makefile_name)

    if not os.path.isfile(makefile_file):
        continue

    print('==============================')
    print(project)
    print(project_path)
    print(makefile_path)
    print(makefile_file)

    with open(makefile_file, 'r') as makefile, \
            mmap.mmap(makefile.fileno(), 0, access=mmap.ACCESS_READ) as stream:

        # targets
        list_of_targets = re.findall(target_pattern, stream)
        # defines
        defines = re.findall(defines_pattern, stream)
        list_of_defines = re.findall(define_pattern, defines[0])
        # cxx flags
        cxx_flags = re.findall(cxx_flags_pattern, stream)
        list_of_cxx_flags = re.findall(cxx_flag_pattern, cxx_flags[0])
        # includes
        includes = re.findall(includes_pattern, stream)
        list_of_includes = re.findall(include_pattern, includes[0])

        print(list_of_targets)
        print(list_of_defines)
        print(list_of_cxx_flags)
        print(list_of_includes)

        makefile.close()
