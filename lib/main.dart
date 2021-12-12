
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Set Your User Data'),
    );
  }
}

// class AddData extends StatelessWidget {
//   var a="aman";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text("geeksforgeeks"),
//       ),
//       body:Center(
//         child: FloatingActionButton(
//           backgroundColor: Colors.green,
//           child: Icon(Icons.add),
//           onPressed: () {
//             // set->delete,update;
//
//             FirebaseFirestore.instance
//                 .collection('data').doc("user1").set({"aman":"is a good boy"});
//
//           },
//         ),
//       ),
//     );
//   }
// }



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
var name,phone,email;
bool forDisplay=false;


  void getData()async{
   await FirebaseFirestore.instance
               .collection('data').doc("user1").set({
      "Name":name,
      "Phone Number":phone,
      "Email":email,
               });

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:forDisplay==false? Container(
        child: Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Name",style:TextStyle(
                  fontWeight: FontWeight.bold
              ),

              ),
            ),
            Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField (
          onChanged: (text) {
            name = text;
          },

          decoration: InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)
              ),

              labelText: 'Enter Name',
              hintText: 'Enter Your Name'
          ),
        ),
      ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Phone Number",style:TextStyle(
                  fontWeight: FontWeight.bold
              ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField (
                onChanged: (text) {
                  phone = text;
                },

                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)
                    ),

                    labelText: 'Enter Phone Number',
                    hintText: 'Enter Your Phone Number'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Email",style:TextStyle(
                  fontWeight: FontWeight.bold
              ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField (
                onChanged: (text) {
                  email = text;
                },

                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)
                    ),

                    labelText: 'Enter Email',
                    hintText: 'Enter Your Email'
                ),
              ),
            ),
            RaisedButton(
              child: Text("Save Your Data"),

                onPressed: (){
                setState(() {
                  forDisplay=true;
                });

               getData();
                })


      ],
        ),

      ):Container(
        child:  StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user1').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.docs as Map<String, dynamic>;

              print("aman");
              print(data);
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(

            );
          },
        ),
      ),

    );
  }
}



