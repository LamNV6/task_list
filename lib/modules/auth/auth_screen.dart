import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'auth_service.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthService.instance;
    return Scaffold(
        backgroundColor: Colors.pink,
        body: Center(
            child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(child: Obx(() {
                if (authService.isCreate.value) {
                  return SignupWidget(authService: authService);
                } else {
                  return LoginWidget(authService: authService);
                }
              }))),
        )));
  }
}

class SignupWidget extends StatelessWidget {
  const SignupWidget({
    Key? key,
    required this.authService,
  }) : super(key: key);

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'CREATE ACCOUNT',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
        ),
        TextFormField(
          controller: usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
          ),
        ),
        TextFormField(
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text('SIGN UP'),
              onPressed: () async {
                await authService.onSignUp(
                  email: emailController.text,
                  password: passwordController.text,
                  username: usernameController.text,
                );
              },
            )),
        const SizedBox(height: 5),
        InkWell(
          child: const Text('I have ready account'),
          onTap: () {
            authService.onCreate(false);
          },
        )
      ],
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key? key,
    required this.authService,
  }) : super(key: key);

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'TASK LIST',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
        ),
        TextFormField(
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: const Text('LOGIN'),
            onPressed: () async {
              await authService.onSignIn(
                email: emailController.text,
                password: passwordController.text,
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        InkWell(
          child: const Text('Create new account'),
          onTap: () {
            authService.onCreate(true);
          },
        ),
      ],
    );
  }
}
