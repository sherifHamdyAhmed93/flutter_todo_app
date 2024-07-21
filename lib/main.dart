import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_todo_app/edit_task_screen/edit_task_screen.dart';
import 'package:flutter_todo_app/home/home_screen.dart';
import 'package:flutter_todo_app/provider/app_language_provider.dart';
import 'package:flutter_todo_app/provider/app_theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(child: MyApp(), providers: [
    ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
  ]));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    AppLanguageProvider languageProvider =
        Provider.of<AppLanguageProvider>(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.currentAppLanguage),
      title: 'Flutter Demo',
      theme: themeProvider.getCurrentAppTheme(),
      themeMode: themeProvider.currentAppTheme,
      initialRoute: HomeScreen.screenName,
      routes: {
        HomeScreen.screenName: (context) => HomeScreen(),
        EditTaskScreen.screenName: (context) => EditTaskScreen(),
      },
    );
  }
}
