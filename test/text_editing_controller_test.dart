import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'mock.dart';

void main() {
  group('useTextEditingController', () {
    testWidgets('creates an instance', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController();
        return Container();
      }));

      expect(controller, isNotNull);
      expect(controller.runtimeType, TextEditingController);
    });

    testWidgets('rebuilds preserve instance', (tester) async {
      TextEditingController controller;
      TextEditingController controller2;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController();
        return Container();
      }));
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller2 = useTextEditingController();
        return Container();
      }));

      expect(controller, controller2);
    });
    testWidgets('unmount disposes instance', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController();
        return Container();
      }));

      await tester.pumpWidget(Container());

      // ignore: invalid_use_of_protected_member
      expect(() => controller.hasListeners, throwsAssertionError);
    });
    testWidgets('pass keys', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController();
        return Container();
      }));
      TextEditingController controller2;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller2 = useTextEditingController(keys: ['foo']);
        return Container();
      }));

      expect(controller2, isNot(controller));
      // ignore: invalid_use_of_protected_member
      expect(() => controller.hasListeners, throwsAssertionError);
    });
    testWidgets('default text is empty', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController();
        return Container();
      }));

      expect(controller.text, '');
    });
    testWidgets('pass text', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController(text: 'foo');
        return Container();
      }));

      expect(controller.text, 'foo');
    });
  });
  testWidgets('cannot switch between default and fromValue', (tester) async {
    await tester.pumpWidget(HookBuilder(builder: (context) {
      useTextEditingController();
      return Container();
    }));
    await tester.pumpWidget(HookBuilder(builder: (context) {
      useTextEditingController.fromValue(TextEditingValue());
      return Container();
    }));

    expect(tester.takeException(), isAssertionError);
  });

  group('useTextEditingController.fromValue', () {
    testWidgets('creates an instance', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController.fromValue(TextEditingValue());
        return Container();
      }));

      expect(controller, isNotNull);
      expect(controller.text, '');
      expect(controller.runtimeType, TextEditingController);
    });

    testWidgets('rebuilds preserve instance', (tester) async {
      TextEditingController controller;
      TextEditingController controller2;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController.fromValue(TextEditingValue());
        return Container();
      }));
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller2 = useTextEditingController.fromValue(null);
        return Container();
      }));

      expect(controller, controller2);
    });
    testWidgets('unmount disposes instance', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController.fromValue(TextEditingValue());
        return Container();
      }));

      await tester.pumpWidget(Container());

      // ignore: invalid_use_of_protected_member
      expect(() => controller.hasListeners, throwsAssertionError);
    });
    testWidgets('pass keys', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController.fromValue(TextEditingValue());
        return Container();
      }));
      TextEditingController controller2;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller2 =
            useTextEditingController.fromValue(TextEditingValue(), ['foo']);
        return Container();
      }));

      expect(controller2, isNot(controller));
      // ignore: invalid_use_of_protected_member
      expect(() => controller.hasListeners, throwsAssertionError);
    });
    testWidgets('default text is empty', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller = useTextEditingController.fromValue(null);
        return Container();
      }));

      expect(controller.text, '');
    });
    testWidgets('pass value', (tester) async {
      TextEditingController controller;
      await tester.pumpWidget(HookBuilder(builder: (context) {
        controller =
            useTextEditingController.fromValue(TextEditingValue(text: 'foo'));
        return Container();
      }));

      expect(controller.text, 'foo');
    });
  });
}
