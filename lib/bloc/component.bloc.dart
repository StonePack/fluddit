import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluddit/components/index.dart';
import 'package:fluddit/constants.dart';
import 'package:fluddit/models/index.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ComponentController extends GetxController {
  CarouselController carouselController = CarouselController();
  RxBool autoMute = false.obs;
  RxInt carouselIndex = 0.obs;

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
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        'Alert',
        message,
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
      );
    }
  }

  Widget getPostThumbnail(Post post) {
    if (post.isSelf) {
      return const Center(
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

  void onCarouselPageUpdate(int page, CarouselPageChangedReason changedReason) {
    carouselIndex.value = page;
  }

  Future<void> updateThemeMode(bool darkMode) async {
    final GetStorage box = GetStorage();

    if (darkMode) {
      await box.write('darkMode', true);
      Get.changeTheme(darkTheme);
    } else {
      await box.write('darkMode', false);
      Get.changeTheme(lightTheme);
    }

    Get.appUpdate();
  }

  Future<void> updateAutoMute(bool autoMute) async {
    this.autoMute.value = autoMute;

    final GetStorage box = GetStorage();
    await box.write('autoMute', autoMute);
  }

  Future<void> updateAccentColor(int color) async {
    final GetStorage box = GetStorage();
    await box.write('accent_color', '$color');

    if (box.read('darkMode')) {
      Get.changeTheme(
        darkTheme.copyWith(primaryColor: Color(color)),
      );
    } else {
      Get.changeTheme(
        lightTheme.copyWith(primaryColor: Color(color)),
      );
    }

    Get.appUpdate();
  }
}
