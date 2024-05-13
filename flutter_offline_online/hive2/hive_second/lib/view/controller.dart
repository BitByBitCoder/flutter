import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_second/view/models.dart';

class PersonControllerNotifier extends StateNotifier<PersonModels> {
  PersonControllerNotifier() : super(PersonModels());
}
