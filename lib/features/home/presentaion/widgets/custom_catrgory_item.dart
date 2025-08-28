import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/category/category.dart';

class CustomCategoryItem extends StatelessWidget {
  const CustomCategoryItem({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          context.push('/category-restaurant', extra: int.parse(category.id));
        },
        child: Container(
          width: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 3),
                blurRadius: 3,
              ),
            ],
          ),

          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/A.png',
                  height: 70,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Text(category.name, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
