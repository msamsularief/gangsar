import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/klinik/klinik_bloc.dart';
import 'package:klinik/bloc/tab/tab_bloc.dart';
import 'package:klinik/bloc/tab/tab_event.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/models/app_tab.dart';
import 'package:klinik/ui/screen/map/map_page.dart';
import 'package:klinik/ui/widget/home_widget/home_appbar_widget.dart';
import 'package:klinik/ui/widget/home_widget/home_drawer_widget.dart';
import 'package:klinik/ui/screen/home/home_page.dart';
import 'package:klinik/ui/screen/profile/profile_page.dart';
import 'package:klinik/ui/screen/video/video_view.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/tab_selector.dart';

class Home extends StatefulWidget {
  final KlinikBloc klinikBloc;
  const Home({Key? key, required this.klinikBloc}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;
  bool _show = true;
  bool isScrolllingDown = false;
  bool isScrollingRight = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    myScrollController(_scrollController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ///Untuk menampilkan FAB
  void showfloatingMenu(bool show) {
    setState(() {
      _show = show;
    });
  }

  void myScrollController(ScrollController controller) {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrolllingDown) {
          isScrolllingDown = true;
          showfloatingMenu(false);
        }
      }
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrolllingDown) {
          isScrolllingDown = false;
          showfloatingMenu(true);
        }
      }
      print("Scrolling : ${controller.position.userScrollDirection}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);

    print("\n\nAPP HEIGHT : ${MediaQuery.of(context).size.height}\n\n");

    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        Widget? body;
        String? title;

        // Default screen akan berbentuk list
        bool listViewEnabled = true;

        if (activeTab == AppTab.home) {
          body = const HomePage();
        } else if (activeTab == AppTab.videos) {
          body = VideoView(
            isFromTabMenu: true,
          );
        } else if (activeTab == AppTab.profile) {
          body = ProfilePage(
            klinikBloc: widget.klinikBloc,
          );
          title = "Profile";
        } else if (activeTab == AppTab.maps) {
          body = MapPage();
          title = "Maps";
          listViewEnabled = false;
        } else {
          body = Center(
            child: Text("This Is Body of ${activeTab.toString()}"),
          );
        }

        print("SHOW : $_show\n");

        final appbarHeight = Core.getDefaultAppHeight(context) > 800
            ? Core.getDefaultAppBarHeight(context) * 1.204
            : Core.getDefaultAppBarHeight(context) * 1.005103;

        return BuildBodyWidget(
          appBar: buildHomeAppBar(
            context,
            title: title,
          ),
          endDrawer: buildHomeDrawer(context),
          body: Builder(
            builder: (context) => GestureDetector(
              onPanUpdate: (details) => details.delta.dx < 0
                  ? Scaffold.of(context).openEndDrawer()
                  : null,
              child: SizedBox(
                height: Core.getDefaultBodyHeight(context) - appbarHeight,
                child: listViewEnabled
                    ? ListView(
                        controller: _scrollController,
                        physics: ClampingScrollPhysics(),
                        children: [
                          body!,
                        ],
                      )
                    : body!,
              ),
            ),
          ),
          floatingActionButtonLocation:
              _show ? FloatingActionButtonLocation.centerFloat : null,
          floatingActionButton: _show
              ? Container(
                  height: Core.getDefaultAppHeight(context) > 800
                      ? AppBar().preferredSize.height * 1.4
                      : AppBar().preferredSize.height * 1.2,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        blurStyle: BlurStyle.normal,
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: TabSelector(
                    activeTab: activeTab,
                    onTabSelected: (tab) => tabBloc.add(UpdateTab(tab)),
                  ),
                )
              : SizedBox(),
        );
      },
    );
  }
}
