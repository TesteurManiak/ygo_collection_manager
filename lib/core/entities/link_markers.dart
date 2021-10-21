enum LinkMarkers {
  top,
  bottom,
  left,
  right,
  bottomLeft,
  bottomRight,
  topLeft,
  topRight,
}

extension LinkMarkersModifier on LinkMarkers {
  String get string {
    switch (this) {
      case LinkMarkers.top:
        return 'Top';
      case LinkMarkers.bottom:
        return 'Bottom';
      case LinkMarkers.left:
        return 'Left';
      case LinkMarkers.right:
        return 'Right';
      case LinkMarkers.bottomLeft:
        return 'Bottom-Left';
      case LinkMarkers.bottomRight:
        return 'Bottom-Right';
      case LinkMarkers.topLeft:
        return 'Top-Left';
      case LinkMarkers.topRight:
        return 'Top-Right';
    }
  }
}

extension LinkMarkersIterableModifier on Iterable<LinkMarkers> {
  Iterable<String> toStringIterable() => map((e) => e.string);
}
