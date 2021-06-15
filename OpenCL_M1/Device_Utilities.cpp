//
//  DeviceUtils.cpp
//
//  Created by Johan Van de Koppel on 03-09-14.
//  Copyright (c) 2014 Johan Van de Koppel. All rights reserved.
//

#include "Device_Utilities.h"

#include <stdio.h>
#include <sys/time.h>
#include <iostream>
#include <math.h>
#include <assert.h>

void print_platform_info(cl_platform_id platform)
{
    char name[128];
    char vendor[128];
    
    clGetPlatformInfo(platform, CL_PLATFORM_NAME, 128, name, NULL);
    clGetPlatformInfo(platform, CL_PLATFORM_VENDOR, 128, vendor, NULL);
    
    fprintf(stdout, " Platform type : %s\n", name);
}

void print_device_info(cl_device_id* device, int Device_Nr)
{
    char* value;
    size_t valueSize;
    
    // print device name
    clGetDeviceInfo(device[Device_Nr], CL_DEVICE_VENDOR, 0, NULL, &valueSize);
    value = (char*) malloc(valueSize);
    clGetDeviceInfo(device[Device_Nr], CL_DEVICE_VENDOR, valueSize, value, NULL);
    printf("%s", value);
    free(value);
    
    // print hardware device version
    clGetDeviceInfo(device[Device_Nr], CL_DEVICE_NAME, 0, NULL, &valueSize);
    value = (char*) malloc(valueSize);
    clGetDeviceInfo(device[Device_Nr], CL_DEVICE_NAME, valueSize, value, NULL);
    printf(" %s\n", value);
    free(value);
}

void Query(cl_uint deviceCount, cl_device_id* devices) {
    
    char* value;
    size_t valueSize;
    cl_uint maxComputeUnits;
    size_t maxWorkGroupSize;
    cl_uint maxWorkGroupDimensions;
    size_t maxWorkItemSizes[25];
    
    printf(" Available devices :\n\n");
    
    // for each device print critical attributes
    for (int j = 0; j < deviceCount; j++) {
        
        // print device name
        clGetDeviceInfo(devices[j], CL_DEVICE_NAME, 0, NULL, &valueSize);
        value = (char*) malloc(valueSize);
        clGetDeviceInfo(devices[j], CL_DEVICE_NAME, valueSize, value, NULL);
        printf(" Device %d: %s\n", j, value);
        free(value);
        
        // print hardware device version
        clGetDeviceInfo(devices[j], CL_DEVICE_VERSION, 0, NULL, &valueSize);
        value = (char*) malloc(valueSize);
        clGetDeviceInfo(devices[j], CL_DEVICE_VERSION, valueSize, value, NULL);
        printf("  %d.%d Hardware version: %s\n", j+1, 1, value);
        free(value);
        
        // print software driver version
        clGetDeviceInfo(devices[j], CL_DRIVER_VERSION, 0, NULL, &valueSize);
        value = (char*) malloc(valueSize);
        clGetDeviceInfo(devices[j], CL_DRIVER_VERSION, valueSize, value, NULL);
        printf("  %d.%d Software version: %s\n", j+1, 2, value);
        free(value);
        
        // print parallel compute units
        clGetDeviceInfo(devices[j], CL_DEVICE_MAX_COMPUTE_UNITS,
                        sizeof(maxComputeUnits), &maxComputeUnits, NULL);
        printf("  %d.%d Parallel compute units: %d\n", j+1, 3, maxComputeUnits);
        
        // print parallel compute units
        clGetDeviceInfo(devices[j], CL_DEVICE_MAX_WORK_GROUP_SIZE,
                        sizeof(maxWorkGroupSize), &maxWorkGroupSize, NULL);
        printf("  %d.%d Maximum work group size: %d\n", j+1, 4, (int)maxWorkGroupSize);
        
        // print parallel compute units
        clGetDeviceInfo(devices[j], CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS,
                        sizeof(maxWorkGroupDimensions), &maxWorkGroupDimensions, NULL);
        printf("  %d.%d Maximum work group dimensions: %d\n", j+1, 5, maxWorkGroupDimensions);
        
        // print parallel compute units
        clGetDeviceInfo(devices[j], CL_DEVICE_MAX_WORK_ITEM_SIZES,
                        sizeof(maxWorkItemSizes), &maxWorkItemSizes, NULL);
        printf("  %d.%d Maximum work item sizes: ", j+1, 6);
        for(int i=0;i<maxWorkGroupDimensions; i++){
            printf("%d ", (int)maxWorkItemSizes[i]);
        }
        printf("\n\n");
    }
    
}

void Get_Build_Errors(cl_program program, cl_device_id* device, cl_int ret){
    
    char* build_log;
    size_t log_size;
    cl_int err;
    
    printf("BuildProgram Error number: %d \n\n", ret);
    
    // First get the size of the error log
    err = clGetProgramBuildInfo(program, device[0], CL_PROGRAM_BUILD_LOG, 0, NULL, &log_size);
    build_log = (char* )malloc((log_size+1));
    
    // Second call to get the log
    err = clGetProgramBuildInfo(program, device[0], CL_PROGRAM_BUILD_LOG, log_size, build_log, NULL);
    build_log[log_size] = '\0';
    printf("--- Build log ---\n ");
    printf("%s\n", build_log);
    free(build_log);
}

cl_program BuildKernelFile(std::string filename, cl_context context, cl_device_id* device, cl_int *err){
    
    // The location of the code is obtain from the __FILE__ macro
    const std::string SourcePath (__FILE__);
    const std::string PathName = SourcePath.substr (0,SourcePath.find_last_of("/")+1);
    const std::string FilePath = PathName + filename;
    
    const std::string IncludePathName = FilePath.substr (0,FilePath.find_last_of("/")+1);
    const std::string IncludeFolder = "-I " + IncludePathName;
    
    cl_int ret;
    
    //Read Kernel from file
    FILE *f = fopen(FilePath.c_str(), "r");
    fseek(f, 0, SEEK_END);
    size_t fileSize = ftell(f);
    rewind(f);
    char *fileString = (char*)malloc(fileSize + 1);
    fileString[fileSize] = '\0';
    fread(fileString, sizeof(char), fileSize, f);
    fclose(f);
    cl_program prog = clCreateProgramWithSource(context, 1, (const char**)&fileString, &fileSize, &ret);
    if (ret!=0) { printf(" > Compile program Error No: %d \n\n", ret); exit(ret);}
    
    free(fileString);
    
    /* Build the kernel program */
    ret = clBuildProgram(prog, 1, device, IncludeFolder.c_str(), NULL, NULL);
    
    // If error is returned, the build log is printed on screen
    if (ret!=0) {
        printf(" > Build Program Error number: %d \n\n", ret);
        Get_Build_Errors(prog, device, ret);
    }
    
    return prog;
}

cl_context CreateGPUcontext(cl_device_id* &devices)
{

    // First get the platform
    cl_platform_id platform;
    cl_int err = clGetPlatformIDs(1, &platform, NULL);
    //print_platform_info(platform);

    // Get device count
    cl_uint deviceCount;
    err = clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, 0, NULL, &deviceCount);

    // Get all devices
    devices = new cl_device_id[deviceCount];
    err = clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, deviceCount, devices, NULL);

    // If needed, print all devices present
    #if Print_All_Devices == ON
        Query(deviceCount, devices);
    #endif

    // Create a OpenCl context on the device devices
    cl_context context = clCreateContext(NULL, deviceCount, devices, NULL, NULL, &err);
    
    return context;
    
}


