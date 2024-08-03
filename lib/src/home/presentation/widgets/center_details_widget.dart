import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paygo_fit/core/common/res/colours.dart';
import 'package:paygo_fit/src/home/data/models/center_details_model.dart';

class CenterDetailsWidget extends StatefulWidget {
  const CenterDetailsWidget({
    required this.centerDetails,
    super.key,
  });

  final CenterDetails centerDetails;

  @override
  State<CenterDetailsWidget> createState() => _CenterDetailsWidgetState();
}

class _CenterDetailsWidgetState extends State<CenterDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: FutureBuilder<String?>(
              future: _getImageUrl(widget.centerDetails.centerImageUrl),
              builder: (context, snapshot) {
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

                return Image.network(
                  snapshot.data!,
                  height: 232,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return IconButton(
                      onPressed: () => setState(() {}),
                      icon: const Icon(
                        Icons.restart_alt_rounded,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.centerDetails.centerName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColours.textPrimaryBlack,
                              // backgroundColor: Colors.amber,
                              // height: 1.0,
                            ),
                          ),
                          Text(
                            widget.centerDetails.centerAddress,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColours.iconGreyLight,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      Text(
                        '~ ${widget.centerDetails.distance} Km',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColours.iconGreyLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${widget.centerDetails.pricePerSession} / session',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColours.textPrimaryBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Book Slot',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColours.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _getImageUrl(String imagePath) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      String downloadUrl = await storage.ref(imagePath).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error occurred while fetching the image URL: $e');
      return null;
    }
  }
}
