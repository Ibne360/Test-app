import 'dart:math';

class CourierPricingRule {
  const CourierPricingRule({
    this.firstKgCost = 120,
    this.perKgCost = 20,
  });

  final int firstKgCost;
  final int perKgCost;
}

int courierCost(double totalKg, {CourierPricingRule rule = const CourierPricingRule()}) {
  if (totalKg <= 0) {
    return 0;
  }
  final remainingKg = max(0, totalKg - 1);
  final remainingRounded = remainingKg.ceil();
  return rule.firstKgCost + (remainingRounded * rule.perKgCost);
}

class BatchDecision {
  const BatchDecision({
    required this.status,
    required this.extendUsed,
  });

  final BatchStatus status;
  final bool extendUsed;
}

enum BatchStatus { open, locked, confirmed, canceled }

BatchDecision decideBatchStatus({
  required int totalOrders,
  required int minOrders,
  required bool extendOnceUsed,
  required bool windowClosed,
}) {
  if (!windowClosed) {
    return BatchDecision(status: BatchStatus.open, extendUsed: extendOnceUsed);
  }
  if (totalOrders >= minOrders) {
    return BatchDecision(status: BatchStatus.confirmed, extendUsed: extendOnceUsed);
  }
  if (!extendOnceUsed) {
    return const BatchDecision(status: BatchStatus.open, extendUsed: true);
  }
  return const BatchDecision(status: BatchStatus.canceled, extendUsed: true);
}

class OrderTotals {
  const OrderTotals({
    required this.subtotal,
    required this.deliveryCharge,
    required this.serviceCharge,
    required this.totalWeightKg,
  });

  final int subtotal;
  final int deliveryCharge;
  final int serviceCharge;
  final double totalWeightKg;

  int get total => subtotal + deliveryCharge + serviceCharge;
}

OrderTotals calculateOrderTotals({
  required List<OrderLine> lines,
  int deliveryCharge = 50,
  int serviceCharge = 0,
}) {
  var subtotal = 0;
  var totalWeight = 0.0;
  for (final line in lines) {
    subtotal += line.unitPrice * line.quantity;
    totalWeight += line.unitWeightKg * line.quantity;
  }
  return OrderTotals(
    subtotal: subtotal,
    deliveryCharge: deliveryCharge,
    serviceCharge: serviceCharge,
    totalWeightKg: totalWeight,
  );
}

class OrderLine {
  const OrderLine({
    required this.unitPrice,
    required this.unitWeightKg,
    required this.quantity,
  });

  final int unitPrice;
  final double unitWeightKg;
  final int quantity;
}
