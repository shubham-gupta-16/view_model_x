import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'view_model.dart';

class MultiViewModelProvider extends MultiProvider {
  MultiViewModelProvider({super.key, required super.providers});
}

/// [ViewModelProvider] is used to wrap the widget with your custom [ViewModel].
/// This requires [create] which accepts custom [ViewModel] and [child] Widget.
class ViewModelProvider<T extends ViewModel> extends Provider<T> {
  ViewModelProvider(
      {super.key,
      required super.create,
      super.child,
      super.lazy,
      super.builder})
      : super(dispose: (context, v) {
          v.dispose();
        });

  static T of<T extends ViewModel>(BuildContext context) {
    try {
      return Provider.of<T>(context, listen: false);
    } on ProviderNotFoundException catch (e) {
      if (e.valueType != T) rethrow;
      throw FlutterError(
        '''
        ViewModelProvider.of() called with a context that does not contain a $T.
        No ancestor could be found starting from the context that was passed to ViewModelProvider.of<$T>().

        This can happen if the context you used comes from a widget above the ViewModelProvider.

        The context used was: $context
        ''',
      );
    }
  }
}

extension ViewModelExtension on BuildContext {
  /// [vm] is an [BuildContext] extension method.
  /// This allows to get the custom [ViewModel] from anywhere nested inside [ViewModelProvider]'s [child]
  T vm<T extends ViewModel>() => ViewModelProvider.of<T>(this);
}
