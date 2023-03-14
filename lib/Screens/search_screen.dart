import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Cubit/States.dart';
import 'package:news_app/Cubit/cubit.dart';
import '../shared/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsAppCubit.get(context).search;

        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    prefixIcon: Icons.search,
                    label: "search",
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        "Search must not be empty";
                      }
                    },
                    onChanged: (value) {
                      NewsAppCubit.get(context).getSearch(value);
                    },
                  ),
                ),
                Expanded(
                    child: articleBuilder(
                  list,
                  context,
                isSearch: true ,
                    )),
              ],
            ));
      },
    );
  }
}
