import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:volunet/screens/home_screen.dart';
import 'package:volunet/screens/login_screen.dart';
import '../constraints/style.dart';
import '../resources/auth_methods.dart';

enum Role { seeker, volunteer }

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  Role? _role = Role.seeker;
  int currentStep = 0;

  late String name, surname, email, city, phoneNumber, password;

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text('Роль'),
        content: Column(
          children: [
            Row(
              children: [
                Radio<Role>(
                  value: Role.seeker,
                  groupValue: _role,
                  onChanged: (Role? value) {
                    setState(() {
                      _role = value;
                    });
                  },
                ),
                Text('Шукаю допомогу'),
              ],
            ),
            Row(
              children: [
                Radio<Role>(
                  value: Role.volunteer,
                  groupValue: _role,
                  onChanged: (Role? value) {
                    setState(() {
                      _role = value;
                    });
                  },
                ),
                Text('Волонтер'),
              ],
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text('Персональні дані'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Реєстрація',
                style: AppStyle.bigTextStyle,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(24),
                          hintText: 'Ім\'я',
                          filled: true,
                          fillColor: AppStyle.colors.lightGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(24),
                          hintText: 'Прізвище',
                          filled: true,
                          fillColor: AppStyle.colors.lightGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            surname = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(24),
                          hintText: 'Пошта',
                          filled: true,
                          fillColor: AppStyle.colors.lightGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(24),
                          hintText: 'Місто',
                          filled: true,
                          fillColor: AppStyle.colors.lightGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            city = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(24),
                          hintText: 'Номер телефону',
                          filled: true,
                          fillColor: AppStyle.colors.lightGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(24),
                          hintText: 'Пароль',
                          filled: true,
                          fillColor: AppStyle.colors.lightGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Вже маєте акаунт?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text('Увійти'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F4690),
              elevation: 0,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () async {
              String response = await AuthMethods().signUpUser(
                  name: name,
                  surname: surname,
                  email: email,
                  city: city,
                  phoneNumber: phoneNumber,
                  password: password,);
              if (response != 'success') {
                print(response.toString());
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Зареєструватися',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(Ionicons.arrow_forward_outline)
              ],
            ),
          ),
        ),
        body: Center(
          child: Stepper(
            elevation: 0,
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepCancel: () => currentStep == 0
                ? null
                : setState(() {
                    currentStep -= 1;
                  }),
            onStepContinue: () {
              bool isLastStep = (currentStep == getSteps().length - 1);
              if (isLastStep) {
                //Do something with this information
              } else {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            onStepTapped: (step) => setState(() {
              currentStep = step;
            }),
            steps: getSteps(),
          ),
        ),
      ),
    );
  }
}
