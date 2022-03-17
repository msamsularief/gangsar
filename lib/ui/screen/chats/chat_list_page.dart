import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({Key? key}) : super(key: key);

  final List<String> _items = [
    "dr. John Doe 1",
    "dr. John Doe 2",
    "dr. John Doe 3"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Core.getDefaultAppWidth(context),
      height: Core.getDefaultBodyHeight(context),
      child: ListView.separated(
        shrinkWrap: true,
        // physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) => _buildList(index),
        itemCount: _items.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[100],
        ),
      ),
    );
  }

  _buildList(int index) {
    return ListTile(
      leading: Icon(
        Icons.account_box_rounded,
        size: 60.0,
      ),
      title: Text(_items[index]),
      onTap: () => navigateTo(AppRoute.chatDetail),
    );
  }
}
