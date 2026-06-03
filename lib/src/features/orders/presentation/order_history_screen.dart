
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/colors.dart';
import '../providers/order_history_provider.dart';
import '../widgets/empty_orders_view.dart';
import '../widgets/order_summery_card.dart';

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final ordersAsync = ref.watch(userOrdersProvider,);
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: ordersAsync.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),);
        },
        error: (e, _) {
          return Center(
            child: Text(e.toString(),),
          );
        },

        data: (orders) {
          if (orders.isEmpty) {
            return const Center(
              child: EmptyOrdersView()
              //Text('No Orders Yet',),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16,),
            itemCount: orders.length,
            separatorBuilder: (_, __) {
              return const SizedBox(height: 18,);
            },
            itemBuilder: (_, index) {
              final order = orders[index];
              return GestureDetector(
                onTap: () {
                  context.push('/order-details', extra: order,);
                },
                child: OrderSummaryCard(order: order,),
              );
            },
          );
        },
      ),
    );
  }
}