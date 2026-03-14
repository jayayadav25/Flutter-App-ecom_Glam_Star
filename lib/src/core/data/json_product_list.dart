import 'dart:convert';

const String rawProductsJson = '''
[
  {
    "product_id": 10179,
    "category": "men",
    "sub_category": "flip-flops",
    "actual_price": 1851,
    "selling_price": 1295,
    "discount": 30,
    "average_rating": 4.3,
    "in_stock": true,
    "has_image": true,
    "baseColour": "Blue",
    "season": "Fall",
    "year": 2011,
    "usage": "Casual",
    "title": "United Colors of Benetton Men Speeder Blue Flip Flops",
    "slug": "united-colors-of-benetton-men-speeder-blue-flip-flops",
    "description":
        "Premium United Colors of Benetton Men Speeder Blue Flip Flops in Blue color, suitable for Casual during Fall. Made for comfort and modern fashion.",
    "images": [
      "https://firebasestorage.googleapis.com/v0/b/trendora-228a2.firebasestorage.app/o/products%2F10179.jpg?alt=media"
    ]
  }
]
''';

List<dynamic> get jsonProductsList =>
    json.decode(rawProductsJson) as List<dynamic>;
