LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := libpng
LOCAL_SRC_FILES := \
    libpng/png.c \
    libpng/pngerror.c \
    libpng/pngget.c \
    libpng/pngmem.c \
    libpng/pngpread.c \
    libpng/pngread.c \
    libpng/pngrio.c \
    libpng/pngrtran.c \
    libpng/pngrutil.c \
    libpng/pngset.c \
    libpng/pngtrans.c \
    libpng/pngwio.c \
    libpng/pngwrite.c \
    libpng/pngwtran.c \
    libpng/pngwutil.c
ifeq (arm, $(findstring arm,$(TARGET_ARCH)))
LOCAL_SRC_FILES += libpng/arm/arm_init.c \
                libpng/arm/filter_neon.S \
                libpng/arm/filter_neon_intrinsics.c \
		libpng/arm/palette_neon_intrinsics.c
else
ifeq (x86, $(findstring x86,$(TARGET_ARCH)))
LOCAL_SRC_FILES += libpng/intel/intel_init.c \
                libpng/intel/filter_sse2_intrinsics.c
endif
endif

LOCAL_LDLIBS := -lz
LOCAL_CFLAGS           := -std=gnu89 -Wall -Werror -Wno-unused-parameter -DPNG_INTEL_SSE_OPT=1
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/libpng/.

include $(BUILD_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE           := libimagequant
LOCAL_SRC_FILES        := \
     libpngquant/lib/blur.c \
     libpngquant/lib/kmeans.c \
     libpngquant/lib/libimagequant.c \
     libpngquant/lib/mediancut.c \
     libpngquant/lib/mempool.c \
     libpngquant/lib/nearest.c \
     libpngquant/lib/pam.c \

LOCAL_CFLAGS           := -std=c99 -O3
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/libpngquant/lib/.
LOCAL_STATIC_LIBRARIES := libpng

include $(BUILD_STATIC_LIBRARY)



include $(CLEAR_VARS)
LOCAL_MODULE           := pngquant
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/libpngquant/.
LOCAL_LDLIBS := -lz
                         
LOCAL_STATIC_LIBRARIES += libpng libimagequant
LOCAL_CFLAGS           := -std=c99 -O3
LOCAL_SRC_FILES        := \
     libpngquant/pngquant.c \
     libpngquant/pngquant_opts.c \
     libpngquant/rwpng.c

include $(BUILD_EXECUTABLE)
