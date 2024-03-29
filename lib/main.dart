import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe_app/constant/text_styles.dart';
import 'package:tic_tac_toe_app/screen/home_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // 기기 회전 제한
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: GetMaterialApp(
        title: 'Tic-Tac-Toe',
        theme: ThemeData(
          fontFamily: 'Jalnan2',
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: appBarTitleStyle,
            color: Colors.grey,
            actionsIconTheme: IconThemeData(
              color: Colors.black87,
            ),
            foregroundColor: Colors.black87,
            elevation: 0,
            iconTheme: IconThemeData(
              size: 30,
            ),
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            background: Colors.grey,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
