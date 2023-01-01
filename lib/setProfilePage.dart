import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_icons_icons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    IconData create = IconData(0xe19d, fontFamily: 'MaterialIcons');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: "profile"),
              Tab(icon: Icon(CustomIcons.inhalator__1_), text: "Medications"),
              Tab(icon: Icon(CustomIcons.stethoscope),text: "Doctor"),
            ],
          ),
          title: const Text("Pippi's profile"),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(
                                    "https://www.aaaai.org/Aaaai/media/MediaLibraryRedesign/Tools%20for%20the%20Public/Conditions%20Library/Library%20-%20Asthma/skd238387sdc-mother-daugh-inhaler-cropped.jpg"),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: -15,
                              child: RawMaterialButton(
                                onPressed: () {},
                                elevation: 5.0,
                                fillColor: Color(0xFFF5F6F9),
                                child: Icon(Icons.camera_alt_outlined,
                                  color: Colors.blue,),
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size(380, 50)),
                          foregroundColor: const MaterialStatePropertyAll<
                              Color>(Colors.white),
                          backgroundColor: const MaterialStatePropertyAll<
                              Color>(Colors.blue),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30.0),
                              side: const BorderSide(width: 3,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: const <Widget>[
                            Text("Log out"),
                          ],
                        ),
                      ), //logout
                      SizedBox(height: 12),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        children: [
                                          Text("name", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                          Text("Pippi")
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(create),
                                        onPressed: () {},
                                      ),
                                    ]
                                ), //name
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("age",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                          Text("11")
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(create),
                                        onPressed: () {},
                                      ),
                                    ]
                                ), //age
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("id",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                          Text("123456789")
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(create),
                                        onPressed: () {},
                                      ),
                                    ]
                                ), //i
                              ]
                          )
                      ),
                    ]
                ),
              ),
            ),
            SingleChildScrollView(
                child: Center(
                    child:Column(
                        children: [
                          SizedBox(height: 10),
                          Card(
                            elevation: 3.5,
                            child: Column(
                                children: [
                                  Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                        gradient: LinearGradient(
                                            colors: [
                                              const Color(0xFFFF4E00),
                                              const Color(0xFFEC9F05),
                                              const Color(0xFFFF4E00),
                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 0.5, 0.8],
                                            tileMode: TileMode.mirror),
                                      ),
                                      child: Center(
                                          child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Column(
                                                  children:[
                                                    Icon(CustomIcons.inhalator__1_, color: Colors.white),
                                                    SizedBox(height: 7),
                                                    Text("Routine Inhaler",style:TextStyle(color: Colors.white))
                                                  ]
                                              )
                                          )
                                      )
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Medicine name", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                      Text("Salbutrim")
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    onPressed: () {},
                                                  ),
                                                ]
                                            ), //name
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Prescripted Dose",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                      Text("1 squeeze twice a day")
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    onPressed: () {},
                                                  ),
                                                ]
                                            ), //age
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Num of doses in bottle",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                      Text("200")
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    onPressed: () {},
                                                  ),
                                                ]
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Expiration Date",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                      Text("11/11/2026"),
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    onPressed: () {},
                                                  ),
                                                ]
                                            ), //i
                                          ]
                                      )
                                  ),
                                ]
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Card(
                            elevation: 3.5,
                            child: Column(
                                children: [
                                  Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                        gradient: LinearGradient(
                                            colors: [
                                              const Color(0xFF010280),
                                              const Color(0xFF135CC5),
                                              const Color(0xFF010280),
                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 0.5, 0.8],
                                            tileMode: TileMode.mirror),
                                      ),
                                      child: Center(
                                          child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Column(
                                                  children:[
                                                    Icon(CustomIcons.inhalator__1_, color: Colors.white),
                                                    SizedBox(height: 7),
                                                    Text("acute Inhaler",style: TextStyle(color:Colors.white))
                                                  ]
                                              )
                                          )
                                      )
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Medicine name", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                      Text("Turbuhaler")
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    onPressed: () {},
                                                  ),
                                                ]
                                            ), //name
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Prescripted Dose",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                      Text("2 squeezes when needed")
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    onPressed: () {},
                                                  ),
                                                ]
                                            ), //age
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Num of doses in bottle",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                      Text("120")
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    onPressed: () {},
                                                  ),
                                                ]
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Expiration Date",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                      Text("11/11/2026")
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    onPressed: () {},
                                                  ),
                                                ]
                                            ), //i
                                          ]
                                      )
                                  ),
                                ]
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ]
                    )
                )
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              children: [
                                Text("Doctor's name", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                Text("Dr. Strange")
                              ],
                            ),
                            IconButton(
                              icon: Icon(create),
                              onPressed: () {},
                            ),
                          ]
                      ), //name
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Doctor's Email",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                Text("DoctorStrange@gmail.com")
                              ],
                            ),
                            IconButton(
                              icon: Icon(create),
                              onPressed: () {},
                            ),
                          ]
                      ), //age
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}
