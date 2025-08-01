@echo off

REM ========================================
REM (Optional) Clean previous build
REM ========================================
@REM REM rmdir /s /q Build


REM ========================================
REM Configure with Visual Studio (MSBuild)
REM ========================================
cmake -G "Visual Studio 17 2022" ^
    -T v142 ^
    -A x64 ^
    -DAC_ADDON_LANGUAGE="INT" ^
    -DAC_API_DEVKIT_DIR="acapi28/Support" ^
    -DAC_VERSION=28 ^
    -DCMAKE_BUILD_TYPE=Debug ^
    -B Build

cmake --build Build -j8

REM ========================================
REM Setup MSVC Environment
REM ========================================
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

REM ========================================
REM Configure with Ninja for compile_commands.json
REM ========================================
cmake -G Ninja ^
    -DCMAKE_C_COMPILER=cl.exe ^
    -DCMAKE_CXX_COMPILER=cl.exe ^
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ^
    -DAC_ADDON_LANGUAGE="INT" ^
    -DAC_API_DEVKIT_DIR="acapi28/Support" ^
    -DAC_VERSION=28 ^
    -DCMAKE_BUILD_TYPE=Debug ^
    -B Build_Ninja

cd Build_Ninja
move compile_commands.json ../compile_commands.json
cd ..
rmdir /s /q Build_Ninja
pause
