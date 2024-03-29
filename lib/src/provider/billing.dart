import 'package:flutter/material.dart';
import 'package:shopos/src/models/input/order.dart';

class Billing with ChangeNotifier {
  // List<Order> _Order = [];
  // List<OrderType> _ordertype = [];

  Map<String, Order> _salesBilling = {};

  Map<String, Order> get salesBilling {
    return {..._salesBilling};
  }

  Map<String, Order> _purchaseBilling = {};

  Map<String, Order> get purchaseBilling {
    return {..._purchaseBilling};
  }

  void updateTableNoInSalesBill(String orderId, String tableNum){
    if(_salesBilling.containsKey(orderId)){
      _salesBilling.update(orderId, (existingOrder) => Order(
          id: existingOrder.id,
          kotId: existingOrder.kotId,
          orderItems: existingOrder.orderItems,
          modeOfPayment: existingOrder.modeOfPayment,
          party: existingOrder.party,
          user: existingOrder.user,
          tableNo: tableNum,
          gst: existingOrder.gst
      ));
    }
    notifyListeners();
  }
  void addSalesBill(Order input, String orderId) {
    print("adding sales bill with order id: $orderId");
     
    if (_salesBilling.containsKey(orderId)) {
      //.... change quantity
      _salesBilling.update(
          orderId,
          (existingOrder) => Order(
              id: input.id,
              kotId: existingOrder.kotId,
              orderItems: existingOrder.orderItems,
              modeOfPayment: existingOrder.modeOfPayment,
              party: existingOrder.party,
              user: existingOrder.user,
              tableNo: input.tableNo,
              gst: input.gst
              ));
    } else {
        
      _salesBilling.putIfAbsent(
          orderId,
          () => Order(
              id: input.id,
              kotId: input.kotId,
              orderItems: input.orderItems,
              modeOfPayment: input.modeOfPayment,
              party: input.party,
              user: input.user,
              tableNo: input.tableNo,
              gst: input.gst
              ));
    }
    notifyListeners();
  }

  void addPurchaseBill(Order input, String orderId) {
    if (_purchaseBilling.containsKey(orderId)) {
      //.... change quantity
      _purchaseBilling.update(
          orderId,
          (existingOrder) => Order(
              orderItems: existingOrder.orderItems,
              modeOfPayment: existingOrder.modeOfPayment,
              party: existingOrder.party,
              user: existingOrder.user));
    } else {
      _purchaseBilling.putIfAbsent(
          orderId,
          () => Order(
                orderItems: input.orderItems,
                modeOfPayment: input.modeOfPayment,
                party: input.party,
                user: input.user,
              ));
    }
    notifyListeners();
  }

  void removeSalesBillItems(String orderId) {
    print("order id in remove sales bill items: $orderId");
    _salesBilling.remove(orderId);
    print(_salesBilling.containsKey(orderId));
    notifyListeners();
  }

  void removePurchaseBillItems(String prodId) {
    _purchaseBilling.remove(prodId);
    notifyListeners();
  }

  void removeAll() {
    _salesBilling.clear();
    _purchaseBilling.clear();
    notifyListeners();
  }
  // void addOrderItem(Order input, OrderType orderType) {
  //   _Order.add(input);
  //   _ordertype.add(orderType);
  //   notifyListeners();
  // }

  // void removeBill(Order input, OrderType orderType) {
  //   int inputIdx = _Order.indexWhere((element) => element == input);

  //   _Order.removeAt(inputIdx);
  //   _ordertype.removeAt(inputIdx);
  //   notifyListeners();
  // }

  // List<Order> getAllOrder() {
  //   return _Order.reversed.toList();
  // }

  // List<OrderType> getAllOrderType() {
  //   return _ordertype.reversed.toList();
  // }
}
