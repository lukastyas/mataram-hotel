// import 'package:flutter/material.dart';

// class CounterWidget extends StatelessWidget {
//   final String name;
//   final ValueSetter<int> onChanged;
//   final int value;
//   final List<String> answer;

//   CounterWidget(this.name, this.onChanged, this.value, this.answer);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           // Expanded(
//           //   child: Container(
//           //     alignment: FractionalOffset.centerLeft,
//           //     padding: EdgeInsets.only(
//           //         top: 6.0, bottom: 6.0, right: 3.0, left: 10.0),
//           //     child: Text(name),
//           //   ),
//           // )
//         ]..addAll(
//             answer.map(
//               (d) =>   Container(
//                                       width: 40.0,
//                                       height: 30.0,
//                                       foregroundDecoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(5.0),
//                                         border: Border.all(
//                                           color: Colors.blueGrey,
//                                           width: 2.0,
//                                         ),
//                                       ),
//                                       child: Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                             child: TextFormField(
//                                               textAlign: TextAlign.center,
//                                               decoration: InputDecoration(
//                                                 contentPadding:
//                                                     EdgeInsets.all(8.0),
//                                                 border: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           5.0),
//                                                 ),
//                                               ),
//                                               controller: _controller,
//                                               keyboardType: TextInputType
//                                                   .numberWithOptions(
//                                                 decimal: false,
//                                                 signed: true,
//                                               ),
//                                               inputFormatters: <
//                                                   TextInputFormatter>[
//                                                 WhitelistingTextInputFormatter
//                                                     .digitsOnly
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 30.0,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: <Widget>[
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                     border: Border(
//                                                       bottom: BorderSide(
//                                                         width: 0.5,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   child: InkWell(
//                                                     child: Icon(
//                                                       Icons.arrow_drop_up,
//                                                       size: 10.0,
//                                                     ),
//                                                     onTap: () {
//                                                       int currentValue =
//                                                           int.parse(
//                                                               _controller.text);
//                                                       currentValue++;
//                                                       _controller.text =
//                                                           (currentValue)
//                                                               .toString(); //
//                                                     },
//                                                   ),
//                                                 ),
//                                                 InkWell(
//                                                   child: Icon(
//                                                     Icons.arrow_drop_down,
//                                                     size: 10.0,
//                                                   ),
//                                                   onTap: () {
//                                                     int currentValue =
//                                                         int.parse(
//                                                             _controller.text);
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//             ),
//           ),
//       ),
//     );
//   }
// }
