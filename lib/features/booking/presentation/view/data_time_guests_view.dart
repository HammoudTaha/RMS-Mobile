import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_managment_mobile/core/widgets/custom_retry_item.dart';
import '../../../restaurant/data/models/restaurant/restaurant.dart';
import '../../data/data_source/remote/book_remote_data_source.dart';
import '../../data/models/data/date.dart';
import '../../data/models/duration/duration.dart';
import '../../data/models/time/time.dart';
import '../bloc/date/date_bloc.dart';
import '../bloc/duration/duration_bloc.dart';
import '../bloc/time/time_bloc.dart';
import '../widgets/custom_book_type_bottom_sheet.dart';
import '../widgets/custom_date_item_shimmer.dart';
import '../widgets/custom_data_item.dart';
import '../../../../core/widgets/custom_wrap_selected_items.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_list_selected_items.dart';
import '../widgets/custom_guest_item.dart';
import '../widgets/custom_time_item.dart';
import '../widgets/custom_time_item_shimmer.dart';

class DataTimeGuestsView extends StatefulWidget {
  const DataTimeGuestsView({super.key, required this.restaurant});
  final Restaurant restaurant;

  @override
  State<DataTimeGuestsView> createState() => _DataTimeGuestsViewState();
}

class _DataTimeGuestsViewState extends State<DataTimeGuestsView> {
  int partySize = 1;
  @override
  void initState() {
    context.read<DateBloc>().add(
      FetchDateEvent(DateParams(widget.restaurant, partySize)),
    );
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
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              ' Party Size',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            CustomListSelectedItems<int>(
              child: (selected, index) {
                return CustomGuestItem(index: index, selected: selected);
              },
              height: 70,
              onTap: (itme) {
                setState(() {
                  partySize = itme;
                });
                context.read<DateBloc>().add(
                  FetchDateEvent(DateParams(widget.restaurant, itme)),
                );
              },
              items: List.generate(10, (index) => index + 1),
            ),
            CustomListedDateItem(
              params: DateParams(widget.restaurant, partySize),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListedDateItem extends StatefulWidget {
  const CustomListedDateItem({super.key, required this.params});
  final DateParams params;

  @override
  State<CustomListedDateItem> createState() => _CustomListedDateItemState();
}

class _CustomListedDateItemState extends State<CustomListedDateItem> {
  String? date;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DateBloc, DateState>(
      listener: (context, state) {
        if (state is FetchedDateState) {
          context.read<TimeBloc>().add(
            FetchTimeEvent(
              TimeParams(
                state.date.dates.first.date,
                widget.params.restaurant,
                state.date.partySize,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FetchedDateState) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  ' Date',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomListSelectedItems<DateItem>(
                  child: (selected, item) {
                    return CustomDataItem(item: item, selected: selected);
                  },
                  height: 80,
                  onTap: (item) {
                    setState(() {
                      date = item.date;
                    });
                    context.read<TimeBloc>().add(
                      FetchTimeEvent(
                        TimeParams(
                          item.date,
                          widget.params.restaurant,
                          state.date.partySize,
                        ),
                      ),
                    );
                  },
                  items: state.date.dates,
                ),
                CustomListedTimeItem(
                  params: TimeParams(
                    date ?? state.date.dates.first.date,
                    widget.params.restaurant,
                    widget.params.partySize,
                  ),
                ),
              ],
            ),
          );
        } else if (state is FailedDateState) {
          return CustomRetryItem(
            height: 60,
            onPress: () {
              context.read<DateBloc>().add(
                FetchDateEvent(
                  DateParams(widget.params.restaurant, widget.params.partySize),
                ),
              );
            },
          );
        } else {
          return Row(
            children: List.generate(
              4,
              (index) => const CustomDateItemShimmer(),
            ),
          );
        }
      },
    );
  }
}

class CustomListedTimeItem extends StatefulWidget {
  const CustomListedTimeItem({super.key, required this.params});
  final TimeParams params;

  @override
  State<CustomListedTimeItem> createState() => _CustomListedTimeItemState();
}

class _CustomListedTimeItemState extends State<CustomListedTimeItem> {
  TimeItem? time;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimeBloc, TimeState>(
      listener: (context, state) {
        if (state is FetchedTimeState) {
          if (state.time.times.isNotEmpty) {
            context.read<DurationBloc>().add(
              FetchDurationEvent(
                DurationParams(
                  state.time.times.first,
                  state.time.date,
                  widget.params.restaurant,
                  state.time.partySize,
                ),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        if (state is FetchedTimeState) {
          return state.time.times.isNotEmpty
              ? Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      ' Time',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomWrapSelectedItems<TimeItem>(
                      child: (selected, item) {
                        return CustomTimeItem(
                          selected: selected,
                          text: item.displayTime,
                        );
                      },
                      onTap: (item) {
                        setState(() {
                          time = item;
                        });
                        context.read<DurationBloc>().add(
                          FetchDurationEvent(
                            DurationParams(
                              item,
                              state.time.date,
                              widget.params.restaurant,
                              state.time.partySize,
                            ),
                          ),
                        );
                      },
                      items: state.time.times,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ' Duration : ',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomListedDurationItem(
                      params: DurationParams(
                        time ?? state.time.times.first,
                        widget.params.date,
                        widget.params.restaurant,
                        widget.params.partySize,
                      ),
                    ),
                  ],
                ),
              )
              : Row(
                spacing: 10,
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  Text(
                    'No available tables of your request',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ],
              );
        } else if (state is FailedTimeState) {
          return CustomRetryItem(
            height: 60,
            onPress: () {
              context.read<TimeBloc>().add(
                FetchTimeEvent(
                  TimeParams(
                    widget.params.date,
                    widget.params.restaurant,
                    widget.params.partySize,
                  ),
                ),
              );
            },
          );
        } else {
          return Row(
            children: List.generate(
              4,
              (index) => const CustomTimeItemShimmer(),
            ),
          );
        }
      },
    );
  }
}

class CustomListedDurationItem extends StatefulWidget {
  const CustomListedDurationItem({super.key, required this.params});
  final DurationParams params;

  @override
  State<CustomListedDurationItem> createState() =>
      _CustomListedDurationItemState();
}

class _CustomListedDurationItemState extends State<CustomListedDurationItem> {
  DurationItem? durationItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DurationBloc, DurationState>(
      builder: (context, state) {
        if (state is FetchedDurationState) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomWrapSelectedItems<DurationItem>(
                  child: (selected, item) {
                    return CustomTimeItem(
                      selected: selected,
                      text: item.displayDuration,
                    );
                  },
                  onTap: (item) {
                    durationItem = item;
                  },
                  items: state.duration.durations,
                ),
                CustomAnimatedButton(
                  text: 'Continue',
                  onClick: () {
                    customBookTypeBottomSheet(
                      context,
                      TableParams(
                        durationItem ?? state.duration.durations.first,
                        widget.params.time,
                        state.duration.date,
                        widget.params.restaurant,
                        state.duration.partySize,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is FailedDurationState) {
          return CustomRetryItem(
            height: 60,
            onPress: () {
              context.read<DurationBloc>().add(
                FetchDurationEvent(
                  DurationParams(
                    widget.params.time,
                    widget.params.date,
                    widget.params.restaurant,
                    widget.params.partySize,
                  ),
                ),
              );
            },
          );
        } else {
          return Row(
            children: List.generate(
              4,
              (index) => const CustomTimeItemShimmer(),
            ),
          );
        }
      },
    );
  }
}
