import 'package:flutter/material.dart';
import 'package:flutter_solve_paging/appoment_status_model.dart';
import 'package:flutter_solve_paging/booking_history_wating_status.dart';
import 'package:flutter_solve_paging/provider_get_status.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  //int skip = 1;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<AppomentStatusModel> data = List();
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refesherKey = GlobalKey();
  List<AppomentStatusModel> list;

  @override
  Widget build(BuildContext context) {

    void _onRefresh() async {
      print("_onRefresh");
      await Future.delayed(Duration(seconds: 2));

      list = Provider.of<ProviderGetStatus>(context, listen: false)
          .fetchStatusPage(
          take: 2,
          skip: Provider.of<ProviderGetStatus>(context, listen: false)
              .items
              .length) as List;

      data.clear();
      // Provider.of<ProviderGetStatus>(context, listen: false).items.clear() ;
      // skip = 1;
      data.addAll(list);
      // Provider.of<ProviderGetStatus>(context, listen: false).items.addAll(list);
      setState(() {
        _refreshController.refreshCompleted();
      });
    }

    void _onLoading() async {
      print("_onLoading");
      // skip += 2;
      list = Provider.of<ProviderGetStatus>(context, listen: false)
          .fetchStatusPage(
              take: 2,
              skip: Provider.of<ProviderGetStatus>(context, listen: false)
                  .items
                  .length) as List;
      data.addAll(list);
      await Future.delayed(Duration(seconds: 2));
      setState(() async {
        _refreshController.loadComplete();
      });
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
       // physics: BouncingScrollPhysics(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: FutureBuilder(
          future: Provider.of<ProviderGetStatus>(context, listen: false)
              .fetchStatusPage(
                  take: 2,
                  skip: Provider.of<ProviderGetStatus>(context, listen: false)
                      .items
                      .length), // Provider.of<ProviderGetStatus>(context).items.length
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
                return Text("ConnectionState error");
                break;
              case ConnectionState.done:
                if (snapShot.hasError) {
                  //  snapShot.error != null
                  // todo  handel error data
                  return Text("ConnectionState error");
                } else {
                  final productsData =
                      Provider.of<ProviderGetStatus>(context).items;
                  //print("length");
                  //print(productsData);
                  //print(productsData.length);
                  if (productsData.length == 0) {
                    //print("I am in NO dATA");
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child:  Text("No Data")),
                      ],
                    );
                  } else {
                    //print("I am in FavoriteGrid");
                    final productsStatus =
                        Provider.of<ProviderGetStatus>(context).items;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          child: ListView.builder(
                        key: _contentKey,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
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
                return Text("ConnectionState error");
            }
          },
        ),
      ),
    );
  }

  refreshPage() {}
}
