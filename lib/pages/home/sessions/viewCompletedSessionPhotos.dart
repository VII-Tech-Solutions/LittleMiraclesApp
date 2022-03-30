//PACKAGES

// Dart imports:
import 'dart:io';
import 'dart:typed_data';

// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/models/media.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/photoeditor/photoeditor.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/dialogHelper.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showLoadingDialog.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showOkDialog.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/general/cachedImageWidget.dart';

//EXTENSIONS

class ViewCompletedSessionPhotos extends StatefulWidget {
  final Media image;
  const ViewCompletedSessionPhotos(this.image, {Key? key}) : super(key: key);

  @override
  State<ViewCompletedSessionPhotos> createState() =>
      _ViewCompletedSessionPhotosState();
}

class _ViewCompletedSessionPhotosState
    extends State<ViewCompletedSessionPhotos> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyE8E9EB,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: MaterialButton(
                elevation: 0,
                onPressed: () {
                  Navigator.maybePop(context);
                },
                color: AppColors.greyF2F3F3,
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.black45515D,
                  size: 24,
                ),
                padding: EdgeInsets.all(8.0),
                shape: CircleBorder(),
              ),
            ),
            Screenshot(
              controller: screenshotController,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.44248768,
                child: CachedNetworkImage(
                  imageUrl: widget.image.url ?? '',
                  placeholder: (context, url) => Image.asset(
                    'assets/images/placeholder_s_blue.png',
                    fit: BoxFit.contain,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/placeholder_s_blue.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.09359,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.blackD0D3D6,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      var status = await Permission.photos.status;
                      print(status);
                      if (status.isLimited)
                        status = await Permission.photos.request();

                      if (status.isGranted) {
                        ShowLoadingDialog(context);
                        GallerySaver.saveImage(widget.image.url!)
                            .then((success) {
                          ShowLoadingDialog(context, dismiss: true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              elevation: 2,
                              duration: Duration(seconds: 2),
                              content: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  success == false
                                      ? 'Something went wrong'
                                      : 'Image Saved',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              backgroundColor: AppColors.black2D3B48,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        });
                      } else if (status.isDenied ||
                          status.isRestricted ||
                          status.isPermanentlyDenied) {
                        DialogHelper.confirmActionWithCancel(context,
                                confirmText: 'Ok',
                                cancelText: 'Cancel',
                                title: 'Please Allow Access to Photos')
                            .then((value) {
                          if (value == true) openAppSettings();
                        });
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.download,
                          color: AppColors.black45515D,
                        ),
                        Text(
                          'Download',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      ShowLoadingDialog(context);
                      await screenshotController
                          .capture(delay: const Duration(milliseconds: 10))
                          .then((image) async {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.path}/image.png').create();
                        await imagePath.writeAsBytes(image!);
                        ShowLoadingDialog(context, dismiss: true);

                        /// Share Plugin
                        await Share.shareFiles([imagePath.path]);
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.share,
                          color: AppColors.black45515D,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      ShowLoadingDialog(context);
                      Future<File> _fileFromImageUrl() async {
                        final response =
                            await http.get(Uri.parse(widget.image.url!));

                        final documentDirectory =
                            await getApplicationDocumentsDirectory();

                        final file =
                            File(join(documentDirectory.path, 'image.png'));

                        file.writeAsBytesSync(response.bodyBytes);

                        return file;
                      }

                      PhotoEditScreen(file: await _fileFromImageUrl())
                          .launch(context, isNewTask: false)
                          .then((value) =>
                              ShowLoadingDialog(context, dismiss: true));
                      print('Effects');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_fix_high,
                          color: AppColors.black45515D,
                        ),
                        Text(
                          'Effects',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
