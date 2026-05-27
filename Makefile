ARCHS = arm64 arm64e
TARGET = iphone:latest:14.0

TWEAK_NAME = urlredirect
urlredirect_FILES = Tweak.xm
urlredirect_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
