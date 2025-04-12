import 'package:damma_project/features/add_post/presentation/widgets/privacy_option_item.dart';
import 'package:flutter/material.dart';

class PrivacyOption extends StatefulWidget {
  final String title;
  final List<String> options;
  final List<String> icons;
  final String selectedOption;
  final ValueChanged<String> onOptionSelected;

  const PrivacyOption({
    super.key,
    required this.title,
    required this.options,
    required this.icons,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  State<PrivacyOption> createState() => _PrivacyOptionState();
}

class _PrivacyOptionState extends State<PrivacyOption> {
  late String currentOption;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    currentOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            currentOption, // ✅ يتم تحديث الـ subtitle فورًا عند التغيير
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Icon(isExpanded
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),
          ),
        ),
        if (isExpanded)
          PrivacyOptionItem(
            options: widget.options,
            icons: widget.icons,
            onOptionSelected: (value) {
              setState(() {
                currentOption = value;
              });
              widget.onOptionSelected(value);
            },
          ),
      ],
    );
  }
}
