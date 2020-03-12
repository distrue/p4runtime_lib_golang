### p4gocontroller

This repository is p4runtime api in golang, which was built from [p4lang/p4runtime](https://github.com/p4lang/p4runtime) protobuf definition.

Files are organized as below:

```
.
├── p4runtime  # git submodule of base protobuf definition
├── build
│   └── protoc_go.sh  # build script of protobuf to golang
├── p4
│   ├── config
│   │   └── v1  # p4.config.v1 golang package (P4Info message definition)
│   └── v1  # p4.v1 golang package (P4Runtime service definition)
```

#### protoc_go.sh

Through this script, you can build golang p4runtime API from specific version of submodule [p4lang/p4runtime](https://github.com/p4lang/p4runtime).

##### what you need
* protoc
* target golang domain directory (directory should be created before shell script runs)
