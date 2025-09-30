import 'package:flutter/material.dart';
import 'package:manajemen_keuangan/db/database_instance.dart';
import 'package:manajemen_keuangan/models/transaksi_model.dart';
import 'package:manajemen_keuangan/screens/create_screen.dart';
import 'package:manajemen_keuangan/screens/update_screen.dart';
import 'package:manajemen_keuangan/splash_screen.dart';


//langkah 1
void main() {
  runApp(MyApp());
}

// langkah 2 Create class, CAll Run (Myapp())
class MyApp extends StatelessWidget {
  const MyApp({super.key});


//Langkah 3.( Ketik STL)dan return   Material APp
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
        
        title: "Management Keuangan",
        //homepage nama di aplikasi
        // home: MyHomePage(),
        // diganti menu home bya
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
    );
  }
}

//Langkah 4( Ketik STL) stl = StatelessWidget dan return Scaffold
class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});
  




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  // langkah 13
DatabaseInstance? databaseInstance;


Future _refresh() async {
  setState(() {
    
  });
}

  void initState(){
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async{
    await databaseInstance!.database();
    setState(() {
      
    });
  }
  
  //buat fungsi 1 namanya Show Alert Dialog
  showAlertDialog(BuildContext context, int idTransaksi){
    Widget okButton = TextButton(
      child: Text("yakin"),
       onPressed: () async{
        await databaseInstance!.hapus(idTransaksi);
        Navigator.of( context, rootNavigator: true).pop();
        setState((){});
       }
       );

      AlertDialog alertDialog= AlertDialog(
        title:  Text('AlertDialog Title'),
        content: Text("Anda yakin ingin menghapus ? "),
        actions: [okButton],
       );

//2. Buat Fungsi 2 untuk Show Dialog nya.
  showDialog(context: context, builder: (BuildContext content){
    return alertDialog;
  });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text("Management Keuangan",
        style:TextStyle(color: Colors.white, 
        fontWeight: FontWeight.bold,),
        ),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            icon:Icon(
              Icons.add,
              color: Colors.white,
            ),
            
            onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateScreen())).then((value){
                setState(() {});
              });
            },
          ),
          )
        ],
        // toolbarTextStyle: TextStyle(color: Colors.blue),
        // foregroundColor : Colors.white
        
      ),

         //Langkah 5. tambahkan safe areia
         //Fungsi Children untuk Rowspan: 
      body : RefreshIndicator(
        onRefresh: _refresh, 
          child : SafeArea(child: Column(children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder(future: databaseInstance!.totalPemasukan(), 
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){  
                return  Text("-");
              }else{
                if (snapshot.hasData) {
                  return Text("Total Pemasukan : RP ${snapshot.data.toString()}");
                }else{
                     return Text("");
                }
              }
            }),
                SizedBox(
              height: 20,
            ),
            FutureBuilder(future: databaseInstance!.totalPengeluaran(), 
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){  
                return  Text("-");
              }else{
                if (snapshot.hasData) {
                  return Text("Total Pemasukan : RP ${snapshot.data.toString()}");
                }else{
                     return Text("");
                }
              }
            }),
          
            //Langkah 6. Tambahkan Lis  `t
            // langah 14 pilih lampu list dan pilih List wrap with builder dan berubah menjadi Futuer builder
            FutureBuilder<List<TransaksiModel>>(
              future: databaseInstance!.getAll(),
              builder: (context, snapshot) {
          
                print('Hasil : ' + snapshot.data.toString());
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("data");
                }
          
                else{
                  if (snapshot.hasData) {
          
                    // List masukkan ke builder
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                        
                        
                        return ListTile(
                                      title: Text(snapshot.data![index].name!),
                                      subtitle: Text(snapshot.data![index].total.toString()),
                                      //Langkah 7. Tambahkan Leading(Sebelah Kiri) untuk menambahkan gambar/icon
                        leading: snapshot.data![index].type ==1?
                        Icon(
                        Icons.download,
                        color: Colors.green,   
                                      //langkah 8. Tambakan Trailing (Sebelah Kanan)  Untuk menambahkan Icon       
                                      )

                        :Icon(
                        Icons.upload,
                        color: Colors.red,   
                                      //langkah 8. Tambakan Trailing (Sebelah Kanan)  Untuk menambahkan Icon       
                         ),
                                      

                       trailing: Wrap(
                                    
                        children: [          
                          IconButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> 
                            UpdateScreen(transaksiModel: snapshot.data![index]
                            )))
                            .then((value){
                              setState(() {
                                
                              });
                            });
                          },icon: Icon(Icons.edit,
                            color:Colors.grey
                          ),
                          ),
                        //langkah 9 tambahkan sizedbox, untuk pengukuran margin
                        SizedBox(
                          width: 20,
                          height: 100,
                        ),
                        IconButton(onPressed: (){
                          showAlertDialog(context, snapshot.data![index].id!);
                        }, 
                        icon: Icon(Icons.delete, color: Colors.red,) )
                        ]
                                    
                                      ),
                                    );
                      }
                  
                      ));
              
                  
                  }else{
                    return Text("Tidak ada data");
                  }
                }
                
              }
            )
          ],)),
        
      )
    );
  }
}
