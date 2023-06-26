import 'package:flutter/material.dart';

import 'package:todo_list_task/todo.dart';

import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  // tz.initializeTimeZones();
  // await di.init();
  // await DBHelper.initDb();
  // NotifyHelper.initializeNotification();
  runApp(const Todo());
}