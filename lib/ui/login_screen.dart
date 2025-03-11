import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/authbloc/auth_bloc.dart';
import 'package:flutter_bloc_demo/authbloc/auth_event.dart';
import 'package:flutter_bloc_demo/common/utils.dart';
import 'package:flutter_bloc_demo/ui/home_screen.dart';

import '../authbloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showSnackBar(context, state.error);
        }
        if (state is AuthenticatedState) {
          showSnackBar(context, state.message);
          if (state.model.status == 200) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => HomeScreen()),
              (route) => false,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              state == SelectedIndexState(0) ? "Login" : "Register",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            bottom: PreferredSize(
              preferredSize: Size(60, 60),
              child: Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        state == SelectedIndexState(0)
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    onPressed:
                        () => context.read<AuthBloc>().add(
                          OnSelectedIndexPressed(0),
                        ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color:
                            state == SelectedIndexState(0)
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        state == SelectedIndexState(1)
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    onPressed:
                        () => context.read<AuthBloc>().add(
                          OnSelectedIndexPressed(1),
                        ),
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                        color:
                            state == SelectedIndexState(1)
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator:
                          (value) =>
                              value!.isEmpty ? "Field is required" : null,
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator:
                          (value) =>
                              value!.isEmpty ? "Field is required" : null,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    SizedBox(height: 35),
                    MaterialButton(
                      height: 50,
                      minWidth: double.infinity,
                      color: Colors.black,
                      disabledColor: Colors.grey,
                      onPressed:
                          state == LoadingState()
                              ? null
                              : () {
                                if (formKey.currentState!.validate()) {
                                  if (state == SelectedIndexState(0)) {
                                    context.read<AuthBloc>().add(
                                      OnLoginPressed(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  } else {
                                    context.read<AuthBloc>().add(
                                      OnRegisterPressed(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  }
                                }
                              },
                      child:
                          state == LoadingState()
                              ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                              : Text(
                                state == SelectedIndexState(0)
                                    ? "LOGIN"
                                    : "REGISTER",

                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
