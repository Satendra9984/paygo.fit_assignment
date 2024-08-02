import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paygo_fit/core/common/res/colours.dart';
import 'package:paygo_fit/core/common/res/media_res.dart';
import 'package:paygo_fit/core/common/widgets/custom_text_field.dart';
import 'package:paygo_fit/src/home/presentation/widgets/exercises_type_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _nearbyAcitivityTextController = TextEditingController();

  final ValueNotifier<int> _exerciseDisplayListNumber = ValueNotifier(5);

  final _excercisesList = <Widget>[
    ExcersizeTypeWidget(
      excerciseIconSVGName: MediaRes.gymSVG,
      excerciseName: 'Gym',
      onTap: () {},
    ),
    ExcersizeTypeWidget(
      excerciseIconSVGName: MediaRes.swimmingSVG,
      excerciseName: 'Swimming',
      onTap: () {},
    ),
    ExcersizeTypeWidget(
      excerciseIconSVGName: MediaRes.badmintonSVG,
      excerciseName: 'Badminton',
      onTap: () {},
    ),
    ExcersizeTypeWidget(
      excerciseIconSVGName: MediaRes.yogasvg,
      excerciseName: 'Yoga',
      onTap: () {},
    ),
    ExcersizeTypeWidget(
      excerciseIconSVGName: MediaRes.zumbaSVG,
      excerciseName: 'Zumba',
      onTap: () {},
    ),
    ExcersizeTypeWidget(
      excerciseIconSVGName: MediaRes.badmintonSVG,
      excerciseName: 'Badminton',
      onTap: () {},
    ),
    ExcersizeTypeWidget(
      excerciseIconSVGName: MediaRes.yogasvg,
      excerciseName: 'Yoga',
      onTap: () {},
    ),
    ExcersizeTypeWidget(
      excerciseIconSVGName: MediaRes.zumbaSVG,
      excerciseName: 'Zumba',
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              color: AppColours.primaryBackground,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'MadhaPur',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColours.textPrimaryBlack,
                    ),
                  ),
                  subtitle: Text(
                    'Road no:127, Tharumaru street...',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColours.textPrimaryBlack,
                    ),
                  ),
                  trailing: Column(
                    children: [
                      Text('Points'),
                      Text('3725'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Hello, karthik!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColours.textPrimaryBlack,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'What would you like\nto do today?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColours.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: CustomCollTextField(
                        controller: _nearbyAcitivityTextController,
                        labelText: null,
                        validator: (activity) {},
                        hintText: 'Find a nearby activity',
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColours.iconGreyLight,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.sliders,
                        // Icons.tune,
                        color: AppColours.iconGrey,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ValueListenableBuilder(
                valueListenable: _exerciseDisplayListNumber,
                builder: (context, currentListItemNumbers, _) {
                  final islistfull =
                      currentListItemNumbers == _excercisesList.length;

                  return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: currentListItemNumbers + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      if (index == currentListItemNumbers) {
                        return Center(
                          child: TextButton(
                            onPressed: () {
                              if (islistfull) {
                                _exerciseDisplayListNumber.value = 5;
                              } else {
                                _exerciseDisplayListNumber.value =
                                    _excercisesList.length;
                              }
                            },
                            child:  Text(
                              islistfull ? 'View less' : 'View all',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColours.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        );
                      }
                      return _excercisesList[index];
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
