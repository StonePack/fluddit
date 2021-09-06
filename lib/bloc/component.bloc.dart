import 'package:fluddit/components/index.dart';
import 'package:fluddit/models/index.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ComponentController extends GetxController {
  RxBool isDarkMode = true.obs;

  void openDrawer(scaffoldKey) {
    if (!scaffoldKey.currentState.isDrawerOpen) {
      scaffoldKey.currentState.openDrawer();
    }
  }

  void closeDrawer(scaffoldKey) {
    if (scaffoldKey.currentState.isDrawerOpen) {
      scaffoldKey.currentState.closeDrawer();
    }
  }

  void displaySnackbar(String message) {
    if (!(Get.isSnackbarOpen ?? false)) {
      Get.snackbar(
        'Alert',
        message,
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
      );
    }
  }

  Widget getPostThumbnail(RedditPost post) {
    if (post.isSelf) {
      return Center(
        child: Text('Tt'),
      );
    } else if (post.isVideo) {
      return VideoThumbnail(post: post);
    } else if (isImage(post.url) || post.domain == 'imgur.com') {
      return ImageThumbnail(post: post);
    } else if (post.isGallery) {
      return GalleryThumbnail(post: post);
    } else {
      return WebThumbnail(post: post);
    }
  }

  bool isImage(String? url) {
    final String parsedUrl = url ?? '';
    return parsedUrl.endsWith('jpg') ||
        parsedUrl.endsWith('png') ||
        parsedUrl.endsWith('gif');
  }

  Future<void> updateThemeMode(bool dark) async {
    final GetStorage box = GetStorage();

    if (dark) {
      await box.write('darkMode', true);
      Get.changeTheme(
        NordTheme.dark().copyWith(
          accentColor: Color(int.parse(box.read('accent_color'))),
        ),
      );
    } else {
      await box.write('darkMode', false);
      Get.changeTheme(
        NordTheme.light().copyWith(
          accentColor: Color(int.parse(box.read('accent_color'))),
        ),
      );
    }

    Get.appUpdate();
  }

  Future<void> updateAccentColor(int color) async {
    final GetStorage box = GetStorage();
    await box.write('accent_color', '$color');

    if (box.read('darkMode')) {
      Get.changeTheme(
        NordTheme.dark().copyWith(accentColor: Color(color)),
      );
    } else {
      Get.changeTheme(
        NordTheme.light().copyWith(accentColor: Color(color)),
      );
    }

    Get.appUpdate();
  }
}
