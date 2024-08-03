import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paygo_fit/core/common/global_cubits/user_location_cubit/user_location_cubit.dart';
import 'package:paygo_fit/core/common/res/colours.dart';
import 'package:paygo_fit/core/common/res/media_res.dart';
import 'package:paygo_fit/core/common/widgets/custom_text_field.dart';
import 'package:paygo_fit/core/enums/loading_states.dart';
import 'package:paygo_fit/src/home/data/models/center_details_model.dart';
import 'package:paygo_fit/src/home/presentation/cubits/centers_cubit/centers_data_cubit.dart';
import 'package:paygo_fit/src/home/presentation/widgets/center_details_widget.dart';
import 'package:paygo_fit/src/home/presentation/widgets/exercises_type_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  // FOR TESTING PURPOSE ONLY
  // final List<CenterDetails> _centerDetailsModelList = [
  //   CenterDetails(
  //     centerImageUrl: '/center/images/image 18.png',
  //     centerName: 'Quad Special Workout Gym',
  //     centerAddress: 'Near Andhra Bank, Manikonda, Hyderabad',
  //     pricePerSession: 45,
  //     distance: 3.4,
  //   ),
  //   CenterDetails(
  //     centerImageUrl: '/center/images/image 106.png',
  //     centerName: 'Quad Special Workout Gym',
  //     centerAddress: 'Near Andhra Bank, Manikonda, Hyderabad',
  //     pricePerSession: 45,
  //     distance: 3.4,
  //   ),
  //   CenterDetails(
  //     centerImageUrl: '/center/images/image 18.png',
  //     centerName: 'Quad Special Workout Gym',
  //     centerAddress: 'Near Andhra Bank, Manikonda, Hyderabad',
  //     pricePerSession: 45,
  //     distance: 3.4,
  //   ),
  //   CenterDetails(
  //     centerImageUrl: '/center/images/image 106.png',
  //     centerName: 'Quad Special Workout Gym',
  //     centerAddress: 'Near Andhra Bank, Manikonda, Hyderabad',
  //     pricePerSession: 45,
  //     distance: 3.4,
  //   ),
  //   CenterDetails(
  //     centerImageUrl: '/center/images/image 18.png',
  //     centerName: 'Quad Special Workout Gym',
  //     centerAddress: 'Near Andhra Bank, Manikonda, Hyderabad',
  //     pricePerSession: 45,
  //     distance: 3.4,
  //   ),
  //   CenterDetails(
  //     centerImageUrl: '/center/images/image 106.png',
  //     centerName: 'Quad Special Workout Gym',
  //     centerAddress: 'Near Andhra Bank, Manikonda, Hyderabad',
  //     pricePerSession: 45,
  //     distance: 3.4,
  //   ),
  // ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<CentersDataCubit>().fetchCentersList();
        context.read<UserLocationCubit>().fetchCurrentAddress();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // PROFILE DETAILS AND SEARCH
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
                BlocConsumer<UserLocationCubit, UserLocationState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    final locationCubit = context.read<UserLocationCubit>();

                    if (state.locationLoadingState == LoadingStates.loading ||
                        state.locationLoadingState == LoadingStates.initial) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColours.primaryBackground,
                        ),
                      ); // Loading indicator while waiting for the URL
                    } else if (state.locationLoadingState ==
                        LoadingStates.errorLoading) {
                      return IconButton(
                        onPressed: () => locationCubit.fetchCurrentAddress(),
                        icon: const Icon(
                          Icons.restart_alt_rounded,
                        ),
                      );
                    }

                    final place = state.address!;
                    final address =
                        "${place.street}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        '${place.administrativeArea}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColours.textPrimaryBlack,
                        ),
                      ),
                      subtitle: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColours.textPrimaryBlack,
                        ),
                      ),
                      trailing: const Column(
                        children: [
                          Text('Points'),
                          Text('3725'),
                        ],
                      ),
                    );
                  },
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

          // EXCERSISE OPTIONS LIST
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
                            onPressed: () async {
                              if (islistfull) {
                                _exerciseDisplayListNumber.value = 5;
                              } else {
                                _exerciseDisplayListNumber.value =
                                    _excercisesList.length;
                              }

                              // only for testing
                              // await context
                              //     .read<CentersDataCubit>()
                              //     .addListToDb(_centerDetailsModelList);
                            },
                            child: Text(
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
          ),

          // CENTER DETAILS LIST
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: BlocConsumer<CentersDataCubit, CentersDataState>(
              listener: (context, state) {},
              builder: (context, state) {
                final centersDataCubit = context.read<CentersDataCubit>();

                if (state.loadingStates == LoadingStates.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColours.primaryBackground,
                    ),
                  ); // Loading indicator while waiting for the URL
                } else if (state.loadingStates == LoadingStates.errorLoading) {
                  return IconButton(
                    onPressed: () => centersDataCubit.fetchCentersList(),
                    icon: const Icon(
                      Icons.restart_alt_rounded,
                    ),
                  );
                }

                return StreamBuilder(
                  stream: state.centersList,
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: AppColours.primaryBackground,
                      ); // Loading indicator while waiting for the URL
                    } else if (snapshot.hasError) {
                      return IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.restart_alt_rounded,
                        ),
                      );
                    }

                    final centersList = snapshot.data ?? [];

                    return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: centersList.length,
                      itemBuilder: (ctx, index) {
                        return CenterDetailsWidget(
                          centerDetails: centersList[index],
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
