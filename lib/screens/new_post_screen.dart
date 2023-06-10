import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:volunet/constraints/style.dart';
import 'package:volunet/providers/user_provider.dart';
import 'package:volunet/resources/posts_methods.dart';
import 'package:volunet/resources/storage_methods.dart';
import 'package:volunet/screens/home_screen.dart';
import 'package:volunet/utils/utils.dart';
import 'package:volunet/widgets/new_post_category_button.dart';

import '../models/user.dart' as model;

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  String text = '';
  String category = 'animals';
  String authorId = '';
  Uint8List? _image;

  List<String> months = [
    'Січня',
    'Лютого',
    'Березня',
    'Квітня',
    'Травня',
    'Червня',
    'Липня',
    'Серпня',
    'Вересня',
    'Жовтня',
    'Листопада',
    'Грудня',
  ];

  List<String> items = [
    'Житло',
    'Продукти',
    'Тварини',
    'Медична Допомога',
    'Психологічна Підтр...',
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

  String getUkrainianMonth(String day) {
    int month = int.parse(day.substring(day.length - 2));
    return months[month - 1];
  }

  selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String day = DateFormat("dd.MM").format(DateTime.now());
    String time = DateFormat("HH:mm").format(DateTime.now());

    String today = '${day.substring(0, 2)} ${getUkrainianMonth(day)}';

    model.User currentUser = Provider.of<UserProvider>(context).getUser;
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.colors.backgroundGrey,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(currentUser.avatarURL),
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              currentUser.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TextField(
                          onChanged: (value) {
                            text = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Ionicons.pencil_outline,
                            ),
                            hintText: 'Про що хочете написати?',
                            contentPadding: const EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            // suffixIcon: Container(
                            //   margin: const EdgeInsets.only(right: 12),
                            //   child: TextButton(
                            //     onPressed: () {},
                            //     child: Text(
                            //       'Опублікувати',
                            //       style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         color: AppStyle.colors.darkBlue,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => selectImage(),
                          child: _image == null
                              ? Image.network(
                                  'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png')
                              : Image.memory(_image!),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                    child: Text(
                      'Категорія',
                      style: AppStyle.bigTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0),
                      itemCount: items.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(6),
                            // padding: const EdgeInsets.symmetric(
                            //     horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: current == index
                                  ? AppStyle.colors.darkBlue
                                  : Colors.white54,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F4690),
                        elevation: 0,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      onPressed: () async {
                        PostsMethods().addPost(
                            authorID: currentUserID,
                            category: categories[current],
                            date: today,
                            image: _image!,
                            text: text,
                            time: time);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Ionicons.add),
                          SizedBox(width: 6),
                          Text(
                            'Опублікувати',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
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
