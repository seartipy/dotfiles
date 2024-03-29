#! /usr/bin/env bash

{

cpp_check() {
    cmd_check cmake scons cppcheck clang++

    is_linux && cmd_check g++
    is_ubuntu && cmd_check ninja bear clang-format clang-tidy
    is_mac && cmd_check ninja bear
}

#
# c++

cpp_ubuntu_install() {
    is_ubuntu || return 1

    slog "Installing C++"
    sudo apt-get install -y clang libclang-dev libc++-dev libc++abi-dev libboost-all-dev g++ cppcheck scons cmake bear clang-format clang-tidy ninja-build lldb
}

cpp_mac_install() {
    is_mac || return 1

    slog "Installing c++ packages"
    brew install boost
    brew install cmake
    brew install scons
    brew install boost-build
    brew install cppcheck
    brew install clang-format
    brew install ninja
    brew install bear
}

cpp_install() {
    cpp_mac_install
    cpp_ubuntu_install
}

installer() {
    setup_backup_dir
    cpp_install
    cpp_check
}

}
