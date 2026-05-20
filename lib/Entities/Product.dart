class Product {
  final String id;
  final String name;
  final String? image;
  final double price;

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });
  Product copyTo({String? name, String? image, double? price})
  {
    return Product(id: id, name: name ?? this.name, image: image ?? this.image, price: price ?? this.price);
  }

  // Factory map Json -> Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }

  // Danh sách tĩnh
  static List<Product> products = [
    Product(
      id: "P01",
      name: "Laptop",
      image: "laptop.png",
      price: 1000,
    ),
    Product(
      id: "P02",
      name: "Phone",
      image: "phone.png",
      price: 500,
    ),
    Product(
      id: "P03",
      name: "Mouse",
      image: "mouse.png",
      price: 50,
    ),
  ];

  // Add
  static void add(Product product) {
    products.add(product);
  }

  // Edit
  static void edit(Product product) {
    int index = products.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      products[index] = product;
    }
  }

  // Search theo tên
  static List<Product> searchByName(String keyword) {
    return products
        .where(
          (p) => p.name.toLowerCase().contains(keyword.toLowerCase()),
    )
        .toList();
  }

  // Search theo giá lớn hơn
  static List<Product> searchByPrice(double minPrice) {
    return products.where((p) => p.price >= minPrice).toList();
  }

  // Find theo id
  static Product? findById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Tăng giá 10% dùng map
  static List<Product> increasePrice() {
    products = products.map((p) {
      return Product(
        id: p.id,
        name: p.name,
        image: p.image,
        price: p.price * 1.1,
      );
    }).toList();

    return products;
  }

  // Hiển thị thông tin
  void printInfo() {
    print(
      "ID: $id - Name: $name - Image: $image - Price: $price",
    );
  }
}

void main() {
  // Add
  Product.add(
    Product(
      id: "P04",
      name: "Keyboard",
      image: "keyboard.png",
      price: 80,
    ),
  );

  // Edit
  Product.edit(
    Product(
      id: "P02",
      name: "IPhone",
      image: "iphone.png",
      price: 1200,
    ),
  );

  // Search
  List<Product> result = Product.searchByName("phone");

  print("Search Result:");
  for (var p in result) {
    p.printInfo();
  }

  // Increase Price
  Product.increasePrice();

  print("\nAfter Increase Price:");
  for (var p in Product.products) {
    p.printInfo();
  }

  // Find
  Product? p = Product.findById("P01");

  print("\nFind Product:");
  p?.printInfo();

  // Json -> Product
  Map<String, dynamic> json = {
    "id": "P05",
    "name": "Monitor",
    "image": "monitor.png",
    "price": 300
  };

  Product newProduct = Product.fromJson(json);

  print("\nProduct From Json:");
  newProduct.printInfo();
}