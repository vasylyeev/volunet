import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:volunet/providers/posts_provider.dart';
import 'package:volunet/providers/user_provider.dart';
import 'package:volunet/screens/new_post_screen.dart';
import 'package:volunet/screens/profile_screen.dart';
import 'package:volunet/ui_elements/back_to_top_button.dart';
import 'package:volunet/widgets/new_post_input.dart';
import 'package:volunet/widgets/post_card.dart';
import '../constraints/style.dart';
import '../models/post.dart';
import '../ui_elements/app_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int bottomSelectedIndex = 0;

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  refreshData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppNavigationBar(
        pageController: _pageController,
        bottomSelectedIndex: bottomSelectedIndex,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: [
          const HomeScreen(),
          const NewPostScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  List<String> items = [
    'Житло',
    'Продукти',
    'Тварини',
    'Медична Допомога',
    'Психологічна Підтримка',
    'Інше',
  ];

  List<String> categories = [
    'housing',
    'food',
    'animals',
    'medical assistance',
    'therapy',
    'other',
  ];

  List<IconData> icons = [
    Ionicons.home,
    Ionicons.fast_food,
    Ionicons.paw,
    Icons.feed,
    Ionicons.medkit,
    Ionicons.ellipsis_horizontal,
  ];
  int current = 0;

  @override
  void initState() {
    PostsProvider().getAllPosts();
    _scrollController.addListener(() {
      double showOffset = 10.0;
      if (_scrollController.offset > showOffset) {
        _showScrollToTopButton = true;
        setState(() {});
      } else {
        _showScrollToTopButton = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var posts = Provider.of<PostsProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppStyle.colors.backgroundGrey,
      floatingActionButton: BackToTopButton(
        scrollController: _scrollController,
        showScrollToTopButton: _showScrollToTopButton,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewPostInput(
              withPublishButton: false,
            ),
            //const CategoryChooser(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: current == index
                                ? AppStyle.colors.darkBlue
                                : Colors.white54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Icon(
                                  icons[index],
                                  size: 18,
                                  color: current == index
                                      ? Colors.white
                                      : AppStyle.colors.darkGrey
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  items[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: current == index
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: posts.getPostsFromCategory(categories[current]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Post> posts = snapshot.data as List<Post>;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return PostCard(post: posts[index]);
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppStyle.colors.darkBlue,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
