import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/tab/tab_bloc.dart';
import 'package:klinik/bloc/tab/tab_event.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/model/app_tab.dart';
import 'package:klinik/ui/screen/home/home_page.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';
import 'package:klinik/ui/widget/tab_selector.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);

    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        Widget? body;
        if (activeTab == AppTab.home) {
          body = const HomePage();
        } else {
          body = Center(
            child: Text("This Is Body of ${activeTab.toString()}"),
          );
        }
        return BuildBodyWidget(
          appBar: KlinikAppBar(
            title: "Klinik Digital",
            automaticallyImplyLeading: false,
            shadow: false,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: body,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            height: AppBar().preferredSize.height * 1.4,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(24.0),
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: TabSelector(
              activeTab: activeTab,
              onTabSelected: (tab) => tabBloc.add(UpdateTab(tab)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Container(),
          ],
        ),
      );
}
