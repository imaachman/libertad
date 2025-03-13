// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'copy_details_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$copyDetailsViewModelHash() =>
    r'8fb3fade211f78dc313bba85547dc357d4f4edc7';

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

abstract class _$CopyDetailsViewModel
    extends BuildlessAutoDisposeNotifier<BookCopy> {
  late final BookCopy copy;

  BookCopy build(
    BookCopy copy,
  );
}

/// See also [CopyDetailsViewModel].
@ProviderFor(CopyDetailsViewModel)
const copyDetailsViewModelProvider = CopyDetailsViewModelFamily();

/// See also [CopyDetailsViewModel].
class CopyDetailsViewModelFamily extends Family<BookCopy> {
  /// See also [CopyDetailsViewModel].
  const CopyDetailsViewModelFamily();

  /// See also [CopyDetailsViewModel].
  CopyDetailsViewModelProvider call(
    BookCopy copy,
  ) {
    return CopyDetailsViewModelProvider(
      copy,
    );
  }

  @override
  CopyDetailsViewModelProvider getProviderOverride(
    covariant CopyDetailsViewModelProvider provider,
  ) {
    return call(
      provider.copy,
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
  String? get name => r'copyDetailsViewModelProvider';
}

/// See also [CopyDetailsViewModel].
class CopyDetailsViewModelProvider
    extends AutoDisposeNotifierProviderImpl<CopyDetailsViewModel, BookCopy> {
  /// See also [CopyDetailsViewModel].
  CopyDetailsViewModelProvider(
    BookCopy copy,
  ) : this._internal(
          () => CopyDetailsViewModel()..copy = copy,
          from: copyDetailsViewModelProvider,
          name: r'copyDetailsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$copyDetailsViewModelHash,
          dependencies: CopyDetailsViewModelFamily._dependencies,
          allTransitiveDependencies:
              CopyDetailsViewModelFamily._allTransitiveDependencies,
          copy: copy,
        );

  CopyDetailsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.copy,
  }) : super.internal();

  final BookCopy copy;

  @override
  BookCopy runNotifierBuild(
    covariant CopyDetailsViewModel notifier,
  ) {
    return notifier.build(
      copy,
    );
  }

  @override
  Override overrideWith(CopyDetailsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: CopyDetailsViewModelProvider._internal(
        () => create()..copy = copy,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        copy: copy,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CopyDetailsViewModel, BookCopy>
      createElement() {
    return _CopyDetailsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CopyDetailsViewModelProvider && other.copy == copy;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, copy.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CopyDetailsViewModelRef on AutoDisposeNotifierProviderRef<BookCopy> {
  /// The parameter `copy` of this provider.
  BookCopy get copy;
}

class _CopyDetailsViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<CopyDetailsViewModel, BookCopy>
    with CopyDetailsViewModelRef {
  _CopyDetailsViewModelProviderElement(super.provider);

  @override
  BookCopy get copy => (origin as CopyDetailsViewModelProvider).copy;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
