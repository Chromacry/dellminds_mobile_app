import 'package:dellminds_mobile_app/providers/quiz_provider.dart';
import 'package:dellminds_mobile_app/providers/user_dummy_provider.dart';
import 'package:dellminds_mobile_app/screens/quiz/quiz_page_1.dart';
import 'package:dellminds_mobile_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final userDummyProvider = Provider.of<UserDummyProvider>(context);
    final topCategory1 = userDummyProvider.topCategory1;
    final topCategory2 = userDummyProvider.topCategory2;

    // Dummy user data
    final userData = UserData(
      joinedEvents: 10,
      completedEvents: 5,
      posts: 20,
    );

    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Megumi",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Display top categories
                  if (topCategory1.isNotEmpty)
                    Text(
                      topCategory1, // Display top categories as a comma-separated string
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Customize text color
                      ),
                    ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16.0),
                      Transform.scale(
                        scale: 0.8,
                        child: FloatingActionButton.extended(
                          onPressed: () {},
                          heroTag: 'editprofile',
                          elevation: 0,
                          backgroundColor: Colors.red,
                          label: const Text("Edit Profile"),
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      const SizedBox(width: 5), // Add spacing between buttons
                      Transform.scale(
                        scale: 0.8,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            // Call resetQuiz to reset questions and categories
                            Provider.of<QuizProvider>(context, listen: false)
                                .resetQuiz();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizPage1()),
                            );
                          },
                          heroTag: 'editpreferences',
                          elevation: 0,
                          backgroundColor:
                              Colors.blue, // Customize the button color
                          label: const Text(
                              "Edit Preferences"), // Customize the button text
                          icon: const Icon(
                              Icons.quiz), // Customize the button icon
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _ProfileInfoRow(
                      userData: userData), // Pass the dummy user data
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navigation_Bar(currentIndex: currentIndex),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final UserData userData;

  const _ProfileInfoRow({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ProfileInfoItem> _items = [
      ProfileInfoItem("Joined Events", userData.joinedEvents),
      ProfileInfoItem("Completed Events", userData.completedEvents),
      ProfileInfoItem("Posts", userData.posts),
    ];

    final double milestoneValue = 0.5; // Replace with your milestone progress

    return Column(
      children: [
        Container(
          height: 80,
          constraints: const BoxConstraints(maxWidth: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _items
                .map((item) => Expanded(
                      child: Row(
                        children: [
                          if (_items.indexOf(item) != 0)
                            const VerticalDivider(),
                          Expanded(child: _singleItem(context, item)),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Milestone:"),
            SizedBox(width: 8),
            Text(
              "Level 3",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        LinearProgressIndicator(
          value: milestoneValue, // Replace with your actual milestone progress
          color: Colors.green, // Customize the progress bar color
          backgroundColor: Colors.grey, // Customize the background color
        ),
      ],
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class UserData {
  final int joinedEvents;
  final int completedEvents;
  final int posts;

  UserData({
    required this.joinedEvents,
    required this.completedEvents,
    required this.posts,
  });
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        100), // Adjust the radius as needed
                    child: Image.asset(
                      'assets/images/defaultpfp.jpg', // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
