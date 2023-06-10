import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:provider/provider.dart';
import 'package:volunet/providers/posts_provider.dart';
import 'package:volunet/providers/user_provider.dart';
import 'package:volunet/resources/posts_methods.dart';
import 'package:volunet/screens/login_screen.dart';
import 'package:dcdg/dcdg.dart';
import 'constraints/style.dart';
import 'screens/home_screen.dart';
import 'screens/post_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Volunet',
        debugShowCheckedModeBanner: false,
        color: AppStyle.colors.darkBlue,
        theme: ThemeData(
          textTheme: GoogleFonts.manropeTextTheme(),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: AppStyle.colors.darkBlue),
        ),
        //home: LoginScreen(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const Home();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('ERROR'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppStyle.colors.darkBlue,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
