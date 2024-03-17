import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ebook/core/constant.dart';
import 'package:ebook/core/widgets/text_style.dart';
import 'package:ebook/features/authentication/presentation/manger/auth_cubit.dart';
import 'package:ebook/features/authentication/presentation/manger/auth_state.dart';
import 'package:ebook/features/book/presentation/manger/book_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../book/data/book_model.dart';
import '../../../authentication/data/user_model.dart';
import '../../../book_details.dart/presentation/view/book_details.dart';

// ignore: must_be_immutable
class UserScreen extends StatefulWidget {
  UserScreen({super.key, required this.userData});
  UserModel userData;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    
    super.initState();
    EbookAuthCubit.get(context).getUser();
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    var bookCubit = BookCubit.get(context);
    return BlocConsumer<EbookAuthCubit,AuthEbookState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return BlocBuilder<EbookAuthCubit,AuthEbookState>(
          builder: (context,state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(widget.userData.image ?? "")),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.userData.name ?? " name", style: const TextStyle(color: Colors.black),),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                      EbookAuthCubit.get(context).userLogOut();
                      },
                      icon: const Icon(Icons.logout, color: Colors.black,)),
                ],
              ),
              body:ConditionalBuilder(condition: state is! GetUserLoadingState , builder: (context) {
                return  Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (EbookAuthCubit.get(context).userData.isVerified == false)
                      Container(
                        color: Colors.grey.withOpacity(.1),
                        width: double.infinity,
                        height: 30,
                        child: const Center(
                            child: TextWidget(
                                title: "Activate your account to access books")),
                      ),
                    if (EbookAuthCubit.get(context).userData.isVerified == true && FirebaseAuth.instance.currentUser!.emailVerified ==false)
                      Container(
                        color: Colors.grey.withOpacity(.1),
                        width: double.infinity,
                        height: 30,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              EbookAuthCubit.get(context).sendVerfication();
                            },
                            child: const TextWidget(title: "Verify your account"),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              coverWidget(bookCubit.books[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 5,
                              ),
                          itemCount: bookCubit.books.length),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const TextWidget(
                      title: "Books List",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    Expanded(
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              bookList(context, bookCubit.books[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: bookCubit.books.length),
                    ),
                  ],
                ),
              );
              }, fallback: (context) =>const Center(child: CircularProgressIndicator()),),
            );
          }
        );
      }
    );
  }
}

Widget coverWidget(BookModel model) {
  return Card(
    margin: const EdgeInsets.all(8),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    child: Image(
        fit: BoxFit.cover,
        height: 300,
        width: 200,
        image: NetworkImage(model.coverImage ?? "")),
  );
}

Widget bookList(context, BookModel model) {
  return InkWell(
    onTap: () {

FirebaseAuth.instance.currentUser!.emailVerified ?  
      Get.to( BookDetails(book: model), ) :
      Get.snackbar("Account not verified ", "Verify account to access books ");
    },
    child: Container(
      height: 230,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            fit: BoxFit.cover,
            height: 200,
            width: 130,
            image: NetworkImage(model.coverImage ?? ""),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: TextWidget(
                  title: model.category ?? "Category",
                  color: mainColor,
                )),
              ),
              SizedBox(
                width: 150,
                child: TextWidget(
                  title: model.name ?? "Title",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 150,
                child: TextWidget(
                  title: model.authorName ?? "Title",
                ),
              ),
              const Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 50,
                  ),
                  TextWidget(
                    title: "(4.5)",
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              const TextWidget(
                title: "50\$   ",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const Icon(
            Icons.file_download_rounded,
            size: 26,
          ),
        ],
      ),
    ),
  );
}
