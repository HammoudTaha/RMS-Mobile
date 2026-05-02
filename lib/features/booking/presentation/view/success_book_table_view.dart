import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_icon_text_item.dart';

class SuccessBookTableView extends StatelessWidget {
  const SuccessBookTableView({super.key, required this.data});
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 150),
          const CircleAvatar(
            backgroundColor: primary,
            minRadius: 50,
            child: Icon(Icons.check, color: Colors.white, size: 70),
          ),
          const SizedBox(height: 10),
          const Text(
            'Successfully\nReserved Your Table',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reservation ID : ',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                ),
              ),
              Text(
                '${data['id']}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CustomIconTextItem(
                icon: Icons.calendar_month,
                text: '${data['date']} - ${data['time']}',
                fontSize: 17,
              ),
              CustomIconTextItem(
                icon: Icons.people_alt,
                text: '${data['party_size']}',
                fontSize: 17,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CustomIconTextItem(
                icon: Icons.watch_later_outlined,
                text: '${data['duration_hours']} hour',
                fontSize: 17,
              ),
              CustomIconTextItem(
                icon: Icons.table_restaurant,
                text: 'T-${data['table']['number']}',
                fontSize: 17,
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomAnimatedButton(
              text: 'Back Home',
              onClick: () {
                context.go('/main');
              },
            ),
          ),
        ],
      ),
    );
  }
}
