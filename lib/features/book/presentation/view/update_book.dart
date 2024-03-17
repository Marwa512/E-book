
import 'package:ebook/core/constant.dart';
import 'package:ebook/core/widgets/text_style.dart';
import 'package:ebook/features/book/data/book_model.dart';
import 'package:ebook/features/book/presentation/manger/book_cubit.dart';
import 'package:ebook/features/book/presentation/manger/book_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBook extends StatelessWidget {
  UpdateBook({super.key, required this.book});

  BookModel book = BookModel();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _aboutAuthorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _cateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookCubit, BookState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bookImage = book.coverImage!;

        _nameController.text = book.name!;
        _authorController.text = book.authorName!;
        _aboutAuthorController.text = book.aboutAuthor!;
        _priceController.text = book.price!;
        _aboutController.text = book.aboutBook!;
        _cateController.text = book.category!;

        return Scaffold(
          appBar: AppBar(
            title: const TextWidget(title: 'Update Book'),
            actions: [
              TextButton(
                  onPressed: () {
                    BookCubit.get(context).uploadBookCover(id: book.id ??"",
                     aboutAuthor: _aboutAuthorController.text,
                      name: _nameController.text,
                      aboutBook: _aboutController.text,
                      authorName: _authorController.text,
                      category: _cateController.text,
                      coverImage:" $BookCubit.get(context).BookCover",
                      pdf: "",
                      voice: "",
                    );
                    BookCubit.get(context).updateBook(
                      id: book.id ?? "",
                      aboutAuthor: _aboutAuthorController.text,
                      name: _nameController.text,
                      aboutBook: _aboutController.text,
                      authorName: _authorController.text,
                      category: _cateController.text,
                      coverImage: bookImage,
                      pdf: "",
                      voice: "",
                    );
                  },
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(children: [
                if (state is UpdateBookLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                    Card(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    child: Image(
                      fit: BoxFit.cover,
                      height: 200,
                      width: 150,
                      image: NetworkImage(book.coverImage ?? ""),
                    ),
                  ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 18,
                          child: IconButton(
                              onPressed: () {
                                BookCubit.get(context).getBookCover();
                              },
                              icon: const Icon(
                                Icons.camera,
                                size: 18,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (BookCubit.get(context).bookImage != null)
                  Row(
                    children: [
                      if (BookCubit.get(context).bookImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    BookCubit.get(context).UploadCoverImage(
                                        authorName: _authorController.text,
                                        category: _cateController.text,
                                        name: _nameController.text,
                                        price: _priceController.text);
                                  },
                                  child: const Text(
                                    "Upload Image",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (state is UpdateBookLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: ((String? value) {
                    if (value!.isEmpty) {
                      return ("Name cant be empty");
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                    labelText: "Book Name",
                    prefixIcon: Icon(Icons.book),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _authorController,
                  keyboardType: TextInputType.name,
                  validator: ((String? value) {
                    if (value!.isEmpty) {
                      return ("Author name cant be empty");
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                    labelText: "Author name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _aboutAuthorController,
                  keyboardType: TextInputType.name,
                  validator: ((String? value) {
                    if (value!.isEmpty) {
                      return ("");
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                    labelText: "About Author ",
                    prefixIcon: Icon(Icons.call_sharp),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _aboutController,
                  keyboardType: TextInputType.name,
                  validator: ((String? value) {
                    if (value!.isEmpty) {
                      return ("");
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                    labelText: "About Book",
                    prefixIcon: Icon(Icons.details),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.name,
                  validator: ((String? value) {
                    if (value!.isEmpty) {
                      return ("");
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                    labelText: "price",
                    prefixIcon: Icon(Icons.attach_money_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _cateController,
                  keyboardType: TextInputType.name,
                  validator: ((String? value) {
                    if (value!.isEmpty) {
                      return ("");
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                    labelText: "Category",
                    prefixIcon: Icon(Icons.menu),
                    border: OutlineInputBorder(),
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
