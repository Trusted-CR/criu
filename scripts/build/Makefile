ARCHES := x86_64 fedora-asan fedora-rawhide centos armv7hf
TARGETS := $(ARCHES) alpine
TARGETS_CLANG := $(addsuffix $(TARGETS),-clang)
CONTAINER_RUNTIME := docker

TARGETS += armv7-cross aarch64-cross ppc64-cross mips64el-cross


all: $(TARGETS) $(TARGETS_CLANG)
.PHONY: all

# A build for each architecture requires appropriate Dockerfile
define ARCH_DEP
$(1): Dockerfile.$(1)
endef
$(foreach arch,$(ARCHES),$(eval $(call ARCH_DEP,$(arch))))

Dockerfile.%: Dockerfile.%.hdr Dockerfile.%.tmpl
	cat $^ > $@

$(TARGETS):
	rm -rf ../../.ccache
	mkdir -p $(HOME)/.ccache
	mv $(HOME)/.ccache ../../
	$(CONTAINER_RUNTIME) build  -t criu-$@ -f Dockerfile.$@ $(DB_CC) $(DB_ENV) ../..
	$(CONTAINER_RUNTIME)  create -ti --name dummy criu-$@ bash
	$(CONTAINER_RUNTIME)  cp dummy:/criu/criu/criu /opt/optee-qemu/build/shared_folder/criu
	$(CONTAINER_RUNTIME)  rm -f dummy
.PHONY: $(TARGETS)

# Clang builds add some Docker build env
define CLANG_DEP
$(1)-clang: $(1)
endef
$(foreach t,$(TARGETS),$(eval $(call CLANG_DEP,$(t))))

%-clang:	DB_CC=--build-arg CC=clang
%-clang:	DB_ENV=--build-arg ENV1=CCACHE_CPP2
s390x-clang:	DB_CC=--build-arg CC=clang-3.8
.PHONY: $(TARGETS_CLANG)
