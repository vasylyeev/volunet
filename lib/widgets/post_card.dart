import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:volunet/models/user.dart';
import 'package:volunet/resources/users_methods.dart';
import '../constraints/style.dart';
import '../models/post.dart';
import '../screens/post_screen.dart';

class PostCard extends StatefulWidget {
  final Post post;

  PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

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

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(post: widget.post),
          ),
        );
      },
      child: Container(
        padding: AppStyle.padding,
        margin: const EdgeInsets.only(bottom: 12),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(author?.avatarURL ?? ''),
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
                      ),
                    ),
                    Text(
                      "${author?.city ?? 'Завантаження...'} • ${widget.post.date}• ${widget.post.time}",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppStyle.colors.darkGrey,
                      ),
                    )
                  ],
                ),
              ],
            ),
            if (widget.post.text != '') ...[
              const SizedBox(height: 12),
              Text(
                widget.post.text ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppStyle.colors.black,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.post.imageURL,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Ionicons.heart_outline,
                      size: 28,
                      color: AppStyle.colors.darkGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "${widget.post.likes}",
                      style: TextStyle(
                        color: AppStyle.colors.darkGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Відкрити на повну сторінку...',
              style: TextStyle(
                color: AppStyle.colors.darkGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
