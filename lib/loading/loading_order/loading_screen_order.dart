import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOrderScreen {
  factory LoadingOrderScreen() => _screen;
  static final LoadingOrderScreen _screen = LoadingOrderScreen.screenInstance();
  LoadingOrderScreen.screenInstance();

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
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: size.width * 0.8,
                  maxHeight: size.height * 0.8,
                  minWidth: size.width * 0.5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitCubeGrid(
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay!);
  }
}
