import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override   
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reciclame',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  } 
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller;
  int currentPage=3;

  // final CollectionReference _movieCollection=Firestore.instance.collection('rutaCompactador');

  @override
  void initState() { 
    super.initState();


  //  Firestore.instance
  //   .collection('rutaCompactador')
  //   .where('Day', isEqualTo: currentPage+1)
  //   .snapshots()
  //   .listen((data) =>
  //       data.documents.forEach((doc) => print(doc['Vehicle'])));

    _controller=PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }
  Widget _bottomAction(IconData icon){
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Icon(icon),
      ),
      onTap: (){},
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 7.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction(FontAwesomeIcons.truckMoving),
            _bottomAction(FontAwesomeIcons.truck),
            SizedBox(width: 50.0,),
            _bottomAction(FontAwesomeIcons.wineBottle),
            _bottomAction(Icons.devices_other),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alert,size: 35.0,),
        onPressed: (){

        },
      ),
      body: _body(),
      // body: StreamBuilder(
      //   stream: _movieCollection.snapshots(),
      //   builder: (context,snapshot){
      //     switch (snapshot.connectionState) {
      //       case  ConnectionState.waiting:
      //         return Center(child: CircularProgressIndicator(),);
      //       default:
      //       return ListView.builder(
      //         itemCount: snapshot.data.documents.length,
      //         itemBuilder: (context,index){
      //           return Text(snapshot.data.documents[index]['Vehicle']);
      //         },
      //       );
      //     }
      //   },
      // ),
    );
  }

  Widget _body(){
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 20.0,
          ),
          _list(),
        ],
      ),
    );
  }

  Widget _pageItem(String nombre, int position){
    var _aligment;
    final selected=TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );
    final unselected=TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );

    if(position==currentPage){
      _aligment=Alignment.center;
    }else if(position>currentPage){
      _aligment=Alignment.centerRight;
    }else{
      _aligment=Alignment.centerLeft;
    }
    return Align(
      alignment: _aligment,
      child: Text(nombre,
        style: position==currentPage?selected:unselected,
      )
    );
  }
  Widget _selector(){
    return SizedBox.fromSize(
      size: Size.fromHeight(50.0),
        child: PageView(
          onPageChanged: (newPage){
            setState(() {
              currentPage=newPage; 
            });
          },
          controller: _controller,
          children: <Widget>[
            _pageItem('Lunes',0),
            _pageItem('Martes',1),
            _pageItem('Miércoles',2),
            _pageItem('Jueves',3),
            _pageItem('Viernes',4),
            _pageItem('Sábado',5),
            _pageItem('Domingo',6),
          ],
      ),
    );
  }

  Widget _list(){
    return Expanded(
      child: ListView.separated(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index)=>_item('8:00 am','10:00 am','Jr Ilo, Jr Pukara, Jr los Andes, Jr. Huascar, Av Simon Bolivar', 'Compactador N° 01'),
        separatorBuilder: (BuildContext context, int index){
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          );
        },
      ),
    );
  }

  Widget _item(String hour1,String hour2,String streets, String vehicle ){
    return ListTile(
      leading: Column(
        children: <Widget>[
          Text('Hora'),
          Text(hour1),
          Text(hour2),
        ],
      ),
      title: Text('Calles referenciales'),
      subtitle: Text(streets),
      trailing: Column(
        children: <Widget>[
          Text('Ver Mapa'),
          Icon(Icons.map),
        ],
      ),
      isThreeLine: true,
    );

  }
}