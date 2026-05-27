ARCHS = arm64 arm64e
TARGET = iphone:latest:14.0

TWEAK_NAME = urlredirect
urlredirect_FILES = Tweak.xm
urlredirect_CFLAGS = -fobjc-arc

# 强制禁用签名
export CODESIGN = false
export CODESIGN_ALLOC = false
TARGET_CODESIGN = false

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
