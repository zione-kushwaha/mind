import 'package:abc/features/home/Emotion/src/data/repositories_impl/images_repository_impl.dart'
    show ImagesRepositoryImpl;
import 'package:abc/features/home/surface/view/home_screen.dart';
import 'package:abc/tab/profile/profile_view.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:abc/core/route/router.dart';
import 'package:provider/provider.dart' as provider;
import 'features/home/AAC/providers/locked/dialog.dart';
import 'features/home/AAC/providers/locked/home.dart';
import 'features/home/AAC/providers/settings/settings.dart';
import 'features/home/AAC/providers/unlocked/unlocked_home_provider.dart';
import 'features/home/Emotion/src/data/repositories_impl/audio_repository_impl.dart';
import 'features/home/Emotion/src/domain/repositories/audio_repository.dart';
import 'features/home/Emotion/src/domain/repositories/images_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  runApp(ProviderScope(child: MyApp()));
}

Future<void> injectDependencies() async {
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());

  GetIt.I.registerLazySingleton<ImagesRepository>(() => ImagesRepositoryImpl());

  GetIt.I.registerLazySingleton<AudioRepository>(
    () => AudioRepositoryImpl(AudioPlayer()),
    dispose: (repository) {
      repository.dispose();
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // We'll use ProviderScope for Riverpod and MultiProvider for provider package
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (context) => SettingsModel()),
        provider.ChangeNotifierProvider<DialogModel>(
          create: (context) => DialogModel(),
        ),
        provider.ChangeNotifierProvider<HomeModel>(
          create: (context) => HomeModel(),
        ),
        provider.ChangeNotifierProvider<UnlockedHomeProvider>(
          create: (context) => UnlockedHomeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mind bridge',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.blueAccent,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
        ),
        home: ChildHomeScreen(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
