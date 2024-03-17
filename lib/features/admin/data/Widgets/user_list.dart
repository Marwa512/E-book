
import 'package:flutter/material.dart';

import '../../../../core/widgets/text_style.dart';
import '../../../authentication/data/user_model.dart';
import '../../../authentication/presentation/manger/auth_cubit.dart';

Widget userList(context, UserModel user) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.image ?? ""),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  title: user.name ?? "User name",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                SizedBox(
                    width: 150,
                    child: TextWidget(title: user.email ?? "Email")),
              ],
            ),
            const Spacer(),
            if (user.isVerified != true)
              TextButton(
                  onPressed: () {
                    user.isVerified = true;
                    EbookAuthCubit.get(context).userVerficationAcceptance(
                        uid: user.uid ?? "", model: user);
                  },
                  child: const TextWidget(
                    title: "Verify User",
                    fontSize: 15,
                  )),
          ],
        ),
      ),
    ),
  );
}
