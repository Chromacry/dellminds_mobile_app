import 'package:dellminds_mobile_app/constants/global_constants.dart';
import 'package:dellminds_mobile_app/models/example.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class ExampleProvider with ChangeNotifier {
  //* Data list
  List<Example> examples = [
    Example(
      id: uuid.v4(), //* Randomly generated unique identifier
      example_name: 'hello world!',
      created_by: GlobalConstants.currentUser,
      created_at: '2023-07-03 00:00:00',
    ),
  ];

  List<Example> getAllExamples() {
    return examples;
  }

  List<Example> getAllExamplesById({id}) {
    List<Example> filteredExamples = [];
    for (Example currentExample in examples) {
      if (currentExample.id == id) filteredExamples.add(currentExample);
    }
    return filteredExamples;
  }

  String addExample({exampleName, createdBy, createdAt}) {
    Example exampleData = Example(
      id: uuid.v4(),
      example_name: exampleName,
      created_at: createdAt,
      created_by: createdBy ?? 'system',
    );

    examples.add(exampleData);
    notifyListeners();
    return 'Example successfully added!';
  }

  String? updateExampleExistById({
    id,
    exampleName,
    updatedBy,
    updatedAt,
  }) {
    int examplesIndex = examples.indexWhere((element) => element.id == id);
    if (examplesIndex != -1) {
      Example currentExample = examples[examplesIndex];
      currentExample.id = id;
      currentExample.example_name = exampleName;
      currentExample.updated_by = updatedBy;
      currentExample.updated_at = updatedAt;
      notifyListeners();
      return 'Successfully updated example!';
    }
    return 'Failed to update example!';
  }

  //* Delete without removing it from list
  void deleteDeviceLocationById({
    id,
    exampleName,
    deletedBy,
    deletedAt,
  }) {
    int exampleIndex = examples.indexWhere((element) => element.id == id);
    examples[exampleIndex] = Example(
      deleted_by: deletedBy,
      deleted_at: deletedAt,
    );
    notifyListeners();
  }

  //* Fully delete/remove from list
  void removeDeviceLocationById({id}) {
    examples.removeAt(examples.indexWhere((element) => element.id == id));
    notifyListeners();
  }
}
