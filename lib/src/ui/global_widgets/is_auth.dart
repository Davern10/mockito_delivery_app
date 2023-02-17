import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../data/repositories/account_repository.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../helpers/get.dart';
import '../../routes/routes.dart';

class IsAuth extends StatefulWidget {
  final Widget page;

  IsAuth({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  State<IsAuth> createState() => _IsAuthState();
}

class _IsAuthState extends State<IsAuth> {
  late bool _initialized;

  final _authenticationRepository = Get.i.find<AuthenticationRepository>();
  final _accountRepository = Get.i.find<AccountRepository>();

  @override
  void initState() {
    super.initState();

    final afterSplash = Get.i.find<bool>(tag: 'after-splash');
    _initialized = !kIsWeb || afterSplash;

    if (!_initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.pushReplacementNamed(context, Routes.splash);
        // final token = _authenticationRepository.token;
        // if (token != null) {
        //   final user = await _accountRepository.userInformation;
        //   if (user != null) {
        //     Get.i.put<User>(user);
        //     setState(() {
        //       _initialized = true;
        //     });
        //     Get.i.put<bool>(true, tag: 'after-splash');
        //     return;
        //   }
        // }
        // Navigator.pushReplacementNamed(context, Routes.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) return widget.page;
    return Container(width: 1, height: 1, color: Colors.transparent);
  }
}
