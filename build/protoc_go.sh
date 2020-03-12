#!/usr/bin/env bash
if [ $# -ne 1 ]; then
    echo "Usage: compile_protos.sh <BUILD_DIR> (ex> \$GOPATH/src/github.com/distrue/)"
    exit 1
fi

BUILD_DIR=$1
PROTOC=$(which protoc)
if [ $? -ne 0 ]; then
    echo "Could not find protoc"
    exit 2
fi

echo "Using $PROTOC"

set -e

THIS_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
PROTO_DIR=$THIS_DIR/../p4runtime/proto

echo $PROTO_DIR

tmpdir=$(mktemp -d)
pushd $tmpdir > /dev/null
git clone --depth 1 https://github.com/googleapis/googleapis.git
popd > /dev/null
GOOGLE_PROTO_DIR=$tmpdir/googleapis
set -o xtrace

if [ -e "$BUILD_DIR/p4goruntime" ]; then
  echo "" # skip
else
  mkdir $BUILD_DIR/p4goruntime
fi

$PROTOC -I=$PROTO_DIR --go_out=plugins=grpc,paths=source_relative:$BUILD_DIR/p4goruntime $PROTO_DIR/p4/v1/p4data.proto 
$PROTOC -I=$PROTO_DIR -I=$GOOGLE_PROTO_DIR --go_out=plugins=grpc,paths=source_relative:$BUILD_DIR/p4goruntime $PROTO_DIR/p4/v1/p4runtime.proto
$PROTOC -I=$PROTO_DIR --go_out=plugins=grpc,paths=source_relative:$BUILD_DIR/p4goruntime $PROTO_DIR/p4/config/v1/p4info.proto
$PROTOC -I=$PROTO_DIR --go_out=plugins=grpc,paths=source_relative:$BUILD_DIR/p4goruntime $PROTO_DIR/p4/config/v1/p4types.proto

set +o xtrace

rm -rf $tmpdir

cd $BUILD_DIR

echo "SUCCESS"
