import 'package:flutter/material.dart';

class AddplacedialogWidget extends StatefulWidget {
  final Map<String, dynamic>? initialPlace;
  final bool isEdit;

  const AddplacedialogWidget({super.key, this.initialPlace, this.isEdit = false});

  @override
  State<AddplacedialogWidget> createState() => _AddplacedialogWidgetState();
}

class _AddplacedialogWidgetState extends State<AddplacedialogWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _imagePathController;
  late final TextEditingController _rateController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialPlace?["name"] ?? '');
    _locationController = TextEditingController(text: widget.initialPlace?["location"] ?? '');
    _imagePathController = TextEditingController(text: widget.initialPlace?["imagePath"] ?? '');
    _rateController = TextEditingController(text: widget.initialPlace?["rate"] ?? '');
    _priceController = TextEditingController(text: widget.initialPlace?["price"] ?? '');
    _descriptionController = TextEditingController(text: widget.initialPlace?["description"] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _imagePathController.dispose();
    _rateController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? "Edit Place" : "Add New Place"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "Name"),
                validator: (value) => (value?.isEmpty ?? true) ? "Enter name" : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(hintText: "Location"),
                validator: (value) => (value?.isEmpty ?? true) ? "Enter location" : null,
              ),
              TextFormField(
                controller: _imagePathController,
                decoration: InputDecoration(hintText: "Image URL"),
                validator: (value) => (value?.isEmpty ?? true) ? "Enter image URL" : null,
              ),
              TextFormField(
                controller: _rateController,
                decoration: InputDecoration(hintText: "Rating"),
                validator: (value) => (value?.isEmpty ?? true) ? "Enter rating" : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(hintText: "Price"),
                validator: (value) => (value?.isEmpty ?? true) ? "Enter price" : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: "Description"),
                validator: (value) => (value?.isEmpty ?? true) ? "Enter description" : null,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newPlace = {
                "name": _nameController.text.trim(),
                "location": _locationController.text.trim(),
                "imagePath": _imagePathController.text.trim(),
                "rate": _rateController.text.trim(),
                "price": _priceController.text.trim(),
                "description": _descriptionController.text.trim(),
              };
              Navigator.pop(context, newPlace);
            }
          },
          child: Text(widget.isEdit ? "Save" : "Add"),
        ),
      ],
    );
  }
}