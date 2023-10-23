import 'package:flutter/material.dart';
import 'package:recipe_model/recipe_model.dart';
import 'package:uuid/uuid.dart';

class CreateIngredientModal extends StatelessWidget {
  CreateIngredientModal({
    super.key,
  });

  // add formkey and controllers for name and description

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _descriptionController = TextEditingController();

  // TODO: Add a form with two textformfields for name and description
  // to adapt size of modal with keyboard opening/closing, add viewinsets bottom padding to the padding of the modal
  // use mediaquery of context to adapt size of modal.
  // return create future on navigation pop

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("This is the create ingredient modal..."));
  }
}
