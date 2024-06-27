import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machientest/authentication/loginpage.dart';
import 'package:machientest/model/productsModel.dart';
import 'package:machientest/providers/profile_providers.dart';
import 'package:machientest/services/api_services.dart';
import 'package:machientest/views/categoryPage.dart';
import 'package:machientest/views/subCategoryPage.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserController()),
          // ChangeNotifierProvider(create: (context) => UserController1()),
        ], // Provide the Counter instance
        child:MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: LoginPage(),
        ));
  }
}
