bash platform.sh ostype
brew install cabal-install icarus-verilog pkg-config tcl-tk zlib gcc
cabal update
cabal v1-install old-time regex-compat split syb
