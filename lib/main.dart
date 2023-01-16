import 'package:afyadaktari_admin/core/presentation/screens/auth/login/login_view.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/verify_phone/state.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/dash_board/dash_board_provider.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/departments/state.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/doctors/state.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/settings/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'core/data/utils/themes/main_theme.dart';
import 'core/presentation/screens/auth/login/login_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VerifyPhoneProvider()),
        ChangeNotifierProvider(
          create: (context) => DashBoardProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => DoctorsProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => SettingsProvider(),
        ),
         ChangeNotifierProvider(
          create: (BuildContext context) => DepartmentsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Afya Daktari Admin',
        theme: mainTheme,
        home: const LoginPage(),
      ),
    );
  }
}
