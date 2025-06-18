import 'dart:convert';
import 'dart:io';

import 'package:damma_project/core/contenet_moderation.dart'
    show ContentModerationPrompt;
import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/features/add_post/data/models/add_post_model.dart';
import 'package:damma_project/features/add_post/manager/post_cubit.dart';
import 'package:damma_project/features/add_post/presentation/views/widgets/media_buttom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/widgets/app_text_button.dart';
import '../../../../../generated/l10n.dart';
import 'post_state_dialog.dart';
import 'privacy_info.dart';
import 'right_part_of_row.dart';

class LocalModelService {
  static const String _baseUrl = 'http://192.168.108.150:5000';

  // Check for bad words
  static Future<bool> hasBadWords(String text) async {
    final url = Uri.parse('$_baseUrl/predict-badword');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'text': text});

    try {
      debugPrint('🔍 [Bad Words Check] Sending request to local model');
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final hasBadWords = data['result'] != 'Normal';
        debugPrint(
            '📊 [Local Model - Bad Words] Result: ${hasBadWords ? "Contains bad words" : "Clean"}');
        return hasBadWords;
      }
      throw 'API Error: ${response.statusCode}';
    } catch (e) {
      debugPrint('❌ [Local Model - Bad Words] Error: $e');
      throw 'Bad words check failed: $e';
    }
  }

  // Check for fake news
  static Future<bool> isFakeNews(String text) async {
    final url = Uri.parse('$_baseUrl/predict-fake-news');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'text': text});

    try {
      debugPrint('🔍 [Fake News Check] Sending request to local model');
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final isFake = data['result'] != 'Real';
        debugPrint(
            '📊 [Local Model - Fake News] Result: ${isFake ? "Fake" : "Real"}');
        return isFake;
      }
      throw 'API Error: ${response.statusCode}';
    } catch (e) {
      debugPrint('❌ [Local Model - Fake News] Error: $e');
      throw 'Fake news check failed: $e';
    }
  }
}

class AddPostViewBody extends StatefulWidget {
  final UserModel user;

  const AddPostViewBody({super.key, required this.user});

  @override
  State<AddPostViewBody> createState() => _AddPostViewBodyState();
}

class _AddPostViewBodyState extends State<AddPostViewBody> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final Dio _dio = Dio();
  final String _apiKey =
      "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";
  bool isButtonActive = false;
  bool _isLoading = false;
  bool _isListening = false;
  bool _speechEnabled = false;
  XFile? _selectedMedia;
  bool _isVideo = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  void _initSpeech() async {
    try {
      _speechEnabled = await _speech.initialize(
        onError: (error) => setState(() => _speechEnabled = false),
        onStatus: (status) {},
      );
      setState(() {});
    } catch (e) {
      setState(() => _speechEnabled = false);
      debugPrint('❌ [Speech] Initialization error: $e');
    }
  }

  Future<void> _startListening() async {
    if (!_speechEnabled) {
      _showErrorSnackBar("Speech recognition not available");
      return;
    }

    try {
      if (!_speech.isAvailable) {
        _showErrorSnackBar("Speech recognition not available");
        return;
      }

      _contentController.selection = TextSelection.fromPosition(
        TextPosition(offset: _contentController.text.length),
      );

      await _speech.listen(
        onResult: (result) async {
          if (result.finalResult) {
            final newText = result.recognizedWords.trim();
            if (newText.isNotEmpty) {
              setState(() {
                _contentController.text = _contentController.text.trim().isEmpty
                    ? newText
                    : "${_contentController.text.trim()} $newText";
              });
            }
            await _stopListening();
          }
        },
        localeId: 'ar_SA',
        listenFor: const Duration(minutes: 5),
        cancelOnError: true,
        partialResults: false,
      );

      setState(() => _isListening = true);
    } catch (e) {
      setState(() => _isListening = false);
      _showErrorSnackBar("Error: ${e.toString()}");
    }
  }

  Future<void> _stopListening() async {
    try {
      await _speech.stop();
      setState(() => _isListening = false);
    } catch (e) {
      setState(() => _isListening = false);
      debugPrint('❌ [Speech] Error stopping: $e');
    }
  }

  Future<bool> _checkWithGroq() async {
    try {
      final String fullPrompt = ContentModerationPrompt.buildPrompt(
        _titleController.text,
        _contentController.text,
      );

      debugPrint(
          '🔍 [Content Check] Sending request to Groq for bad words check');

      final response = await _dio.post(
        'https://api.groq.com/openai/v1/chat/completions',
        options: Options(
          headers: {
            "Authorization": "Bearer $_apiKey",
            "Content-Type": "application/json",
          },
        ),
        data: {
          "model": "llama3-70b-8192",
          "messages": [
            {
              "role": "system",
              "content":
                  "أنت نظام تصنيف محتوى. مهمتك فقط إرجاع '0' أو '1' بدون أي شرح أو تعليق.",
            },
            {
              "role": "user",
              "content": fullPrompt,
            }
          ],
          "temperature": 0.1,
          "max_tokens": 1,
        },
      );

      final result = response.data['choices'][0]['message']['content'].trim();
      final isSafe = result == "0";
      debugPrint('📊 [Groq - Bad Words] Result: ${isSafe ? "Safe" : "Unsafe"}');
      return isSafe;
    } catch (e) {
      debugPrint('❌ [Groq - Bad Words] Error: $e');
      _showErrorSnackBar("حدث خطأ أثناء التحقق من المحتوى");
      return false;
    }
  }

  Future<void> _checkContent() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final fullText = "${_titleController.text}\n${_contentController.text}";
      debugPrint('\n=== STARTING CONTENT VALIDATION ===');

      debugPrint('\n🔍 STEP 1: Checking for bad words');
      final localModelHasBadWords =
          await LocalModelService.hasBadWords(fullText);

      final isGroqSafe = await _checkWithGroq();

      debugPrint('\n📝 BAD WORDS VALIDATION RESULTS:');
      debugPrint(
          '• Local Model: ${localModelHasBadWords ? "Has bad words" : "Clean"}');
      debugPrint('• Groq: ${isGroqSafe ? "Safe" : "Unsafe"}');

      if (localModelHasBadWords && !isGroqSafe) {
        debugPrint('\n❌ REJECTED: Both models detected bad words');
        _rejectPost();
        _showErrorSnackBar('المحتوى غير لائق');
        return;
      }

      if (!localModelHasBadWords && !isGroqSafe) {
        debugPrint('\n❌ REJECTED: Groq detected bad words (local model clean)');
        _rejectPost();
        _showErrorSnackBar('المحتوى غير لائق');
        return;
      }

      debugPrint('\n✅ PASSED BAD WORDS CHECK - Proceeding to fake news check');
      // Proceed to fake news check if passed bad words check
      await _checkFakeNews(fullText);
    } catch (e) {
      debugPrint('\n❌ ERROR DURING VALIDATION: $e');
      _showErrorSnackBar("حدث خطأ أثناء التحقق من المحتوى: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
      debugPrint('=== VALIDATION COMPLETED ===\n');
    }
  }

  Future<void> _checkFakeNews(String fullText) async {
    try {
      debugPrint('\n🔍 STEP 2: Checking for fake news');

      final localModelIsFake = await LocalModelService.isFakeNews(fullText);

      final isGroqFakeNews = await _checkFakeNewsWithGroq(fullText);

      debugPrint('\n📝 FAKE NEWS VALIDATION RESULTS:');
      debugPrint('• Local Model: ${localModelIsFake ? "Fake" : "Real"}');
      debugPrint('• Groq: ${isGroqFakeNews ? "Fake" : "Real"}');

      if ((localModelIsFake && !isGroqFakeNews) ||
          (!localModelIsFake && !isGroqFakeNews)) {
        debugPrint('\n✅ ACCEPTED: Content is valid');
        _acceptPost();
      } else {
        debugPrint('\n❌ REJECTED: Fake news detected');
        _rejectPost();
        _showErrorSnackBar('المحتوى يحتوي على معلومات مزيفة');
      }
    } catch (e) {
      debugPrint('\n❌ ERROR DURING FAKE NEWS CHECK: $e');
      _showErrorSnackBar("حدث خطأ أثناء التحقق من صحة المحتوى");
      _rejectPost();
    }
  }

  Future<bool> _checkFakeNewsWithGroq(String text) async {
    try {
      final String fakeNewsPrompt =
          "أنت نظام تحكيم محتوى. مهمتك فقط إرجاع 0 أو 1 بناء على التالي:\n"
          "1 إذا كان النص يحتوي على معلومات مزيفة\n"
          "0 إذا كان النص حقيقي وموثوق\n"
          "لا تشرح ولا تعلق فقط أعد 0 أو 1\n"
          "النص: $text";

      debugPrint('🔍 [Fake News Check] Sending request to Groq');

      final response = await _dio.post(
        'https://api.groq.com/openai/v1/chat/completions',
        options: Options(
          headers: {
            "Authorization": "Bearer $_apiKey",
            "Content-Type": "application/json",
          },
        ),
        data: {
          "model": "llama3-70b-8192",
          "messages": [
            {
              "role": "system",
              "content":
                  "أنت نظام تصنيف محتوى. مهمتك فقط إرجاع '0' أو '1' بدون أي شرح أو تعليق.",
            },
            {
              "role": "user",
              "content": fakeNewsPrompt,
            }
          ],
          "temperature": 0.1,
          "max_tokens": 1,
        },
      );

      final result = response.data['choices'][0]['message']['content'].trim();
      final isFake = result == "1";
      debugPrint('📊 [Groq - Fake News] Result: ${isFake ? "Fake" : "Real"}');
      return isFake;
    } catch (e) {
      debugPrint('❌ [Groq - Fake News] Error: $e');
      throw 'Fake news check with Groq failed: $e';
    }
  }

  void _acceptPost() {
    if (_isVideo &&
        _selectedMedia != null &&
        !_selectedMedia!.path.endsWith('.mp4')) {
      _showErrorSnackBar("يجب اختيار ملف فيديو بصيغة MP4");
      return;
    }

    if (!_isVideo &&
        _selectedMedia != null &&
        !['.jpg', '.jpeg', '.png']
            .any((ext) => _selectedMedia!.path.endsWith(ext))) {
      _showErrorSnackBar("يجب اختيار صورة بصيغة JPG أو JPEG أو PNG");
      return;
    }

    context.read<PostCubit>().addPost(
          AddPostModel(
            title: _titleController.text,
            content: _contentController.text,
            image: !_isVideo ? _selectedMedia : null,
            video: _isVideo ? _selectedMedia : null,
          ),
        );
  }

  void _rejectPost() {
    PostStateDialog.showBottomPopup(context, false);
  }

  void _onTextChanged() {
    setState(() {
      isButtonActive = _titleController.text.trim().isNotEmpty &&
          _contentController.text.trim().isNotEmpty;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      final fileExtension = pickedFile.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png'].contains(fileExtension)) {
        _showErrorSnackBar(
            "نوع الملف غير مدعوم. يرجى اختيار صورة (JPG/JPEG/PNG)");
        return;
      }

      setState(() {
        _selectedMedia = pickedFile;
        _isVideo = false;
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final fileExtension = pickedFile.path.split('.').last.toLowerCase();
      if (fileExtension != 'mp4') {
        _showErrorSnackBar("نوع الملف غير مدعوم. يرجى اختيار فيديو (MP4)");
        return;
      }

      setState(() {
        _selectedMedia = pickedFile;
        _isVideo = true;
      });
    }
  }

  void _removeMedia() {
    setState(() {
      _selectedMedia = null;
    });
  }

  void _handlePostPressed() {
    if (!_isLoading && isButtonActive) {
      if (_titleController.text.trim().length < 3) {
        _showErrorSnackBar("يجب أن يكون العنوان من 3 إلى 100 حرف");
        return;
      }

      if (_titleController.text.trim().length > 100) {
        _showErrorSnackBar("يجب أن لا يتجاوز العنوان 100 حرف");
        return;
      }

      if (_contentController.text.trim().length < 10) {
        _showErrorSnackBar("يجب أن يكون المحتوى من 10 إلى 5000 حرف");
        return;
      }

      if (_contentController.text.trim().length > 5000) {
        _showErrorSnackBar("يجب أن لا يتجاوز المحتوى 5000 حرف");
        return;
      }

      _checkContent();
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyles.styleMedium14.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.removeListener(_onTextChanged);
    _contentController.removeListener(_onTextChanged);
    _titleController.dispose();
    _contentController.dispose();
    _speech.stop();
    super.dispose();
  }

  Widget _buildMediaPreview() {
    if (_selectedMedia == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.whiteColor,
            ),
            child: _isVideo
                ? const Icon(Icons.videocam, size: 50, color: Colors.grey)
                : Image.file(File(_selectedMedia!.path)),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: _removeMedia,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                child: const Icon(Icons.close, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        _isLoading = state is PostLoading;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RightPartOfRow(user: widget.user),
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
                                  child: CircularProgressIndicator(
                                      color: AppColors.primaryColor),
                                ),
                              )
                            : AppTextButton(
                                backgroundColor: isButtonActive
                                    ? AppColors.primaryColor
                                    : AppColors.inactiveButtonColor
                                        .withOpacity(0.5),
                                borderRadius: 20.r,
                                buttonWidth: 66.w,
                                buttonHeight: 40.h,
                                buttonText: S.of(context).post,
                                textStyle: AppStyles.styleMedium14.copyWith(
                                  color: isButtonActive
                                      ? AppColors.whiteColor
                                      : Colors.grey[600],
                                ),
                                onPressed:
                                    isButtonActive ? _handlePostPressed : () {},
                              ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "ادخل عنوان للبوست",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    style: AppStyles.styleMedium16
                        .copyWith(color: AppColors.blackTextColor),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      hintText: S.of(context).whatWillYouTalkAbout,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    style: AppStyles.styleMedium14,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(height: 16),
                _buildMediaPreview(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MediaButton(
                      icon: Assets.svgsVedio,
                      onPressed: _pickVideo,
                      isActive: _selectedMedia == null,
                    ),
                    const SizedBox(width: 16),
                    MediaButton(
                      icon: Assets.svgsGallary,
                      onPressed: _pickImage,
                      isActive: _selectedMedia == null,
                    ),
                    const SizedBox(width: 16),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_speechEnabled)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _isListening ? 40.w : 32.w,
                            height: _isListening ? 40.h : 32.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isListening
                                  ? AppColors.primaryColor.withOpacity(0.2)
                                  : Colors.transparent,
                            ),
                          ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: _speechEnabled
                              ? () async {
                                  if (_isListening) {
                                    await _stopListening();
                                  } else {
                                    await _startListening();
                                  }
                                }
                              : null,
                          icon: Icon(
                            _isListening ? Icons.mic : Icons.mic_none,
                            color: _speechEnabled
                                ? (_isListening
                                    ? AppColors.primaryColor
                                    : Colors.black54)
                                : Colors.grey,
                            size: 24.w,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// import 'dart:convert';
// import 'dart:io';

// import 'package:damma_project/core/utils/models/user_model.dart';
// import 'package:damma_project/features/add_post/data/models/add_post_model.dart';
// import 'package:damma_project/features/add_post/manager/post_cubit.dart';
// import 'package:damma_project/features/add_post/presentation/views/widgets/media_buttom.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:http/http.dart' as http;

// import '../../../../../core/utils/app_colors.dart';
// import '../../../../../core/utils/app_styles.dart';
// import '../../../../../core/utils/assets.dart';
// import '../../../../../core/utils/widgets/app_text_button.dart';
// import '../../../../../generated/l10n.dart';
// import 'post_state_dialog.dart';
// import 'privacy_info.dart';
// import 'right_part_of_row.dart';

// class LocalModelService {
//   // Base URL for the Bad Words API (assuming it runs on port 5000)
//   static const String _badWordsBaseUrl = 'http://192.168.1.19:5000';
//   // Base URL for the Fake News API (assuming it runs on port 5001)
//   static const String _fakeNewsBaseUrl = 'http://192.168.1.19:5001';

//   // Check for bad words
//   static Future<bool> hasBadWords(String text) async {
//     final url = Uri.parse('$_badWordsBaseUrl/predict-badword');
//     final headers = {'Content-Type': 'application/json'};
//     final body = jsonEncode({'text': text});

//     try {
//       debugPrint('🔍 [Bad Words Check] Sending request to local model');
//       final response = await http
//           .post(url, headers: headers, body: body)
//           .timeout(const Duration(seconds: 10));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final hasBadWords = data['result'] != 'Normal';
//         debugPrint(
//             '📊 [Local Model - Bad Words] Result: ${hasBadWords ? "Contains bad words" : "Clean"}');
//         return hasBadWords;
//       }
//       throw 'API Error: ${response.statusCode}';
//     } catch (e) {
//       debugPrint('❌ [Local Model - Bad Words] Error: $e');
//       throw 'Bad words check failed: $e';
//     }
//   }

//   // Check for fake news
//   static Future<bool> isFakeNews(String text) async {
//     final url = Uri.parse('$_fakeNewsBaseUrl/predict-fake-news');
//     final headers = {'Content-Type': 'application/json'};
//     final body = jsonEncode({'text': text});

//     try {
//       debugPrint('🔍 [Fake News Check] Sending request to local model');
//       final response = await http
//           .post(url, headers: headers, body: body)
//           .timeout(const Duration(seconds: 10));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final isFake = data['result'] != 'Real';
//         debugPrint(
//             '📊 [Local Model - Fake News] Result: ${isFake ? "Fake" : "Real"}');
//         return isFake;
//       }
//       throw 'API Error: ${response.statusCode}';
//     } catch (e) {
//       debugPrint('❌ [Local Model - Fake News] Error: $e');
//       throw 'Fake news check failed: $e';
//     }
//   }
// }

// class AddPostViewBody extends StatefulWidget {
//   final UserModel user;

//   const AddPostViewBody({super.key, required this.user});

//   @override
//   State<AddPostViewBody> createState() => _AddPostViewBodyState();
// }

// class _AddPostViewBodyState extends State<AddPostViewBody> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _contentController = TextEditingController();
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   final Dio _dio = Dio();
//   final String _apiKey =
//       "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";
//   bool isButtonActive = false;
//   bool _isLoading = false;
//   bool _isListening = false;
//   bool _speechEnabled = false;
//   XFile? _selectedMedia;
//   bool _isVideo = false;

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//     _titleController.addListener(_onTextChanged);
//     _contentController.addListener(_onTextChanged);
//   }

//   void _initSpeech() async {
//     try {
//       _speechEnabled = await _speech.initialize(
//         onError: (error) => setState(() => _speechEnabled = false),
//         onStatus: (status) {},
//       );
//       setState(() {});
//     } catch (e) {
//       setState(() => _speechEnabled = false);
//       debugPrint('❌ [Speech] Initialization error: $e');
//     }
//   }

//   Future<void> _startListening() async {
//     if (!_speechEnabled) {
//       _showErrorSnackBar("Speech recognition not available");
//       return;
//     }

//     try {
//       if (!_speech.isAvailable) {
//         _showErrorSnackBar("Speech recognition not available");
//         return;
//       }

//       _contentController.selection = TextSelection.fromPosition(
//         TextPosition(offset: _contentController.text.length),
//       );

//       await _speech.listen(
//         onResult: (result) async {
//           if (result.finalResult) {
//             final newText = result.recognizedWords.trim();
//             if (newText.isNotEmpty) {
//               setState(() {
//                 _contentController.text = _contentController.text.trim().isEmpty
//                     ? newText
//                     : "${_contentController.text.trim()} $newText";
//               });
//             }
//             await _stopListening();
//           }
//         },
//         localeId: 'ar_SA',
//         listenFor: const Duration(minutes: 5),
//         cancelOnError: true,
//         partialResults: false,
//       );

//       setState(() => _isListening = true);
//     } catch (e) {
//       setState(() => _isListening = false);
//       _showErrorSnackBar("Error: ${e.toString()}");
//     }
//   }

//   Future<void> _stopListening() async {
//     try {
//       await _speech.stop();
//       setState(() => _isListening = false);
//     } catch (e) {
//       setState(() => _isListening = false);
//       debugPrint('❌ [Speech] Error stopping: $e');
//     }
//   }

//   Future<bool> _checkWithGroq() async {
//     try {
//       final String fullPrompt =
//           "أنت نظام تحكيم محتوى. مهمتك فقط إرجاع 0 أو 1 بناء على التالي:\n"
//           "1 إذا كان النص يحتوي على:\n"
//           "- ألفاظ بذيئة أو نابية\n"
//           "- تنمر أو إساءة\n"
//           "- محتوى خادش للحياء\n"
//           "- أخبار أو معلومات مزيفة\n"
//           "0 إذا كان النص عاديًا وآمنًا وموثوقًا\n"
//           "لا تشرح ولا تعلق فقط أعد 0 أو 1\n"
//           "النص: ${_titleController.text}\n${_contentController.text}";

//       debugPrint(
//           '🔍 [Content Check] Sending request to Groq for bad words check');

//       final response = await _dio.post(
//         'https://api.groq.com/openai/v1/chat/completions',
//         options: Options(
//           headers: {
//             "Authorization": "Bearer $_apiKey",
//             "Content-Type": "application/json",
//           },
//         ),
//         data: {
//           "model": "llama3-70b-8192",
//           "messages": [
//             {
//               "role": "system",
//               "content":
//                   "أنت نظام تصنيف محتوى. مهمتك فقط إرجاع '0' أو '1' بدون أي شرح أو تعليق.",
//             },
//             {
//               "role": "user",
//               "content": fullPrompt,
//             }
//           ],
//           "temperature": 0.1,
//           "max_tokens": 1,
//         },
//       );

//       final result = response.data['choices'][0]['message']['content'].trim();
//       final isSafe = result == "0";
//       debugPrint('📊 [Groq - Bad Words] Result: ${isSafe ? "Safe" : "Unsafe"}');
//       return isSafe;
//     } catch (e) {
//       debugPrint('❌ [Groq - Bad Words] Error: $e');
//       _showErrorSnackBar("حدث خطأ أثناء التحقق من المحتوى");
//       return false;
//     }
//   }

//   Future<void> _checkContent() async {
//     if (_isLoading) return;
//     setState(() => _isLoading = true);

//     try {
//       final fullText = "${_titleController.text}\n${_contentController.text}";
//       debugPrint('\n=== STARTING CONTENT VALIDATION ===');

//       debugPrint('\n🔍 STEP 1: Checking for bad words');
//       final localModelHasBadWords =
//           await LocalModelService.hasBadWords(fullText);

//       final isGroqSafe = await _checkWithGroq();

//       debugPrint('\n📝 BAD WORDS VALIDATION RESULTS:');
//       debugPrint(
//           '• Local Model: ${localModelHasBadWords ? "Has bad words" : "Clean"}');
//       debugPrint('• Groq: ${isGroqSafe ? "Safe" : "Unsafe"}');

//       if (localModelHasBadWords && !isGroqSafe) {
//         debugPrint('\n❌ REJECTED: Both models detected bad words');
//         _rejectPost();
//         _showErrorSnackBar('المحتوى غير لائق');
//         return;
//       }

//       if (!localModelHasBadWords && !isGroqSafe) {
//         debugPrint('\n❌ REJECTED: Groq detected bad words (local model clean)');
//         _rejectPost();
//         _showErrorSnackBar('المحتوى غير لائق');
//         return;
//       }

//       debugPrint('\n✅ PASSED BAD WORDS CHECK - Proceeding to fake news check');
//       // Proceed to fake news check if passed bad words check
//       await _checkFakeNews(fullText);
//     } catch (e) {
//       debugPrint('\n❌ ERROR DURING VALIDATION: $e');
//       _showErrorSnackBar("حدث خطأ أثناء التحقق من المحتوى: ${e.toString()}");
//     } finally {
//       setState(() => _isLoading = false);
//       debugPrint('=== VALIDATION COMPLETED ===\n');
//     }
//   }

//   Future<void> _checkFakeNews(String fullText) async {
//     try {
//       debugPrint('\n🔍 STEP 2: Checking for fake news');

//       final localModelIsFake = await LocalModelService.isFakeNews(fullText);

//       final isGroqFakeNews = await _checkFakeNewsWithGroq(fullText);

//       debugPrint('\n📝 FAKE NEWS VALIDATION RESULTS:');
//       debugPrint('• Local Model: ${localModelIsFake ? "Fake" : "Real"}');
//       debugPrint('• Groq: ${isGroqFakeNews ? "Fake" : "Real"}');

//       if ((localModelIsFake && !isGroqFakeNews) ||
//           (!localModelIsFake && !isGroqFakeNews)) {
//         debugPrint('\n✅ ACCEPTED: Content is valid');
//         _acceptPost();
//       } else {
//         debugPrint('\n❌ REJECTED: Fake news detected');
//         _rejectPost();
//         _showErrorSnackBar('المحتوى يحتوي على معلومات مزيفة');
//       }
//     } catch (e) {
//       debugPrint('\n❌ ERROR DURING FAKE NEWS CHECK: $e');
//       _showErrorSnackBar("حدث خطأ أثناء التحقق من صحة المحتوى");
//       _rejectPost();
//     }
//   }

//   Future<bool> _checkFakeNewsWithGroq(String text) async {
//     try {
//       final String fakeNewsPrompt =
//           "أنت نظام تحكيم محتوى. مهمتك فقط إرجاع 0 أو 1 بناء على التالي:\n"
//           "1 إذا كان النص يحتوي على معلومات مزيفة\n"
//           "0 إذا كان النص حقيقي وموثوق\n"
//           "لا تشرح ولا تعلق فقط أعد 0 أو 1\n"
//           "النص: $text";

//       debugPrint('🔍 [Fake News Check] Sending request to Groq');

//       final response = await _dio.post(
//         'https://api.groq.com/openai/v1/chat/completions',
//         options: Options(
//           headers: {
//             "Authorization": "Bearer $_apiKey",
//             "Content-Type": "application/json",
//           },
//         ),
//         data: {
//           "model": "llama3-70b-8192",
//           "messages": [
//             {
//               "role": "system",
//               "content":
//                   "أنت نظام تصنيف محتوى. مهمتك فقط إرجاع '0' أو '1' بدون أي شرح أو تعليق.",
//             },
//             {
//               "role": "user",
//               "content": fakeNewsPrompt,
//             }
//           ],
//           "temperature": 0.1,
//           "max_tokens": 1,
//         },
//       );

//       final result = response.data['choices'][0]['message']['content'].trim();
//       final isFake = result == "1";
//       debugPrint('📊 [Groq - Fake News] Result: ${isFake ? "Fake" : "Real"}');
//       return isFake;
//     } catch (e) {
//       debugPrint('❌ [Groq - Fake News] Error: $e');
//       throw 'Fake news check with Groq failed: $e';
//     }
//   }

//   void _acceptPost() {
//     if (_isVideo &&
//         _selectedMedia != null &&
//         !_selectedMedia!.path.endsWith('.mp4')) {
//       _showErrorSnackBar("يجب اختيار ملف فيديو بصيغة MP4");
//       return;
//     }

//     if (!_isVideo &&
//         _selectedMedia != null &&
//         !['.jpg', '.jpeg', '.png']
//             .any((ext) => _selectedMedia!.path.endsWith(ext))) {
//       _showErrorSnackBar("يجب اختيار صورة بصيغة JPG أو JPEG أو PNG");
//       return;
//     }

//     context.read<PostCubit>().addPost(
//           AddPostModel(
//             title: _titleController.text,
//             content: _contentController.text,
//             image: !_isVideo ? _selectedMedia : null,
//             video: _isVideo ? _selectedMedia : null,
//           ),
//         );
//   }

//   void _rejectPost() {
//     PostStateDialog.showBottomPopup(context, false);
//   }

//   void _onTextChanged() {
//     setState(() {
//       isButtonActive = _titleController.text.trim().isNotEmpty &&
//           _contentController.text.trim().isNotEmpty;
//     });
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 85,
//     );

//     if (pickedFile != null) {
//       final fileExtension = pickedFile.path.split('.').last.toLowerCase();
//       if (!['jpg', 'jpeg', 'png'].contains(fileExtension)) {
//         _showErrorSnackBar(
//             "نوع الملف غير مدعوم. يرجى اختيار صورة (JPG/JPEG/PNG)");
//         return;
//       }

//       setState(() {
//         _selectedMedia = pickedFile;
//         _isVideo = false;
//       });
//     }
//   }

//   Future<void> _pickVideo() async {
//     final pickedFile = await ImagePicker().pickVideo(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       final fileExtension = pickedFile.path.split('.').last.toLowerCase();
//       if (fileExtension != 'mp4') {
//         _showErrorSnackBar("نوع الملف غير مدعوم. يرجى اختيار فيديو (MP4)");
//         return;
//       }

//       setState(() {
//         _selectedMedia = pickedFile;
//         _isVideo = true;
//       });
//     }
//   }

//   void _removeMedia() {
//     setState(() {
//       _selectedMedia = null;
//     });
//   }

//   void _handlePostPressed() {
//     if (!_isLoading && isButtonActive) {
//       if (_titleController.text.trim().length < 3) {
//         _showErrorSnackBar("يجب أن يكون العنوان من 3 إلى 100 حرف");
//         return;
//       }

//       if (_titleController.text.trim().length > 100) {
//         _showErrorSnackBar("يجب أن لا يتجاوز العنوان 100 حرف");
//         return;
//       }

//       if (_contentController.text.trim().length < 10) {
//         _showErrorSnackBar("يجب أن يكون المحتوى من 10 إلى 5000 حرف");
//         return;
//       }

//       if (_contentController.text.trim().length > 5000) {
//         _showErrorSnackBar("يجب أن لا يتجاوز المحتوى 5000 حرف");
//         return;
//       }

//       _checkContent();
//     }
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: AppStyles.styleMedium14.copyWith(color: Colors.white),
//         ),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _titleController.removeListener(_onTextChanged);
//     _contentController.removeListener(_onTextChanged);
//     _titleController.dispose();
//     _contentController.dispose();
//     _speech.stop();
//     super.dispose();
//   }

//   Widget _buildMediaPreview() {
//     if (_selectedMedia == null) return const SizedBox.shrink();

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 200,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: AppColors.whiteColor,
//             ),
//             child: _isVideo
//                 ? const Icon(Icons.videocam, size: 50, color: Colors.grey)
//                 : Image.file(File(_selectedMedia!.path)),
//           ),
//           Positioned(
//             top: 8,
//             right: 8,
//             child: GestureDetector(
//               onTap: _removeMedia,
//               child: Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.black54,
//                 ),
//                 child: const Icon(
//                   Icons.close,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PostCubit, PostState>(
//       builder: (context, state) {
//         _isLoading = state is PostLoading;

//         return SingleChildScrollView(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Top Row: Profile + Privacy + Post Button
//               Row(
//                 children: [
//                   RightPartOfRow(user: widget.user),
//                   const PrivacyInfo(),
//                   const Spacer(),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 11.w),
//                         child: SvgPicture.asset(
//                           Assets.svgsClock,
//                           width: 25.w,
//                           height: 25.h,
//                         ),
//                       ),
//                       _isLoading
//                           ? SizedBox(
//                               width: 66.w,
//                               height: 40.h,
//                               child: const Center(
//                                 child: CircularProgressIndicator(
//                                     color: AppColors.primaryColor),
//                               ),
//                             )
//                           : AppTextButton(
//                               backgroundColor: isButtonActive
//                                   ? AppColors.primaryColor
//                                   : AppColors.inactiveButtonColor
//                                       .withOpacity(0.5),
//                               borderRadius: 20.r,
//                               buttonWidth: 66.w,
//                               buttonHeight: 40.h,
//                               buttonText: S.of(context).post,
//                               textStyle: AppStyles.styleMedium14.copyWith(
//                                 color: isButtonActive
//                                     ? AppColors.whiteColor
//                                     : Colors.grey[600],
//                               ),
//                               onPressed:
//                                   isButtonActive ? _handlePostPressed : () {},
//                             ),
//                     ],
//                   ),
//                 ],
//               ),

//               SizedBox(height: 20.h),

//               // Title Input
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: TextField(
//                   controller: _titleController,
//                   decoration: InputDecoration(
//                     hintText: 'عنوان البوست',
//                     border: InputBorder.none,
//                     hintStyle: TextStyle(color: Colors.grey[600]),
//                   ),
//                   style: AppStyles.styleMedium16
//                       .copyWith(color: AppColors.blackTextColor),
//                   maxLines: 1,
//                 ),
//               ),

//               SizedBox(height: 16.h),

//               // Content Input
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 child: TextField(
//                   controller: _contentController,
//                   decoration: InputDecoration(
//                     hintText: "موضوع البوست",
//                     border: InputBorder.none,
//                     hintStyle: TextStyle(color: Colors.grey[600]),
//                   ),
//                   style: AppStyles.styleMedium14,
//                   maxLines: null,
//                   keyboardType: TextInputType.multiline,
//                 ),
//               ),

//               SizedBox(height: 16.h),

//               // Media Preview (if selected)
//               _buildMediaPreview(),

//               SizedBox(height: 16.h),

//               // Media Buttons and Mic
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   MediaButton(
//                     icon: Assets.svgsVedio,
//                     onPressed: _pickVideo,
//                     isActive: _selectedMedia == null,
//                   ),
//                   SizedBox(width: 16.w),
//                   MediaButton(
//                     icon: Assets.svgsGallary,
//                     onPressed: _pickImage,
//                     isActive: _selectedMedia == null,
//                   ),
//                   SizedBox(width: 16.w),
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       if (_speechEnabled)
//                         AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           width: _isListening ? 40.w : 32.w,
//                           height: _isListening ? 40.h : 32.h,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: _isListening
//                                 ? AppColors.primaryColor.withOpacity(0.2)
//                                 : Colors.transparent,
//                           ),
//                         ),
//                       IconButton(
//                         padding: EdgeInsets.zero,
//                         onPressed: _speechEnabled
//                             ? () async {
//                                 if (_isListening) {
//                                   await _stopListening();
//                                 } else {
//                                   await _startListening();
//                                 }
//                               }
//                             : null,
//                         icon: Icon(
//                           _isListening ? Icons.mic : Icons.mic_none,
//                           color: _speechEnabled
//                               ? (_isListening
//                                   ? AppColors.primaryColor
//                                   : Colors.black54)
//                               : Colors.grey,
//                           size: 24.w,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
