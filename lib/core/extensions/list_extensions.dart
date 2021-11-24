extension ListModifier<T> on List<T> {
  /// Go through the list one item at a time, calling a function for each
  /// element, and allowing the callback to return either null or an element for
  /// only gathering the non-null elements and collecting them into a list and
  /// returning the result.
  ///
  /// source: https://github.com/vandadnp/flutter-tips-and-tricks#flatmap-and-compactmap-in-dart
  List<E> compactMap<E>(E? Function(T element) f) {
    Iterable<E> imp(E? Function(T element) f) sync* {
      for (final value in this) {
        final mapped = f(value);
        if (mapped != null) {
          yield mapped;
        }
      }
    }

    return imp(f).toList();
  }
}
