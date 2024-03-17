import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant.dart';
import '../../../../core/widgets/text_style.dart';
import '../../../book/data/book_model.dart';
import '../../../book/presentation/manger/book_cubit.dart';
import '../../../book/presentation/view/update_book.dart';

class BookList extends StatefulWidget {
  BookList({super.key, required this.model});
  BookModel model = BookModel();

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  void initState() {
    BookCubit.get(context).getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        () {
          BookCubit().deleteBooks(widget.model.id);
          setState(() {});
        };
      },
      key: Key(widget.model.id.toString()),
      child: InkWell(
        onTap: () {
          Get.to(
            UpdateBook(book: widget.model),
          );
        },
        child: SizedBox(
          height: 230,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                fit: BoxFit.cover,
                height: 200,
                width: 130,
                image: NetworkImage(widget.model.coverImage ?? ""),
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
                      title: widget.model.category ?? "Category",
                      color: mainColor,
                    )),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextWidget(
                      title: widget.model.name ?? "Title",
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
                      title: widget.model.authorName ?? "Title",
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
                   TextWidget(
                    title: widget.model.price ??"",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  BookCubit().deleteBooks(widget.model.id);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.delete,
                  size: 26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
