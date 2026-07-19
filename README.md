# SDUI Mini (Author + Publish)

Author mini screens in Dart, preview with the same Flutter renderer, export `publish/bundle.json` for Super OTA.

## Edit

`lib/bundle/definition.dart`

## Preview / Export in app

```bash
cd mini
flutter pub get
flutter run
```

Tap **Preview** or **Export bundle.json**.

## Export CLI

```bash
cd mini
dart run tool/export_bundle.dart --version 1.0.1
```

## Serve for Super

```bash
cd mini/publish
python -m http.server 8080
```

Super URL: `http://127.0.0.1:8080/bundle.json`
