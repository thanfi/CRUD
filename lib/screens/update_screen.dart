import 'package:flutter/material.dart';
import 'package:manajemen_keuangan/db/database_instance.dart';
import 'package:manajemen_keuangan/models/transaksi_model.dart';

//? langkah 8: buat createScreen StatelessWidget
class UpdateScreen extends StatefulWidget {
  final TransaksiModel transaksiModel;
  const UpdateScreen({Key? key, required this.transaksiModel})
  : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int _value = 1;

  void initState(){
    databaseInstance.database();
    nameController.text = widget.transaksiModel.name!;
    totalController.text = widget.transaksiModel.total!.toString();
    _value = widget.transaksiModel.type!;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.grey,
      title: Text('Update',
      style: TextStyle(color: Colors.white,
      fontWeight: FontWeight.bold
      ),
      ),
      ),
      //? Langkah 10: buat child column kemudian
      //? Pencet lampu untuk buat padding
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(8.0),
      //? Langkah 11: crossAxisAlignment buat bikin texfield
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama'),
          TextField(controller: nameController,),
          SizedBox( height: 30,),
          Text('Tipe Transaksi'),

          //? Langkah 12: buat Listtile & Leading radio untuk membuat pemasukan
          ListTile(
            title: Text('Pemasukan'),
            leading: Radio(groupValue: _value, value: 1, onChanged: (value){
              setState(() {
                _value = int.parse(value.toString());
              });
            }),
          ),

          //? Langkah 13: buat Listtile & Leading radio untuk membuat pengeluaran
          ListTile(
            title: Text('Pengeluaran'),
            leading: Radio(groupValue: _value, value: 1000, onChanged: (value){
              setState(() {
                _value = int.parse(value.toString());
              });
            }),
          ),
          SizedBox(height: 30,),
          Text('Total'),
          TextField(controller: totalController,),
          SizedBox(height: 30,),

          //? Langkah 14: buat elevatedButton untuk menyimpan data
           ElevatedButton(
               onPressed: () async{
                  await databaseInstance.update(widget.transaksiModel.id!,{
                  'name': nameController.text,
                  'type': _value,
                  'total': totalController.text,
                  // 'created_At': DateTime.now().toString(),
                  'update_At': DateTime.now().toString(),
                 }) ;
                 Navigator.pop(context);

               },
               
              child: Text("Update"))
        ],
      ),
    ),
    ),
    );
  }
}
