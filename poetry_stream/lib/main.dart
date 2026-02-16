import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'providers/purchase_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fullscreen immersive mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Allow runtime font fetching from Google Fonts
  GoogleFonts.config.allowRuntimeFetching = true;

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize purchase provider early to catch purchase stream events
  final container = ProviderContainer();
  container.read(purchaseProvider);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const PoetryStreamApp(),
  ));
}
