#! /usr/bin/env bash

# Find the absolute location of this script
# https://gist.github.com/tvlooy/cbfbdb111a4ebad8b93e
function abs_script_dir_path {
    SOURCE=${BASH_SOURCE[0]}
    while [ -h "$SOURCE" ]; do
      DIR=$( cd -P $( dirname "$SOURCE") && pwd )
      SOURCE=$(readlink "$SOURCE")
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    DIR=$( cd -P $( dirname "$SOURCE" ) && pwd )
    echo $DIR
}

BINDIR="$(abs_script_dir_path)"
SCRIPTNAME=`basename "${BASH_SOURCE[0]}"`

# Set BLUESPECDIR based on the location
BLUESPECDIR="${BINDIR}/../lib"
export BLUESPECDIR

# Add the dynamically-linked SAT libraris the load path
if [ -n "$BLUESPEC_LD_LIBRARY_PATH" ] ; then
    LD_LIBRARY_PATH=${BLUESPEC_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}
    DYLD_LIBRARY_PATH=${BLUESPEC_LD_LIBRARY_PATH}:${DYLD_LIBRARY_PATH}
fi
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${BLUESPECDIR}/SAT:${BLUESPECDIR}/itk4.1.0
DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${BLUESPECDIR}/SAT:${BLUESPECDIR}/itk4.1.0
export LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH

# Determine the actual executable to run
BLUESPECEXEC=${BINDIR}/../bscbin/${SCRIPTNAME}

if [ -z "$BLUESPECEXEC" ] || [ ! -x $BLUESPECEXEC ] ; then
    echo "Error Bluespec executable not found: ${BLUESPECEXEC}"
    exit 1;
fi

exec $BLUESPECEXEC "$@"
