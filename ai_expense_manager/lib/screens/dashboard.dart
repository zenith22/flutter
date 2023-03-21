import 'package:flutter/material.dart';
import 'package:ai_expense_manager/datetime_formatter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Text(
          'Dashboard - ${MyDateTimeFormatter.getFormattedDateTime(DateTime.now())}'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
