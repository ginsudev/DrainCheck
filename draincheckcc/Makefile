ARCHS = arm64 arm64e
TARGET := iphone:clang:15.5:14.4
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = draincheckcc
draincheckcc_BUNDLE_EXTENSION = bundle
draincheckcc_FILES = draincheckcc.m
draincheckcc_CFLAGS = -fobjc-arc
draincheckcc_FRAMEWORKS = UIKit
draincheckcc_PRIVATE_FRAMEWORKS = ControlCenterUIKit
draincheckcc_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
