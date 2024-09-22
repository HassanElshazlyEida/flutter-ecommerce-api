import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/locale/locale_controller.dart';
import 'package:flutter_ecommerce/modules/screens/auth/user_repo.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:flutter_ecommerce/themes/theme_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleController localController = Get.put(LocaleController());
    final ThemeController themeController = Get.find<ThemeController>();

    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              _showLanguageMenu(context, localController);
            },
          ),
            IconButton(
            icon: Obx(() => Icon(themeController.isDarkMode.value ? Icons.light_mode : Icons.dark_mode )),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              UserRepository.logout();
              Get.toNamed(Routes.login);
              Get.snackbar('Success'.tr, 'Logout Successfully'.tr);
            },
          ),
        ],
        title:  Text('Home'.tr),
      ),
      body:  Center(
        child: Text('Home Screen'.tr),
      ),
    );
  }
}
 void _showLanguageMenu(BuildContext context, LocaleController localController) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('English'),
              onTap: () {
                localController.changeLanguage('en');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Arabic'),
              onTap: () {
                localController.changeLanguage('ar');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }