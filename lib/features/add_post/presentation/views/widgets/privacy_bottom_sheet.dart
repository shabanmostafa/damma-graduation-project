import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'privacy_option.dart';

class PrivacyBottomSheet {
  static void showBottomSheet(
    BuildContext context,
    String initialVisibilityOption,
    String initialCommentsOption,
    Function(String) onVisibilitySelected,
    Function(String) onCommentsSelected,
  ) {
    String selectedVisibilityOption = initialVisibilityOption;
    String selectedCommentsOption = initialCommentsOption;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrivacyOption(
                  title: S.of(context).whoCanSeeThisPost,
                  options: [
                    S.of(context).anyOne,
                    S.of(context).onlyFriends,
                    S.of(context).noOne
                  ],
                  icons: const [
                    Assets.svgsWorld,
                    Assets.svgsFriends,
                    Assets.svgsNoOne
                  ],
                  selectedOption: selectedVisibilityOption,
                  onOptionSelected: (value) {
                    setState(() {
                      selectedVisibilityOption = value;
                    });
                    onVisibilitySelected(value); // تحديث القيمة المختارة
                  },
                ),
                PrivacyOption(
                  title: S.of(context).whocancomment,
                  options: [
                    S.of(context).anyOne,
                    S.of(context).onlyFriends,
                    S.of(context).noOne
                  ],
                  icons: const [
                    Assets.svgsWorld,
                    Assets.svgsFriends,
                    Assets.svgsNoComments
                  ],
                  selectedOption: selectedCommentsOption,
                  onOptionSelected: (value) {
                    setState(() {
                      selectedCommentsOption = value;
                    });
                    onCommentsSelected(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
