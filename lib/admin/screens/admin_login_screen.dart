import 'dart:ui';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/admin_login_controller.dart';
import 'package:synctrackr/admin/screens/main_screen.dart';
import 'package:synctrackr/core/constants/app_barrels.dart';
import 'package:synctrackr/core/widgets/custom_btn.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminLoginController controller = Get.put(AdminLoginController());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundWave,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 0 : 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: isMobile ? double.infinity : 646,
                        padding: EdgeInsets.all(isMobile ? 24 : 40),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.black.withOpacity(0.4)
                              : Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isDark
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                            width: 3,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                isDark ? AppAssets.logoDark : AppAssets.logo,
                                width: isMobile ? 180 : 300,
                                height: isMobile ? 90 : 152,
                              ),
                            ),
                            const SizedBox(height: 24),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Login To ",
                                    style:
                                        theme.textTheme.headlineSmall?.copyWith(
                                      fontSize: isMobile ? 24 : 40,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Synctrackr",
                                    style:
                                        theme.textTheme.headlineSmall?.copyWith(
                                      fontSize: isMobile ? 24 : 40,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Email Field
                            Obx(() {
                              return TextField(
                                controller: controller.emailController,
                                style: TextStyle(
                                    color:
                                        isDark ? Colors.white : Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Email Id",
                                  errorText: controller.emailError.value.isEmpty
                                      ? null
                                      : controller.emailError.value,
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: isDark
                                        ? AppColors.primaryBlue
                                        : Colors.black54,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: isDark
                                          ? AppColors.primaryBlue
                                          : Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: isDark
                                          ? AppColors.primaryBlue
                                          : Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryBlue),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 12),
                            Obx(() {
                              return TextField(
                                controller: controller.passwordController,
                                obscureText:
                                    !controller.isPasswordVisible.value,
                                style: TextStyle(
                                    color:
                                        isDark ? Colors.white : Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  errorText:
                                      controller.passwordError.value.isEmpty
                                          ? null
                                          : controller.passwordError.value,
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: isDark
                                        ? AppColors.primaryBlue
                                        : Colors.black54,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      controller.togglePasswordVisibility();
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: isDark
                                          ? AppColors.primaryBlue
                                          : Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: isDark
                                          ? AppColors.primaryBlue
                                          : Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryBlue),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 12),

                            // Terms Checkbox
                            Row(
                              children: [
                                // Checkbox(
                                //   value: true,
                                //   onChanged: (value) {},
                                //   side: BorderSide(
                                //     color: isDark
                                //         ? const Color(0xFFBCD3FF)
                                //         : Colors.black45,
                                //   ),
                                //   activeColor: AppColors.primaryBlue,
                                // ),
                                Obx(() {
                                  return Checkbox(
                                    value: controller.isTermsAccepted.value,
                                    onChanged: (value) {
                                      controller.isTermsAccepted.value =
                                          value ?? false;
                                    },
                                    side: BorderSide(
                                      color: isDark
                                          ? const Color(0xFFBCD3FF)
                                          : Colors.black45,
                                    ),
                                    activeColor: AppColors.primaryBlue,
                                  );
                                }),

                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      text: "I agree to the ",
                                      style: TextStyle(
                                          color: isDark
                                              ? AppColors.primaryBlue
                                              : AppColors.darkAdmin),
                                      children: [
                                        TextSpan(
                                          text: "Terms & conditions",
                                          style: TextStyle(
                                            color: isDark
                                                ? AppColors.darkPrimaryBlue
                                                : AppColors.primaryBlue,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: isDark
                                                ? AppColors.darkPrimaryBlue
                                                : AppColors.primaryBlue,
                                            decorationThickness: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Button
                            Obx(() {
                              return controller.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : CustomButton(
                                      text: "Sign In",
                                      onPressed: controller
                                              .isTermsAccepted.value
                                          ? () => controller.login()
                                          : null, // <-- disabled when checkbox unchecked
                                      backgroundColor: isDark
                                          ? AppColors.darkPrimaryBlue
                                          : AppColors.primaryBlue,
                                      foregroundColor: isDark
                                          ? AppColors.darkBackground
                                          : AppColors.background,
                                      fontSize: isMobile ? 14 : 15,
                                    );

                              //
                              //
                              // CustomButton(
                              //     text: "Sign In",
                              //     onPressed: () {
                              //       controller.login();
                              //     },
                              //     backgroundColor: isDark
                              //         ? AppColors.darkPrimaryBlue
                              //         : AppColors.primaryBlue,
                              //     foregroundColor: isDark
                              //         ? AppColors.darkBackground
                              //         : AppColors.background,
                              //     fontSize: isMobile ? 14 : 15,
                              //   );
                            }),
                            const SizedBox(height: 10),

                            Obx(() {
                              if (controller.generalError.value.isNotEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    controller.generalError.value,
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                    color: Color(0xff4682B4),
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xff4682B4)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
