import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_solve_paging/booking_history_wating_status.dart';
import 'package:flutter_solve_paging/provider_get_status.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

GlobalKey _contentKey = GlobalKey();
GlobalKey _refesherKey = GlobalKey();

class _ListViewPageState extends State<ListViewPage> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  static const int take = 4;

  @override
  Widget build(BuildContext context) {

    void _onRefresh() async {
      print("_onRefresh");
      await Future.delayed(Duration(milliseconds: 1000));

      Provider.of<ProviderGetStatus>(context, listen: false).clearData();

      Provider.of<ProviderGetStatus>(context, listen: false).fetchStatusPage(
          take: take,
          skip: Provider.of<ProviderGetStatus>(context, listen: false)
              .items
              .length);

      // setState(() {
      _refreshController.refreshCompleted();
      //});
    }

    void _onLoading() async {
      print("_onLoading");
      Provider.of<ProviderGetStatus>(context, listen: false).fetchStatusPage(
          take: take,
          skip: Provider.of<ProviderGetStatus>(context, listen: false)
              .items
              .length);
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.loadComplete();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("load"),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        key: _refesherKey,
        enablePullUp: true,
        enablePullDown: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
//        physics: BouncingScrollPhysics(),
//        footer: ClassicFooter(
//          loadStyle: LoadStyle.ShowWhenLoading,
//        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: FutureBuilder(
          future: Provider.of<ProviderGetStatus>(context, listen: false)
              .fetchStatusPage(
              take: take,
              skip: Provider.of<ProviderGetStatus>(context, listen: false)
                  .items
                  .length),
          builder: (context, AsyncSnapshot snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.none:
              //  todo  handel error
                return Text("ConnectionState Error");
                break;
              case ConnectionState.done:
                if (snapShot.hasError) {
                  return Text("ConnectionState Error");
                } else {
                  final productsData =
                      Provider.of<ProviderGetStatus>(context).items;

                  if (productsData.length == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child:   Text("No Data")),
                      ],
                    );
                  } else {
                    final productsStatus =
                        Provider.of<ProviderGetStatus>(context).items;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          child: ListView.builder(
                            key: _contentKey,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(), //  BouncingScrollPhysics
                            itemBuilder: (context, position) {
                              return Container(
                                child: ChangeNotifierProvider.value(
                                  value: productsStatus[position],
                                  child: buildBookingHistoryWaitingStatus(
                                      context, Color(0xff07c83a)),
                                ),
                              );
                            },
                            itemCount: productsStatus.length,
                          )),
                    );
                  }
                }
                break;
              default:
                return Text("ConnectionState Error");
            }
          },
        ),
      ),
    );
  }

  refreshPage() {}
}
