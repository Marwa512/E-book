// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:ebook/features/admin/presentation/view/admin_panel.dart';
import 'package:ebook/features/authentication/presentation/manger/auth_state.dart';
import 'package:ebook/features/authentication/presentation/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../home/presentation/view/user_home.dart';
import '../../data/user_model.dart';

class EbookAuthCubit extends Cubit<AuthEbookState> {
  EbookAuthCubit() : super(AuthInitialState());
  static EbookAuthCubit get(context) => BlocProvider.of(context);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      if (email == 'admin@admin.com') {
        Get.to(() => const AdminPanel());
      } else {
        await getUser();
        Get.to(() => UserScreen(userData: userData));
      }
      emit(LoginSucessState());
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  void userVerficationAcceptance({
    required String uid,
    required UserModel model,
  }) {
    emit(AdminAcceptVerSuccessState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .update(model.ToMap())
        .then((value) {
      getUsers();
    }).catchError((error) {
      emit(AdminAcceptVerErrorState(error.toString()));
    });
  }

  void sendVerfication() {
    emit(SendVerLoadingState());
    FirebaseAuth.instance.currentUser!
        .sendEmailVerification()
        .then((value) => emit(SendVerSuccessState()))
        .catchError((error) {
      emit(SendtVerErrorState(error.toString()));
    });
  }

  late UserModel userData;
  Future<void> getUser() async {
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userData = UserModel.FromJson(value.data()!);
      emit(GetUserSuccessState());
      Get.to(UserScreen(
        userData: userData,
      ));
    }).catchError((error) {
      emit(GetUserErrorState(error));
    });
  }

  void userLogOut() {
    FirebaseAuth.instance.signOut().then((value) {
      Get.to(()=> LoginScreen());
            emit(LogoutSucessState());
    }).catchError((error) {
      emit(LogoutErrorState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    if (isPasswordShown == true) {
      suffix = Icons.visibility_off_outlined;
      isPasswordShown = false;
    } else {
      suffix = Icons.visibility_outlined;
      isPasswordShown = true;
    }

    emit(LoginchangePasswordVisibilityState());
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(email: email, name: name, uid: value.user!.uid);
      emit(RegisterSucessState());
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser(
      {required String email, required String name, required String uid}) {
    emit(CreateUserLoadingState());
    UserModel model = UserModel(
      email: email,
      name: name,
      uid: uid,
      isVerified: false,
      image:
          "https://img.freepik.com/free-photo/internet-library-online-education-concept_107791-15685.jpg?t=st=1710250963~exp=1710254563~hmac=826f8bd66470ec4fe9417390fdb3b01153a6911e79496448ae4f6bf4a5c42df4&w=826",
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set(model.ToMap())
        .then((value) {
      emit(CreateUserSucessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error));
    });
  }

  List<UserModel> users = [];

  Future<void> getUsers() async {
    users = [];
    emit(GetAllUserLoadingState());
    await FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        users.add(UserModel.FromJson(element.data()));
      });

      emit(GetAllUserSuccessState());
    }).catchError((error) {
      emit(GetAllUserErrorState(error.toString()));
    });
  }
}
