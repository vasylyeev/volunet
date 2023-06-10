import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:ionicons/ionicons.dart';
import 'package:volunet/widgets/back_text_button.dart';
import '../constraints/style.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../resources/users_methods.dart';

class PostScreen extends StatefulWidget {
  final Post post;

  const PostScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  User? author;

  initUser() async {
    User user = await UsersMethods().getUserByUID(widget.post.authorID);
    setState(() {
      author = user;
    });
  }

  @override
  void initState() {
    initUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                clipBehavior: Clip.none,
                shrinkWrap: true,
                children: [
                  const BackTextButton(text: 'Назад'),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProfileScreen(
                      //       avatarImageURL: widget.post.avatarImageURL,
                      //       name: widget.post.author,
                      //       city: widget.post.city,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage:
                              NetworkImage(author?.avatarURL ?? ''),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${author?.name ?? 'Завантаження...'} ${author?.surname ?? ''}",
                              style: TextStyle(
                                color: AppStyle.colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${author?.city ?? 'Завантаження...'} • ${widget.post.date}• ${widget.post.time}",
                              style: TextStyle(
                                color: AppStyle.colors.darkGrey,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (widget.post.text != null)
                    Text(
                      widget.post.text ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppStyle.colors.black,
                      ),
                    ),
                  const SizedBox(height: 12),
                  widget.post.imageURL != null
                      ? FullScreenWidget(
                          disposeLevel: DisposeLevel.High,
                          child: Center(
                            child: Hero(
                              tag: 'smallImage',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  widget.post.imageURL ?? '',
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Ionicons.heart_outline,
                            size: 34,
                            color: AppStyle.colors.darkGrey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "${widget.post.likes}",
                            style: TextStyle(
                              color: AppStyle.colors.darkGrey,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
