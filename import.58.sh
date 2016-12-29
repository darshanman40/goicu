set -e

TARGET=`pwd`
DIR=/tmp/icu

# Data file can be obtained from ICU source tgz file.
# Dgraph will put up one copy of this.
DATA=icudt58l.dat

mkdir -p $DIR
cd $DIR

if [ ! -f $DIR/icu4c-58_2-src.tgz ]; then
  wget http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz
  tar xvzf icu4c-58_2-src.tgz
fi

if [ ! -f $DIR/$DATA ]; then
  # Get data from somewhere!
  wget https://github.com/dgraph-io/experiments/raw/master/icu/$DATA
fi

# Add: Get data from our github page.

rm -Rf $TARGET/icuembed
mkdir -p $TARGET/icuembed

cp -f icu/source/common/*.cpp $TARGET/icuembed
cp -f icu/source/common/*.c $TARGET/icuembed
cp -f icu/source/common/*.h $TARGET/icuembed
cp -Rf icu/source/common/unicode $TARGET/icuembed

#cp -Rf icu/source/common $TARGET
cp -f icu/source/stubdata/stubdata.c $TARGET/icuembed

cp -f $DIR/$DATA $TARGET

# Add in some Go file(s).
cd $TARGET
cp -f icuembed.go.tmpl icuembed/icuembed.go
cp -f dummy.go.tmpl icuembed/unicode/dummy.go

echo -e "Please run dgraph with the flag:\n-icu $TARGET/$DATA"