// import 'package:damma_project/features/add_post/presentation/widgets/gallary_icons_section.dart';
// import 'package:damma_project/features/add_post/presentation/widgets/post_state_dialog.dart';
// import 'package:damma_project/features/add_post/presentation/widgets/privacy_info.dart';
// import 'package:damma_project/features/add_post/presentation/widgets/right_part_of_row.dart';
// import 'package:damma_project/features/add_post/presentation/widgets/left_part_of_row.dart';
// import 'package:damma_project/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/app_styles.dart';
// import '../../../../core/utils/assets.dart';
// import '../../../../core/utils/widgets/app_text_button.dart';
// import 'post_validator.dart';

// class AddPostViewBody extends StatefulWidget {
//   const AddPostViewBody({super.key});

//   @override
//   State<AddPostViewBody> createState() => _AddPostViewBodyState();
// }

// class _AddPostViewBodyState extends State<AddPostViewBody> {
//   final TextEditingController _textController = TextEditingController();
//   bool isButtonActive = false;

//   @override
//   void initState() {
//     super.initState();
//     _textController.addListener(_onTextChanged);
//   }

//   void _onTextChanged() {
//     setState(() {
//       isButtonActive = _textController.text.trim().isNotEmpty;
//     });
//   }

//   @override
//   void dispose() {
//     _textController.removeListener(_onTextChanged);
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const RightPartOfRow(),
//               const PrivacyInfo(),
//               const Spacer(),
//               LeftPartOfRow(
//                 isButtonActive: isButtonActive,
//                 postContent: _textController.text, // تمرير المحتوى
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             controller: _textController,
//             decoration: InputDecoration(
//               hintText: S.of(context).whatWillYouTalkAbout,
//               border: InputBorder.none,
//             ),
//             maxLines: null,
//           ),
//           const Spacer(),
//           const GallaryIconsSection(),
//         ],
//       ),
//     );
//   }
// }

// class LeftPartOfRow extends StatelessWidget {
//   const LeftPartOfRow(
//       {super.key, required this.isButtonActive, required this.postContent});

//   final bool isButtonActive;
//   final String postContent;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 11.0.w),
//           child: SvgPicture.asset(
//             Assets.svgsClock,
//             width: 25.w,
//             height: 25.h,
//           ),
//         ),
//         AppTextButton(
//           backgroundColor: isButtonActive
//               ? AppColors.primaryColor
//               : AppColors.inactiveButtonColor,
//           borderRadius: 20.r,
//           buttonWidth: 66.w,
//           buttonHeight: 40.h,
//           buttonText: S.of(context).post,
//           textStyle:
//               AppStyles.styleMedium14.copyWith(color: AppColors.whiteColor),
//           onPressed: isButtonActive
//               ? () {
//                   bool isPostAccepted = PostValidator.validate(postContent);
//                   PostStateDialog.showBottomPopup(context, isPostAccepted);
//                 }
//               : () {}, // الزر غير مفعل إذا كان المحتوى فارغًا
//         ),
//       ],
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/widgets/app_text_button.dart';
import '../../../../../generated/l10n.dart';
import 'gallary_icons_section.dart';
import 'post_state_dialog.dart';
import 'privacy_info.dart';
import 'right_part_of_row.dart';

class AddPostViewBody extends StatefulWidget {
  const AddPostViewBody({super.key});

  @override
  State<AddPostViewBody> createState() => _AddPostViewBodyState();
}

class _AddPostViewBodyState extends State<AddPostViewBody> {
  final Dio _dio = Dio();
  final TextEditingController _textController = TextEditingController();
  bool isButtonActive = false;
  bool _isLoading = false;

  // Hardcoded API key (for testing only - remove before publishing!)
  final String _apiKey =
      "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";

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

  Future<void> _checkContent() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final String fullPrompt =
          "أنت نظام تحكيم محتوى. مهمتك فقط إرجاع 0 أو 1 بناء على التالي:\n"
          "1 إذا كان النص يحتوي على:\n"
          "- ألفاظ بذيئة أو نابية\n"
          "- تنمر أو إساءة\n"
          "- محتوى خادش للحياء\n"
          "- أخبار أو معلومات مزيفة\n"
          "0 إذا كان النص عاديًا وآمنًا\n"
          "لا تشرح ولا تعلق فقط أعد 0 أو 1\n"
          "النص: ${_textController.text}";

      final response = await _dio.post(
        'https://api.groq.com/openai/v1/chat/completions',
        options: Options(
          headers: {
            "Authorization": "Bearer $_apiKey",
            "Content-Type": "application/json",
          },
        ),
        data: {
          "model": "llama-3.3-70b-versatile",
          "messages": [
            {
              "role": "system",
              "content":
                  "أنت نظام تصنيف محتوى. مهمتك فقط إرجاع 0 أو 1 بدون أي شرح أو تعليق.",
            },
            {
              "role": "user",
              "content": fullPrompt,
            }
          ],
          "temperature": 0.0,
          "max_tokens": 1,
        },
      );

      final result = response.data['choices'][0]['message']['content'];
      PostStateDialog.showBottomPopup(context, result == "0");
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.response?.data ?? e.message}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handlePostPressed() {
    if (!_isLoading && isButtonActive) {
      _checkContent();
    }
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _dio.close();
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 11.0.w),
                    child: SvgPicture.asset(
                      Assets.svgsClock,
                      width: 25.w,
                      height: 25.h,
                    ),
                  ),
                  _isLoading
                      ? SizedBox(
                          width: 66.w,
                          height: 40.h,
                          child: const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                        )
                      : AppTextButton(
                          backgroundColor: isButtonActive
                              ? AppColors.primaryColor
                              : AppColors.inactiveButtonColor,
                          borderRadius: 20.r,
                          buttonWidth: 66.w,
                          buttonHeight: 40.h,
                          buttonText: S.of(context).post,
                          textStyle: AppStyles.styleMedium14
                              .copyWith(color: AppColors.whiteColor),
                          onPressed:
                              isButtonActive ? _handlePostPressed : () {},
                        ),
                ],
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
