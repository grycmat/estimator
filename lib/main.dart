import 'package:estimator/pages/login_page.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Estimator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<User>(
            create: (_) => User(),
          ),
          ChangeNotifierProvider<ProjectEstimate>(
            create: (_) => ProjectEstimate(),
          ),
        ],
        child: LoginPage(),
      ),
    );
  }
}
