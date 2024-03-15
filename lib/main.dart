import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe_app/common/font_style.dart';
import 'package:tic_tac_toe_app/view/home/home_screen.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Jalnan2',
          appBarTheme: const AppBarTheme(
            titleTextStyle: AppStyle.appBarTitleStyle,
            color: Colors.grey,
            actionsIconTheme: IconThemeData(
              color: Colors.black87,
            ),
            foregroundColor: Colors.black87,
            elevation: 0,
            iconTheme: IconThemeData(
              size: 30
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
