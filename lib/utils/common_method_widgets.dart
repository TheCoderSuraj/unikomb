import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import '../core/auth/functions/auth/auth.dart';
import 'constants.dart';

void showMyToast(
  String message, {
  bool isError = false,
}) {
  showToast(
    message,
    position: ToastPosition.bottom,
    textStyle: kDefaultTextStyle.copyWith(
      color: Colors.white,
    ),
    backgroundColor: isError ? Colors.red[500] : Colors.black,
    textAlign: TextAlign.center,
    textMaxLines: 3,
    textOverflow: TextOverflow.ellipsis,
  );
}

Widget buildBackButton(BuildContext context) {
  if (!Navigator.canPop(context)) {
    return const SizedBox();
  }
  return const Align(
    alignment: Alignment.topLeft,
    child: BackButton(
        // color: Colors.white,
        ),
  );
}

IconButton getSignOutButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      Auth.signOutUser();
      // onComplete: () =>
      //  Navigator.pushNamedAndRemoveUntil(
      //     context, LoginScreen.id, (route) => false));
      // context.read<AccountProvider>().clearAccount();
    },
    icon: const Icon(
      Icons.logout_rounded,
      color: Colors.grey,
    ),
  );
}
