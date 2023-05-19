import 'dart:io';

import 'package:dezvapmobile/model/FoodLog.dart';
import 'package:dezvapmobile/model/FoodLogList.dart';
import 'package:dezvapmobile/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dezvapmobile/util/database_helper.dart';
import 'package:provider/provider.dart';
import 'MealAddedCongratsRoute.dart';
import 'package:image_picker/image_picker.dart';

class AddEditMealRoute extends StatelessWidget {
  const AddEditMealRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Edit meal'),
      ),
      body: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final Storage storage = Storage();

  TextEditingController dateinput = TextEditingController();

  FoodLog _foodLog = FoodLog();
  late DatabaseHelper _dbHelper;

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    _dbHelper = DatabaseHelper.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Add TextFormFields and ElevatedButton here.
            image == null
                ? Container()
                : Image.file(File(image!.path), height: 300, fit: BoxFit.cover),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'What did you eat?',
                    icon: Icon(Icons.dinner_dining_sharp),
                    hintText: "Cereal with milk..."),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _foodLog.foodName = null;
                    return 'You must complete what you ate';
                  }
                  _foodLog.foodName = value;
                  return null;
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.calendar_month), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text =
                            formattedDate; //set output date to TextField value.
                        _foodLog.date = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.electric_bolt), //icon of text field
                    labelText: 'Calories (est.)',
                    hintText: "500"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _foodLog.calories = null;
                    return null;
                  }
                  if (int.tryParse(value) == null) {
                    return 'Value must be natural number';
                  }
                  _foodLog.calories = int.parse(value);
                  return null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);

                  if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No photo selected')));
                  } else {
                    storage
                        .uploadFile(image!.path, image!.name)
                        .then((value) => {
                              setState(() {
                                _foodLog.photo = image!.name;
                              })
                            });
                  }
                },
                child: Text("Pick Image")),
            ElevatedButton(
              onPressed: () async {
                if (_foodLog.photo == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No photo selected')));
                  return;
                }
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (_foodLog.id == null) {
                    Provider.of<FoodLogProvider>(context, listen: false)
                        .add(_foodLog);
                  } else {
                    await _dbHelper.updateFoodLog(_foodLog);
                  }

                  print(_foodLog.calories);
                  Navigator.of(context)
                      .push(animatedTransitionMealAddedCongratsRoute());
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
