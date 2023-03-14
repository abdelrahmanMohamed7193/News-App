import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:news_app/Cubit/States.dart';
import 'package:news_app/Screens/news_homelayout_screen.dart';
import 'Cubit/cubit.dart';
import 'Cubit/darkModeCubit.dart';
import 'Network/local/cash_helper.dart';
import 'Network/remote/dio_helper.dart';
import 'shared/styles.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized() ;
  DioHelper.init() ;
 await CasHelper.init() ;

 bool? isDark=CasHelper.getBoolean(key:"isDark") ;

  runApp(  MyApp(isDark));
}

class MyApp extends StatelessWidget
{


  final bool? isDark ;
  MyApp(this.isDark) ;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(

      providers:  [
        BlocProvider(
        create:(context)=>NewsAppCubit()..getBusiness ),
        BlocProvider(
    create: (BuildContext context) =>DarkModeCubit(NewsAppInitialState())..changeAppMode(
    fromShared: isDark ),
        )
    ],
    child:
        BlocConsumer<DarkModeCubit,NewsAppStates>(

          listener: (BuildContext context, state){},
          builder: (BuildContext context,  state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: DarkModeCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
              home:  const HomeLayoutScreen(),
            );
          },

        ),
      );

  }
}
