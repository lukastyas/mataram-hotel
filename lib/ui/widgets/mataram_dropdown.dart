part of 'widgets.dart';

class MataramDropdown extends StatelessWidget {
  final String name;
  final ValueChanged<bool> onChangedCheckBox;
  final ValueChanged<dynamic> onChangedDropDown;
  final int value;
  final List<Map<String, dynamic>> answers;
  final dynamic valueDropdown;
  final bool valueCheckbox;
  final bool checkList;

  const MataramDropdown(
      {this.name,
      this.onChangedCheckBox,
      this.onChangedDropDown,
      this.value,
      this.answers,
      this.valueDropdown,
      this.valueCheckbox,
      this.checkList = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Expanded(
            //   flex: 2,
            //   child: Container(
            //     height: 40.0,
            //     alignment: Alignment.centerLeft,
            //     child: Text(name),
            //   ),
            // ),
            Expanded(
              flex: 8,
              child: Container(
                height: 40.0,
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                      color: Color(0xffFCFAFA),
                    ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    items: answers
                        .map(
                          (Map<String, dynamic> item) =>
                              DropdownMenuItem<String>(
                            value: item["value"],
                            child: Row(
                              children: <Widget>[
                                checkList == false
                                    ? Container()
                                    : Checkbox(
                                        onChanged: onChangedCheckBox ??
                                            (bool value) {},
                                        value: valueCheckbox,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item["name"],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: onChangedDropDown ?? (v) {},
                    value: valueDropdown,
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Select value'),
                    ),
                  ),
                ),
              ),
            )
          ]

          // Container(
          //   width: MediaQuery.of(context).size.width / 1,
          //   padding: const EdgeInsets.only(
          //       top: 6.0, bottom: 6.0, right: 0.0, left: 3.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       answers.map(
          //                             (d) => Center(
          //             child: DropdownButton(
          //           items: [
          //             DropdownMenuItem(
          //               child: Row(
          //                 children: <Widget>[
          //                   Checkbox(
          //                     onChanged: (bool value) {},
          //                     value: valueDropdown,
          //                   ),
          //                   Text(d),
          //                 ],
          //               ),
          //             ),
          //           ],
          //           onChanged: (value) {},
          //           hint: Text('Select value'),
          //         )),
          //       ),
          //       Radio(
          //         value: answers.indexOf(d),
          //         groupValue: value,
          //         onChanged: onChanged,
          //       ),
          //       Text(
          //         d,
          //         style: TextStyle(fontSize: 12),
          //       ),
          //     ],
          //   ),
          // ),

          ),
    );
  }
}
