import 'package:meta/meta.dart';

@immutable
abstract class Setting<T> {
  static const _typeKey = 'type';
  static const _valueKey = 'value';

  final T value;

  Setting(this.value);

  Map<String, dynamic> toJson() {
    return {
      _typeKey: runtimeType.toString(),
      _valueKey: value,
    };
  }

  static Setting fromJson(Map<String, dynamic> json) {
    final type = json[_typeKey];
    final value = json[_valueKey];

    assert(type != null);
    assert(value != null);

    if (type == (RemoteLoggingSetting).toString()) {
      return RemoteLoggingSetting(value);
    } else if (type == (ShowDialerConfirmPopupSetting).toString()) {
      return ShowDialerConfirmPopupSetting(value);
    } else {
      throw UnsupportedError('Setting type does not exist');
    }
  }

  Setting<T> copyWith({T value});

  @override
  bool operator ==(other) {
    return other.runtimeType == runtimeType && other.value == value;
  }

  @override
  int get hashCode => runtimeType.hashCode + value.hashCode;
}

class RemoteLoggingSetting extends Setting<bool> {
  // ignore: avoid_positional_boolean_parameters
  RemoteLoggingSetting(bool value) : super(value);

  @override
  Setting<bool> copyWith({bool value}) => RemoteLoggingSetting(value);
}

class ShowDialerConfirmPopupSetting extends Setting<bool> {
  // ignore: avoid_positional_boolean_parameters
  ShowDialerConfirmPopupSetting(bool value) : super(value);

  @override
  Setting<bool> copyWith({bool value}) => ShowDialerConfirmPopupSetting(value);
}

extension SettingsByType on List<Setting> {
  T get<T extends Setting>() {
    return firstWhere((setting) => setting is T);
  }
}
