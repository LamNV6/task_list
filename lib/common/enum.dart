enum ActionType { create, update }

extension ActionTypeExt on ActionType {
  String toValue() {
    switch (this) {
      case ActionType.create:
        return 'Create';
      case ActionType.update:
        return 'Update';
      default:
        throw ('No type');
    }
  }
}
