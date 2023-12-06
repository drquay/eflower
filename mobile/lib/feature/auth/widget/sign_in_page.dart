import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/auth/model/auth_state.dart';
import 'package:flutter_boilerplate/feature/auth/provider/auth_provider.dart';
import 'package:flutter_boilerplate/l10n/l10n.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';

class SignInPage extends ConsumerWidget {
   SignInPage({Key? key}) : super(key: key);

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authProvider,
      (_, AuthState state) => state.mapOrNull(
        error: (value) {
          UiUtil.showAppException(value.error);
        },
      ),
    );

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 150),
            Text(
              context.l10n.sign_in,
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: context.l10n.username_hint,
                        icon: const Icon(Icons.account_circle_outlined)),
                    controller: _userNameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: context.l10n.password_hint,
                      icon: const Icon(Icons.password_rounded),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      _widgetSignInButton(context, ref),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _widgetSignInButton(BuildContext context, WidgetRef ref) {
    return GFButton(
      color: Colors.green,
      onPressed: () {
        ref
            .read(authProvider.notifier)
            .login(_userNameController.text, _passwordController.text);
      },
      size: GFSize.LARGE,
      shape: GFButtonShape.pills,
      child: Text(
        context.l10n.sign_in,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
