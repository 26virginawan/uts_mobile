import 'package:flutter/material.dart';
import 'models/item.dart';
import 'package:google_fonts/google_fonts.dart';

class EntryForm extends StatefulWidget {
  final Item item;
  EntryForm(this.item);
  @override
  EntryFormState createState() => EntryFormState(this.item);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Item item;
  EntryFormState(this.item);
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
//kondisi
    if (item != null) {
      nameController.text = item.name;
      priceController.text = item.price.toString();
    }
//rubah
    return Scaffold(
      appBar: AppBar(
        title: item == null ? Text('Tambah') : Text('Ubah'),
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
// nama
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                    // borderRadius: BorderRadius.circular(25.7),
                  ),
                  labelText: 'Nama Barang',
                  labelStyle: TextStyle(color: Colors.black87),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
//
                },
              ),
            ),
// harga
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                    // borderRadius: BorderRadius.circular(25.7),
                  ),
                  labelText: 'Harga',
                  labelStyle: TextStyle(color: Colors.black87),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
//
                },
              ),
            ),
            // harga
// tombol button
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
// tombol simpan
                  Expanded(
                    child: RaisedButton(
                      color: Colors.orangeAccent,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      onPressed: () {
                        if (item == null) {
// tambah data
                          item = Item(nameController.text,
                              int.parse(priceController.text));
                        } else {
// ubah data
                          item.name = nameController.text;
                          item.price = int.parse(priceController.text);
                        }
// kembali ke layar sebelumnya dengan membawa objek item
                        Navigator.pop(context, item);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
// tombol batal
                  Expanded(
                    child: RaisedButton(
                      color: Colors.white,
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.orangeAccent),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                        color: Colors.orangeAccent.withOpacity(0.2),
                        width: 1,
                      )),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
