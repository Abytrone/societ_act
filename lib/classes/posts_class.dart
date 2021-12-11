class Post {
  final String? fullname;
  final String? username;
  final String? userImage;
  final String? postImage;
  final String? postText;
  final String? postTitle;
  final String? likes;

  const Post({
    this.fullname,
    this.username,
    this.userImage,
    this.postImage,
    this.postText,
    this.postTitle,
    this.likes,
  });
}

class Posts {
  static List<Post>? item() {
    const posts = <Post>[
      Post(
        fullname: 'Abdul Basit Yahaya',
        username: '@Abytrone',
        userImage: 'https://cdn-icons-png.flaticon.com/512/4139/4139981.png',
        postImage:
            'https://images.unsplash.com/photo-1638368012876-5812dd95d7cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDh8NnNNVmpUTFNrZVF8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
        postText:
            'To keep it very simple I have only 3 layers, I could’ve separated all the service classes into a service package, since our app is so small and has only one service class I preferred this structure.',
        postTitle: 'RadioButton With ChangeNotifier Provider',
        likes: '143',
      ),
      Post(
        fullname: 'Nurudeen Yahuza',
        username: '@Yahuza',
        userImage:
            'https://images.unsplash.com/photo-1624673130139-e04e46d8d680?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=423&q=80',
        postImage:
            'https://images.unsplash.com/photo-1521449897387-b0e90df72994?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=888&q=80',
        postText:
            'With the google_fonts package, .ttf or .otf files do not need to be stored in your assets folder and mapped in the pubspec. Instead, they can be fetched once via http at runtime, and cached in the app\'s file system. This is ideal for development, and can be the preferred behavior for production apps that are looking to reduce the app bundle size. Still, you may at any time choose to include the font file in the assets, and the Google Fonts package will prioritize pre-bundled files over http fetching. Because of this, the Google Fonts package allows developers to choose between pre-bundling the fonts and loading them over http, while using the same API.',
        postTitle: 'A package to include fonts from fonts.',
        likes: '433',
      ),
      // Post(
      //   fullname: '',
      //   username: '',
      //   userImage: '',
      //   postImage: '',
      //   postText: '',
      //   postTitle: '',
      //   likes: '',
      // ),
    ];
    return posts;
  }
}
