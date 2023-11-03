import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading {
  factory Loading() => _screen;
  static final Loading _screen = Loading.screenInstance();
  Loading.screenInstance();

  OverlayEntry? overlay;

  void show({
    required BuildContext context,
  }) {
    overlay ?? showOverlay(context: context);
  }

  void hide() {
    overlay?.remove();
    overlay = null;
  }

  void showOverlay({
    required BuildContext context,
  }) {
    overlay = OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.black.withAlpha(150),
          child: const Center(
            child: SpinKitCircle(
              size: 72.0,
              color: Colors.white,
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlay!);
  }
}
