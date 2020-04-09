import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';

class JobDetails extends StatelessWidget {
String _jobTitle ;
String _jobType;
String _jobPrice ;
String _jobLocation ;
String _jobWorkingHours ;
String _jobDescription ;
String _jobMobileNumber;
String _jobEmail ;
String _userID ;
String jobTit;
  String jobId,jobTitle;
  JobDetails(this.jobId, this.jobTitle, this._jobType, this._jobPrice, this._jobLocation, this._jobDescription, this._jobMobileNumber,this._jobEmail, {Key key}) : super(key: key);
  double width;
  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
      child: Container(
          height: 85,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.orange,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, LightColor.lightOrange)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, LightColor.darkOrange)),
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
                            "Gig Details",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                                icon: Icon(Icons.close, color: Colors.white),
                                iconSize: 25.0,
                                onPressed: () {
                                  Navigator.pop(context);
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
  getData()async{
      String url = "https://worky-flutter.000webhostapp.com/getData_waas.php";
      var res = await http.get(Uri.encodeFull(url),headers:{"Accept":"application/json"});
      var responseBody = json.decode(res.body);
      return responseBody;
    }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    int id = 0;  
    List snap ;
    return Scaffold(
      resizeToAvoidBottomPadding: true ,
      body:Container(        
          child: Stack(
              children: <Widget>[
                SingleChildScrollView(            
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 110),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 6.0, 15.0, 20.0),
                        //child:_createNewJob(50),
                        child: MyCustomForm(this.jobId,this.jobTitle, this._jobType, this._jobPrice, this._jobLocation, this._jobDescription, this._jobMobileNumber,this._jobEmail),
                      ),
                    ],
                  ),
              )),
              _header(context),  
              ]
            ),      
          ),
        );
    }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class MyCustomForm extends StatefulWidget {
  String jobId,jobTitle, _jobType, _jobPrice, _jobLocation, _jobDescription, _jobMobileNumber,_jobEmail;
  MyCustomForm(this.jobId, this.jobTitle, this._jobType, this._jobPrice, this._jobLocation, this._jobDescription, this._jobMobileNumber,this._jobEmail);


  @override
  MyCustomFormState createState() {
    return MyCustomFormState(this.jobId, this.jobTitle, this._jobType, this._jobPrice, this._jobLocation, this._jobDescription, this._jobMobileNumber,this._jobEmail);
  }
}
//global variables
DateTime _dateTimeStart_ = DateTime.now();
DateTime _dateTimeFinish_ = DateTime.now();

class MyCustomFormState extends State<MyCustomForm> {
  String jobId, jobTitle, _jobType, _jobPrice, _jobLocation, _jobDescription, _jobMobileNumber,_jobEmail;
  MyCustomFormState(this.jobId, this.jobTitle, this._jobType, this._jobPrice, this._jobLocation, this._jobDescription, this._jobMobileNumber,this._jobEmail);

  
  final _formKey = GlobalKey<FormState>();
  
   deleteDataConfirm(BuildContext context,var id){
     print("id is:",);
     print(id);
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Are you sure want to delete ?"),
      actions: <Widget>[
        RaisedButton(
          child: Text("DELETE",style: TextStyle(color: Colors.white),),
          color: Colors.red,
          onPressed:(){
            deletData(id);
            Navigator.of(context,rootNavigator: true).pop('alertDialog');
            Navigator.pop(context);
            
          },
        ),
        RaisedButton(
          child: Text("CANCEL",style: TextStyle(color: Colors.white),),
          color: Colors.red,
          onPressed: () async {
                  Navigator.pop(context);
                  
              }
        )
      ],
    );
    showDialog(context: context, child:alertDialog);
  }

  deletData(var jobID)async{
    String url = "https://worky-flutter.000webhostapp.com/deleteData_waas.php";
    print("id");print(jobID);
    http.post(url,body:{
      'JobID': jobID,
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[            
            _textFields(jobTitle, _jobType, _jobPrice,_jobLocation,_jobDescription,_jobMobileNumber,_jobEmail,context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CupertinoButton(
                  // minWidth: 100,
                  onPressed: () async {
                    deleteDataConfirm(context,this.jobId);                    
                                                                  
                },
                color: Colors.red,
                child: Text('Delete',style: TextStyle(fontSize: 15)),
                // color: Colors.black,
                // textColor: Colors.white,              
                // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                // splashColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //   borderRadius: new BorderRadius.circular(18.0),
                //   side: BorderSide(color: Colors.grey)
                // ),
              ),
            ),
          ],
        );
  }
}


Widget _textFields(var jobTitle,var jobType,var jobPrice,var jobLocation,var jobDescription,var jobMobileNumber,var jobEmail,BuildContext context){
    return Container(
      decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(10.0),
          ),
      padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment:Alignment.center,
              child:Text(
                "-----------  Gig Details  -----------",                      
                ),),
            SizedBox(height: 15),
            TextFormField(
              readOnly: true,
                initialValue: jobTitle,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: 20,
                    decorationColor: Colors.black,//Font color change
                  ),
    
                decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
                  
                  labelText: '  Gig Title',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            SizedBox(height: 10),
            Material(
              borderRadius: new BorderRadius.circular(8.0),
              color: Colors.white,
              child:TextFormField(
                    readOnly: true,
                    initialValue: jobType,

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      labelText: ' Gig Type',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
            SizedBox(height: 20),
            Material(
              borderRadius: new BorderRadius.circular(8.0),
              color: Colors.white,
              child:TextFormField(
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    initialValue: jobPrice,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      prefixIcon: new Icon(
                              Icons.attach_money,
                          ),
                      labelText: 'Price'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
            SizedBox(height: 10),
            Material(
              borderRadius: new BorderRadius.circular(8.0),
              color: Colors.white,
              child:TextFormField(
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    initialValue: jobLocation,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),                     
                      prefixIcon: new Icon(
                              Icons.add_location,
                          ),
                      labelText: 'District'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
                        
            SizedBox(height: 10),
            Material(
              borderRadius: new BorderRadius.circular(8.0),
              color: Colors.white,
              child:TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines:4,
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    initialValue: jobDescription,
                    decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 10.0, right: 30.0, bottom: 50.0, left: 30.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      labelText: '   Description'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
            SizedBox(height: 20),
            Align(
              alignment:Alignment.center,
              child:Text(
                "-----------  Contact Details  -----------",                      
                ),),
            SizedBox(height: 20),
            Material(
              borderRadius: new BorderRadius.circular(8.0),
              color: Colors.white,
              child:TextFormField(
                    readOnly: true,
                    initialValue: jobMobileNumber,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      prefixIcon: new Icon(
                              Icons.call,
                          ),
                      labelText: 'Mobile Number',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if(value.length<10){
                        return 'Invalid Mobile Number';
                      }
                      return null;
                    },
               )),
            SizedBox(height: 10),
            Material(
              borderRadius: new BorderRadius.circular(8.0),
              color: Colors.white,
              child:TextFormField(
                    readOnly: true,
                    initialValue: jobEmail,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      prefixIcon: new Icon(
                              Icons.email,
                          ),
                      labelText: 'Email'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      bool check = false;
                      for(int i=0;i<value.length;i++){
                        if(value[i]=='@'){
                          check = true;
                          return null;
                        }
                      } 
                      if(check==false){
                        return 'Invalid Email Address';
                      }                     
                      return null;
                    },
                )),
                SizedBox(height: 10),
              ],
            ),
          );
        }
