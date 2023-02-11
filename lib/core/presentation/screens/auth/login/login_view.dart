import 'package:afyadaktari_admin/core/data/utils/strings/common.dart';
import 'package:afyadaktari_admin/core/data/utils/strings/keys.dart';
import 'package:afyadaktari_admin/core/domain/repository/auth/request/login_request.dart';
import 'package:afyadaktari_admin/core/presentation/components/check_box.dart';
import 'package:afyadaktari_admin/core/presentation/components/text_field.dart';
import 'package:afyadaktari_admin/core/presentation/screens/auth/verify_phone/view.dart';
import 'package:afyadaktari_admin/core/presentation/screens/home/dash_board/dash_board_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  late final bool rememberMe = getBoolAsync(keyRememberMe);

  late final TextEditingController username = TextEditingController(
      text: rememberMe ? getStringAsync(keyUsername) : null);

  late final TextEditingController password = TextEditingController(
      text: rememberMe ? getStringAsync(keyPassword) : null);

  @override
  void dispose() {
    _btnController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<LoginProvider>();
    final providerWatch = context.watch<LoginProvider>();

    LoginRequest request = LoginRequest();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.stU(username.text);
      provider.stP(password.text);
    });

    request.password = password.text;

    request.rememberMe = providerWatch.rememberMe;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: Text(
        'Login page',
        style: boldTextStyle(),
      )),
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  const Divider(),
                  const Icon(
                    Icons.admin_panel_settings,
                    size: 100,
                  ),
                  32.height,
                  TextFieldWidget(
                    validator: (p0) => provider.usnErr,
                    hintText: usernameOrPhoneText,
                    controller: username,
                    onChanged: (p0) => provider.stU(p0),
                    prefixIcon: const Icon(Icons.account_circle),
                  ),
                  16.height,
                  TextFieldWidget(
                    validator: (p0) => provider.passErr,
                    textInputAction: TextInputAction.done,
                    hintText: passwordText,
                    controller: password,
                    onChanged: (p0) => provider.stP(p0),
                    obscureText: !providerWatch.passwordVisible,
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: Icon(providerWatch.passwordIcon),
                      onPressed: () => provider.togglePasswordVisibility(),
                    ),
                  ),
                  12.height,
                  Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(
                          'Forgot Password?',
                          style: primaryTextStyle(color: Colors.blue),
                        ),
                        onPressed: () =>
                            const VerifyPhoneView().launch(context),
                      )),
                  8.height,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CheckBoxWidget(
                          value: providerWatch.rememberMe,
                          onChanged: (_) => provider.setRememberMe(),
                        ),
                        8.width,
                        Text(
                          rememberMeText,
                          style: primaryTextStyle(),
                        )
                      ],
                    ),
                  ),
                  32.height,
                  RoundedLoadingButton(
                    controller: _btnController,
                    onPressed: () async {
                      await provider.login;
                      if (provider.success) {
                        if (mounted) {
                          const DashBoardPage()
                              .launch(context, isNewTask: true);
                        }
                      } else {
                        _btnController.stop();
                        loginFormKey.currentState!.validate();
                      }
                    },
                    child: const Text(loginText,
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            )
          ]).center().paddingAll(8),
        ),
      ),
    );
  }
}
