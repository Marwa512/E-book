import 'package:ebook/core/constant.dart';
import 'package:ebook/core/widgets/text_style.dart';
import 'package:ebook/features/book/data/book_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_button.dart';

class BookDetails extends StatelessWidget {
   BookDetails({super.key, required this.book});
   BookModel book=BookModel();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
              backgroundColor: Colors.grey.withOpacity(.1),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey.withOpacity(.1),
              height: 400,
              width: double.infinity,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    title: book.name ?? "Book name",
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  TextWidget(
                    title: book.authorName ?? "Author",
                    color: Colors.black,
                  ),
                  Card(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    child: Image(
                      fit: BoxFit.cover,
                      height: 300,
                      width: 150,
                      image: NetworkImage(book.coverImage ?? ""),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 60,
                  width: 150,
                  child: CustomButton(
                    buttonColor: mainColor,
                    onTap: () {},
                    text: "Reading",
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: CustomButton(
                    buttonColor: mainColor,
                    onTap: () {},
                    text: "Listening",
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
            const TextWidget(
              title: "About the book",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
             TextWidget(
              title:
book.aboutBook ?? "about book"
            ),
            const TextWidget(
              title: "About the author",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
             TextWidget(
                title:
                    book.aboutAuthor ??"")
          ],
        ),
      ),
    );
  }
}
