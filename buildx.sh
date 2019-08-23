#!/bin/sh

export OWGHOSTSCRIPTPATH=$PATH
export OWDOSBOXPATH=$PATH
export OWDOSBOX=dosbox
export SDL_VIDEODRIVER=dummy
export SDL_AUDIODRIVER=disk
export SDL_DISKAUDIOFILE=/dev/null

. $OWROOT/cmnvars.sh

mkdir $OWBINDIR

# build OW wmake for host system
cd $OWSRCDIR/wmake
mkdir $OWOBJDIR
cd $OWOBJDIR
make -f ../posmake TARGETDEF=-D__LINUX__
# build OW builder for host system
cd $OWSRCDIR/builder
mkdir $OWOBJDIR
cd $OWOBJDIR
$OWBINDIR/wmake -f ../binmake bootstrap=1 builder.exe
# build OW tools for host system
cd $OWSRCDIR/watcom
builder boot
cd $OWSRCDIR/builder
builder boot
cd $OWSRCDIR/whpcvt
builder boot
cd $OWSRCDIR/bmp2eps
builder boot
# build documentation and copy it to rel tree
cd $OWSRCDIR
builder -i webdocs $OWDOCTARGET -- -i
cd $BUILD_SOURCESDIRECTORY
