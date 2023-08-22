import 'package:flash_chat_flutter/screens/cubits/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../components/Option_Button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            _showSpinner = true;
          } else if (state is LoginSuccess) {
            Navigator.pushNamed(context, ChatScreen.id);
            _showSpinner = false;
          } else if (state is LoginFail) {
            showTopSnackBar(Overlay.of(context),
                CustomSnackBar.error(message: state.errMessage));
            _showSpinner = false;
          }
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                ButtonOption(
                  option: 'Log In',
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    BlocProvider.of<LoginCubit>(context)
                        .loginUser(email: email!, password: password!);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
