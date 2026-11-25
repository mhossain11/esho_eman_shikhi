import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import 'app_update_model.dart';

class AppUpdateService {
  static const String configUrl =
      'https://raw.githubusercontent.com/mhossain11/esho_eman_shikhi/master/app_update.json';

  Future<AppUpdateModel?> fetchUpdateConfig() async {
    try {
      final response = await http
          .get(
            Uri.parse(configUrl),
            headers: const {'Cache-Control': 'no-cache'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) return null;

      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is! Map<String, dynamic>) return null;

      return AppUpdateModel.fromJson(decoded);
    } catch (_) {
      // If the config cannot be reached, allow the app to continue.
      return null;
    }
  }

  int compareVersions(String a, String b) {
    List<int> parse(String version) {
      // Ignore an optional build suffix such as +13.
      final cleanVersion = version.split('+').first;
      return cleanVersion
          .split('.')
          .map((part) => int.tryParse(part) ?? 0)
          .toList();
    }

    final first = parse(a);
    final second = parse(b);
    final length = first.length > second.length ? first.length : second.length;

    for (var i = 0; i < length; i++) {
      final x = i < first.length ? first[i] : 0;
      final y = i < second.length ? second[i] : 0;

      if (x > y) return 1;
      if (x < y) return -1;
    }
    return 0;
  }

  Future<({AppUpdateModel config, bool force})?> checkForUpdate() async {
    final config = await fetchUpdateConfig();
    if (config == null) return null;

    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    // No update is needed if this app is already at the latest version.
    if (compareVersions(currentVersion, config.latestVersion) >= 0) {
      return null;
    }

    final belowMinimum =
        compareVersions(currentVersion, config.minimumVersion) < 0;

    return (
      config: config,
      force: belowMinimum || config.forceUpdate,
    );
  }
}
