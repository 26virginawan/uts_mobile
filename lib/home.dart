import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:tokosepatu/DbHelper.dart';
import 'package:tokosepatu/EntryForm.dart';
import 'models/item.dart'; //pendukung program asinkron
// import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item> itemList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<Item>();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.list),
          color: Colors.black87,
          iconSize: 32,
          onPressed: () {},
        ),
        title: Text(
          "CONVERSE",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
              color: Colors.black87),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.topLeft,
          child: Text(
            "List Item",
            style:
                GoogleFonts.poppins(fontSize: 27, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: createListView()),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 20),
          child: SizedBox(
            width: 250,
            height: 50,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              color: Colors.orangeAccent,
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    "tambahkan Item",
                    style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<Item> navigateToEntryForm(BuildContext context, Item item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.orange.withOpacity(0.2),
                width: 2,
              )),
          shadowColor: Colors.black38,
          elevation: 2.0,
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        this.itemList[index].name,
                        style: GoogleFonts.poppins(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp : " + this.itemList[index].price.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.edit,
                                size: 37,
                                color: Colors.greenAccent,
                              ),
                              onTap: () async {
                                var item = await navigateToEntryForm(
                                    context, this.itemList[index]);
                                //TODO 4 Panggil Fungsi untuk Edit data
                                dbHelper.update(item);
                                updateListView();
                              },
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.delete,
                                size: 37,
                                color: Colors.redAccent,
                              ),
                              onTap: () async {
                                // //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                                dbHelper.delete(this.itemList[index].id);
                                updateListView();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Image.asset(
                  'images/2.jpg',
                  height: 100,
                  width: 150,
                ),
                margin:
                    EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
                // width: 150,
                // height: 160,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.2),
                //         spreadRadius: 2,
                //         blurRadius: 3,
                //         offset: Offset(0, 0), // changes position of shadow
                //       ),
                //     ],
                //     color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Item>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
