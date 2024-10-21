# netcdf.build

[![netcdf_gcc_v4.9.2](https://github.com/CUG-hydro/netcdf.build/actions/workflows/netcdf-gcc.yml/badge.svg)](https://github.com/CUG-hydro/netcdf.build/actions/workflows/netcdf-gcc.yml)
[![netcdf_openmpi_v4.9.2](https://github.com/CUG-hydro/netcdf.build/actions/workflows/netcdf-openmpi.yml/badge.svg)](https://github.com/CUG-hydro/netcdf.build/actions/workflows/netcdf-openmpi.yml)
[![License](http://img.shields.io/badge/license-GPLv3-blue.svg?style=flat)](http://www.gnu.org/licenses/gpl-3.0.html)

<!-- [![netCDF in parallel](https://github.com/CUG-hydro/netcdf.build/actions/workflows/netcdf_parallel.yml/badge.svg)](https://github.com/CUG-hydro/netcdf.build/actions/workflows/netcdf_parallel.yml)
[![netCDF in serial](https://github.com/CUG-hydro/netcdf.build/actions/workflows/netcdf_serial.yml/badge.svg)](https://github.com/CUG-hydro/netcdf.build/actions/workflows/netcdf_serial.yml) -->

> Build netcdf-c and netcdf-fortran with Github Action

## 使用情景
> 陆面模式的编译与运行，解决依赖环境netcdf, pnetcdf配置的问题。
- `CLM5`
- `CoLM`

## Compilers

- `openmpi`
- `gcc`: 11.4.0

## Libraries

- `curl`: 8.6.0
- `zlib`: 1.3
- `hdf5`: 1.14.0
- `pnetcdf`: 1.12.3
- `netcdf`: 4.9.2
- `netcdff`: 4.6.0

## TODO

- [ ] 安装与移植

文件路径一定要放对。否则需要修复rpath。

建议使用并行版本的。
享用方法：

```bash
unzip Ubuntu2204_openmpi_netcdf-v4.9.2.zip -d /opt/netcdf_v4.9.2_openmpi

# export NETCDF="/home/kong/github/CUG-hydro/CoLM202X/netcdf"
export NETCDF="/opt/netcdf_v4.9.2_openmpi"
export LD_LIBRARY_PATH="$NETCDF/lib:$NETCDF/hdf5/lib:$NETCDF/zlib/lib"
export NETCDF_LIB=$NETCDF/lib
export NETCDF_INC=$NETCDF/include
echo $LD_LIBRARY_PATH
```

1. `/opt/netcdf_4.9.2_openmpi`
2. `/opt/netcdf_4.9.2_gcc11`

## References

- Building_netcdf: <https://docs.unidata.ucar.edu/nug/current/getting_and_building_netcdf.html>
- <https://github.com/dspelaez/install-netcdf-fortran>
