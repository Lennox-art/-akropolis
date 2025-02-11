# akropolis

Build runner
```bash
  flutter pub run build_runner build --delete-conflicting-outputs
```

SHA1 fingerprint
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

# Cloud functions locally from /functions directory
```bash
(cd functions && npm run serve)
```