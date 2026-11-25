import 'package:flutter/material.dart';

import 'app_update_dialog.dart';
import 'app_update_service.dart';

class AppUpdateGate extends StatefulWidget {
  final Widget child;

  const AppUpdateGate({
    super.key,
    required this.child,
  });

  @override
  State<AppUpdateGate> createState() => _AppUpdateGateState();
}

class _AppUpdateGateState extends State<AppUpdateGate> {
  final AppUpdateService _service = AppUpdateService();
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUpdate();
    });
  }

  Future<void> _checkUpdate() async {
    if (_checked) return;
    _checked = true;

    final result = await _service.checkForUpdate();
    if (!mounted || result == null) return;

    await AppUpdateDialog.show(
      context,
      config: result.config,
      force: result.force,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
