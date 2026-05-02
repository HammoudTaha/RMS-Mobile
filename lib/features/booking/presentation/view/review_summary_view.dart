import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_tow_text.dart';
import '../../data/data_source/remote/book_remote_data_source.dart';
import '../bloc/book/book_bloc.dart';
import '../widgets/custom_restaurnat_info_item.dart';

class ReviewSummaryBookingView extends StatefulWidget {
  const ReviewSummaryBookingView({super.key, required this.params});
  final BookParams params;

  @override
  State<ReviewSummaryBookingView> createState() =>
      _ReviewSummaryBookingViewState();
}

class _ReviewSummaryBookingViewState extends State<ReviewSummaryBookingView> {
  final GlobalKey<FormState> formStateKey = GlobalKey();
  String? special;
  bool quietArea = false;
  bool windowSeat = false;
  bool romanticSetting = false;
  bool nearKitchen = false;
  bool accessible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Review Summary'),
      body: BlocListener<BookBloc, BookState>(
        listener: (context, state) {
          if (state is BookedState) {
            EasyLoading.dismiss();
            context.go('/success-book-table', extra: state.data);
          } else if (state is FailedBookState) {
            EasyLoading.dismiss();
            showSnakbar(state.message);
          } else {
            EasyLoading.show(status: 'Loading');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formStateKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 20,
              children: [
                CustomRestaurantInfoItem(restaurant: widget.params.restaurant),
                CustomTowText(
                  text1: 'Booking for',
                  text2:
                      '${widget.params.date} - ${widget.params.time.displayTime}',
                  fontSize: 18,
                ),
                CustomTowText(
                  text1: 'Party Size',
                  text2: '${widget.params.partySize}',
                  fontSize: 18,
                ),
                if (widget.params.bookType == BookType.customized)
                  CustomTowText(
                    text1: 'Table Number',
                    text2: 'T-${widget.params.table!.tableNumber}',
                    fontSize: 18,
                  ),
                CustomTowText(
                  text1: 'Duration',
                  text2: widget.params.duration.displayDuration,
                  fontSize: 18,
                ),
                SizedBox(height: 20),
                if (widget.params.bookType == BookType.random)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        'Special Requests',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomTextField(
                        lines: 2,
                        text: 'Special Requests',
                        onSave: (value) {
                          special = value;
                        },
                      ),
                      item(
                        'Quiet Area',
                        quietArea,
                        (value) => quietArea = value ?? false,
                      ),
                      item(
                        'Window Seat',
                        windowSeat,
                        (value) => windowSeat = value ?? false,
                      ),
                      item(
                        'Romantic Setting',
                        romanticSetting,
                        (value) => romanticSetting = value ?? false,
                      ),
                      item(
                        'Near Kitchen',
                        nearKitchen,
                        (value) => nearKitchen = value ?? false,
                      ),
                      item(
                        'Accessible',
                        accessible,
                        (value) => accessible = value ?? false,
                      ),
                    ],
                  ),
                const Spacer(),
                CustomAnimatedButton(
                  text: 'Confirm Booking',
                  onClick: () {
                    formStateKey.currentState?.save();
                    context.read<BookBloc>().add(
                      BookEvent(
                        BookParams(
                          widget.params.table,
                          widget.params.bookType,
                          special ?? '',
                          UserPreferencesParams(
                            accessible: accessible,
                            nearKitchen: nearKitchen,
                            quietArea: quietArea,
                            romanticSetting: romanticSetting,
                            windowSeat: windowSeat,
                          ),
                          widget.params.duration,
                          widget.params.time,
                          widget.params.date,
                          widget.params.restaurant,
                          widget.params.partySize,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox item(String text, bool value, void Function(bool?) fn) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged:
                (value) => setState(() {
                  fn(value);
                }),
            activeColor: primary,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
