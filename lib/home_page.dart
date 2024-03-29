import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/videos.dart';
import 'color.dart' as color;
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  _launchURL() async {
    //final result = await Process.run('/usr/bin/python', ['/home/pi/cam2.py']);
    final Uri url = Uri.parse('http://0.0.0.0:5000/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch _url');
    }
  }

  List info = [];

  _initData() {
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value) {
      info = json.decode(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.AppColor.circuitsColor,
        foregroundColor: Colors.white,
        actions: [
          GestureDetector(onTap: signOut, child: const Icon(Icons.logout, size: 25.0)),
          const SizedBox(width: 20.0),
        ],
      ),
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Dashboard",
                  style: TextStyle(
                      fontSize: 30,
                      color: color.AppColor.homePageTitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: signOut,
                  child: Icon(Icons.arrow_back_ios,
                      size: 20, color: color.AppColor.homePageIcons),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(Icons.calendar_today_outlined,
                    size: 20, color: color.AppColor.homePageIcons),
                const SizedBox(
                  width: 15,
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 20, color: color.AppColor.homePageIcons),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Video Streaming",
                  style: TextStyle(
                      fontSize: 20,
                      color: color.AppColor.homePageSubtitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 20,
                    color: color.AppColor.homePageDetail,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(Icons.arrow_forward,
                    size: 20, color: color.AppColor.homePageIcons)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        color.AppColor.gradientFirst.withOpacity(0.8),
                        color.AppColor.gradientSecond.withOpacity(0.9),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.centerRight //defining the gradient
                      ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(10, 10),
                        blurRadius: 20,
                        color: color.AppColor.gradientSecond.withOpacity(0.5))
                  ]),
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                //this gains the padding for the first container
                child: Column(
                  //cross alignment divides the plane into two axis and
                  //moves the text to one-sided alignment
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMEd().format(DateTime.now()),
                      style: TextStyle(
                          fontSize: 16,
                          color: color.AppColor.homePageContainerTextSmall),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Print on process",
                      style: TextStyle(
                          fontSize: 25,
                          color: color.AppColor.homePageContainerTextSmall),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      "Metal alignment process",
                      style: TextStyle(
                        fontSize: 25,
                        color: color.AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.adjust_rounded,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("Live",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: color.AppColor.secondPageIconColor,
                                )),
                          ],
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: _launchURL,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [
                                  BoxShadow(
                                      color: color.AppColor.gradientFirst,
                                      blurRadius: 10,
                                      offset: Offset(4, 8))
                                ]),
                            child: Icon(
                              Icons.play_circle_fill,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 30),
                    height: 120,
                    //adding the image to wrap it around
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image: AssetImage("assets/card.jpg"),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 40,
                              offset: Offset(8, 10),
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.3)),
                          BoxShadow(
                              blurRadius: 10,
                              offset: Offset(-1, -5),
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.3))
                        ]),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      right: 200,
                      bottom: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/figure.png"),
                        //fit:BoxFit.fill
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 150, top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Completed Projects",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color.AppColor.homePageDetail),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: (Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return videos();
                                  }));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Videos",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: color
                                              .AppColor.homePagePlaneColor),
                                    ),
                                    Icon(
                                      Icons.double_arrow_rounded,
                                      size: 20,
                                      color: color.AppColor.homePagePlaneColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            children: [
                              RichText(
                                  text: TextSpan(
                                text: "Recorded will be"
                                    " available here\n",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: color.AppColor.homePagePlaneColor),
                              ))
                            ],
                          ),
                        ) //recorded videos available here
                      ],
                    ),
                  ),
                ], //children
              ),
            ),
            Row(
              children: [
                Text(
                  "Stock Analysis",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: color.AppColor.homePageTitle),
                )
              ],
            ), //text analysis

            //stock containers....
            Expanded(
                child: OverflowBox(
              maxWidth: MediaQuery.of(context).size.width,
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                    itemCount: (info.length.toDouble() / 2).toInt(), //2
                    itemBuilder: (_, i) {
                      int a = 2 * i;
                      int b = 2 * i + 1;
                      return Row(children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          height: 170,
                          margin:
                              EdgeInsets.only(left: 30, bottom: 15, top: 15),
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(info[a]['img']),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(5, 5),
                                    color: color.AppColor.gradientSecond
                                        .withOpacity(0.1)),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(-5, -5),
                                    color: color.AppColor.gradientSecond
                                        .withOpacity(0.1))
                              ]),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                info[a]["title"],
                                style: TextStyle(
                                    fontSize: 17,
                                    color: color.AppColor.homePageDetail),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          height: 170,
                          margin:
                              EdgeInsets.only(left: 30, bottom: 15, top: 15),
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(info[b]['img']),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(5, 5),
                                    color: color.AppColor.gradientSecond
                                        .withOpacity(0.1)),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(-5, -5),
                                    color: color.AppColor.gradientSecond
                                        .withOpacity(0.1))
                              ]),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                info[b]["title"],
                                style: TextStyle(
                                    fontSize: 17,
                                    color: color.AppColor.homePageDetail),
                              ),
                            ),
                          ),
                        ),
                      ]);
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
