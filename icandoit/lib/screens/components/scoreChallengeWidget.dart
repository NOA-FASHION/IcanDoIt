import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ScoreChallengeWidget extends StatefulWidget {
  final MediaQueryData mediaQueryData;
  final String challengeDayResult;
  final String nmbreChalleneEnCours;
  final String lottiesString;
  final String nombchallengeVallide;
  final String nbtacheVallide;
  ScoreChallengeWidget(
      this.nombchallengeVallide,
      this.mediaQueryData,
      this.nbtacheVallide,
      this.challengeDayResult,
      this.lottiesString,
      this.nmbreChalleneEnCours);

  @override
  State<ScoreChallengeWidget> createState() => _ScoreChallengeWidgetState();
}

class _ScoreChallengeWidgetState extends State<ScoreChallengeWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.nmbreChalleneEnCours);
    print("test");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 15.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Center(
                child: Text(
                  "Aujourd'hui".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(fontSize: 17),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            width: MediaQuery.of(context).size.width / 1.13,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 45.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                  offset: Offset(
                    3.0, // Move to right 10  horizontally
                    3.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
            ),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 20.0,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    // child: Container(
                    //     width: MediaQuery.of(context).size.width / 1.2,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.white70),
                    //         borderRadius: BorderRadius.circular(15),
                    //         gradient: LinearGradient(
                    //             begin: Alignment.centerLeft,
                    //             end: Alignment.centerRight,
                    //             colors: [Colors.blue, Colors.purple])),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Column(
                    //         children: [
                    //           Row(
                    //             children: [
                    //               Text(
                    //                 widget.challengeDayResult,
                    //                 style: TextStyle(
                    //                     fontWeight: FontWeight.bold,
                    //                     color: Colors.white),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     )),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 15.0,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 25.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white70),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Colors.blue,
                                                Colors.purple
                                              ])),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.nbtacheVallide.isEmpty
                                            ? "Pas d'activité"
                                            : widget.nbtacheVallide,
                                        style: GoogleFonts.playfairDisplay(
                                            fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width:
                                            widget.mediaQueryData.size.width /
                                                2.7,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white70),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Colors.blue,
                                                        Colors.purple
                                                      ])),
                                              width: widget.mediaQueryData.size
                                                      .width /
                                                  3,
                                              height: 140,
                                              child: Card(
                                                color: Colors.transparent,
                                                elevation: 25.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Lottie.asset(
                                                    widget.lottiesString,
                                                    width: 90),
                                              ),
                                            ),
                                            SizedBox(height: 25.0),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white70),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Colors.blue,
                                                        Colors.purple
                                                      ])),
                                              width: widget.mediaQueryData.size
                                                      .width /
                                                  3,
                                              height: 140,
                                              child: Card(
                                                color: Colors.transparent,
                                                elevation: 25.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Lottie.asset(
                                                          'assets/progress.json',
                                                          width: 60),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          widget
                                                              .challengeDayResult,
                                                          style: GoogleFonts
                                                              .playfairDisplay(
                                                                  fontSize: 13),
                                                          textAlign:
                                                              TextAlign.center),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            widget.mediaQueryData.size.width /
                                                2.7,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white70),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Colors.blue,
                                                        Colors.purple
                                                      ])),
                                              width: widget.mediaQueryData.size
                                                      .width /
                                                  3,
                                              height: 140,
                                              child: Card(
                                                color: Colors.transparent,
                                                elevation: 25.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Lottie.asset(
                                                          'assets/task.json',
                                                          width: 50.0),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          widget
                                                              .nmbreChalleneEnCours,
                                                          style: GoogleFonts
                                                              .playfairDisplay(
                                                                  fontSize: 13),
                                                          textAlign:
                                                              TextAlign.center),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 25.0),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white70),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Colors.blue,
                                                        Colors.purple
                                                      ])),
                                              width: widget.mediaQueryData.size
                                                      .width /
                                                  3,
                                              height: 140,
                                              child: Card(
                                                color: Colors.transparent,
                                                elevation: 5.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Lottie.asset(
                                                        'assets/challenge.json',
                                                        width: 70),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          widget
                                                              .nombchallengeVallide,
                                                          style: GoogleFonts
                                                              .playfairDisplay(
                                                                  fontSize: 13),
                                                          textAlign:
                                                              TextAlign.center),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 15.0,
                        child: Column(
                          children: [],
                        ),
                      ),
                    )
                  ],
                ))),
      ],
    );
  }
}
