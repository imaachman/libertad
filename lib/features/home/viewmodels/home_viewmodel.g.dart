// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeViewModelHash() => r'cb6bac780b5716cbf69397f76e4e952faf376c36';

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

abstract class _$HomeViewModel extends BuildlessAutoDisposeNotifier<void> {
  late final TabController tabController;

  void build(
    TabController tabController,
  );
}

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
const homeViewModelProvider = HomeViewModelFamily();

/// See also [HomeViewModel].
class HomeViewModelFamily extends Family<void> {
  /// See also [HomeViewModel].
  const HomeViewModelFamily();

  /// See also [HomeViewModel].
  HomeViewModelProvider call(
    TabController tabController,
  ) {
    return HomeViewModelProvider(
      tabController,
    );
  }

  @override
  HomeViewModelProvider getProviderOverride(
    covariant HomeViewModelProvider provider,
  ) {
    return call(
      provider.tabController,
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
  String? get name => r'homeViewModelProvider';
}

/// See also [HomeViewModel].
class HomeViewModelProvider
    extends AutoDisposeNotifierProviderImpl<HomeViewModel, void> {
  /// See also [HomeViewModel].
  HomeViewModelProvider(
    TabController tabController,
  ) : this._internal(
          () => HomeViewModel()..tabController = tabController,
          from: homeViewModelProvider,
          name: r'homeViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$homeViewModelHash,
          dependencies: HomeViewModelFamily._dependencies,
          allTransitiveDependencies:
              HomeViewModelFamily._allTransitiveDependencies,
          tabController: tabController,
        );

  HomeViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tabController,
  }) : super.internal();

  final TabController tabController;

  @override
  void runNotifierBuild(
    covariant HomeViewModel notifier,
  ) {
    return notifier.build(
      tabController,
    );
  }

  @override
  Override overrideWith(HomeViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: HomeViewModelProvider._internal(
        () => create()..tabController = tabController,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tabController: tabController,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<HomeViewModel, void> createElement() {
    return _HomeViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeViewModelProvider &&
        other.tabController == tabController;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tabController.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HomeViewModelRef on AutoDisposeNotifierProviderRef<void> {
  /// The parameter `tabController` of this provider.
  TabController get tabController;
}

class _HomeViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<HomeViewModel, void>
    with HomeViewModelRef {
  _HomeViewModelProviderElement(super.provider);

  @override
  TabController get tabController =>
      (origin as HomeViewModelProvider).tabController;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
