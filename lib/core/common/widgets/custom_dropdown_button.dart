import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String hint;
  final ValueChanged<T?> onChanged;
  final String labelText;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.value,
    required this.hint,
    required this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 28.sp),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.w),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              hint: Text(
                hint,
                style: TextStyle(fontSize: 20.sp, color: Colors.grey[600]),
              ),
              items: items,
              onChanged: onChanged,
              dropdownColor: Colors.white,
              icon: Icon(
                Icons.arrow_drop_down,
                size: 38.sp,
                color: Colors.grey[600],
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
