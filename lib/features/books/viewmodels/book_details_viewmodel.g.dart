// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_details_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookDetailsViewModelHash() =>
    r'03b80dfe73419a06250575987132bc4c4a35333e';

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

abstract class _$BookDetailsViewModel
    extends BuildlessAutoDisposeNotifier<Book> {
  late final Book book;

  Book build(
    Book book,
  );
}

/// See also [BookDetailsViewModel].
@ProviderFor(BookDetailsViewModel)
const bookDetailsViewModelProvider = BookDetailsViewModelFamily();

/// See also [BookDetailsViewModel].
class BookDetailsViewModelFamily extends Family<Book> {
  /// See also [BookDetailsViewModel].
  const BookDetailsViewModelFamily();

  /// See also [BookDetailsViewModel].
  BookDetailsViewModelProvider call(
    Book book,
  ) {
    return BookDetailsViewModelProvider(
      book,
    );
  }

  @override
  BookDetailsViewModelProvider getProviderOverride(
    covariant BookDetailsViewModelProvider provider,
  ) {
    return call(
      provider.book,
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
  String? get name => r'bookDetailsViewModelProvider';
}

/// See also [BookDetailsViewModel].
class BookDetailsViewModelProvider
    extends AutoDisposeNotifierProviderImpl<BookDetailsViewModel, Book> {
  /// See also [BookDetailsViewModel].
  BookDetailsViewModelProvider(
    Book book,
  ) : this._internal(
          () => BookDetailsViewModel()..book = book,
          from: bookDetailsViewModelProvider,
          name: r'bookDetailsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookDetailsViewModelHash,
          dependencies: BookDetailsViewModelFamily._dependencies,
          allTransitiveDependencies:
              BookDetailsViewModelFamily._allTransitiveDependencies,
          book: book,
        );

  BookDetailsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.book,
  }) : super.internal();

  final Book book;

  @override
  Book runNotifierBuild(
    covariant BookDetailsViewModel notifier,
  ) {
    return notifier.build(
      book,
    );
  }

  @override
  Override overrideWith(BookDetailsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookDetailsViewModelProvider._internal(
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
  AutoDisposeNotifierProviderElement<BookDetailsViewModel, Book>
      createElement() {
    return _BookDetailsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookDetailsViewModelProvider && other.book == book;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, book.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BookDetailsViewModelRef on AutoDisposeNotifierProviderRef<Book> {
  /// The parameter `book` of this provider.
  Book get book;
}

class _BookDetailsViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<BookDetailsViewModel, Book>
    with BookDetailsViewModelRef {
  _BookDetailsViewModelProviderElement(super.provider);

  @override
  Book get book => (origin as BookDetailsViewModelProvider).book;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
