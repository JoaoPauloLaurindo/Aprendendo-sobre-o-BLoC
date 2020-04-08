import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Estudando BLoC',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Estudando BLoC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Bloc _bloc;

  // Instanciando o BLoC
  @override
  void initState() {
    _bloc = Bloc();
    super.initState();
  }

  // Dando dispose no BLoC
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Você clicou:'),
            StreamBuilder<int>(
              stream: _bloc.saida,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data} vezes',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bloc.aumentar,
        tooltip: 'Aumentar',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Bloc extends BlocBase {
  final controlador = BehaviorSubject<int>.seeded(0);
  Stream<int> get saida => controlador.stream;
  Sink<int> get entrada => controlador.sink;
  int get valor => controlador.value;

  aumentar() {
    entrada.add(valor + 1);
  }

  @override
  void dispose() {
    controlador.close();
    super.dispose();
  }
}
