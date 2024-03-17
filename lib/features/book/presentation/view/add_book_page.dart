import 'dart:io';

import 'package:ebook/core/constant.dart';
import 'package:ebook/core/widgets/custom_button.dart';
import 'package:ebook/features/book/presentation/manger/book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_textfield.dart';
import '../manger/book_states.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController authorController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController aboutAuthorController = TextEditingController();
    TextEditingController aboutBookController = TextEditingController();
    return BlocConsumer<BookCubit, BookState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<BookCubit, BookState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomFormTextField(
                    hintText: "Book name",
                    inputType: TextInputType.name,
                    controller: nameController,
                    color: Colors.grey.withOpacity(.1),
                    validator: (v) {
                      return "";
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormTextField(
                    hintText: "Author Name",
                    inputType: TextInputType.name,
                    controller: authorController,
                    color: Colors.grey.withOpacity(.1),
                    validator: (v) {
                      return "";
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormTextField(
                    hintText: "Category name",
                    inputType: TextInputType.name,
                    controller: categoryController,
                    color: Colors.grey.withOpacity(.1),
                    validator: (v) {
                      return "";
                    },
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  CustomFormTextField(
                    hintText: "Price ",
                    inputType: TextInputType.name,
                    controller: priceController,
                    color: Colors.grey.withOpacity(.1),
                    validator: (v) {
                      return "";
                    },
                  ), const SizedBox(
                    height: 10,
                  ),
                  CustomFormTextField(
                    hintText: "about author ",
                    inputType: TextInputType.name,
                    controller: aboutAuthorController,
                    color: Colors.grey.withOpacity(.1),
                    validator: (v) {
                      return "";
                    },
                  ), const SizedBox(
                    height: 10,
                  ),
                  CustomFormTextField(
                    hintText: "About Book ",
                    inputType: TextInputType.name,
                    controller: aboutBookController,
                    color: Colors.grey.withOpacity(.1),
                    validator: (v) {
                      return "";
                    },
                  ), const SizedBox(
                    height: 10,
                  ),
                  if (BookCubit.get(context).bookImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: FileImage(
                                    BookCubit.get(context).bookImage as File),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 20,
                            child: IconButton(
                                onPressed: () {
                                  BookCubit.get(context).RemoveCoverImage();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 18,
                                )),
                          ),
                        ),
                      ],
                    ),
                  TextButton(
                    onPressed: () {
                      BookCubit.get(context).getBookImage();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Add cover image")
                      ],
                    ),
                  ),
                  CustomButton(
                      onTap: () {
                        BookCubit.get(context).UploadCoverImage(
                            authorName: authorController.text,
                            name: nameController.text,
                            category: categoryController.text, 
                            price: priceController.text,
                            aboutAuthor: aboutAuthorController.text,
                            aboutBook: aboutBookController.text,
                            );
                      },
                      textColor: Colors.white,
                      isLoading: state is AddBookLoadingState || state is BookUploadCoverImagePickedSuccessState,
                      text: "Add Book",
                      buttonColor: mainColor),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
