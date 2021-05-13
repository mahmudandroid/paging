import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_solve_paging/appoment_status_model.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';


class buildBookingHistoryWaitingStatus extends StatefulWidget {
  Color color;
  BuildContext context;

  buildBookingHistoryWaitingStatus(this.context, this.color);

  @override
  _buildBookingHistoryWaitingStatusState createState() =>
      _buildBookingHistoryWaitingStatusState();
}

bool isLoading = false;

class _buildBookingHistoryWaitingStatusState
    extends State<buildBookingHistoryWaitingStatus> {


  @override
  Widget build(BuildContext context) {
    final statusModel = Provider.of<AppomentStatusModel>(context);



    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: double.infinity,
        height: 102, //95
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: const Color(0xffffffff)),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xfff0dac5),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 17,
                ),
                // Rectangle 1010
                Container(
                  width: 240,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        statusModel.doctorName,
                        style: const TextStyle(
                            color: const Color(0xff00c8d5),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              //width: 240,
                              height: 24,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  border: Border.all(
                                      color: const Color(0xffc77070),
                                      width: 1),
                                  color: const Color(0xffffffff)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Center(
                                  child: Text(
                                       'cancellation',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: "Roboto",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.left),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  statusModel.userName,
                  style: const TextStyle(
                      color: const Color(0xff1c2340),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }


}
