import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_managment_mobile/core/widgets/custom_error_page.dart';
import 'package:restaurant_managment_mobile/core/widgets/custom_wrap_selected_items.dart';
import '../../../../core/utils/enum.dart';
import '../../data/data_source/remote/book_remote_data_source.dart';
import '../bloc/table/table_bloc.dart';
import '../widgets/cusom_table_item.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../data/models/table/table.dart' as table;

class TableView extends StatefulWidget {
  const TableView({super.key, required this.tableParams});
  final TableParams tableParams;

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  table.Table? t;
  @override
  void initState() {
    context.read<TableBloc>().add(FetchTableEvent(widget.tableParams));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Available Tables',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<TableBloc, TableState>(
                builder: (context, state) {
                  if (state is FetchedTableState) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CustomWrapSelectedItems<table.Table>(
                          child: (selected, item) {
                            return CustomTableItem(
                              selected: selected,
                              tableItem: item,
                            );
                          },
                          items: state.tables,
                          onTap: (item) {
                            setState(() {
                              t = item;
                            });
                          },
                          initial: -1,
                        ),
                      ),
                    );
                  } else if (state is FailedTableState) {
                    return CustomErrorPage(onRetry: () {});
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            CustomAnimatedButton(
              text: 'Continue',
              onClick: () {
                if (t != null) {
                  context.push(
                    '/review-summary-booking',
                    extra: BookParams(
                      t!,
                      BookType.customized,
                      '',
                      null,
                      widget.tableParams.duration,
                      widget.tableParams.time,
                      widget.tableParams.date,
                      widget.tableParams.restaurant,
                      widget.tableParams.partySize,
                    ),
                  );
                }
              },
              visable: t == null ? false : true,
            ),
          ],
        ),
      ),
    );
  }
}
