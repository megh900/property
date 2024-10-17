
import 'package:flutter/material.dart';
import 'package:newdoor/preference/pref_utils.dart';
import 'package:newdoor/routes/app_route.dart';
import 'package:newdoor/screens/onboarding/components/indicator.dart';
import 'package:newdoor/screens/onboarding/components/slide_view.dart';

import '../../../model/item.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Item> itemList = [];

  int currentIndex = 0;
  final _pageController = PageController();

  @override
  void initState() {
    itemList.add(
      Item(
          title: 'Property Listing',
          desc:
          'Discover your perfect property with ease. Whether you are looking to rent, buy, or invest, our platform offers a seamless experience for browsing commercial spaces, residential homes, and more.',
          image: 'assets/images/59296.jpg'),
    );
    itemList.add(
      Item(
          title: 'Buy Property',
          desc:
          'Take the first step toward owning your dream space! Whether you are looking for a cozy home, an office space, or a profitable investment, NewDoor offers an extensive range of properties tailored to your needs.',
          image: 'assets/images/19958-NSJLOB.jpg'),
    );
    itemList.add(
      Item(
          title: 'Delivery',
          desc:
          'Maximize your property’s value with NewDoor! Whether you are an individual owner or a real estate agent, our platform makes it easy to connect with potential buyers and sell your property efficiently.',
          image: 'assets/images/221267-P18L31-864.jpg'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (value) {
            //print(value);
            setState(() {
              currentIndex = value;
            });
          },
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return SlideView(itemList[index]);
          },
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                for(int i = 0; i<itemList.length; i++)
                  if(i==currentIndex)
                    getIndicator(true)
                  else
                    getIndicator(false)
              ],
            ),

            ElevatedButton(
              onPressed: () {
                if(currentIndex != itemList.length - 1){
                  // navigate to next slide
                  currentIndex++;
                  _pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 500), curve: Curves.linear);

                }else{
                  PrefUtils.updateOnboardingStatus(true).then((value) {
                    if(value){
                      // navigate to login screen
                      Navigator.pushReplacementNamed(context, AppRoute.signInScreen);
                    }
                  });
                }
              },
              child: Text(currentIndex != itemList.length - 1 ? 'NEXT' : 'FINISH'),
            )
          ],
        ),
      ),
    );
  }
}
