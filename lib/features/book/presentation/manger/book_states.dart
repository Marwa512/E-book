import 'package:ebook/features/book/data/book_model.dart';

abstract class BookState {}

class BookInitialState extends BookState {}

class BookCoverImagePickedSuccessState extends BookState {}

class BookostImagePickedErrorState extends BookState {}

class BookUploadCoverImagePickedSuccessState extends BookState {}

class BookUploadCoverImagePickedErrorState extends BookState {}

class BookRemoveCoverImageState extends BookState {}

class AddBookLoadingState extends BookState {}
class AddBookSuccessState extends BookState {}
class AddBookErrorState extends BookState {

  String? error; 
  AddBookErrorState(this.error);
}
class GetBookLoadingState extends BookState {}
class GetBookSuccessState extends BookState {
List<BookModel> ? books;
GetBookSuccessState(this.books);
}
class GetBookErrorState extends BookState {

  String? error; 
  GetBookErrorState(this.error);
}
class DeleteBookLoadingState extends BookState {}
class DeleteBookSuccessState extends BookState {

}
class DeleteBookErrorState extends BookState {

  String? error; 
  DeleteBookErrorState(this.error);
}
class UpdateBookLoadingState extends BookState {}
class UpdateBookSuccessState extends BookState {

}
class UpdateBookErrorState extends BookState {

  String? error; 
  UpdateBookErrorState(this.error);
}

class BookUploadPdfPickedLoadingState extends BookState {}

class BookUploadPdfPickedSuccessState extends BookState {}

class BookUploadPdfPickedErrorState extends BookState {

String? error;
BookUploadPdfPickedErrorState(this.error);

}
