// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrower_editor_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$borrowerEditorViewModelHash() =>
    r'9af9724954fbd3d0d9ae1bfa292e1a1bf9b428df';

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

abstract class _$BorrowerEditorViewModel
    extends BuildlessAutoDisposeNotifier<Borrower?> {
  late final Borrower? borrower;

  Borrower? build({
    Borrower? borrower,
  });
}

/// Business logic layer for borrower editor.
///
/// Copied from [BorrowerEditorViewModel].
@ProviderFor(BorrowerEditorViewModel)
const borrowerEditorViewModelProvider = BorrowerEditorViewModelFamily();

/// Business logic layer for borrower editor.
///
/// Copied from [BorrowerEditorViewModel].
class BorrowerEditorViewModelFamily extends Family<Borrower?> {
  /// Business logic layer for borrower editor.
  ///
  /// Copied from [BorrowerEditorViewModel].
  const BorrowerEditorViewModelFamily();

  /// Business logic layer for borrower editor.
  ///
  /// Copied from [BorrowerEditorViewModel].
  BorrowerEditorViewModelProvider call({
    Borrower? borrower,
  }) {
    return BorrowerEditorViewModelProvider(
      borrower: borrower,
    );
  }

  @override
  BorrowerEditorViewModelProvider getProviderOverride(
    covariant BorrowerEditorViewModelProvider provider,
  ) {
    return call(
      borrower: provider.borrower,
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
  String? get name => r'borrowerEditorViewModelProvider';
}

/// Business logic layer for borrower editor.
///
/// Copied from [BorrowerEditorViewModel].
class BorrowerEditorViewModelProvider extends AutoDisposeNotifierProviderImpl<
    BorrowerEditorViewModel, Borrower?> {
  /// Business logic layer for borrower editor.
  ///
  /// Copied from [BorrowerEditorViewModel].
  BorrowerEditorViewModelProvider({
    Borrower? borrower,
  }) : this._internal(
          () => BorrowerEditorViewModel()..borrower = borrower,
          from: borrowerEditorViewModelProvider,
          name: r'borrowerEditorViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$borrowerEditorViewModelHash,
          dependencies: BorrowerEditorViewModelFamily._dependencies,
          allTransitiveDependencies:
              BorrowerEditorViewModelFamily._allTransitiveDependencies,
          borrower: borrower,
        );

  BorrowerEditorViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.borrower,
  }) : super.internal();

  final Borrower? borrower;

  @override
  Borrower? runNotifierBuild(
    covariant BorrowerEditorViewModel notifier,
  ) {
    return notifier.build(
      borrower: borrower,
    );
  }

  @override
  Override overrideWith(BorrowerEditorViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: BorrowerEditorViewModelProvider._internal(
        () => create()..borrower = borrower,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        borrower: borrower,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<BorrowerEditorViewModel, Borrower?>
      createElement() {
    return _BorrowerEditorViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BorrowerEditorViewModelProvider &&
        other.borrower == borrower;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, borrower.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BorrowerEditorViewModelRef on AutoDisposeNotifierProviderRef<Borrower?> {
  /// The parameter `borrower` of this provider.
  Borrower? get borrower;
}

class _BorrowerEditorViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<BorrowerEditorViewModel,
        Borrower?> with BorrowerEditorViewModelRef {
  _BorrowerEditorViewModelProviderElement(super.provider);

  @override
  Borrower? get borrower =>
      (origin as BorrowerEditorViewModelProvider).borrower;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
