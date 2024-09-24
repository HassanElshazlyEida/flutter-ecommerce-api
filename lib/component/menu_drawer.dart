import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/locale/locale_controller.dart';
import 'package:flutter_ecommerce/modules/screens/auth/user_repo.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:flutter_ecommerce/themes/theme_controller.dart';
import 'package:get/get.dart';

class MenuDrawer extends StatelessWidget {


  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocaleController localController = Get.find<LocaleController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Image.asset('images/logo.png',height: 100,width: 100)),
             ListTile(
              leading: const Icon(Icons.home),
              title:  Text('Home'.tr),
              onTap: () {
                Get.toNamed(Routes.home);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title:  Text('Profile'.tr),
              onTap: () {
                Get.toNamed(Routes.profile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title:  Text('Language'.tr),
              onTap: () {
                _showLanguageMenu(context, localController);
              },
            ),
            ListTile(
              leading:Obx(() => Icon(themeController.isDarkMode.value ? Icons.light_mode : Icons.dark_mode )),
              title:  Text('Theme'.tr),
              onTap: () {
                 themeController.toggleTheme();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title:  Text('Logout'.tr),
              onTap: () {
                UserRepository.logout();
                Get.toNamed(Routes.login);
                Get.snackbar('Success'.tr, 'Logout Successfully'.tr);
              },
            ),
          
          ],
        ),
    );
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
              title:  Text('English'.tr),
              onTap: () {
                localController.changeLanguage('en');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title:  Text('Arabic'.tr),
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
}