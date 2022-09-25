ARCHS = arm64 arm64e
TARGET := iphone:clang:15.5:14.4

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = draincheck

draincheck_LIBRARIES = gscommon
draincheck_FILES = $(shell find Sources/draincheck -name '*.swift') $(shell find Sources/draincheckC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
draincheck_SWIFTFLAGS = -ISources/draincheckC/include
draincheck_INSTALL_PATH = /Library/PreferenceBundles
draincheck_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
