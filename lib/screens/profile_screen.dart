import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:volunet/providers/user_provider.dart';
import 'package:volunet/resources/storage_methods.dart';
import 'package:volunet/resources/users_methods.dart';
import 'package:volunet/screens/login_screen.dart';
import 'package:volunet/ui_elements/back_to_top_button.dart';
import 'package:volunet/models/user.dart' as model;

import '../constraints/style.dart';
import '../models/post.dart';
import '../providers/posts_provider.dart';
import '../utils/utils.dart';
import '../widgets/post_card.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    String profilePictureURL =
        await StorageMethods().uploadImageToStorage('profilePics', image);
    await UsersMethods().updateUsersProfilePicture(
        FirebaseAuth.instance.currentUser!.uid, profilePictureURL);
    setState(() {});
  }

  @override
  void initState() {
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
    model.User user = Provider.of<UserProvider>(context).getUser;
    String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
    var posts = Provider.of<PostsProvider>(context, listen: false);

    return Scaffold(
      floatingActionButton: BackToTopButton(
        scrollController: _scrollController,
        showScrollToTopButton: _showScrollToTopButton,
      ),
      backgroundColor: AppStyle.colors.backgroundGrey,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: AppStyle.borderRadius,
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => selectImage(),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(user.avatarURL == ''
                              ? 'https://images.are.na/eyJidWNrZXQiOiJhcmVuYV9pbWFnZXMiLCJrZXkiOiI4MDQwOTc0L29yaWdpbmFsX2ZmNGYxZjQzZDdiNzJjYzMxZDJlYjViMDgyN2ZmMWFjLnBuZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0IjoxMjAwLCJmaXQiOiJpbnNpZGUiLCJ3aXRob3V0RW5sYXJnZW1lbnQiOnRydWV9LCJ3ZWJwIjp7InF1YWxpdHkiOjkwfSwianBlZyI6eyJxdWFsaXR5Ijo5MH0sInJvdGF0ZSI6bnVsbH19?bc=0'
                              : user.avatarURL),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      //const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.name} ${user.surname}',
                            style: TextStyle(
                              color: AppStyle.colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Ionicons.home_outline,
                              size: 16,
                              color: AppStyle.colors.darkGrey,),
                              SizedBox(width: 8,),
                              Text(
                                user.city,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppStyle.colors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Ionicons.call_outline,
                                size: 16,
                                color: AppStyle.colors.darkGrey,),
                              SizedBox(width: 8,),
                              Text(
                                user.phoneNumber,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppStyle.colors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Ionicons.mail_outline,
                                size: 16,
                                color: AppStyle.colors.darkGrey,),
                              SizedBox(width: 8,),
                              Text(
                                user.email,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppStyle.colors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Ionicons.log_out_outline,
                          color: AppStyle.colors.darkGrey,
                          size: 28,
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: FutureBuilder(
                future: posts.getPostsByUser(currentUserUID),
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
