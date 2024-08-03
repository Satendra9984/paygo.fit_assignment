class CenterDetails {
  final String centerImageUrl;
  final String centerName;
  final String centerAddress;
  final num pricePerSession;
  final num distance;

  CenterDetails({
    required this.centerImageUrl,
    required this.centerName,
    required this.centerAddress,
    required this.pricePerSession,
    required this.distance,
  });

  // Constructor to create a CenterDetails object from a JSON map
  factory CenterDetails.fromJson(Map<String, dynamic> json) {
    return CenterDetails(
      centerImageUrl: json['centerImageUrl'],
      centerName: json['centerName'],
      centerAddress: json['centerAddress'],
      pricePerSession: json['pricePerSession'] as num,
      distance: json['distance'] as num,
    );
  }

  // Method to convert a CenterDetails object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'centerImageUrl': centerImageUrl,
      'centerName': centerName,
      'centerAddress': centerAddress,
      'pricePerSession': pricePerSession,
      'distance': distance,
    };
  }
}
