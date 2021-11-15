import 'package:flutter/material.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/screens/records/record_detail_screen.dart';

class RecordCard extends StatelessWidget {
  const RecordCard({
    Key? key,
    required this.id,
    required this.dateTime,
    required this.time,
    required this.distance,
  }) : super(key: key);

  final String id;
  final String dateTime;
  final String time;
  final double distance;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0x99000000),
      elevation: 0.8,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: InkWell(
        splashColor: Colors.orangeAccent,
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            kPpageRouteBuilder(RecordDetailScreen(id: id)),
          );
        },
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          title: Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('$dateTime'),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text(
                      '$time',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      '$distance m',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right, size: 30.0),
        ),
      ),
    );
  }
}
