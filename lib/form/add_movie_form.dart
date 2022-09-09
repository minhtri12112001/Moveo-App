import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class AddMovieForm extends StatefulWidget {
  const AddMovieForm({Key? key}) : super(key: key);
  @override
  State<AddMovieForm> createState() => _AddMovieFormState();
}

class _AddMovieFormState extends State<AddMovieForm>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryController = TextEditingController();
  final movieNameController = TextEditingController();
  final movieUrlController = TextEditingController();
  final movieDescriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  void _updateMovieDetail(){
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    _updateMovieDetail();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Movie Name",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: movieNameController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Movie Description",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: movieDescriptionController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Movie URL",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: movieUrlController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Category",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: categoryController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Image URL",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: imageUrlController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    FirebaseFirestore.instance.collection('movies')
                        .add(
                        {
                          "movie_name": movieNameController.text,
                          "movie_description": movieDescriptionController.text,
                          "movie_url": movieUrlController.text,
                          "image_url": imageUrlController.text,
                          "category": categoryController.text
                        }
                    )
                        .then((value) => print("Movie Added"))
                        .catchError((error) => print("Failed to add movie: $error"));
                    Navigator.pop(context, "Add");
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}