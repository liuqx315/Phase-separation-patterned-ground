//
//  Device_Utilities.h
//
//  Created by Johan Van de Koppel on 03-09-14.
//  Copyright (c) 2014 Johan Van de Koppel. All rights reserved.
//

#ifndef DEVICE_UTILITIES_H
#define DEVICE_UTILITIES_H

#include <string>

#ifdef __APPLE__
#include <OpenCL/opencl.h>
#else
#include <CL/cl.h>
#endif

#define ON 1
#define OFF 0

#define Print_All_Devices OFF

// Prints a description of the platform, e.g. an Apple computer
void print_platform_info(cl_platform_id platform);

// Prints the name of the device that is used
void print_device_info(cl_device_id* device, int Device_Nr);

// To prints a detailed description of all processors in the computer
void Query(cl_uint deviceCount, cl_device_id* devices);

// Describes the compile errors occuring while compiling opencl kernel file
void Get_Build_Errors(cl_program program, cl_device_id* device, cl_int ret);

// Builds the kernel file
cl_program BuildKernelFile(std::string filename, cl_context context,
                           cl_device_id* device, cl_int *err);

// Sets up a device context
cl_context CreateGPUcontext(cl_device_id* &devices);

#endif


