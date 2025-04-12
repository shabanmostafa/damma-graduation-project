import 'package:damma_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrivacyOptionItem extends StatefulWidget {
  final List<String> options;
  final List<String> icons;
  final Function(String) onOptionSelected;

  const PrivacyOptionItem({
    super.key,
    required this.options,
    required this.icons,
    required this.onOptionSelected,
  });

  @override
  _PrivacyOptionItemState createState() => _PrivacyOptionItemState();
}

class _PrivacyOptionItemState extends State<PrivacyOptionItem> {
  String? currentOption;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    currentOption = currentOption ?? widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.options.length, (index) {
        return RadioListTile<String>(
          controlAffinity: ListTileControlAffinity.trailing,
          title: Row(
            children: [
              SvgPicture.asset(
                widget.icons[index],
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 10),
              Text(widget.options[index]),
            ],
          ),
          value: widget.options[index],
          groupValue: currentOption,
          activeColor: AppColors.primaryColor,
          onChanged: (value) {
            setState(() {
              currentOption = value!;
              isExpanded = false;
            });
            widget.onOptionSelected(value!);
          },
        );
      }),
    );
  }
}
