// Modifed based on Phase separation in Mussel beds by QX Liu et al
// main.cpp
//
//  Original created by Johan Van de Koppel on 03-09-14. Modifed by Quan-Xing Liu
//  Copyright (c) 2014 Johan Van de Koppel. All rights reserved.
//

// Compiler directives
#define ON              1
#define OFF             0

// --- Definitions for SpatialFunctions.cl -------------------------------------
#define Forward   1
#define Backward  2
#define Central   3

#define DifferenceScheme Backward

#define Print_All_Devices OFF
#define Give_Error_Numbers OFF
#define Device_No        2    // 0: CPU; 1: Intel 4000; 2: Nvidia
#define ProgressBarWidth 45

#define StoreLog        OFF

// Thread block size
#define Block_Size_X	128                // 32
#define Block_Size_Y	128                // 32

// Number of blox
/* I define the Block_Number_ensions of the matrix as product of two numbers
Makes it easier to keep them a multiple of something (16, 32) when using CUDA*/
#define Block_Number_X	16               // 32
#define Block_Number_Y	16               // 32

// Matrix Block_Number_ensions
// (chosen as multiples of the thread block size for simplicity)
#define Grid_Width  (Block_Size_X * Block_Number_X)			// Matrix A width
#define Grid_Height (Block_Size_Y * Block_Number_Y)			// Matrix A height
#define Grid_Size (Grid_Width*Grid_Height)                  // Grid Size

// DIVIDE_INTO(x/y) for integers, used to determine # of blocks/warps etc.
#define DIVIDE_INTO(x,y) (((x) + (y) - 1)/(y))

// Definition of spatial parameters
#define dX          1.0             // 1     The size of each grid cell in X direction
#define dY          1.0             // 1     The size of each grid cell in Y direction

// Process parameters            Original value   Explanation and Units
#define	D           1.0             // 1.0  - The diffusivity parameter
//#define Gamma       0.5           // 0.5  - The non-parameterical density-dependence parameter
#define lambda0     1.53            // 0.85 - model parameters
#define lambdaMin   0.3             // 0.5  - minimal Lambda
#define lambdaMax   7.3             // 2.0  - maximal Lambda  
#define kappa       0.15            // 0.8  - model parameters
#define v0          2.02            // 2.0  - movement speed
#define S0          1.00            // 2.0  - initial concentration of stones
#define S0_min      0.1             // 1.0  - minimal initial S0 for gradient left
#define S0_max      6.1             // 2.5  - maximal initial S0 for gradient right

#define Time		1                // 1   - Start time of the simulation
#define dT          0.020            // 0.025 TIME STEP
#define NumFrames	200              // 100  - Number of times the data is stored
#define MAX_STORE	(NumFrames+2)    // Determines the size of the storage array
#define EndTime		20000            // 1000 - End time of the simulation
