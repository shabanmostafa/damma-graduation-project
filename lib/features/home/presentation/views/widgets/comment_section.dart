// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../core/utils/app_styles.dart';
// import '../../../../../core/utils/spacing.dart';

// class CommentSection extends StatefulWidget {
//   final List<String> comments;
//   final Function(String) onCommentAdded;

//   const CommentSection({
//     super.key,
//     required this.comments,
//     required this.onCommentAdded,
//   });

//   @override
//   State<CommentSection> createState() => _CommentSectionState();
// }

// class _CommentSectionState extends State<CommentSection> {
//   final TextEditingController _commentController = TextEditingController();

//   void submitComment() {
//     String commentText = _commentController.text.trim();
//     if (commentText.isNotEmpty) {
//       setState(() {
//         widget.onCommentAdded(commentText);
//         _commentController.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 40.w,
//             height: 5.h,
//             decoration: BoxDecoration(
//               color: Colors.grey[400],
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//           ),
//           verticalSpace(10),
//           Text(
//             'التعليقات',
//             style: AppStyles.styleBold16,
//           ),
//           verticalSpace(10),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.comments.length,
//               itemBuilder: (context, index) => ListTile(
//                 leading: const CircleAvatar(
//                   backgroundImage: AssetImage('assets/images/shaban.jpg'),
//                 ),
//                 title: Text('مستخدم $index', style: AppStyles.styleMedium12),
//                 subtitle: Text(widget.comments[index],
//                     style: AppStyles.styleMedium12),
//               ),
//             ),
//           ),
//           TextField(
//             controller: _commentController,
//             decoration: InputDecoration(
//               hintText: 'اكتب تعليق...',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//             ),
//             onSubmitted: (value) => submitComment(),
//           ),
//           verticalSpace(10),
//         ],
//       ),
//     );
//   }
// }
