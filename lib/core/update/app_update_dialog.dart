import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_update_model.dart';

class AppUpdateDialog {
  static Future<void> show(
    BuildContext context, {
    required AppUpdateModel config,
    required bool force,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: !force,
      builder: (dialogContext) {
        return PopScope(
          canPop: !force,
          child: AlertDialog(
            title: Text(config.title),
            content: Text(config.message),
            actions: [
              if (!force)
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('পরে'),
                ),
              ElevatedButton(
                onPressed: () async {
                  final uri = Uri.tryParse(config.playStoreUrl);
                  if (uri == null ||
                      (uri.scheme != 'https' && uri.scheme != 'http')) {
                    return;
                  }

                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: const Text('এখনই আপডেট করুন'),
              ),
            ],
          ),
        );
      },
    );
  }
}
