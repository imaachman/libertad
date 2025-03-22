import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/borrower_field.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/return_date_field.dart';
import 'package:libertad/features/books/screens/book_details_screen/copy_list_tile.dart';
import 'package:libertad/main.dart' as app;
import 'package:libertad/widgets/book_list_tile.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Tests issue book flow.
  testWidgets('Issue book flow', (tester) async {
    // Launch app.
    await app.main();
    await tester.pumpAndSettle();
    // Reset database.
    await tester.tap(find.byTooltip('Show menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reset database'));
    await tester.pumpAndSettle();
    // Navigate to book details page.
    await tester.tap(find.byType(BookListTile).at(0));
    await tester.pumpAndSettle();
    // Navigate to copy details page.
    await tester.scrollUntilVisible(find.byType(CopyListTile).at(0), 50);
    await tester.tap(find.byType(CopyListTile).at(0));
    await tester.pumpAndSettle();
    // Tap on issue button.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    // Fill in return date.
    await tester.tap(find.byType(ReturnDateField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('30'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    // Select borrower.
    await tester.tap(find.byType(BorrowerField));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ListTile).at(0));
    await tester.pumpAndSettle();
    // Tap on issue copy button.
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    // Expect the copy to be issued to the borrower.
    expect(find.text('issued to'), findsAny);
  });
}
