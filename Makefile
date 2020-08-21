THEOS_DEVICE_IP = 10.93.237.14
THEOS_DEVICE_PORT = 22
ARCHS = armv7 arm64 arm64e
TARGET = iphone:latest:8.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CCRevealLoader
CCRevealLoader_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

before-package::
	@echo "Downlading reveal server framework..."
	mkdir -p ./layout/Library/Application\ Support/CCRevealLoader/
	cp -r  /Applications/Reveal.app/Contents/SharedSupport/iOS-Libraries/RevealServer.framework ./layout/Library/Application\ Support/CCRevealLoader/
	lipo -remove i386 ./layout/Library/Application\ Support/CCRevealLoader/RevealServer.framework/RevealServer -o ./layout/Library/Application\ Support/CCRevealLoader/RevealServer.framework/RevealServer
	lipo -remove x86_64 ./layout/Library/Application\ Support/CCRevealLoader/RevealServer.framework/RevealServer -o ./layout/Library/Application\ Support/CCRevealLoader/RevealServer.framework/RevealServer
	codesign -f -s "Apple Development: 11240624@qq.com (V5R66GXGUY)" ./layout/Library/Application\ Support/CCRevealLoader/RevealServer.framework
after-install::
	install.exec "killall -9 SpringBoard"
