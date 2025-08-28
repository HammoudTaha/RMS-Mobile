import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_outline_button.dart';
import '../../data/data_source/remote/book_remote_data_source.dart';

Future<dynamic> customBookTypeBottomSheet(
  BuildContext context,
  TableParams params,
) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return Container(
        height: 180,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 55,
              child: CustomOutLineButton(
                text: 'Select Table',
                onTap: () {
                  context.push(
                    '/table',
                    extra: TableParams(
                      params.duration,
                      params.time,
                      params.date,
                      params.restaurant,
                      params.partySize,
                    ),
                  );
                  context.pop();
                },
                fontSize: 18,
              ),
            ),
            CustomAnimatedButton(
              text: 'Skip',
              onClick: () {
                context.push(
                  '/review-summary-booking',
                  extra: BookParams(
                    null,
                    BookType.random,
                    '',
                    null,
                    params.duration,
                    params.time,
                    params.date,
                    params.restaurant,
                    params.partySize,
                  ),
                );
                context.pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
