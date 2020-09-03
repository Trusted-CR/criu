    ARCH=arm \
    CROSS_COMPILE=arm-linux-androideabi- \
    CFLAGS="-Wno-macro-redefined `pkg-config --cflags libprotobuf-c` -D ANDROID_BUILD -D CONFIG_HAS_TCP_REPAIR_WINDOW -D CONFIG_HAS_TCP_REPAIR -D CONFIG_HAS_FSCONFIG -D NO_SE_LINUX -D CONFIG_HAS_PTRACE_PEEKSIGINFO" \
    LDFLAGS="-static `pkg-config --libs libprotobuf-c` `pkg-config --libs libnl-3.0` `pkg-config --libs libnet`" \
    make criu #V=1

