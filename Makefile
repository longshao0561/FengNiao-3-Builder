# Theos 路径（GitHub Actions 会覆盖）
THEOS = /opt/theos
THEOS_MAKE_PATH = $(THEOS)/makefiles

# 架构
ARCHS = arm64 arm64e

# 目标 iOS 版本
TARGET = iphone:latest:14.0

# 插件名称
TWEAK_NAME = urlredirect

# 源文件
$(TWEAK_NAME)_FILES = Tweak.xm

# 编译标志
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

# 包含 Theos 构建文件
include $(THEOS_MAKE_PATH)/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
