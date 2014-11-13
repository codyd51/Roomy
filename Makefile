ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = Roomy
Roomy_FILES = Tweak.xm
Roomy_FRAMEWORKS = UIKit
Roomy_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
