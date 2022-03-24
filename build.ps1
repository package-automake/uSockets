function BuildForWindows($platform, $build_type, $libuv_dir) {
    $build_dir = "build"
    mkdir $build_dir -Force -ErrorAction Stop | Out-Null
    cd $build_dir
    ls

    if ($platform -eq "x64") {
        $msbuild_platform = "x64"
    }
    else {
        $msbuild_platform = "Win32"
    }


    cmake -G "Visual Studio 16 2019" `
    -A $msbuild_platform `
    -D CMAKE_BUILD_TYPE=${build_type} `
    -D libuv_DIR=${libuv_dir} `
    -D CMAKE_INSTALL_PREFIX=install ../uSockets/src

    msbuild INSTALL.vcxproj /t:build /p:configuration=$build_type /p:platform=$msbuild_platform -maxcpucount
    ls
    cd ..
}