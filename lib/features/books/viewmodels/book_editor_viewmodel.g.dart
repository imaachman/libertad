// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_editor_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookEditorViewModelHash() =>
    r'6c5d50f01f7a14e70aa7ed5ea91ab28c28b2a8b5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BookEditorViewModel
    extends BuildlessAutoDisposeNotifier<Book?> {
  late final Book? book;

  Book? build({
    Book? book,
  });
}

/// See also [BookEditorViewModel].
@ProviderFor(BookEditorViewModel)
const bookEditorViewModelProvider = BookEditorViewModelFamily();

/// See also [BookEditorViewModel].
class BookEditorViewModelFamily extends Family<Book?> {
  /// See also [BookEditorViewModel].
  const BookEditorViewModelFamily();

  /// See also [BookEditorViewModel].
  BookEditorViewModelProvider call({
    Book? book,
  }) {
    return BookEditorViewModelProvider(
      book: book,
    );
  }

  @override
  BookEditorViewModelProvider getProviderOverride(
    covariant BookEditorViewModelProvider provider,
  ) {
    return call(
      book: provider.book,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bookEditorViewModelProvider';
}

/// See also [BookEditorViewModel].
class BookEditorViewModelProvider
    extends AutoDisposeNotifierProviderImpl<BookEditorViewModel, Book?> {
  /// See also [BookEditorViewModel].
  BookEditorViewModelProvider({
    Book? book,
  }) : this._internal(
          () => BookEditorViewModel()..book = book,
          from: bookEditorViewModelProvider,
          name: r'bookEditorViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookEditorViewModelHash,
          dependencies: BookEditorViewModelFamily._dependencies,
          allTransitiveDependencies:
              BookEditorViewModelFamily._allTransitiveDependencies,
          book: book,
        );

  BookEditorViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.book,
  }) : super.internal();

  final Book? book;

  @override
  Book? runNotifierBuild(
    covariant BookEditorViewModel notifier,
  ) {
    return notifier.build(
      book: book,
    );
  }

  @override
  Override overrideWith(BookEditorViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookEditorViewModelProvider._internal(
        () => create()..book = book,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        book: book,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<BookEditorViewModel, Book?>
      createElement() {
    return _BookEditorViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookEditorViewModelProvider && other.book == book;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, book.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BookEditorViewModelRef on AutoDisposeNotifierProviderRef<Book?> {
  /// The parameter `book` of this provider.
  Book? get book;
}

class _BookEditorViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<BookEditorViewModel, Book?>
    with BookEditorViewModelRef {
  _BookEditorViewModelProviderElement(super.provider);

  @override
  Book? get book => (origin as BookEditorViewModelProvider).book;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
