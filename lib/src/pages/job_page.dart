import 'dart:convert';
import 'package:flutter_smart_course/src/pages/create_jobs.dart';
import 'package:flutter_smart_course/src/pages/job_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
class JobsPage extends StatelessWidget {
  
  JobsPage({Key key}) : super(key: key);
  double width;
  ScrollController _scrollController = ScrollController();

  getData()async{
    String url = "https://worker-dot-workytest.el.r.appspot.com/";
    var res = await http.get(Uri.encodeFull(url),headers:{"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
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
            color: Colors.pink,
            ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, LightColor.lightOrange)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, LightColor.darkOrange)),
              Positioned(
                  top: -230,
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
                            "Job",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),   
                          IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                iconSize: 25.0,
                                onPressed: () {
                                  Navigator.of(context).push(_createRoute_create());
                                  },
                            ),                       
                        ],
                      ),
                    ],
                )))
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

  Widget _createNewJob(BuildContext context,double height){
    return Container(      
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: LightColor.lightOrange),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.white),
                iconSize: 50.0,
                onPressed: () {
                  Navigator.of(context).push(_createRoute_create());
                },
              ),
              SizedBox(width: 5.0),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 2.0),
                    Text(
                      'Create a New Gig',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                        ),
                        SizedBox(height: 4.0),
                    Text(
                        'Click here ',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 10.0),
                      ),
                  ],
                ),
              ),
              // SizedBox(width: 40.0),
              // Padding(
              //   padding: EdgeInsets.only(left: 15),
              //   child: IconButton(
              //   icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              //   iconSize: 30.0,
              //   onPressed: () {
              //     Navigator.of(context).push(_createRoute_create());
              //     },
              //   )              
             // )              
            ],
        ),      
    );
  }

 Widget _body(BuildContext context){
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 70),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(20.0, 6.0, 15.0, 20.0),
                  //   child:_createNewJob(context,50),
                  // ),
                  // SizedBox(height: 20),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
                  //   child:Text(
                  //     "Your Gigs",                      
                  //     ),
                  //   ),
                    SizedBox(height: 20),                  
                  // Padding(
                  //   // padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
                  //   padding: EdgeInsets.only(left: 10.0,right: 10,bottom: 20,top: 10),
                    // padding: EdgeInsets.only(left: 10.0,right: 10,bottom: 20,top: 10),
                    FutureBuilder(
                            future: getData(),
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              List snap = snapshot.data;
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(heightFactor: 12,
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
                                  return Container(
                                      width: 200,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        color: Colors.pink,
    
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: Icon(Icons.work, size: 50),
                                              title: Text("${snap[index]['jobTitle']}", style: TextStyle(color: Colors.white,fontSize: 20)),
                                              subtitle: Text('${snap[index]['jobLocation']}', style: TextStyle(color: Colors.white)),
                                              trailing: Text("${snap[index]['jobPrice']}\$", style: TextStyle(color: Colors.white)), 
                                              onTap:()=>Navigator.of(context).push(_createRoute_details("${snap[index]['JobID']}","${snap[index]['jobTitle']}","${snap[index]['jobType']}","${snap[index]['jobPrice']}","${snap[index]['jobLocation']}","${snap[index]['jobDescription']}","${snap[index]['jobMobileNumber']}","${snap[index]['jobEmail']}")), 
                                            ),
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
                                  // Card(
                                  //   child:SingleChildScrollView(
                                  //     child:ListTile(
                                  //     leading: Icon(Icons.work),
                                  //     title: Text("${snap[index]['jobTitle']}"),
                                  //     subtitle:  Text("${snap[index]['jobLocation']}"),
                                  //     enabled: true,
                                  //     dense: true,
                                  //     onTap: ()=>Navigator.of(context).push(_createRoute_details("${snap[index]['JobID']}","${snap[index]['jobTitle']}","${snap[index]['jobType']}","${snap[index]['jobPrice']}","${snap[index]['jobLocation']}","${snap[index]['jobDescription']}","${snap[index]['jobMobileNumber']}","${snap[index]['jobEmail']}")),
                                  //     onLongPress: (){
                                  //       // do something else
                                  //     },
                                  //   trailing: Text("${snap[index]['jobPrice']}\$"), 
                                  // )));
                                },
                              );
                            },
                        ),                           // ),
                ],
                  ),
    ));
 }
Widget _gap(){
  return Container(
      decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(0.0),
              color: Colors.white,
            ),
      margin: EdgeInsets.symmetric(vertical: 85,horizontal: 0),
      height: 10,
        
    );
}
   

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false ,       
      body:Container(        
            child: Stack(
                children: <Widget>[                             
                _body(context),
                _header(context), 
                ],
            ),          
          ),            
      );    
  
  }

Route _createRoute_details(String jobID, String s, String s1, String s2, String s3, String s4, String s5, String s6) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => JobDetails(jobID,s, s1,  s2,  s3,  s4,  s5,  s6),
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
Route _createRoute_create() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CreateJob(),
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
}
