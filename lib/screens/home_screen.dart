import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[_RecipesCard(context), _RecipesCard(context)],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Acción al presionar el botón flotante
          _showBottom(context);
        },
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (contexto) => Container(
        width: MediaQuery.of(context).size.width,
        height: 500,
        color: Colors.white,
        child: RecipeForm(),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://armonicacafe.com/cdn/shop/files/Capuccinoycarrotcake.jpg?v=1751389753',
                    fit: BoxFit
                        .cover, // ajusta la imagen al tamaño del container
                  ),
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

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Form(
        // key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Recipe',
              style: TextStyle(color: Colors.deepPurple, fontSize: 24),
            ),
            SizedBox(height: 16),
            _buildTextField(label: 'Recipe Name'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.deepPurple,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
