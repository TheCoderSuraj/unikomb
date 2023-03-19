import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unikomb/core/auth/screens/additional_details_screen.dart';
import 'package:unikomb/utils/route_generator.dart';

import 'core/general/providers/shared_pref_provider.dart';
import 'core/general/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  // initializing other services before calling app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // to call application to run first time
  runApp(
    // initialize all providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SharedPrefProvider(),
        ),
      ],
      // calling application
      child: UniKombApp(),
    ),
  );
}

// application widget
class UniKombApp extends StatefulWidget {
  const UniKombApp({super.key});

  @override
  State<UniKombApp> createState() => _UniKombAppState();
}

class _UniKombAppState extends State<UniKombApp> {
  @override
  void initState() {
    super.initState();
    context.read<SharedPrefProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      // initialRoute: HomeScreen.id,
      initialRoute: AdditionalDetailsScreen.id,
    );
  }
}
