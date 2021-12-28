import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_taksu/ui/shared/styles.dart';
import 'package:todo_taksu/ui/views/home_page.dart';
import 'package:todo_taksu/ui/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 74),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: "Name",
                  hint: "John Doe",
                  message: 'Please enter your name',
                  controller: controller,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 112,
                  height: 40,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: green,
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => HomePage(name: controller.text,)));
                      }
                      },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
