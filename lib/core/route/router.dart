import 'package:abc/features/home/Emotion/src/ui/pages/game/Emotion_view.dart';
import 'package:abc/features/home/learn/learn_alphabets/view/learn_alphabet_view.dart';
import 'package:abc/features/home/learn/memory_game/homepage.dart';
import 'package:abc/features/home/learn_time/StartClock.dart';
import 'package:abc/features/home/major_learn/view/activities/view/activities.dart';
import 'package:abc/features/home/major_learn/view/activities/view/activity_test.dart';
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
import 'package:abc/previous/practice_speaking/view/practice_speaking.dart';
import 'package:abc/previous/text_reconization/view/text_view.dart';
import 'package:flutter/material.dart';

import '../../previous/orientation_test/view/orientation_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _customPageRoute(ChildHomeScreen());

      case ActivityScreen.routeName:
        return _fadePageRoute(ActivityScreen());

      case ActivityTest.routeName:
        return _fadePageRoute(ActivityTest());

      case ContentScreenLearning.routeName:
        return _fadePageRoute(ContentScreenLearning());

      case PeopleScreen.routeName:
        return _fadePageRoute(PeopleScreen());

      case AnimalScreen.routeName:
        return _fadePageRoute(AnimalScreen());

      case SchoolScreen.routeName:
        return _fadePageRoute(SchoolScreen());

      case FoodScreen.routeName:
        return _fadePageRoute(FoodScreen());

      case FeelingScreen.routeName:
        return _fadePageRoute(FeelingScreen());
      case ColorScreen.routeName:
        return _fadePageRoute(ColorScreen());
      case ConversationScreen.routeName:
        return _fadePageRoute(ConversationScreen());

      case AnimalTest.routeName:
        return _fadePageRoute(AnimalTest());

      case PeopleTest.routeName:
        return _fadePageRoute(PeopleTest());
      case SchoolTest.routeName:
        return _fadePageRoute(SchoolTest());

      case ColorTest.routeName:
        return _fadePageRoute(ColorTest());

      case FeelingTest.routeName:
        return _fadePageRoute(FeelingTest());

      case FoodTest.routeName:
        return _fadePageRoute(FoodTest());

      case PracticeSpeaking.routeName:
        return _fadePageRoute(PracticeSpeaking());

      case LearnAlphabetView.routeName:
        return _fadePageRoute(LearnAlphabetView());
      case MemoryHomePage.routeName:
        return _fadePageRoute(MemoryHomePage());

      case EmotionView.routeName:
        return _fadePageRoute(EmotionView());

      case StartClock.routeName:
        return _fadePageRoute(StartClock());

      case TextReconization.routeName:
        return _fadePageRoute(TextReconization());
      case OrientationView.routeName:
        return _fadePageRoute(OrientationView());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }

  static PageRouteBuilder _fadePageRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static MaterialPageRoute _customPageRoute(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }
}
