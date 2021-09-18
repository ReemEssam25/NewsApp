import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports-screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get (context) => BlocProvider.of(context);

  int currentIndex = 0;

  List <Widget> currentScreen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen()
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: "Business"
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: "Sports"
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: "Science"
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Settings"
    ),
  ];


  void changeBottomNavBar (int index)
  {
    currentIndex = index;
    if (index == 1)
      getSports();
    else if (index == 2)
      getScience();
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business =[];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'58a1b67c70564726978032d632f56865'
    }).then((value){
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error);
      emit(NewsGetBusinessFailState(error.toString()));
    });
  }

  List<dynamic> sports =[];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());


    if (sports.length==0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'sports',
              'apiKey':'58a1b67c70564726978032d632f56865'
            }).then((value){
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          print(error);
          emit(NewsGetSportsFailState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetSportsSuccessState());
      }
  }

  List<dynamic> science =[];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'science',
              'apiKey':'58a1b67c70564726978032d632f56865'
            }).then((value){
          science = value.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccessState());
        }).catchError((error){
          print(error);
          emit(NewsGetScienceFailState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetScienceSuccessState());
      }
  }

}