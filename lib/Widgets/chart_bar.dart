import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  //final double total;
  final double expended;
  final double expendedPercent;
  final double earnedPercent;
  final double earned;

  ChartBar(
    this.earned,
    this.label,
    this.expended,
    this.expendedPercent,
    this.earnedPercent,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          color: Colors.grey[350],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(
                    '৳${(earned - expended).toStringAsFixed(0)}',
                    style: TextStyle(
                        color:
                            (earned - expended) < 0 ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: constraints.maxHeight * 0.60,
                    width: 10,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        FractionallySizedBox(
                          heightFactor: expendedPercent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.60,
                    width: 10,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        FractionallySizedBox(
                          heightFactor: earnedPercent,
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.15,
                padding: EdgeInsets.only(bottom: 15),
                child: FittedBox(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.blue[900],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
