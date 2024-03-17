import 'package:ebook/features/authentication/presentation/view/login_view.dart';
import 'package:ebook/features/book/presentation/manger/book_cubit.dart';
import 'package:ebook/features/authentication/presentation/manger/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'core/utils/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDr3c1BM07YZqwKUjeIf8hu2fZsmBTB2Xc",
        authDomain: "e-book-350ed.firebaseapp.com",
        projectId: "e-book-350ed",
        storageBucket: "e-book-350ed.appspot.com",
        messagingSenderId: "813835248623",
        appId: "1:813835248623:web:51fd0f4e2f2ae6fa76cc1a"),
  );
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => EbookAuthCubit()..getUsers()),
       
        BlocProvider(create: (BuildContext context) => BookCubit()..getBooks()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
          useMaterial3: false,
        ),
        home:  LoginScreen(),
      ),
    );
  }
}
