import 'package:abc/features/home/learn/activities/view/activities.dart';
import 'package:abc/features/home/learn/activities/view/activity_test.dart';
import 'package:abc/features/home/major_learn/view/animal/animal_screen.dart';
import 'package:abc/features/home/major_learn/view/animal/animal_test.dart';
import 'package:abc/features/home/major_learn/view/color/color_screen.dart';
import 'package:abc/features/home/major_learn/view/color/color_test.dart';
import 'package:abc/features/home/major_learn/view/content.dart';
import 'package:abc/features/home/major_learn/view/conversation/conversation.dart';
import 'package:abc/features/home/major_learn/view/feeling/feeling_test.dart';
import 'package:abc/features/home/major_learn/view/feeling/felling_screen.dart';
import 'package:abc/features/home/major_learn/view/food/food_screen.dart';
import 'package:abc/features/home/major_learn/view/food/food_test.dart';
import 'package:abc/features/home/major_learn/view/people/people.dart';
import 'package:abc/features/home/major_learn/view/people/people_test.dart';
import 'package:abc/features/home/major_learn/view/school/school_screen.dart';
import 'package:abc/features/home/major_learn/view/school/school_test.dart';
import 'package:abc/features/home/surface/view/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _customPageRoute(ChildHomeScreen());

      case ActivityScreen.routeName:
        return _customPageRoute(ActivityScreen());

      case ActivityTest.routeName:
        return _customPageRoute(ActivityTest());

      case ContentScreenLearning.routeName:
        return _customPageRoute(ContentScreenLearning());

      case PeopleScreen.routeName:
        return _customPageRoute(PeopleScreen());

      case AnimalScreen.routeName:
        return _customPageRoute(AnimalScreen());

      case SchoolScreen.routeName:
        return _customPageRoute(SchoolScreen());

      case FoodScreen.routeName:
        return _customPageRoute(FoodScreen());

      case FeelingScreen.routeName:
        return _customPageRoute(FeelingScreen());
      case ColorScreen.routeName:
        return _customPageRoute(ColorScreen());
      case ConversationScreen.routeName:
        return _customPageRoute(ConversationScreen());

      case AnimalTest.routeName:
        return _customPageRoute(AnimalTest());

      case PeopleTest.routeName:
        return _customPageRoute(PeopleTest());
      case SchoolTest.routeName:
        return _customPageRoute(SchoolTest());

      case ColorTest.routeName:
        return _customPageRoute(ColorTest());

      case FeelingTest.routeName:
        return _customPageRoute(FeelingTest());

      case FoodTest.routeName:
        return _customPageRoute(FoodTest());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }

  static PageRouteBuilder _customPageRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
