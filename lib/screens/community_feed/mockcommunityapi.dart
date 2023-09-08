class MockCommunityFeedApi {
  Future<List<Post>> fetchPosts() async {
    // Simulate API request delay
    await Future.delayed(Duration(seconds: 1));

    // Return mock data
    return [
      Post(
        id: 1,
        title: 'Post 1 Title',
        caption: 'This is the content of the first post.',
        remarks: 'Remark 1',
        created_by: 'User 1',
        image: 'https://img.freepik.com/free-photo/medium-shot-happy-friends-outside_23-2149003024.jpg?w=2000',
      ),
      Post(
        id: 2,
        title: 'Post 2 Title',
        caption: 'This is the content of the second post.',
        remarks: 'Remark 2',
        created_by: 'User 2',
        image: 'https://img.freepik.com/free-photo/medium-shot-happy-friends-outside_23-2149003024.jpg?w=2000',
      ),
      Post(
        id: 3,
        title: 'Post 3 Title',
        caption: 'This is the content of the third post.',
        remarks: 'Remark 3',
        created_by: 'User 3',
        image: 'https://img.freepik.com/free-photo/medium-shot-happy-friends-outside_23-2149003024.jpg?w=2000',
      ),
    ];
  }
}

class Post {
  final int id;
  final String title;
  final String caption;
  final String remarks;
  final String created_by;
  final String image;

  Post({
    required this.id,
    required this.title,
    required this.caption,
    required this.remarks,
    required this.created_by,
    required this.image,
  });
}
