import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/search_filter_provider.dart';

class SearchFiltersScreen extends ConsumerWidget {
  const SearchFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(searchFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PRICE RANGE
            const Text(
              'Price Range',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            RangeSlider(
              values: RangeValues(
                filter.minPrice,
                filter.maxPrice,
              ),
              min: 0,
              max: 10000,
              divisions: 100,
              labels: RangeLabels(
                '₹${filter.minPrice.toInt()}',
                '₹${filter.maxPrice.toInt()}',
              ),
              onChanged: (values) {
                ref
                    .read(searchFilterProvider.notifier)
                    .updatePrice(values.start, values.end);
              },
            ),

            const SizedBox(height: 20),

            // Sort
            const Text(
              'Sort By',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            DropdownButton<String>(
              value: filter.sortBy,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                    value: 'Relevance',
                    child: Text('Relevance')),
                DropdownMenuItem(
                    value: 'PriceLow',
                    child: Text('Price: Low to High')),
                DropdownMenuItem(
                    value: 'PriceHigh',
                    child: Text('Price: High to Low')),
                DropdownMenuItem(
                    value: 'Newest',
                    child: Text('Newest')),
              ],
              onChanged: (v) {
                if (v == null) return;
                ref
                    .read(searchFilterProvider.notifier)
                    .updateSort(v);
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

