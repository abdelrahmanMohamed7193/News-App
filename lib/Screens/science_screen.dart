import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Cubit/States.dart';
import 'package:news_app/Cubit/cubit.dart';


import '../shared/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list= NewsAppCubit.get(context).science ;
          return articleBuilder(list,context) ;

        }
    );
  }
}