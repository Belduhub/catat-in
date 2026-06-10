import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> initializeDatabase() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Desktop: use FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    print('✅ Desktop: FFI initialized for ${Platform.operatingSystem}');
  } else {
    // Mobile: native SQLite
    print('✅ Mobile: Native SQLite for ${Platform.operatingSystem}');
  }
}
