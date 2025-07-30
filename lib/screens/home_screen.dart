import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[_RecipesCard(context), _RecipesCard(context)],
      ),
    );
  }

  Widget _RecipesCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // área principal de la aplicación.
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          // cajita con bordes y sombra
          child: Row(
            children: <Widget>[
              Container(
                // este container es una caja que contiene un widget.
                height: 125,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFFFB6C1), // color rosa claro
                ),
                child: ClipRRect(
                  // da bordes redondeados a un widget.
                  borderRadius: BorderRadius.circular(10),
                  child: Container(),
                ),
              ),
              SizedBox(width: 26),
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // centrar
                crossAxisAlignment:
                    CrossAxisAlignment.start, // alinear a la izquierda
                //apila widgets verticalmente.
                children: <Widget>[
                  Text(
                    'Capuccino',
                    style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                  ),
                  SizedBox(height: 4),
                  Container(height: 2, width: 75, color: Color(0xFFFFB6C1)),
                  Text(
                    'Café',
                    style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
