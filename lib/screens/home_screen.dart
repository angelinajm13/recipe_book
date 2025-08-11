import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Future<List<dynamic>> FetchRecipes() async {
    // Android 10.0.2.2
    // iOS 127.0.0.1
    // web
    final url = Uri.parse('http://10.0.2.2:12346/recipes'); // URL de API
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['recipes'];
      } else {
        print('Error: ${response.statusCode}');
        return []; // Manejo de error
      }
    } catch (e) {
      print('Error in request');
      return []; // Manejo de error
    }
  }

  @override
  Widget build(BuildContext context) {
    // FetchRecipes();
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: FetchRecipes(),
        builder: (context, snapshot) {
          final recipes = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found'));
          } else {
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return _RecipesCard(context, recipes[index]);
              },
            );
          }
        },
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
}

Future<void> _showBottom(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (contexto) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(contexto).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(contexto).size.height * 0.5,
        ),
        width: MediaQuery.of(contexto).size.width,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: SingleChildScrollView(child: RecipeForm())),
          ],
        ),
      ),
    ),
  );
}

Widget _RecipesCard(BuildContext context, dynamic recipe) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetail(recipeName: 'name'),
        ),
      );
    },
    child: Padding(
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
                    recipe['image_link'], // URL de la imagen
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
                    '${recipe['name']}', // nombre de la receta
                    style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                  ),
                  SizedBox(height: 4),
                  Container(height: 2, width: 75, color: Color(0xFFFFB6C1)),
                  Text(
                    '${recipe['author']}', // nombre del autor
                    style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAutor = TextEditingController();
    final TextEditingController _recipeIMG = TextEditingController();
    final TextEditingController _recipeDescription = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Recipe',
              style: TextStyle(color: Colors.pink, fontSize: 22),
            ),

            _buildTextField(
              controller: _recipeName,
              label: 'Recipe Name',
              icon: Icons.restaurant_menu,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a recipe name';
                }
                return null;
              },
            ),
            SizedBox(height: 14),

            _buildTextField(
              controller: _recipeAutor,
              label: 'Autor Name',
              icon: Icons.category,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a autor recipe name';
                }
                return null;
              },
            ),
            SizedBox(height: 14),

            _buildTextField(
              maxLines: 3,
              controller: _recipeDescription,
              label: 'Recipe Description',
              icon: Icons.description,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a recipe description';
                }
                return null;
              },
            ),
            SizedBox(height: 14),

            _buildTextField(
              controller: _recipeIMG,
              label: 'Image URL',
              icon: Icons.image,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a recipe image URL';
                }
                return null;
              },
            ),
            SizedBox(height: 14),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí puedo manejar la lógica para guardar la receta
                    Navigator.pop(context); // Cierra el modal al guardar
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save Recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData? icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.pinkAccent,
        ),
        prefixIcon: icon != null ? Icon(icon, color: Colors.pinkAccent) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      maxLines: maxLines,
    );
  }
}
