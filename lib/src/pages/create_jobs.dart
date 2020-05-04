import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_smart_course/src/helper/image_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateJob extends StatelessWidget {
  CreateJob({Key key}) : super(key: key);
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
                            "Create a Gig",
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

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
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
                        child: MyCustomForm(),
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

}

class MyCustomForm extends StatefulWidget {


  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
//global variables
DateTime _dateTimeStart_ = DateTime.now();
DateTime _dateTimeFinish_ = DateTime.now();

class MyCustomFormState extends State<MyCustomForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _jobTitle = TextEditingController(text: "");
  TextEditingController _jobType = TextEditingController(text: "");
  TextEditingController _jobPrice = TextEditingController(text: "");
  TextEditingController _jobLocation = TextEditingController(text: "");
  TextEditingController _jobWorkingHours = TextEditingController(text: "");
  TextEditingController _jobDescription = TextEditingController(text: "");
  TextEditingController _jobMobileNumber = TextEditingController(text: "");
  TextEditingController _jobEmail = TextEditingController(text: "");
  TextEditingController _userID = TextEditingController(text: "");
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  File tmpFile;
  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }
  insertData() async{
    print("imagefile");
    ImageUploadModel firstImage = images[0];
    String _imageOne =  base64Encode(firstImage.imageFile.readAsBytesSync());
    print(_imageOne);
    String url = "https://worker-insert-data-dot-workytest.el.r.appspot.com/";
    String _dateTimeStart = ((_dateTimeStart_.millisecondsSinceEpoch)/1000).toString();
    String _dateTimeFinish = ((_dateTimeFinish_.millisecondsSinceEpoch)/1000).toString();
    print(_dateTimeFinish);
    print(_dateTimeStart);
    var res = await http.post(Uri.encodeFull(url),headers:{"Accept":"application/json"},body:{
      "jobTitle":_jobTitle.text,
      "jobType":_jobType.text,
      "jobPrice":_jobPrice.text,
      "jobLocation":_jobLocation.text,
      "jobWorkingHours":_jobWorkingHours.text,
      "jobDescription":_jobDescription.text,
      "jobMobileNumber":_jobMobileNumber.text,
      "jobEmail":_jobEmail.text,
      "imageUrl":_imageOne,
      "dateTimeStart":_dateTimeStart,
      "dateTimeFinish":_dateTimeFinish,
    }
    );
    var responseBody = json.decode(res.body);
  }
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _titleAndType(_jobTitle, _jobType),
            SizedBox(height: 20,), 
            buildGridView(),
            SizedBox(height: 20,), 
            _textFields(_jobPrice,_jobLocation,_jobWorkingHours,_jobDescription,_jobMobileNumber,_jobEmail,context), 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CupertinoButton(
                  // minWidth: 100,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(duration: const Duration(seconds: 2),content: Text('Processing Data...'),backgroundColor: Colors.blue,));
                      insertData();
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(duration: const Duration(seconds: 1),content: Text('Saved!'),backgroundColor: Colors.blue,));  
                      await Future.delayed(const Duration(seconds : 3));
                      Navigator.pop(context);
                    }
                    else{
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(duration: const Duration(seconds: 1),content: Text('Error Occured'),backgroundColor: Colors.red,));
                    }                                                 
                },
                color: Colors.orange,
                child: Text('Submit',style: TextStyle(fontSize: 15)),
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
        ),
    );
  }


Widget buildGridView() {
    return Container(
      decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(10.0),
          ),
      padding: const EdgeInsets.all(8.0),
        child:Column(
          children: <Widget>[ 
            Align(
                  alignment:Alignment.center,
                  child:Text(
                    "-----------  Upload Gig Images  -----------",                      
                    ),),
                SizedBox(height: 15),       
            GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1,
            children: List.generate(images.length, (index) {
              if (images[index] is ImageUploadModel) {
                ImageUploadModel uploadModel = images[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: <Widget>[
                    Image.file(
                        uploadModel.imageFile,
                        width: 300,
                        height: 300,
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: InkWell(
                          child: Icon(
                            Icons.remove_circle,
                            size: 20,
                            color: Colors.red,
                          ),
                          onTap: () {
                            setState(() {
                              images.replaceRange(index, index + 1, ['Add Image']);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Card(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _onAddImageClick(index);
                    },
                  ),
                );
              }
            }),
      )]));
  }

   Future _onAddImageClick(int index) async {

        setState(() {
          _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
          getFileImage(index);
        });
          }

  void getFileImage(int index) async {
        //    var dir = await path_provider.getTemporaryDirectory();
        _imageFile.then((file) async {
          setState(() {
            ImageUploadModel imageUpload = new ImageUploadModel();
            imageUpload.isUploaded = false;
            imageUpload.uploading = false;
            imageUpload.imageFile = file;
            imageUpload.imageUrl = '';
            images.replaceRange(index, index + 1, [imageUpload]);
          });
        });
      }
}

Widget _titleAndType(var _jobTitle,var _jobType){
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
                "-----------  Enter Your Details Below  -----------",                      
                ),),
            SizedBox(height: 15),
            TextFormField(
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: 20,
                    decorationColor: Colors.black,//Font color change
                  ),
                controller: _jobTitle,
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
                  
                  labelText: '  Enter your Gig Title',
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
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    controller: _jobType,
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
                      labelText: '  Gig Type',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
            SizedBox(height: 20),
          ],
        ),
    );        
}
Widget _textFields(var _jobPrice,var _jobLocation,var _jobWorkingHours,var _jobDescription,var _jobMobileNumber,var _jobEmail,BuildContext context){
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
                "-----------  Select the Date  -----------",                      
                ),),
            // SizedBox(height: 15),
            // Align(
            //   alignment:Alignment.center,
            //   child:Text(
            //     "From",  
            //      style: TextStyle(color: Colors.black38),                   
            //     ),),
            SizedBox(height: 10),
            SizedBox(
              height: 100,       
              child: CupertinoDatePicker(
                initialDateTime: _dateTimeStart_,
                use24hFormat: true,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (dateTime){
                  _dateTimeStart_ = dateTime;
                  // print(dateTime);
                  // setState((){
                  //   _dateTime=dateTime;
                  // });
                },
                ),
            ), 
            SizedBox(height: 10),
            // Align(
            //   alignment:Alignment.center,
            //   child:Text(
            //     "To",    
            //     style: TextStyle(color: Colors.black38),                        
            //     ),),
            // SizedBox(height: 10),
            // SizedBox(
            //   height: 100,       
            //   child: CupertinoDatePicker(
            //     initialDateTime: _dateTimeFinish_,
            //     mode: CupertinoDatePickerMode.date,
            //     use24hFormat: true,
            //     onDateTimeChanged: (dateTime){
            //       _dateTimeFinish_ = dateTime;
            //       // print(_dateTime);
            //       // setState((){
            //       //   _dateTime=dateTime;
            //       // });
            //     },
            //     ),
            // ), 
            SizedBox(height: 20),
            Align(
              alignment:Alignment.center,
              child:Text(
                "-----------  Gig Details  -----------",                      
                ),),
            SizedBox(height: 20),
            Material(
              borderRadius: new BorderRadius.circular(8.0),
              color: Colors.white,
              child:TextFormField(
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    controller: _jobPrice,
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
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    controller: _jobLocation,
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
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.multiline,
                    maxLines:4,
                    textInputAction: TextInputAction.next,
                    controller: _jobDescription,
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
                    textCapitalization: TextCapitalization.words,
                    controller: _jobMobileNumber,
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
                      labelText: 'Mobile Number'
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
                    textCapitalization: TextCapitalization.words,
                    controller: _jobEmail,
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

