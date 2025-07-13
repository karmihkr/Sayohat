import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/place_model.dart';

OverlayEntry searchWindowFactory(
    BuildContext context,
    List<Place> places,
    void Function(String title, String subtitle, String? uri) onTap,
    ) {
  RenderBox renderBox = context.findRenderObject()! as RenderBox;
  var size = renderBox.size;
  var offset = renderBox.localToGlobal(Offset.zero);
  return OverlayEntry(
    builder: (context) => Positioned(
      left: offset.dx,
      top: offset.dy + size.height + 5.0,
      width: size.width,
      child: Material(
        elevation: 4.0,
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            for (Place place in places)
              ListTile(
                title: Text(place.title),
                subtitle: Text(place.subtitle),
                onTap: () {
                  onTap(place.title, place.subtitle, place.uri);
                },
              ),
          ],
        ),
      ),
    ),
  );
}

void searchWindowSafeRemove(OverlayEntry? searchWindow) {
  try {
    searchWindow!.remove();
  } catch (_) {}
}
