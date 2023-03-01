# Source Engine Android Mod Template
- Repository based on [FWGS Xash3D android launcher](https://github.com/FWGS/xash3d-android-project)

## Building
- Create SDK with sdkmanager
- Copy libs to android/lib/arch/
- Run `./waf configure -T release`
- Run `./waf build`
### Custom signing
- Add `--key=keystore_name,keystore_alias,keystore_pass,key_pass` on configure stage. Replace <keystore_name,keystore_alias,keystore_pass,key_pass> with your key, alias etc.
### Building with JDK 11+
- Add `--javac-source-target=8` on configure stage
