import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moveo_app/model/movie_model.dart';



class UpdateMovieForm extends StatefulWidget {
  final MovieModel movie;
  const UpdateMovieForm({Key? key, required this.movie}) : super(key: key);
  @override
  State<UpdateMovieForm> createState() => _UpdateMovieFormState();
}

class _UpdateMovieFormState extends State<UpdateMovieForm>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryController = TextEditingController();
  final movieNameController = TextEditingController();
  final movieUrlController = TextEditingController();
  final movieDescriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  void _updateMovieDetail(){
    categoryController.text = widget.movie.category;
    movieNameController.text = widget.movie.movie_name;
    movieUrlController.text = widget.movie.movie_url;
    movieDescriptionController.text = widget.movie.movie_description;
    imageUrlController.text = widget.movie.image_url;
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
                  labelText: "Movie Name",
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
                        .doc(widget.movie.id)
                        .update(
                        {
                          "movie_name": movieNameController.text,
                          "movie_description": movieDescriptionController.text,
                          "movie_url": movieUrlController.text,
                          "image_url": imageUrlController.text,
                          "category": categoryController.text
                        }
                    )
                        .then((value) => print("User Updated"))
                        .catchError((error) => print("Failed to update user: $error"));
                    Navigator.pop(context, "Update");
                  }
                },
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}