%comspec% /k ""C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"" x86_amd64
REM START "c:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/vcvarsall.bat"
cmake -B build -G "Ninja" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
