class MockCommunityFeedApi {
  Future<List<Post>> fetchPosts() async {
    // Simulate API request delay
    await Future.delayed(Duration(seconds: 1));

    // Return mock data
    return [
      Post(
        id: 1,
        title: 'Football match',
        caption: 'Had fun at football today!',
        created_by: 'Jack Lim',
        image: 'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80',
      ),
      Post(
        id: 2,
        title: 'Arts workshop',
        caption: 'I learned alot from this arts workshop.',
        created_by: 'Mary Fukouka',
        image: 'https://woodstockschoolofart.org/wp-content/uploads/2022/12/PXL_20221108_193644346-scaled.jpg',
      ),
      Post(
        id: 3,
        title: 'Hiking',
        caption: 'I made alot of friends from the hiking today!',
        created_by: 'John Campbell',
        image: 'https://img.freepik.com/free-photo/medium-shot-happy-friends-outside_23-2149003024.jpg?w=2000',
      ),
    ];
  }
}

class Post {
  final int id;
  final String title;
  final String caption;
  final String created_by;
  final String image;

  Post({
    required this.id,
    required this.title,
    required this.caption,
    required this.created_by,
    required this.image,
  });
}
