# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/local/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/quan-xing/Desktop/OpenCL

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/quan-xing/Desktop/OpenCL/build

# Utility rule file for destroy.

# Include the progress variables for this target.
include CMakeFiles/destroy.dir/progress.make

CMakeFiles/destroy:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/quan-xing/Desktop/OpenCL/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) “Clears_the_build_directory”
	rm -rf ../build/*

destroy: CMakeFiles/destroy
destroy: CMakeFiles/destroy.dir/build.make

.PHONY : destroy

# Rule to build all files generated by this target.
CMakeFiles/destroy.dir/build: destroy

.PHONY : CMakeFiles/destroy.dir/build

CMakeFiles/destroy.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/destroy.dir/cmake_clean.cmake
.PHONY : CMakeFiles/destroy.dir/clean

CMakeFiles/destroy.dir/depend:
	cd /Users/quan-xing/Desktop/OpenCL/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/quan-xing/Desktop/OpenCL /Users/quan-xing/Desktop/OpenCL /Users/quan-xing/Desktop/OpenCL/build /Users/quan-xing/Desktop/OpenCL/build /Users/quan-xing/Desktop/OpenCL/build/CMakeFiles/destroy.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/destroy.dir/depend
