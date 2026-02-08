import 'package:flutter_test/flutter_test.dart';
import 'package:thana_group_buying/core/utils/pricing_utils.dart';

void main() {
  group('courierCost', () {
    test('returns 0 for non-positive weight', () {
      expect(courierCost(0), 0);
      expect(courierCost(-1), 0);
    });

    test('calculates cost using ceiling for remaining kg', () {
      expect(courierCost(1), 120);
      expect(courierCost(1.2), 140);
      expect(courierCost(2.0), 140);
      expect(courierCost(100), 2100);
    });
  });

  group('decideBatchStatus', () {
    test('keeps open when window not closed', () {
      final result = decideBatchStatus(
        totalOrders: 3,
        minOrders: 10,
        extendOnceUsed: false,
        windowClosed: false,
      );
      expect(result.status, BatchStatus.open);
      expect(result.extendUsed, false);
    });

    test('confirms when min orders met', () {
      final result = decideBatchStatus(
        totalOrders: 10,
        minOrders: 10,
        extendOnceUsed: false,
        windowClosed: true,
      );
      expect(result.status, BatchStatus.confirmed);
    });

    test('extends once if below min orders', () {
      final result = decideBatchStatus(
        totalOrders: 2,
        minOrders: 10,
        extendOnceUsed: false,
        windowClosed: true,
      );
      expect(result.status, BatchStatus.open);
      expect(result.extendUsed, true);
    });

    test('cancels if already extended', () {
      final result = decideBatchStatus(
        totalOrders: 2,
        minOrders: 10,
        extendOnceUsed: true,
        windowClosed: true,
      );
      expect(result.status, BatchStatus.canceled);
      expect(result.extendUsed, true);
    });
  });

  group('calculateOrderTotals', () {
    test('sums lines and adds charges', () {
      final totals = calculateOrderTotals(
        lines: const [
          OrderLine(unitPrice: 100, unitWeightKg: 1, quantity: 2),
          OrderLine(unitPrice: 50, unitWeightKg: 0.5, quantity: 1),
        ],
      );

      expect(totals.subtotal, 250);
      expect(totals.totalWeightKg, 2.5);
      expect(totals.total, 300);
    });
  });
}
