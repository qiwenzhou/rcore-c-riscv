# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/penghy/Desktop/labs-2018011375/user

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/penghy/Desktop/labs-2018011375/user/build

# Include any dependencies generated for this target.
include CMakeFiles/ch3_0_sleep.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/ch3_0_sleep.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ch3_0_sleep.dir/flags.make

CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.o: CMakeFiles/ch3_0_sleep.dir/flags.make
CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.o: ../src/ch3_0_sleep.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/penghy/Desktop/labs-2018011375/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.o"
	riscv64-linux-musl-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.o   -c /home/penghy/Desktop/labs-2018011375/user/src/ch3_0_sleep.c

CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.i"
	riscv64-linux-musl-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/penghy/Desktop/labs-2018011375/user/src/ch3_0_sleep.c > CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.i

CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.s"
	riscv64-linux-musl-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/penghy/Desktop/labs-2018011375/user/src/ch3_0_sleep.c -o CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.s

# Object files for target ch3_0_sleep
ch3_0_sleep_OBJECTS = \
"CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.o"

# External object files for target ch3_0_sleep
ch3_0_sleep_EXTERNAL_OBJECTS =

riscv64/ch3_0_sleep: CMakeFiles/ch3_0_sleep.dir/src/ch3_0_sleep.c.o
riscv64/ch3_0_sleep: CMakeFiles/ch3_0_sleep.dir/build.make
riscv64/ch3_0_sleep: libulib.a
riscv64/ch3_0_sleep: CMakeFiles/ch3_0_sleep.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/penghy/Desktop/labs-2018011375/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable riscv64/ch3_0_sleep"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ch3_0_sleep.dir/link.txt --verbose=$(VERBOSE)
	mkdir -p asm
	riscv64-linux-musl-objdump -d -S /home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3_0_sleep > asm/ch3_0_sleep.asm
	mkdir -p target
	riscv64-linux-musl-objcopy -O binary /home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3_0_sleep target/ch3_0_sleep.bin --set-section-flags .bss=alloc,load,contents

# Rule to build all files generated by this target.
CMakeFiles/ch3_0_sleep.dir/build: riscv64/ch3_0_sleep

.PHONY : CMakeFiles/ch3_0_sleep.dir/build

CMakeFiles/ch3_0_sleep.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ch3_0_sleep.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ch3_0_sleep.dir/clean

CMakeFiles/ch3_0_sleep.dir/depend:
	cd /home/penghy/Desktop/labs-2018011375/user/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/penghy/Desktop/labs-2018011375/user /home/penghy/Desktop/labs-2018011375/user /home/penghy/Desktop/labs-2018011375/user/build /home/penghy/Desktop/labs-2018011375/user/build /home/penghy/Desktop/labs-2018011375/user/build/CMakeFiles/ch3_0_sleep.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ch3_0_sleep.dir/depend

