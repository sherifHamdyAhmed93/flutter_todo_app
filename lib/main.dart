import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_todo_app/edit_task_screen/edit_task_screen.dart';
import 'package:flutter_todo_app/firestore/firebase_utils.dart';
import 'package:flutter_todo_app/home/home_screen.dart';
import 'package:flutter_todo_app/login/login_screen.dart';
import 'package:flutter_todo_app/model/user.dart';
import 'package:flutter_todo_app/provider/app_language_provider.dart';
import 'package:flutter_todo_app/provider/app_theme_provider.dart';
import 'package:flutter_todo_app/provider/authUserProvider.dart';
import 'package:flutter_todo_app/provider/task_provider.dart';
import 'package:flutter_todo_app/register/signup_screen.dart';
import 'package:flutter_todo_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  try {
    Platform.isAndroid
        ? await Firebase.initializeApp(
            options: FirebaseOptions(
                apiKey: 'AIzaSyCtnCJeQuKeUEy4FEZizGxHv3YHMr6vvFY',
                appId: 'com.example.flutter_todo_app',
                messagingSenderId: '659552831760',
                projectId: 'todo-flutter-app-96d5f'))
        : await Firebase.initializeApp();
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  //FirebaseFirestore.instance.disableNetwork();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MultiProvider(child: MyApp(), providers: [
    ChangeNotifierProvider(create: (context) => TaskProvider()),
    ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
    ChangeNotifierProvider(create: (context) => AuthUserProvider())
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

    if (FirebaseAuth.instance.currentUser != null) {
      AuthUserProvider authUserProvider =
          Provider.of<AuthUserProvider>(context, listen: false);
      MyUser? myUser = await FirebaseUtils.readUserFromFirestore(
          FirebaseAuth.instance.currentUser?.uid ?? '');
      if (myUser != null) {
        authUserProvider.updateUser(myUser);
      }
    }

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
    AuthUserProvider authUserProvider = Provider.of<AuthUserProvider>(context);

    print('Saved Theme is ${themeProvider.currentAppTheme}');
    print('Saved Lang is ${languageProvider.currentAppLanguage}');
    print('Saved User is ${authUserProvider.currentUser}');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.currentAppLanguage),
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentAppTheme,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LoginScreen.screenName
          : HomeScreen.screenName,
      routes: {
        HomeScreen.screenName: (context) => HomeScreen(),
        EditTaskScreen.screenName: (context) => EditTaskScreen(),
        LoginScreen.screenName: (context) => LoginScreen(),
        SignupScreen.screenName: (context) => SignupScreen()
      },
    );
  }
}
