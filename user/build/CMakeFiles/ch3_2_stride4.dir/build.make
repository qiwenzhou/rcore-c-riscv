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
include CMakeFiles/ch3_2_stride4.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/ch3_2_stride4.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ch3_2_stride4.dir/flags.make

CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.o: CMakeFiles/ch3_2_stride4.dir/flags.make
CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.o: ../src/ch3_2_stride4.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/penghy/Desktop/labs-2018011375/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.o"
	riscv64-linux-musl-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.o   -c /home/penghy/Desktop/labs-2018011375/user/src/ch3_2_stride4.c

CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.i"
	riscv64-linux-musl-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/penghy/Desktop/labs-2018011375/user/src/ch3_2_stride4.c > CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.i

CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.s"
	riscv64-linux-musl-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/penghy/Desktop/labs-2018011375/user/src/ch3_2_stride4.c -o CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.s

# Object files for target ch3_2_stride4
ch3_2_stride4_OBJECTS = \
"CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.o"

# External object files for target ch3_2_stride4
ch3_2_stride4_EXTERNAL_OBJECTS =

riscv64/ch3_2_stride4: CMakeFiles/ch3_2_stride4.dir/src/ch3_2_stride4.c.o
riscv64/ch3_2_stride4: CMakeFiles/ch3_2_stride4.dir/build.make
riscv64/ch3_2_stride4: libulib.a
riscv64/ch3_2_stride4: CMakeFiles/ch3_2_stride4.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/penghy/Desktop/labs-2018011375/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable riscv64/ch3_2_stride4"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ch3_2_stride4.dir/link.txt --verbose=$(VERBOSE)
	mkdir -p asm
	riscv64-linux-musl-objdump -d -S /home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3_2_stride4 > asm/ch3_2_stride4.asm
	mkdir -p target
	riscv64-linux-musl-objcopy -O binary /home/penghy/Desktop/labs-2018011375/user/build/riscv64/ch3_2_stride4 target/ch3_2_stride4.bin --set-section-flags .bss=alloc,load,contents

# Rule to build all files generated by this target.
CMakeFiles/ch3_2_stride4.dir/build: riscv64/ch3_2_stride4

.PHONY : CMakeFiles/ch3_2_stride4.dir/build

CMakeFiles/ch3_2_stride4.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ch3_2_stride4.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ch3_2_stride4.dir/clean

CMakeFiles/ch3_2_stride4.dir/depend:
	cd /home/penghy/Desktop/labs-2018011375/user/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/penghy/Desktop/labs-2018011375/user /home/penghy/Desktop/labs-2018011375/user /home/penghy/Desktop/labs-2018011375/user/build /home/penghy/Desktop/labs-2018011375/user/build /home/penghy/Desktop/labs-2018011375/user/build/CMakeFiles/ch3_2_stride4.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ch3_2_stride4.dir/depend

