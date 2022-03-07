import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class ChooseDoctor extends StatefulWidget {
  final List<String> items;
  const ChooseDoctor({Key? key, required this.items}) : super(key: key);

  @override
  State<ChooseDoctor> createState() => _ChooseDoctorState();
}

class _ChooseDoctorState extends State<ChooseDoctor> {
  bool selected = false;
  String? itemSelected;

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: "Pilih Dokter",
        titleTextSize: 28.0,
        automaticallyImplyLeading: false,
      ),
      persistentFooterButtons: [
        CustomButton.defaultButton(
          title: "Pilih Dokter",
          titleSize: 18.0,
          titleColor: Colors.white,
          titleFontWeight: FontWeight.bold,
          width: Core.getDefaultAppWidth(context),
          height: 48.0,
          onPressed: () => goBack(itemSelected),
        ),
      ],
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.items
            .map(
              (e) => ListTile(
                key: ValueKey(e),
                leading: SizedBox(
                  child: Icon(
                    Icons.account_box_rounded,
                    size: 60.0,
                  ),
                ),
                title: Text(e),
                subtitle: Text(e),
                selected: itemSelected == e ? true : false,
                selectedColor:
                    itemSelected == e ? Colors.white : Colors.transparent,
                selectedTileColor: itemSelected == e
                    ? Theme.of(context).primaryColor.withOpacity(0.4)
                    : Colors.transparent,
                onLongPress: () {
                  print(e);
                  if (itemSelected == null) {
                    setState(() {
                      itemSelected = widget.items[widget.items.indexOf(e)];
                    });
                  } else if (itemSelected != null && itemSelected != e) {
                    setState(() {
                      itemSelected = widget.items[widget.items.indexOf(e)];
                    });
                  } else {
                    print("error");
                  }
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
