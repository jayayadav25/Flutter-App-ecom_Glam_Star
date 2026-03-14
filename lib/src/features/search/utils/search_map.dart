
// word - canonical tag
final Map<String, String> searchMap = {
  "kid": "kids",
  "child": "kids",
  "children": "kids",
  "boy": "kids",
  "girl": "kids",
  "men": "men",
  "man": "man",
  "women": "women",
  "woman": "woman",
  "female": "female",
  "male": "male",
  "tshirt": "tshirts",
  "tee": "tshirts",
  "tees": "tshirts",
  "shirt": "shirts",
  "denim": "jeans",
  "jean": "jeans",
  "pant": "pants",
  "pants": "pants",
  "sandal": "sandals",
  "sneaker": "shoes",
  "kurti": "kurtis",
  "kurta": "kurtas",
  "watch": "watches",
  "bag": "bags",
  "backpack": "bags",
};

// Subcategory aliases
const Map<String, List<String>> subcategoryAliases = {
  "tshirts": ["tshirt", "tshirts", "tee", "tees"],
  "shirts": ["shirt", "shirts"],
  "jeans": ["jeans", "denim", "pant", "pants"],
  "shoes": ["shoe", "shoes", "sneaker", "sneakers"],
  "sandals": ["sandal", "sandals", "flipflop", "flipflops"],
  "bags": ["bag", "bags", "backpack", "backpacks"],
};
