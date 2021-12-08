//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
//PAGES

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  Widget _oldWidget() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 338,
      child: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Icon(Icons.ac_unit),
                    color: Colors.red,
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 10 / 7,
                  child: Container(
                    child: Icon(Icons.ac_unit),
                    color: Colors.yellow,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 0.5,
                  child: Container(
                    child: Icon(Icons.ac_unit),
                    color: Colors.green,
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 0.5,
                  child: Container(
                    child: Icon(Icons.ac_unit),
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width - 32;
    return Container(
      width: size,
      height: size,
      child: Row(
        children: [
          Container(
            width: size * 0.592,
            child: Column(
              children: [
                Container(
                  height: size * 0.414,
                  child: CachedImageWidget(
                    'assets/images/splash_background.png',
                    ImageShape.rectangle,
                    radius: 0.0,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: CachedImageWidget(
                    'assets/images/splash_background.png',
                    ImageShape.square,
                    radius: 0.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: size * 0.592,
                  child: CachedImageWidget(
                    'assets/images/splash_background.png',
                    ImageShape.square,
                    radius: 0.0,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    child: CachedImageWidget(
                      'assets/images/splash_background.png',
                      ImageShape.square,
                      radius: 0.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
