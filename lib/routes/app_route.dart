
import 'package:flutter/material.dart';
import 'package:newdoor/model/property.dart';
import 'package:newdoor/screens/aboutus/aboutus.dart';
import 'package:newdoor/screens/buy/buy.dart';
import 'package:newdoor/screens/contactus/contactus.dart';
import 'package:newdoor/screens/detailbuy/detailbuy.dart';
import 'package:newdoor/screens/filter/filter.dart';
import 'package:newdoor/screens/help/help.dart';
import 'package:newdoor/screens/home/home_screen.dart';
import 'package:newdoor/screens/property/property.dart';
import 'package:newdoor/screens/property_list/property_list.dart';
import 'package:newdoor/screens/seeprofile/seeprofile.dart';
import 'package:newdoor/screens/sign_in/sign_in_screen.dart';
import 'package:newdoor/screens/sign_up/sign_up_screen.dart';
import 'package:newdoor/screens/subscription/component/body.dart';
import 'package:newdoor/screens/subscription/subscription.dart';
import 'package:newdoor/screens/time/time.dart';
import 'package:newdoor/screens/viewer/viewer.dart';
import '../model/category.dart';
import '../screens/category/category_screen.dart';
import '../screens/category_list/category_list_screen.dart';
import '../screens/onboarding/on_boarding_screen.dart';
import '../screens/splash/splash_screen.dart';

class AppRoute {

  static const splashScreen = '/';
  static const onBoardingScreen = '/onBoarding';
  static const signInScreen = '/signIn';
  static const signUpScreen = '/signUp';
  static const homeScreen = '/home';
  static const aboutScreen='/about';
  static const buyScreen='/buy';
  static const categoryListScreen = '/categoryList';
  static const categoryScreen = '/category';
  static const propertyScreen = '/propertyform';
  static const propertydetailsScreen = '/propertydetails';
  static const detailbuyScreen = '/detailbuy';
  static const filterscreen = '/filter';
  static const helpscreen = '/help';
  static const contactusscreen = '/contactus';
  static const subscriptionscreen = '/subscription';
  static const seeprofilescreen = '/seeprofile';
  static const viewerscreen = '/viewer';
  static const timescreen = '/time';
  static const notificationscreen = '/notification';




  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => OnBoardingScreen(),
        );
      case signInScreen:
        return MaterialPageRoute(
          builder: (context) => SignInScreen(),
        );
      case signUpScreen:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case AppRoute.timescreen:
        final String propertyOwnerUid = settings.arguments as String; // Extract the UID from arguments
        return MaterialPageRoute(
          builder: (context) => TimeScreen(propertyOwnerUid: propertyOwnerUid), // Pass it to TimeScreen
        );

      case subscriptionscreen:
        return MaterialPageRoute(
          builder: (context) => subscription(),
        );
      case contactusscreen:
        return MaterialPageRoute(
          builder: (context) => contactus(),
        );
      case viewerscreen:
        return MaterialPageRoute(
          builder: (context) => viewer(),
        );
      case aboutScreen:
        return MaterialPageRoute(
          builder: (context) => about(),
        );
      case seeprofilescreen:
        return MaterialPageRoute(
          builder: (context) => seeprofile(),
        );
      case buyScreen:
        return MaterialPageRoute(
          builder: (context) => buy(),
        );
      case categoryListScreen:
        return MaterialPageRoute(
          builder: (context) => CategoryListScreen(),
        );
      case helpscreen:
        return MaterialPageRoute(
          builder: (context) => help(),
        );
      case propertydetailsScreen:
        return MaterialPageRoute(
          builder: (context) => propertylist(),
        );
      case filterscreen:
        return MaterialPageRoute(
          builder: (context) => Filter(),
        );
      case propertyScreen:
        Property? property = settings.arguments != null ? settings.arguments as Property : null;

        return MaterialPageRoute(
          builder: (context) => propertyscreen(
            property: property,
          ),
        );
      case detailbuyScreen:
        Property? property = settings.arguments != null ? settings.arguments as Property : null;
        return MaterialPageRoute(
          builder: (context) => detailBuy(property: property!),
        );
      case categoryScreen:
        Category? category = settings.arguments != null ? settings.arguments as Category : null;

        return MaterialPageRoute(
          builder: (context) => CategoryScreen(
            category: category,
          ),
        );

    }
  }


}
