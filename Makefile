ARCHS = arm64 arm64e
TARGET = iphone:latest:14.0

TWEAK_NAME = urlredirect
urlredirect_FILES = Tweak.xm
urlredirect_CFLAGS = -fobjc-arc

# 禁用签名
CODESIGN = NO
DEBUG = 0

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
