import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditProfile2 extends StatefulWidget {
  @override
  EditProfile2State createState() => EditProfile2State();
}

class EditProfile2State extends State<EditProfile2> {
  String? _selectedLocation = 'Male';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _Address = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = "Dat@gmail.com";
    _Address.text = "Huế, Hương Sơ";
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl:
                "https://cdn.mobilecity.vn/mobilecity-vn/images/2023/08/hinh-nen-genshin-impact-4k-pc-10-jpeg.jpg",
            width: width,
            height: height / 2.5,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: height / 4),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 16),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "https://cdn.mobilecity.vn/mobilecity-vn/images/2023/08/hinh-nen-genshin-impact-4k-pc-10-jpeg.jpg",
                                          width: 120,
                                          height: 80),
                                    ),
                                    SizedBox(width: 24),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Name",
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "user email",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 35,
                                  height: 35,
                                  child: FloatingActionButton(
                                    onPressed: () {},
                                    child:
                                        Icon(Icons.edit, color: Colors.black),
                                    backgroundColor: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24))),
                          child: Container(
                            width: width,
                            height: height,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Address",
                                ),
                                TextField(
                                  controller: _Address,
                                  decoration: InputDecoration(
                                    hintText: "Address",
                                  ),
                                ),
                                Theme(
                                  data: ThemeData.light(),
                                  child: DropdownButton<String>(
                                    value: _selectedLocation,
                                    items: <String>['Female', 'Male']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedLocation = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              width: width,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.yellow, Colors.yellow]),
              ),
              child: Text(
                "Save",
              ),
            ),
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EditProfile2(),
  ));
}
