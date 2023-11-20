import 'dart:convert';

List<SalesModel> salesModelFromJson(String str) =>
    List<SalesModel>.from(json.decode(str).map((x) => SalesModel.fromJson(x)));

String salesModelToJson(List<SalesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalesModel {
  String orderId;
  String profit;
  String city;
  String customerName;
  String productName;
  String rowId;
  String country;
  String discount;
  String customerId;
  String region;
  String quantity;
  String segment;
  String state;
  String shipMode;
  String subCategory;
  String postalCode;
  String shipDate;
  String category;
  String productId;
  String sales;
  String orderDate;

  SalesModel({
    required this.orderId,
    required this.profit,
    required this.city,
    required this.customerName,
    required this.productName,
    required this.rowId,
    required this.country,
    required this.discount,
    required this.customerId,
    required this.region,
    required this.quantity,
    required this.segment,
    required this.state,
    required this.shipMode,
    required this.subCategory,
    required this.postalCode,
    required this.shipDate,
    required this.category,
    required this.productId,
    required this.sales,
    required this.orderDate,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(
        orderId: json["Order ID"],
        profit: json["Profit"],
        city: json["City"],
        customerName: json["Customer Name"],
        productName: json["Product Name"],
        rowId: json["Row ID"],
        country: json["Country"],
        discount: json["Discount"],
        customerId: json["Customer ID"],
        region: json["Region"],
        quantity: json["Quantity"],
        segment: json["Segment"],
        state: json["State"],
        shipMode: json["Ship Mode"],
        subCategory: json["Sub-Category"],
        postalCode: json["Postal Code"],
        shipDate: json["Ship Date"],
        category: json["Category"],
        productId: json["Product ID"],
        sales: json["Sales"],
        orderDate: json["Order Date"],
      );

  Map<String, dynamic> toJson() => {
        "Order ID": orderId,
        "Profit": profit,
        "City": city,
        "Customer Name": customerName,
        "Product Name": productName,
        "Row ID": rowId,
        "Country": country,
        "Discount": discount,
        "Customer ID": customerId,
        "Region": region,
        "Quantity": quantity,
        "Segment": segment,
        "State": state,
        "Ship Mode": shipMode,
        "Sub-Category": subCategory,
        "Postal Code": postalCode,
        "Ship Date": shipDate,
        "Category": category,
        "Product ID": productId,
        "Sales": sales,
        "Order Date": orderDate,
      };
}
