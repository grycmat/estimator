import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimator/pages/estimation_page.dart';
import 'package:estimator/pages/login_page.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/providers/user.dart';
import 'package:estimator/widgets/with_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
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

  Future<void> _initUniLinks() async {
    try {
      Uri? initialLink = await getInitialUri();
      print(initialLink);
    } on PlatformException {
      print('platfrom exception unilink');
    }
  }

  @override
  Widget build(BuildContext context) {
    _initUniLinks();
    precacheImage(const AssetImage('assets/and.jpg'), context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(
          create: (_) => User(),
        ),
        ChangeNotifierProvider<ProjectEstimate>(
          create: (_) => ProjectEstimate(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Estimator',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.transparent,
        ),
        home: const WithWallpaper(
          child: LoginPage(),
        ),
      ),
    );
  }
}
