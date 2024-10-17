import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:newdoor/routes/app_route.dart'; // Adjust import according to your project structure
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenDrawer extends StatefulWidget {
  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  String email = '';

  @override
  void initState() {
    super.initState();
    readUserEmail(); // Fetch the email when the drawer is initialized
  }

  // Fetch email from Firebase Authentication
  Future<void> readUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user != null) {
      setState(() {
        email = user.email ?? ''; // Set email or empty string
      });
    } else {
      setState(() {
        email = ''; // Set to empty if no user is logged in
      });
    }
  }

  // Clear SharedPreferences on logout
  Future<void> clearSession() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear(); // Clear all stored session data
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          buildUserAccountHeader(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.subscriptions_outlined),
            title: const Text('Subscription'),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.subscriptionscreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.next_plan_outlined),
            title: const Text('Plan Your Property'),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.seeprofilescreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.remove_red_eye_outlined),
            title: const Text('Property Viewer'),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.viewerscreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_page),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.contactusscreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.helpscreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.aboutScreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('LogOut'),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  // Build the user account header with email
  Widget buildUserAccountHeader() {
    return UserAccountsDrawerHeader(
      accountName: const Text(
        "NewDoor",
        style: TextStyle(color: Colors.white),
      ),
      accountEmail: Text(
        email.isNotEmpty ? email : "Guest", // Show guest if no email is available
        style: const TextStyle(color: Colors.white),
      ),
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset(
          'assets/images/user.png',
          height: 45,
          width: 45,
        ),
      ),
    );
  }

  // Show Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.login_rounded,
            size: 50,
          ),
          title: const Text("Are you sure?"),
          titleTextStyle: const TextStyle(
              fontSize: 28, color: Colors.black, fontWeight: FontWeight.w400),
          content: const Text(
            "Come back sooner!",
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Aligns buttons evenly
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Handle logout process
                    FirebaseAuth auth = FirebaseAuth.instance;
                    await auth.signOut(); // Sign out from Firebase

                    // Clear session data
                    await clearSession();

                    // Navigate to sign-in screen
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoute.signInScreen, (route) => false);
                  },
                  child: const Text("Yes"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}
