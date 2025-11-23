import 'package:hooks_riverpod/legacy.dart';
import 'package:service_provider_assessment/models/provider_model.dart';

class ProviderListState {
  final String searchQuery;
  final List<ServiceProvider> filteredProviders;

  ProviderListState({
    required this.searchQuery,
    required this.filteredProviders,
  });
}

class ProviderListScreenNotifier extends StateNotifier<ProviderListState> {
  ProviderListScreenNotifier()
    : super(ProviderListState(searchQuery: '', filteredProviders: providers));

  void search(String query) {
    if (query.isEmpty) {
      state = ProviderListState(
        searchQuery: query,
        filteredProviders: providers,
      );
    } else {
      final filtered = providers
          .where(
            (provider) =>
                provider.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      state = ProviderListState(
        searchQuery: query,
        filteredProviders: filtered,
      );
    }
  }
}

final providerListProvider =
    StateNotifierProvider<ProviderListScreenNotifier, ProviderListState>(
      (ref) => ProviderListScreenNotifier(),
    );
