# Configuration file for closest
CXX=nvcc -arch=sm_$(SHADER_MODEL) -I .

CXXFLAGS=-O3

LDFLAGS=-lnetcdf 

DEFINES=-DBINTRAJ -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

NETCDF_LIB_DIR=
NETCDF_INC_DIR=
