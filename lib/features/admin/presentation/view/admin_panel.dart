import 'package:ebook/features/authentication/presentation/manger/auth_cubit.dart';
import 'package:ebook/features/authentication/presentation/manger/auth_state.dart';
import 'package:ebook/features/book/presentation/manger/book_states.dart';
import 'package:ebook/features/book/presentation/view/add_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready/ready.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../../book/presentation/manger/book_cubit.dart';
import '../../data/Widgets/book_list.dart';
import '../../data/Widgets/user_list.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  void initState() {
    EbookAuthCubit.get(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<BookCubit, BookState>(
          listener: (context, state) {},
          builder: (context, state) {
            return BlocBuilder<BookCubit, BookState>(builder: (context, state) {
              return ReadyDashboard(
                onPageChanged: (value) {
                  BookCubit.get(context).getBooks();
                },
                items: [
                  DashboardItem(
                      label: "Browse Books",
                      id: "1",
                      builder: (parameters) {
                        return ConditionalBuilder(
                          condition: state is! GetBookLoadingState,
                          builder: (context) {
                            return ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => BookList(
                                    model: BookCubit.get(context).books[index]),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 10,
                                    ),
                                itemCount: BookCubit.get(context).books.length);
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      },
                      icon: const Icon(Icons.book)),
                  DashboardItem(
                      label: "Add Book",
                      id: "2",
                      builder: (parameters) {
                        return const AddBookScreen();
                      },
                      icon: const Icon(Icons.library_add_rounded)),
                  DashboardItem(
                      label: "Users",
                      id: "3",
                      builder: (parameters) {
                        return ConditionalBuilder(
                          condition: state is! GetUserSuccessState,
                          builder: (context) {
                            return ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => userList(
                                    context,
                                    EbookAuthCubit.get(context).users[index]),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 10,
                                    ),
                                itemCount:
                                    EbookAuthCubit.get(context).users.length);
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      },
                      icon: const Icon(Icons.people)),
                ],
              );
            });
          }),
    );
  }
}
