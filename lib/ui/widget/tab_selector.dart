import 'package:flutter/material.dart';
import 'package:klinik/models/app_tab.dart';

class TabSelector extends StatelessWidget {
  final AppTab? activeTab;
  final Function(AppTab)? onTabSelected;

  const TabSelector({
    Key? key,
    this.activeTab,
    this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      addAutomaticKeepAlives: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppTab.values.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppTab.values.length,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemBuilder: (context, index) {
        var e = AppTab.values[index];
        IconData? icon;
        String? label;
        AppTab selectedItem = e;

        if (e == AppTab.home) {
          icon = Icons.home_filled;
          label = 'Home';
        } else if (e == AppTab.videos) {
          icon = Icons.video_collection_outlined;
          label = 'Videos';
        } else if (e == AppTab.chats) {
          icon = Icons.message_rounded;
          label = 'Chats';
        } else if (e == AppTab.maps) {
          icon = Icons.map_outlined;
          label = 'Maps';
        } else if (e == AppTab.profile) {
          icon = Icons.person;
          label = 'Profile';
        }

        return _buildItems(
          onTap: () {
            onTabSelected!(e);
          },
          icon: icon,
          label: label,
          selectedItem: selectedItem,
        );
      },
    );
  }

  Widget _buildItems({
    required VoidCallback? onTap,
    IconData? icon,
    String? label,
    AppTab? selectedItem,
  }) {
    return IconButton(
      onPressed: onTap,
      alignment: Alignment.center,
      tooltip: label,
      visualDensity: VisualDensity.comfortable,
      padding: EdgeInsets.zero,
      icon: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: _buildIcon(icon, label, selectedItem),
      ),
    );
  }

  Widget _buildIcon(
    IconData? icon,
    String? label,
    AppTab? selectedItem,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: selectedItem == activeTab ? 32 : 24,
          color: selectedItem == activeTab
              ? Colors.orange.shade400
              : Colors.grey.shade500,
        ),
        Text(
          "$label",
          style: TextStyle(
            fontSize: selectedItem == activeTab ? 14 : 12,
            color: selectedItem == activeTab
                ? Colors.orange.shade400
                : Colors.grey.shade500,
            fontWeight:
                selectedItem == activeTab ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
