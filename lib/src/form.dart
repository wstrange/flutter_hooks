part of 'hooks.dart';

class _UseTextEditingController {
  const _UseTextEditingController();

  TextEditingController call({String text, List<Object> keys}) {
    return Hook.use(_UseTextEditingControllerHook(
      keys: keys,
      text: text,
    ));
  }

  /// Created a [TextEditingController] using [TextEditingController.fromValue] constructor.
  ///
  /// See also:
  ///   * [TextEditingController]
  TextEditingController fromValue(TextEditingValue value, [List<Object> keys]) {
    return Hook.use(
      _UseTextEditingControllerFromValueHook(keys: keys, value: value),
    );
  }
}

/// Creates a [TextEditingController].
///
/// See also:
///   * [TextEditingController]
const useTextEditingController = _UseTextEditingController();

class _UseTextEditingControllerHook extends Hook<TextEditingController> {
  _UseTextEditingControllerHook({
    List<Object> keys,
    this.text,
  }) : super(keys: keys);

  final String text;

  @override
  _UseTextEditingControllerHookState createState() =>
      _UseTextEditingControllerHookState();
}

class _UseTextEditingControllerHookState
    extends HookState<TextEditingController, _UseTextEditingControllerHook> {
  TextEditingController controller;

  @override
  void initHook() {
    controller = TextEditingController(text: hook.text);
  }

  @override
  TextEditingController build(BuildContext context) => controller;

  @override
  void dispose() {
    controller.dispose();
  }
}

class _UseTextEditingControllerFromValueHook
    extends Hook<TextEditingController> {
  _UseTextEditingControllerFromValueHook({
    List<Object> keys,
    this.value,
  }) : super(keys: keys);

  final TextEditingValue value;

  @override
  _UseTextEditingControllerFromValueHookState createState() =>
      _UseTextEditingControllerFromValueHookState();
}

class _UseTextEditingControllerFromValueHookState extends HookState<
    TextEditingController, _UseTextEditingControllerFromValueHook> {
  TextEditingController controller;

  @override
  void initHook() {
    controller = TextEditingController.fromValue(hook.value);
  }

  @override
  TextEditingController build(BuildContext context) => controller;

  @override
  void dispose() {
    controller.dispose();
  }
}
