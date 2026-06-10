# 🚀 Quick Run Commands - Catatin App

## ⚡ Super Quick Start (Copy-Paste)

### Windows PowerShell:
```powershell
flutter pub get ; flutter run
```

### Linux/Mac Terminal:
```bash
flutter pub get && flutter run
```

---

## 📋 Step-by-Step Commands

### 1. First Time Setup
```bash
# Clone (jika belum)
git clone <repo-url>
cd catatin

# Install dependencies
flutter pub get

# Check everything OK
flutter doctor

# Run
flutter run
```

### 2. Daily Development
```bash
# Run app
flutter run

# Setelah app muncul:
# - Tekan 'r' untuk hot reload (quick UI changes)
# - Tekan 'R' untuk hot restart (full restart, needed after code changes)
# - Tekan 'q' untuk quit
```

### 3. Clean Build (If Issues)
```bash
flutter clean
flutter pub get
flutter run
```

---

## 🎯 Platform-Specific Run

### Android Emulator:
```bash
# List devices
flutter devices

# Run on specific device
flutter run -d emulator-5554
```

### Android Physical Device:
```bash
# Enable USB debugging on phone
# Connect via USB
flutter devices
flutter run -d <device-id>
```

### Chrome (Web):
```bash
flutter run -d chrome
```

### Windows Desktop:
```bash
flutter run -d windows
```

---

## 🔧 Build Release

### Android APK:
```bash
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (for Play Store):
```bash
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### Windows:
```bash
flutter build windows --release

# Output: build/windows/x64/runner/Release/
```

---

## 🧹 Maintenance Commands

### Update Dependencies:
```bash
flutter pub upgrade
```

### Check Outdated Packages:
```bash
flutter pub outdated
```

### Analyze Code:
```bash
flutter analyze
```

### Format Code:
```bash
flutter format lib/
```

### Clean Build Cache:
```bash
flutter clean
```

---

## 🐛 Debug Commands

### Run with Verbose Logging:
```bash
flutter run -v
```

### Run with Specific Flavor:
```bash
flutter run --debug
flutter run --profile
flutter run --release
```

### Attach Debugger:
```bash
flutter attach
```

### View Logs:
```bash
flutter logs
```

---

## 📊 Performance Commands

### Run with Performance Overlay:
```bash
flutter run --profile
# Then in app: tap on performance overlay icon
```

### Build with Tree Shake Icons:
```bash
flutter build apk --tree-shake-icons
```

### Analyze App Size:
```bash
flutter build apk --analyze-size
```

---

## 🔥 Hot Keys (During Flutter Run)

| Key | Action |
|-----|--------|
| `r` | Hot reload (quick, UI only) |
| `R` | Hot restart (full, includes logic) |
| `h` | Show help |
| `c` | Clear console |
| `q` | Quit app |
| `d` | Detach (keep app running) |
| `w` | Dump widget hierarchy |
| `t` | Dump render tree |
| `L` | Dump layer tree |
| `S` | Dump accessibility tree |
| `p` | Toggle debug paint |
| `P` | Toggle performance overlay |
| `o` | Toggle platform (iOS/Android) |

---

## 🎓 Common Workflows

### Workflow 1: Fix Bug
```bash
# 1. Make code changes
# 2. In running app terminal, press 'R' (hot restart)
# 3. Test fix
# 4. If needed: flutter clean && flutter run
```

### Workflow 2: Test on Multiple Devices
```bash
# Terminal 1
flutter run -d emulator-5554

# Terminal 2 (new tab/window)
flutter run -d chrome

# Terminal 3
flutter run -d windows
```

### Workflow 3: Build for Production
```bash
# 1. Clean
flutter clean

# 2. Update dependencies
flutter pub get

# 3. Analyze code
flutter analyze

# 4. Build
flutter build apk --release

# 5. Test release build
flutter install
```

---

## 📱 Device Management

### List Connected Devices:
```bash
flutter devices
```

### List Available Emulators:
```bash
flutter emulators
```

### Launch Emulator:
```bash
flutter emulators --launch <emulator-id>
```

### Example:
```bash
# List
flutter emulators
# Output: Pixel_5_API_33

# Launch
flutter emulators --launch Pixel_5_API_33

# Wait for emulator to start, then:
flutter run
```

---

## 🔍 Troubleshooting Commands

### Check Flutter Installation:
```bash
flutter doctor -v
```

### Repair Flutter:
```bash
flutter doctor --android-licenses
flutter upgrade
flutter channel stable
```

### Clear Flutter Cache:
```bash
flutter clean
rm -rf build/  # Linux/Mac
rmdir /s /q build  # Windows
```

### Reset Flutter:
```bash
flutter downgrade  # if upgrade caused issues
flutter doctor
```

---

## 🎯 Pre-Demo Checklist Commands

```bash
# 1. Clean everything
flutter clean

# 2. Get fresh dependencies
flutter pub get

# 3. Check no issues
flutter analyze

# 4. Build release
flutter build apk --release

# 5. Install on demo device
flutter install -d <demo-device-id>

# 6. Test all features
# (manual testing)

# 7. Ready for demo! 🎉
```

---

## 💡 Pro Tips

### Tip 1: Keep Terminal Open
```bash
# Run in background (Linux/Mac)
flutter run &

# Or use screen/tmux for persistent sessions
```

### Tip 2: Auto-restart on File Changes
```bash
# Use nodemon (if installed)
nodemon --exec "flutter run" --watch lib/

# Or use VS Code/Android Studio built-in features
```

### Tip 3: Quick Test Multiple Platforms
```bash
# Create batch script (Windows: test_all.bat)
flutter run -d windows &
flutter run -d chrome &
flutter run -d emulator-5554 &

# Or PowerShell script
```

### Tip 4: Check Performance
```bash
# Use --profile mode for performance testing
flutter run --profile

# Then use DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

---

## 🆘 Emergency Commands

### App Crashed / Won't Run:
```bash
flutter clean
flutter pub get
flutter run
```

### Build Errors:
```bash
cd android
./gradlew clean  # Linux/Mac
gradlew.bat clean  # Windows
cd ..
flutter clean
flutter run
```

### Can't Find Device:
```bash
# Restart ADB (Android)
adb kill-server
adb start-server
flutter devices
```

### Database Issues:
```bash
# Uninstall app (clears database)
flutter run --uninstall-only

# Then reinstall
flutter run
```

---

## 📝 Cheat Sheet

```bash
# Most Used Commands:
flutter run              # Run app
flutter pub get          # Install deps
flutter clean            # Clean build
flutter analyze          # Check code
flutter build apk        # Build release

# Hot keys in running app:
r = reload    R = restart    q = quit

# Quick combo:
flutter clean ; flutter pub get ; flutter run
```

---

## ✅ Success Check

After running, verify in console:
```
✅ FFI Database initialized for desktop platform
✅ Database opened successfully
✅ No error messages
✅ App running on <device>
```

---

**Happy Coding! 🚀**

**Quick Start**: `flutter pub get ; flutter run`  
**After Changes**: Press `R` in terminal  
**If Issues**: `flutter clean ; flutter pub get ; flutter run`  

🎉 **That's it! Enjoy!**
