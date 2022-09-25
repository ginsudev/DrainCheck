ARCHS = arm64 arm64e
TARGET := iphone:clang:15.5:14.4
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = draincheckactivator

draincheckactivator_FILES = Listener-on.x Listener-off.x Listener-toggle.x
draincheckactivator_LIBRARIES = activator
draincheckactivator_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
