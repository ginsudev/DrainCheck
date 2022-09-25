ARCHS = arm64 arm64e
TARGET := iphone:clang:15.5:14.4
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_DEVICE_IP = localhost -p 2222
PACKAGE_VERSION = 3.0.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DrainCheck

DrainCheck_PRIVATE_FRAMEWORKS = ControlCenterUI
DrainCheck_FILES = $(shell find Sources/DrainCheck -name '*.swift') $(shell find Sources/DrainCheckC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
DrainCheck_SWIFTFLAGS = -ISources/DrainCheckC/include
DrainCheck_CFLAGS = -fobjc-arc -ISources/DrainCheckC/include

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += draincheckcc draincheck
SUBPROJECTS += draincheckapp
SUBPROJECTS += draincheckactivator
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "uicache -p /Applications/DrainCheck.app"
