import 'package:fluddit/bloc/index.dart';
import 'package:fluddit/routes/index.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      child: Container(
        color: Theme.of(context).primaryColor,
        width: 300,
        height: 45,
        child: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
      onPressed: () {
        Get.back();
        Get.to(() => const LoginView());
      },
    );
  }
}
