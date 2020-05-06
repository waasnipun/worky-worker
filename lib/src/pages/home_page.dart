import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/Modules/http.dart';
import 'package:flutter_smart_course/src/pages/Show_Job_Details.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import 'package:flutter_smart_course/src/theme/theme.dart';

class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  double width;
  int items;
  String displayImage;
  @override
  void initState() {
    super.initState();
    getData();
  }
  
  int test = 0;

  getData()async{
    var main = List();
    var temp = List();
    var responseBody = await http_get("workerHome");
    for(var i in responseBody){
        if(i['jobLocation']=='Gampaha' || i['jobLocation']=='gampaha'){
          i['jobLocation']='Gampaha';
          main.add(i);
        }
        else{
          temp.add(i);
        }
      }
      main = shuffle(main)+shuffle(temp);
    return main;
  }

//shuffling data in a list
  List shuffle(List items) {
    var random = new Random();
    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }


  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
      child: Container(
          height: 85,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.lightOrange2,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, LightColor.orange)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, LightColor.lightOrange)),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                top: 35,
                left: 0,
                child: Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: <Widget>[
                      // Icon(
                      //   Icons.keyboard_arrow_left,
                      //   color: Colors.white,
                      //   size: 40,
                      // ), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Home",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          
                          IconButton(
                                icon: Icon(Icons.notifications, color: Colors.white),
                                iconSize: 25.0,
                                onPressed: () {
                                  test = 10;
                                  },
                            ),
                        ],
                      ),
                    ],
                )))
              // Positioned(
              //     top: 40,
              //     left: 0,
              //     child: Container(
              //         width: width,
              //         padding: EdgeInsets.symmetric(horizontal: 20),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             // Icon(
              //             //   Icons.keyboard_arrow_left,
              //             //   color: Colors.white,
              //             //   size: 40,
              //             // ),
              //             SizedBox(height: 10),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: <Widget>[
              //                 Text(
              //                   "Search courses",
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.w500),
              //                 ),
              //                 Icon(
              //                   Icons.search,
              //                   color: Colors.white,
              //                   size: 30,
              //                 )
              //               ],
              //             ),
              //             // SizedBox(height: 20),
              //             // Text(
              //             //   "Type Something...",
              //             //   style: TextStyle(
              //             //       color: Colors.white54,
              //             //       fontSize: 30,
              //             //       fontWeight: FontWeight.w500),
              //             // )
              //           ],
              //         )))
            ],
          )),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _categoryRow(String title) {
    return Container(
      decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(0.0),
              color: Colors.white,
            ),
      margin: EdgeInsets.symmetric(vertical: 85,horizontal: 0),
      height: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(
                  color: LightColor.extraDarkPurple,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
              width: width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 20),
                  _chip("Data Scientist", LightColor.yellow, height: 5),
                  SizedBox(width: 10),
                  _chip("Data Analyst", LightColor.seeBlue, height: 5),
                  SizedBox(width: 10),
                  _chip("Data Engineer", LightColor.orange, height: 5),
                  SizedBox(width: 10),
                  _chip("Data Scientist", LightColor.lightBlue, height: 5),
                ],
              )),
          SizedBox(height: 10)
        ],
      ),
    );
  }
  Widget _courseList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 160,),
            Align(
              alignment: Alignment.bottomCenter,
                child:FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    List snap = snapshot.data;
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        heightFactor: 12,
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(snapshot.hasError){
                      return Center(child: Text("Error!"),);
                    }
                    else if(snap.length==0){
                      return Center(child: Text("No Jobs Found"),);
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snap.length,
                      controller: _scrollController,
                      itemBuilder: (context,index){
                        var _bytesImage = Base64Decoder().convert("${snap[index]['imageUrl']}");
                        return Container(
                          alignment: Alignment.center,
                            child: Card(       
                              shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),                   
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[                                  
                                    _courceInfo(snap[index],context,
                                    _decorationContainerC(_bytesImage),_bytesImage,
                                    background: Colors.white),     
                                  // ButtonTheme.bar(
                                  //   child: ButtonBar(
                                  //     children: <Widget>[
                                  //       FlatButton(
                                  //         child: const Text('Show', style: TextStyle(color: Colors.white)),
                                  //         onPressed: ()=>Navigator.of(context).push(_createRoute_details("${snap[index]['JobID']}","${snap[index]['jobTitle']}","${snap[index]['jobType']}","${snap[index]['jobPrice']}","${snap[index]['jobLocation']}","${snap[index]['jobDescription']}","${snap[index]['jobMobileNumber']}","${snap[index]['jobEmail']}")),
                                  //       ),
                                  //       FlatButton(
                                  //         child: const Text('Delete', style: TextStyle(color: Colors.white)),
                                  //         onPressed: () {},
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                                                      
                        );
                      },
                    );
                  },
                ),
              
            ),
          ],
      ),
    );
  }

  Widget _card(
      {Color primaryColor = Colors.redAccent,
      var imgPath,
      Widget backWidget}) {
    return Container(
        height: 170,
        width: width * .34,
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: Color(0x12000000))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Image.memory(imgPath,width: 400,height: 800,scale: 0.001,),
        ));
  }

  Widget _courceInfo(var snap,BuildContext context, Widget decoration,var imageOne, {Color background}) {
    return Container(
        height: 160,
        width: width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: _card(primaryColor: background, backWidget: decoration,imgPath: imageOne),
            ),
            SizedBox(width: 7),
            Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  width: 260,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text("${snap['jobTitle']}",
                            style: TextStyle(
                                color: LightColor.purple,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                      ),
                      // CircleAvatar(
                      //   radius: 3,
                      //   backgroundColor: background,
                      // ),
                      SizedBox(
                        width: 4,
                      ),
                      Text("${snap['jobPrice']} \$",
                          style: TextStyle(
                            color: LightColor.black,
                            fontSize: 16,
                          )),
                      SizedBox(width: 10)
                    ],
                  ),
                ),                
                Text("${snap['jobType']}",
                  style: AppTheme.h6Style.copyWith(
                    fontSize: 12,
                    color: LightColor.grey,
                  )),                                     
                SizedBox(height: 15),   
                Container(
                width: 260,             
                child:Text("${snap['jobDescription']}",
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.h6Style.copyWith(
                        fontSize: 10, color: LightColor.extraDarkPurple)),    
                ),                 
                SizedBox(height: 15),
                Container(
                  width: 260,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child:_chip("${snap['jobLocation']}", LightColor.darkOrange, height: 5),
                        ),
                      SizedBox(
                          width: 30,
                      ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.black54),
                      iconSize: 20.0,
                      onPressed: () {
                        Navigator.of(context).push(_createRoute_details(snap,imageOne));
                        },
                      ),
                      SizedBox(width: 10)                          
                      // _chip(model.tag2, LightColor.seeBlue, height: 5),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ));
  }
Route _createRoute_details(var snap, var imageOne) {
  return PageRouteBuilder(
    // pageBuilder: (context, animation, secondaryAnimation) => JobDetails(jobID,s, s1,  s2,  s3,  s4,  s5,  s6),
    pageBuilder: (context, animation, secondaryAnimation) => ShowJobDetails(snap, imageOne),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  Widget _decorationContainerA() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: CircleAvatar(
            radius: 100,
            backgroundColor: LightColor.darkseeBlue,
          ),
        ),
        _smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child:
                CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
    );
  }

  Widget _decorationContainerB() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.lightOrange2,
            child: CircleAvatar(
                radius: 30, backgroundColor: LightColor.darkOrange),
          ),
        ),
        Positioned(
            bottom: -35,
            right: -40,
            child:
                CircleAvatar(backgroundColor: LightColor.yellow, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: _circularContainer(70, Colors.transparent,
              borderColor: Colors.white),
        ),
      ],
    );
  }

  Widget _decorationContainerC(var _image) {
    return Stack(
      children: <Widget>[
  
        
            
            
          
        // Positioned(
        //   bottom: -65,
        //   left: -35,
        //   child: CircleAvatar(
        //     radius: 70,
        //     backgroundColor: Color(0xfffeeaea),
        //   ),
        // ),
        // Positioned(
        //     bottom: -30,
        //     right: -25,
        //     child: ClipRect(
        //         clipper: QuadClipper(),
        //         child: CircleAvatar(
        //             backgroundColor: LightColor.yellow, radius: 40))),
        // _smallContainer(
        //   Colors.yellow,
        //   35,
        //   70,
        // ),
      ],
    );
  }

  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            child: Stack(
              children: <Widget>[    
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                  child:_courseList(),
                  ),                                                               
              _categoryRow("Start a new career"),
              _header(context), 
          ],
        ),
      )
    );
  }

}
