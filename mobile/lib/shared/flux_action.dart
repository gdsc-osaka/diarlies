import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FluxAction {
  const FluxAction(this.ref);

  final Ref ref;
}
