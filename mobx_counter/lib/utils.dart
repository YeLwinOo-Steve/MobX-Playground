import 'package:flutter/material.dart';

import 'action_enums.dart';

class Utils {
  static IconData getIconFromAction(ActionTypes type) {
    switch(type){
      case ActionTypes.add:
        return Icons.add;
      case ActionTypes.subtract:
        return Icons.remove;
    }
  }
}
