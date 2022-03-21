import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/models/history.dart';
import 'package:klinik/ui/widget/card_widget.dart';

class HistoryItem extends StatefulWidget {
  final List<History> items;
  const HistoryItem({Key? key, required this.items}) : super(key: key);

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  late List<History> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    // widget.items
    //     .map((e) => e.id == widget.items.first.id
    //         ? _items.add(
    //             widget.items[widget.items.indexOf(e)].copy(isChecked: true),
    //           )
    //         : _items.add(e))
    //     .toList(growable: false);

    // print(_items.asMap().toString());

    return Column(
      children: _items
          .map(
            (e) => cardWidget(
              margin: const EdgeInsets.only(bottom: 8.0),
              borderRadius: BorderRadius.circular(8.0),
              backgroundColor:
                  e.isChecked ? Colors.grey.shade100 : Colors.white,
              onTap: () {
                navigateTo(
                  AppRoute.historyPreviewPage,
                  arguments: e,
                );

                print("clicked!");

                Future.delayed(
                  const Duration(milliseconds: 800),
                  () => setState(() {
                    final value = [e.copy(isChecked: true)];
                    _items.replaceRange(
                      _items.indexOf(e),
                      _items.indexOf(e),
                      value,
                    );
                    _items.removeAt(_items.indexOf(e));

                    print(_items.asMap().toString());
                  }),
                );
              },
              child: ListTile(
                key: ValueKey(e.id),
                tileColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                title: Text(
                  e.timestamp.towdMMMMy(),
                  style: const TextStyle(
                    color: Color(0xFF00213D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  e.description,
                  style: const TextStyle(
                    color: Color(0xFF00213D),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                trailing: const SizedBox(
                  height: 60,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 32.0,
                    color: Color(0xFF00213D),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
