import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Cubit/States.dart';
import 'package:news_app/Network/remote/dio_helper.dart';
import 'package:news_app/Screens/business_screen.dart';
import 'package:news_app/Screens/science_screen.dart';
import 'package:news_app/Screens/sports_screen.dart';

import '../Screens/settings_screen.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(NewsAppInitialState());

  static NewsAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: "sports",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: "science",
    ),
  ];

  void changeBotNavItem(int index) {
    currentIndex = index;

    if (index == 1) {      getSports();
    }

    if (index == 2) {
      getScience();
    }

    emit(ChangeBotNavItemState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState(),);
    DioHelper.getData(
      methodUrl: "v2/top-headlines",
      query: {
        "country": "eg",
        "category": "business",
        "apiKey": "56782a2b85b34e6fa31815af9aad7b8e",
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]["title"]);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print("error is ${error.toString()}");
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        methodUrl: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "sports",
          "apiKey": "56782a2b85b34e6fa31815af9aad7b8e",
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]["title"]);

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print("error is ${error.toString()}");
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        methodUrl: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "science",
          "apiKey": "56782a2b85b34e6fa31815af9aad7b8e",
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]["title"]);

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print("error is ${error.toString()}");
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }


  List<dynamic> search = [];

  void getSearch(String value)  {
    emit(NewsGetSearchLoadingState());
      DioHelper .getData(
        methodUrl: "v2/everything",
        query: {
          "q": "$value",
          "apiKey": "56782a2b85b34e6fa31815af9aad7b8e",
        },
      ).then((value) {
        search = value.data['articles'];
        print(search[0]["title"]);

        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print("error is ${error.toString()}");
        emit(NewsGetSearchErrorState(error.toString()));
      });

  }

}
