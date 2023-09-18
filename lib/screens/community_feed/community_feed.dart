import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:dellminds_mobile_app/screens/community_feed/create_post.dart';
import 'package:dellminds_mobile_app/screens/community_feed/mockcommunityapi.dart';
import 'package:dellminds_mobile_app/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class CommunityFeedScreen extends StatefulWidget {
  static const String routeName = '/community';

  @override
  _CommunityFeedScreenState createState() => _CommunityFeedScreenState();
}

class _CommunityFeedScreenState extends State<CommunityFeedScreen> {
  final int currentIndex = 1;

  final mockApi = MockCommunityFeedApi();
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final loadedPosts = await mockApi.fetchPosts();
    setState(() {
      posts = loadedPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! To get around grey bar ontop of emulator

          Container(
            height: 55,
            padding: EdgeInsets.symmetric(vertical: 16),
            color: DesignConstants.COLOR_THEMEPINK,
          ),
          // Community Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: DesignConstants.COLOR_THEMEPINK,
            child: Column(
              children: [
                Text(
                  'Community',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.white,
                  indent: 16,
                  endIndent: 16,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: posts.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
              itemBuilder: (context, index) {
                final post = posts[index];
                return Column(
                  children: [
                    CommunityPostCard(post),
                    Divider(
                      height: 2,
                      thickness: 2,
                      color: Colors.grey, // Adjust the color as needed
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            CreatePostScreen.routeName,
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: Navigation_Bar(currentIndex: currentIndex),
    );
  }
}

class CommunityPostCard extends StatelessWidget {
  final Post post;

  CommunityPostCard(this.post);

  @override
  Widget build(BuildContext context) {
    // You can remove these lines as they are not needed for community posts.
    // final EventApi = Provider.of<EventApi>(context);
    // final userDummyProvider = Provider.of<UserDummyProvider>(context);
    // final userId = userDummyProvider.userId;

    // Check if the user has liked the post (example: you can add this functionality later).
    bool hasLiked =
        false; // You can implement this logic based on your requirements.

    return InkWell(
      onTap: () {
        // You can add actions to perform when a post is tapped.
        // For example, open the post details.
        // showDialog(
        //   context: context,
        //   builder: (context) => PostDetailsModal(post),
        // );
      },
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the post title
              Text(
                post.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),

              // Display the post creator (replace with your data)
              Text(
                '${post.created_by}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),

              // Display the post content (replace with your data)
              Text(
                post.caption,
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 2),

              // Display the post image (you can customize the image loading here)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  post.image, // Use the post's image URL
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),

              // You can add more widgets here, such as like and comment buttons.

              // Example like button (customize as needed)
              IconButton(
                icon: Icon(
                  hasLiked ? Icons.favorite : Icons.favorite_border,
                  color: hasLiked ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  // Implement logic to handle liking/unliking the post.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
