import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paygo_fit/core/common/res/colours.dart';

class ExcersizeTypeWidget extends StatelessWidget {
  const ExcersizeTypeWidget({
    required this.excerciseIconSVGName,
    required this.excerciseName,
    required this.onTap,
    super.key,
  });

  final String excerciseName;

  final String excerciseIconSVGName;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              excerciseIconSVGName,
              height: 44,
              width: 44,
            ),
            const SizedBox(height: 12),
            Text(
              excerciseName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColours.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
