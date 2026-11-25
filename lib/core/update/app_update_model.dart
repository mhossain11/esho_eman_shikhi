class AppUpdateModel {
  final String latestVersion;
  final String minimumVersion;
  final bool forceUpdate;
  final String title;
  final String message;
  final String playStoreUrl;

  const AppUpdateModel({
    required this.latestVersion,
    required this.minimumVersion,
    required this.forceUpdate,
    required this.title,
    required this.message,
    required this.playStoreUrl,
  });

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) {
    return AppUpdateModel(
      latestVersion: json['latest_version'] as String,
      minimumVersion: json['minimum_version'] as String,
      forceUpdate: json['force_update'] as bool? ?? false,
      title: json['title'] as String? ?? 'নতুন আপডেট',
      message: json['message'] as String? ?? 'অ্যাপ আপডেট করুন।',
      playStoreUrl: json['play_store_url'] as String,
    );
  }
}
