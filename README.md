# memo_app

A memo app for Android and iOS to demonstrate the Command-Query Separation (CQS) pattern on Flutter projects.

## Getting Started

1. Install [fvm](https://github.com/leoafarias/fvm)
2. Install the project Flutter version:
```bash
fvm install
```

3. Get the project dependencies:
```bash
fvm flutter pub get
```

4. Generate the source code:
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```
If you want, you can use the watcher to generate code during development:
```bash
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```