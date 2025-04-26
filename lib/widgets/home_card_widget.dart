import 'package:flutter/material.dart';
import 'package:grocery_plus/constants/colors.dart';

class HomeCardWidget extends StatefulWidget {
  final String image;
  final String name;
  final String rating;
  final Function() ontap;
  const HomeCardWidget({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.ontap
  });

  @override
  State<HomeCardWidget> createState() => _HomeCardWidgetState();
}

class _HomeCardWidgetState extends State<HomeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.image,
                height: 100,
                width: 300,
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.name),
                  Row(
                    children: [
                      Text(widget.rating),
                      Icon(Icons.star, color: Colors.amber, size: 12)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
