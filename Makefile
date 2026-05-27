ARCHS = arm64 arm64e
TARGET = iphone:latest:14.0

TWEAK_NAME = urlredirect
urlredirect_FILES = Tweak.xm
urlredirect_CFLAGS = -fobjc-arc

# 强制禁用所有签名相关操作
DEBUG = 0
FINALPACKAGE = 1
CODESIGN_IPA = NO
CODESIGN_APP = NO
_TARGET_CODESIGN := false

# 跳过签名阶段
after-stage::
	@echo "Skipping codesign."

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
