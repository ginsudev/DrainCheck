TARGET = iphone:15.5:14.4
ARCHS = arm64

INSTALL_TARGET_PROCESSES = DrainCheck

include $(THEOS)/makefiles/common.mk
XCODEPROJ_NAME = DrainCheck
DrainCheck_LIBRARIES = gscommon
DrainCheck_XCODE_SCHEME = DrainCheck
DrainCheck_CODESIGN_FLAGS = -SdrainCheckEntitlements.xml

include $(THEOS_MAKE_PATH)/xcodeproj.mk
