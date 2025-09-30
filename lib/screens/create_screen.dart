import 'package:flutter/material.dart';
import 'package:manajemen_keuangan/db/database_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int _value = 1;

  void initState(){
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Halaman Tambah",),
          backgroundColor: Colors.green,
          //leading widget kiri
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);//Kembali ke halaman sebelumnya
            },
            
          ), 
          foregroundColor: Colors.white,),
        // body: SafeArea(child: Column(
        //diubah jadi child: Padding dengan block kemudian pilih padding.
        body: SafeArea(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          
            //untuk supaya children nama di sebelah mana(start = kiri)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama" ,style: TextStyle(color: Colors.blue),),
              TextField( 
              controller: nameController,
              style: TextStyle(color: Colors.red),),
              SizedBox(
                height: 20,
              ),
              Text("Tipe Transaksi"),
              ListTile(
                title: Text("Pemasukkan"),
                leading:Radio(groupValue:_value ,value: 1, onChanged: (value) {
                  setState(() {
                    _value = int.parse(value.toString());
                  });
                }),
              ),
              ListTile(
                title: Text("Pengeluaran"),
                leading:Radio(groupValue:_value ,value: 2, onChanged: (value) {
                    setState(() {
                    _value = int.parse(value.toString());
                  });
                },)
              ),
                          SizedBox(
                height: 20,
              ),
              Text("Total"),
              SizedBox(height: 20,),
              TextField(

                controller: totalController,
              ),
              
             ElevatedButton(
               onPressed: () async{
                 int idInsert = await databaseInstance.insert({
                  'name': nameController.text,
                  'type': _value,
                  'total': totalController.text,
                  'created_At': DateTime.now().toString(),
                  // 'update_At': DateTime.now().toString(),
                 }) ;
                 print("Sudah Masuk : " + idInsert.toString());
                 Navigator.pop(context);

               },
               
              child: Text("Simpan"))
            ],
          
          ),
        )),
    );
  }
}
