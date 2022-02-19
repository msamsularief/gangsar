import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:klinik/helper/date_formatter.dart';

class HplView extends StatelessWidget {
  final DateTime initDate;
  const HplView({Key? key, required this.initDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentDate = Jiffy(DateTime.now().toLocal());
    final diference = Jiffy(initDate);

    final jiffy = currentDate.diff(diference, Units.MONTH);

    // final jiffy = Jiffy(initDate).startOf(Units.MONTH).fromNow();

    print("JIFFY : $jiffy");

    List<int> months = List.generate(9, (index) => index, growable: false);
    print("MONTHS : $months");
    print("INITIAL DATE : $initDate");
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          color: Colors.white.withOpacity(0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Perkiraan kelahiran berdasarkan tanggal awal kehamilan.",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 24.0,
                      wordSpacing: 0.6,
                      letterSpacing: 0.8,
                    ),
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Tanggal awal kehamilah : " + initDate.toString().todMMMMy(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                      wordSpacing: 0.6,
                      letterSpacing: 0.8,
                    ),
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: months.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8.0,
                    blurStyle: BlurStyle.solid,
                    color: Colors.purple.shade100.withOpacity(0.2),
                    offset: Offset(1.0, 0.8),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    blurRadius: 8.0,
                    blurStyle: BlurStyle.solid,
                    color: Colors.blueGrey.shade200.withOpacity(0.2),
                    offset: Offset(1.8, 2.8),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: months[i] + 1 <= jiffy
                      ? Colors.grey.shade200
                      : Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                child: Text(
                  "${months[i] + 1}",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 40.0,
                      ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
