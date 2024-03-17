// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, deprecated_member_use

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/book_model.dart';
import 'book_states.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitialState());
  static BookCubit get(context) => BlocProvider.of(context);

  File? bookImage;
  var picker = ImagePicker();

  Future<void> getBookImage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      bookImage = File(PickedFile.path);
      emit(BookCoverImagePickedSuccessState());
    } else {
      emit(BookostImagePickedErrorState());
    }
  }

  void RemoveCoverImage() {
    bookImage = null;
    emit(BookRemoveCoverImageState());
  }

  void UploadCoverImage({
    required String authorName,
    required String name,
    required String category,
    required String price,
    String? aboutBook,
    String? aboutAuthor,
  }) {
    emit(AddBookLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('books/${Uri.file(bookImage!.path).pathSegments.last}')
        .putFile(bookImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(BookUploadCoverImagePickedSuccessState());
        addBook(
          coverImage: value,
          authorName: authorName,
          category: category,
          name: name,
          pdf: "pdf",
          voice: "voice",
          price:price,
          aboutAuthor:
              "the dummy text of the printing and typesetting industry.",
          aboutBook:
              "Lorem ipsum is a placeholder text commonly used in publishing and graphic design to demonstrate the visual form of a document or a typeface without relying on meaningful content1234. It is essentially nonsense text that still gives an idea of what real words will look like in the final product3. The phrase \"lorem ipsum\" derives from the Latin phrase \"dolorem ipsum,\" which translates to \"pain itself\"",
        );
      }).catchError((error) {
        emit(BookUploadCoverImagePickedErrorState());
      });
    }).catchError((error) {
      emit(BookUploadCoverImagePickedErrorState());
    });
  }

  void addBook({
    String? name,
    String? authorName,
    String? aboutBook,
    String? aboutAuthor,
    String? category,
    String? coverImage,
    String? voice,
    String? pdf,
    String? id,
    String ? price

  }) {
    emit(AddBookLoadingState());

    var ref = FirebaseFirestore.instance.collection('Books').doc();
    var id = ref.id;
    BookModel model = BookModel(
        authorName: authorName,
        category: category,
        coverImage: coverImage,
        name: name,
        pdf: pdf,
        voice: voice,
        price:price,
        aboutAuthor: aboutAuthor,
        aboutBook: aboutBook,
        id: id);
    ref.set(model.toMap()).then((value) {
      //  model.id = value;

      emit(AddBookSuccessState());
    }).catchError((error) {
      emit(AddBookErrorState(error.toString()));
    });
  }

  List<BookModel> books = [];

  void getBooks() {
    books = [];
    emit(GetBookLoadingState());
    FirebaseFirestore.instance.collection('Books').get().then((value) {
      value.docs.forEach((element) {
        books.add(BookModel.fromJson(element.data()));
      });

      emit(GetBookSuccessState(books));
    }).catchError((error) {
      emit(GetBookErrorState(error.toString()));
    });
  }

  void deleteBooks(
    String? id,
  ) {
    FirebaseFirestore.instance
        .collection('Books')
        .doc(id)
        .delete()
        .then((value) async {
            getBooks();
      emit(DeleteBookSuccessState());
    
    }).catchError((error) {
      emit(DeleteBookErrorState(error.toString()));
    });
  }

  File? BookCover;

  Future<void> getBookCover() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      BookCover = File(PickedFile.path);
      emit(BookCoverImagePickedSuccessState());
    } else {
      emit(BookostImagePickedErrorState());
    }
  }

  void uploadBookCover({
    String? name,
    String? authorName,
    String? aboutBook,
    String? aboutAuthor,
    String? category,
    String? coverImage,
    String? voice,
    String? pdf,
    required String id,
  }) {
    emit(UpdateBookLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('books/${Uri.file(BookCover!.path).pathSegments.last}')
        .putFile(BookCover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(BookUploadCoverImagePickedSuccessState());
        updateBook(
          id: id,
          aboutAuthor: aboutAuthor,
          aboutBook: aboutBook,
          authorName: authorName,
          category: category,
          coverImage: coverImage,
          name: name,
          pdf: pdf,
          voice: voice,
        );
      });
    }).catchError((error) {
      emit(BookUploadCoverImagePickedErrorState());
    });
  }

  void updateBook({
    String? name,
    String? authorName,
    String? aboutBook,
    String? aboutAuthor,
    String? category,
    String? coverImage,
    String? voice,
    String? pdf,
    required String id,
  }) {
    emit(UpdateBookLoadingState());
    BookModel model = BookModel(
      aboutAuthor: aboutAuthor,
      aboutBook: aboutBook,
      authorName: authorName,
      category: category,
      coverImage: coverImage,
      voice: voice,
      name: name,
      pdf: pdf,
      id: id,
    );
    emit(UpdateBookSuccessState());
    FirebaseFirestore.instance
        .collection('Books')
        .doc(id)
        .update(model.toMap())
        .then((value) {
      getBooks();
    }).catchError((error) {
      emit(UpdateBookErrorState(error.toString()));
    });
  }

  pickPdf() async {
    emit(BookUploadPdfPickedLoadingState());
    try {
      final result = await FilePicker.platform.pickFiles(
          // type: FileType.custom,
          // allowMultiple: false,
          // allowedExtensions: ['pdf'],
          );

      if (result != null) {
        // Now you have the path to the selected PDF file
      } else {
        // User canceled the file picker
      }
    } catch (e) {
      return e.toString();
    }
    // emit(BookUploadPdfPickedLoadingState());
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   File file = File(result.files.single.path!);
    //   print(file);
    //   emit(BookUploadPdfPickedSuccessState());
    // } else {
    //   // User canceled the picker
    // }
  }
}
