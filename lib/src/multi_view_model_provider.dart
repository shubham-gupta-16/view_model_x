import 'package:flutter/cupertino.dart';
import 'package:nested/nested.dart';
import 'package:view_model_x/src/view_model_provider.dart';

/// [MultiViewModelProvider] converts the [ViewModelProvider] list into a tree of nested
/// [ViewModelProvider] widgets.
/// As a result, the only advantage of using [MultiViewModelProvider] is improved
/// readability due to the reduction in nesting and boilerplate.
class MultiViewModelProvider extends Nested {
  MultiViewModelProvider(
      {super.key, required List<ViewModelProviderSingleChildWidget> providers, required Widget child})
      : super(children: providers, child: child);
}
