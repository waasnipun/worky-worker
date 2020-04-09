import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import 'package:flutter_smart_course/src/theme/design_course.dart';
import 'package:flutter_smart_course/src/theme/theme.dart';

class ShowJobDetails extends StatelessWidget {
String _jobTitle ;
String _jobType;
String _jobPrice ;
String _jobLocation ;
String _jobStart ;
String _jobDescription ;
String _jobMobileNumber;
String _jobEmail ;
String _userID ;
String jobTit;
var imageOne;
String jobId,jobTitle;
ShowJobDetails(this.jobId, this.jobTitle, this._jobType, this._jobPrice, this._jobLocation, this._jobDescription, this._jobMobileNumber,this._jobEmail, this.imageOne,this._jobStart, {Key key}) : super(key: key);


@override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true ,
      body:Container(        
          child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                      imageContainer(context,this.jobTitle,this.imageOne),
                      
                      ],
                    ),
                  ),
                ),
                _header(context),
              ]
            ),      
          ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
        );
    }
Widget _buildBottomNavigationBar(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50.0,
    decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.5),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: RaisedButton(
            onPressed: () {},
            color: Colors.red.withOpacity(0.9),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "CONTACT",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: RaisedButton(
            onPressed: () {},
            color: Colors.white,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 4.0,
                  ),
                  
                  Text(
                    _jobPrice,
                    style: TextStyle(color: Colors.black54,fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
 Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
          child: Container(
          height: 85,
          width: width,
          // decoration: BoxDecoration(
          //   color: LightColor.orange,
          // ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              // Positioned(
              //     top: 30,
              //     right: -100,
              //     child: _circularContainer(300, LightColor.lightOrange)),
              // Positioned(
              //     top: -100,
              //     left: -45,
              //     child: _circularContainer(width * .5, LightColor.darkOrange)),
              // Positioned(
              //     top: -180,
              //     right: -30,
              //     child: _circularContainer(width * .7, Colors.transparent,
              //         borderColor: Colors.white38)),
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
                          FlatButton(
                            onPressed: () {
                                Navigator.pop(context);
                            },
                            child: new Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            shape: new CircleBorder(),
                            color: Colors.black45,
                          ),
                          FlatButton(
                            onPressed: () {
                                //script for share
                            },
                            child: new Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            shape: new CircleBorder(),
                            color: Colors.black45,
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
   
  Widget imageContainer(BuildContext context,var jobTitle,var imgPath){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(50),bottomRight: Radius.circular(50), ),
            child: Image.memory(imgPath),
          ),
            SizedBox(height: 15),
            getTimeBoxUI(jobTitle,this._jobType,30.0),
            // Text(jobTitle,
            //   style: TextStyle(
            //       color: DesignCourseAppTheme.nearlyBlue,
            //       fontSize: 31,
            //       fontWeight: FontWeight.bold)),
            // SizedBox(height: 6,),
            //  Text(this._jobType,
            //           style: AppTheme.h6Style.copyWith(
            //             fontSize: 21,
            //             color: LightColor.grey,
            //           )),                                                               
          SizedBox(height: 5),   
          Divider(color: Colors.black54,indent: 50.0,endIndent: 50.0 ),          
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // getTimeBoxUI("DN", 'Day/Night'),
                getTimeBoxUI("Seller",'UserName',12.0),
                getTimeBoxUI( 'Date',_jobStart,12.0),
                getTimeBoxUI('Location', _jobLocation,12.0),
              ],
            ),
            getTimeBoxUI( "Description",_jobDescription,14.0),
          Divider(color: Colors.black54,indent: 50.0,endIndent: 50.0 ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // getTimeBoxUI("DN", 'Day/Night'),
                getTimeBoxUI("E-mail",_jobEmail,12.0),
                getTimeBoxUI( 'Voice',_jobMobileNumber,12.0),
              ],
            ),
        ],
      ),
    );
  }

   Widget getTimeBoxUI(String text1, String txt2, var fontSize) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.05),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              SizedBox(height: 6,),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
   Widget boxWithOnlyOneTitle(String text1,var fontSize) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.05),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}