import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mbinu/ui/screens/auth/otp_screen.dart';
import 'package:mbinu/ui/state_holders/auth/email_verification_controller.dart';
import 'package:mbinu/ui/utils/images_utils.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Center(
                  child: SvgPicture.asset(
                    ImagesUtils.mbinuStoreLogoSVG,
                    width: 100,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Welcome Back",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 4),
                Text(
                  "Identify yoursel together with your password to login",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "username, phone or email is required";
                          } else {
                            return null;
                          }
                        },
                        controller: _emailTEController,
                        decoration: const InputDecoration(
                          labelText: "Username, phone or email",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          } else {
                            return null;
                          }
                        },
                        controller: _passwordTEController,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<EmailVerificationController>(
                    builder: (emailController) {
                      if (emailController.emailVerificationInProgress) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            verifyEmail(emailController);
                          }
                        },
                        child: const Text("NEXT"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyEmail(EmailVerificationController controller) async {
    final response = await controller.verifyEmail(
      _emailTEController.text.trim(),
      _passwordTEController.text.trim(),
    );
    if (response) {
      Get.to(() => OtpVerificationScreen(email: _emailTEController.text));
    } else {
      Get.snackbar("error", "Email verification has failed! please try again");
    }
  }
}
