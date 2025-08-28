import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../bloc/order/order_bloc.dart';
import '../widgets/custom_active_order_body_full.dart';
import '../widgets/custom_history_order_body_full.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    context.read<OrderBloc>().add(FetchOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              onTap: (value) {},
              labelColor: primary,
              indicatorColor: primary,
              labelStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [Tab(text: 'Active'), Tab(text: 'History')],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return TabBarView(
                      children: [
                        if (state is FetchedOrdersState)
                          CustomActiveOrderBodyFull(
                            orders:
                                state.orders
                                    .where(
                                      (order) =>
                                          order.status == OrderStatus.pending,
                                    )
                                    .toList(),
                          )
                        else if (state is FailedOrderState)
                          CustomErrorPage(onRetry: () {})
                        else
                          const Center(child: CircularProgressIndicator()),
                        if (state is FetchedOrdersState)
                          CustomHistoryOrderBody(
                            orders:
                                state.orders
                                    .where(
                                      (order) =>
                                          order.status != OrderStatus.pending,
                                    )
                                    .toList(),
                          )
                        else if (state is FailedOrderState)
                          CustomErrorPage(onRetry: () {})
                        else
                          const Center(child: CircularProgressIndicator()),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
