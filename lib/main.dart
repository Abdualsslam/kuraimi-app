import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuraimi/providers/locale_cubit.dart';
import 'package:kuraimi/providers/theme_cubit.dart';
import 'package:kuraimi/routes/app_router.dart';
import 'package:kuraimi/themes/app_theme.dart';
import 'constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const AlkuraimiApp());
}

class AlkuraimiApp extends StatelessWidget {
  const AlkuraimiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
      ],
      child: Builder(
        builder: (context) {
          // استخدام select للاستماع فقط للحقول المطلوبة
          final themeMode = context.select((ThemeCubit cubit) => cubit.state.themeMode);
          final locale = context.select((LocaleCubit cubit) => cubit.state.locale);
          final s = AppStrings.of(context);

          return MaterialApp.router(
            title: s.appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            themeAnimationDuration: const Duration(milliseconds: 500),
            themeAnimationCurve: Curves.linear,
            locale: locale,
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: router,
          );
        },
      ),
    );
  }
}
