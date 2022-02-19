import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/hpl/hpl.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/ui/screen/hpl/hpl_view.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';
import 'package:klinik/ui/widget/loading_widget.dart';

class HplPage extends StatefulWidget {
  final String hplKey;
  const HplPage({Key? key, required this.hplKey}) : super(key: key);

  @override
  State<HplPage> createState() => _HplPageState();
}

class _HplPageState extends State<HplPage> {
  final TextEditingController _firstDateController = TextEditingController();
  late DateTime currentDate;
  late DateTime initialDate;
  late DateTime initialFirstDate;
  late FocusNode _buttonFocus;

  bool isEditPage = false;
  bool isInputPage = false;

  bool textIsEmpty = false;
  String? errorMessage = "";

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    initialDate = DateTime.now();
    initialFirstDate = DateTime(
      currentDate.year,
      currentDate.month - 9,
    );
    _buttonFocus = FocusNode();
  }

  @override
  void dispose() {
    _buttonFocus.dispose();
    _firstDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hplBloc = BlocProvider.of<HplBloc>(context);

    DateTime? initDate;

    void _handleClick(String value) {
      switch (value) {
        case 'History':
          break;
      }
    }

    return BlocListener<HplBloc, HplState>(
      listener: (context, state) {
        if (state is HplLoaded) {
          initDate = DateTime.parse(state.dateTime);
          isEditPage = false;
          isInputPage = false;
        }
        if (state is HplSuccess) {
          initDate = DateTime.parse(state.dateTime.toString());
          isEditPage = false;
          isInputPage = false;
        }
      },
      child: BlocBuilder<HplBloc, HplState>(
        builder: (context, state) {
          if (state is HplLoading) {
            return LoadingWidget(title: 'Hari Perkiraan Lahir');
          }
          return BuildBodyWidget(
            appBar: KlinikAppBar(
              title: "Hari Perkiraan Lahir",
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isEditPage = true;
                        isInputPage = true;
                      });
                    },
                    icon: Icon(
                      Icons.edit_rounded,
                    ),
                  ),
                ),
              ],
            ),
            body:
                isEditPage == false && isInputPage == false && initDate != null
                    ? HplView(
                        initDate: initDate!,
                      )
                    : BlocBuilder<HplBloc, HplState>(
                        builder: (context, state) {
                          return _buildBody(context, hplBloc);
                        },
                      ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HplBloc hplBloc) {
    ///Unutk menambahkan data ke [Local Storage]
    void _addData() async {
      setState(() {
        hplBloc.add(
          HplButtonPressed(
            key: widget.hplKey,
            dateTime: initialDate.toLocal().toString(),
          ),
        );
        hplBloc.add(GetHplData(widget.hplKey));
      });
    }

    ///Untuk submit tanggal awal kehamilan.
    void _onSubmitted() {
      setState(() {
        _buttonFocus.unfocus();

        if (_firstDateController.text.isNotEmpty) {
          setState(() {
            textIsEmpty = false;

            _firstDateController.text = initialDate.toString().todMMMMy();
            _addData();
          });
        } else {
          if (_firstDateController.text.isEmpty) {
            textIsEmpty = true;
            errorMessage = "Tanggal tidak boleh kosong !";
          }
        }
      });
    }

    return _buildCard(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: [
            Text(
              "Penghitungan hari perkiraan kelahiran.",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    wordSpacing: 0.6,
                    letterSpacing: 0.8,
                  ),
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 8.0,
                bottom: 24.0,
              ),
              width: Core.getDefaultAppWidth(context) / 2.0,
              child: CustomFormField(
                controller: _firstDateController,
                hintText: "masukkan tanggal awal kehamilan anda",
                readOnly: true,
                textAlign: TextAlign.center,
                onTap: () async {
                  DateTime? result = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: initialFirstDate,
                    lastDate: currentDate,
                    currentDate: currentDate,
                    cancelText: "Cancel",
                    confirmText: "Ok",
                    helpText: "Pilih tanggal awal kehamilan Anda.",
                    fieldHintText: "Bulan/Tanggal/Tahun",
                    initialDatePickerMode: DatePickerMode.day,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    builder: (context, child) => child!,
                  );

                  if (result != null) {
                    setState(() {
                      _firstDateController.text = result.toString().todMMMMy();
                      initialDate = result;
                      textIsEmpty = false;
                    });
                  }
                },
              ),
            ),
            textIsEmpty
                ? Text(
                    "$errorMessage",
                    style: TextStyle(color: Color.fromARGB(255, 255, 104, 93)),
                  )
                : SizedBox(),
            Container(
              margin: EdgeInsets.only(top: !textIsEmpty ? 10.0 : 32.0),
              width: Core.getDefaultAppWidth(context),
              child: CustomButton.defaultButton(
                title: "Hitung",
                titleSize: 18.0,
                titleColor: Colors.white,
                buttonDefaultColor: Theme.of(context).primaryColor,
                titleFontWeight: FontWeight.bold,
                width: Core.getDefaultAppWidth(context),
                height: 48.0,
                onPressed: _onSubmitted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Untuk membuild `Base Card` agar tampilan lebih tertata.
  Widget _buildCard(
          {required Widget? child,
          EdgeInsetsGeometry? margin,
          double? topPadding}) =>
      Container(
        margin: margin,
        padding: EdgeInsets.fromLTRB(
          20.0,
          topPadding ?? 40.0,
          20.0,
          20.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
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
        child: child,
      );

  Widget _text(
    BuildContext context,
    String? text, {
    double? fontSize,
  }) =>
      Text(
        "$text",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: fontSize ?? 18.0,
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
      );
}
