import 'package:flutter/material.dart';
import 'package:test_transaction/common/extensions/build_context.dart';

mixin UxNotifications<T extends StatefulWidget> on State<T> {
  OverlayEntry? entry;

  void unblockUi() {
    if (entry == null) return;
    entry!.remove();
    entry = null;
  }

  void blockUI() {
    setState(
      () {
        entry = OverlayEntry(
          builder: (context) => Container(
            width: context.width,
            height: context.height,
            color: Colors.black.withOpacity(0.8),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(entry!);
  }
}
