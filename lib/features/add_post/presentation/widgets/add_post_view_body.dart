import 'package:damma_project/features/add_post/presentation/widgets/gallary_icons_section.dart';
import 'package:damma_project/features/add_post/presentation/widgets/privacy_info.dart';
import 'package:damma_project/features/add_post/presentation/widgets/right_part_of_row.dart';
import 'package:damma_project/features/add_post/presentation/widgets/left_part_of_row.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';

class AddPostViewBody extends StatefulWidget {
  const AddPostViewBody({super.key});

  @override
  State<AddPostViewBody> createState() => _AddPostViewBodyState();
}

class _AddPostViewBodyState extends State<AddPostViewBody> {
  final TextEditingController _textController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      isButtonActive = _textController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const RightPartOfRow(),
              const PrivacyInfo(),
              const Spacer(),
              LeftPartOfRow(
                isButtonActive: isButtonActive,
                postContent: _textController.text, // تمرير المحتوى
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: S.of(context).whatWillYouTalkAbout,
              border: InputBorder.none,
            ),
            maxLines: null,
          ),
          const Spacer(),
          const GallaryIconsSection(),
        ],
      ),
    );
  }
}
