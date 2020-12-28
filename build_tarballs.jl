# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "libpg_query"
version = v"0.0.5"

# Collection of sources required to build libpg_query
sources = [
    GitSource(
        "https://github.com/relationalai-oss/libpg_query.git",
        "bc18e37f079e7cfecee297b36c01e37a7110c4ba",
    ),
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd libpg_query/
make build
mkdir -p $prefix/lib
cp libpg_query.* $prefix/lib/

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, libc=:glibc),
    Linux(:x86_64, libc=:glibc),
    Linux(:i686, libc=:musl),
    Linux(:x86_64, libc=:musl),
    MacOS(:x86_64)
]

# The products that we will ensure are always built
products = [
    LibraryProduct("libpg_query", :libpg_query)
]

# Dependencies that must be installed before this package can be built
dependencies = [

]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
