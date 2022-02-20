//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/models/session.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/general/cachedImageWidget.dart';
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class ImagePickerContainer extends StatefulWidget {
  final String? _url;
  const ImagePickerContainer(this._url, {Key? key}) : super(key: key);

  @override
  State<ImagePickerContainer> createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
      },
      child: AspectRatio(
        aspectRatio: 123 / 123,
        child: Stack(
          children: [
            CachedImageWidget(
              widget._url,
              ImageShape.square,
              borderRadius: BorderRadius.zero,
            ),
            Visibility(
              visible: _selected,
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding: EdgeInsets.zero,
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: _selected == true
                      ? AppColors.blue8DC4CB
                      : Color(0x80ffffff),
                ),
                child: Visibility(
                  visible: _selected == true,
                  child: Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
