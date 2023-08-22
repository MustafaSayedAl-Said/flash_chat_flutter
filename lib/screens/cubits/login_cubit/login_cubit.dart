import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFail(errMessage: 'User not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFail(errMessage: 'Wrong password'));
      }
      else{
        emit(LoginFail(errMessage: 'Something went wrong'));
      }
    } catch (e) {
      emit(LoginFail(errMessage: 'Something went wrong'));
    }
  }
}
