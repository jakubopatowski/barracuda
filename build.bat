REM START "c:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/vcvarsall.bat"
cmake -B build -G "Ninja" -DCMAKE_C_COMPILER="c:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/cl.exe" -DCMAKE_CXX_COMPILER="c:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/cl.exe" .
