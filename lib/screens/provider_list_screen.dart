import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:service_provider_assessment/screens/providers/provider_list_screen_provider.dart';
import 'package:service_provider_assessment/widgets/provider_card.dart';
import 'package:shimmer/shimmer.dart';

class ProviderListScreen extends ConsumerWidget {
  const ProviderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerListState = ref.watch(providerListProvider);
    final providerListNotifier = ref.read(providerListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Expert'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              onChanged: (query) => providerListNotifier.search(query),

              decoration: InputDecoration(
                hintText: 'Search for services or providers',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),

      body: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 1),
        ), // Simulate network delay
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerLoading(context);
          } else {
            if (providerListState.filteredProviders.isEmpty) {
              return Center(child: Text('Empty'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: providerListState.filteredProviders.length,
              itemBuilder: (context, index) {
                return ProviderCard(
                  provider: providerListState.filteredProviders[index],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 20.0,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 100,
                              height: 16.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
