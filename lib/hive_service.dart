import 'package:candy_store/product_list_item.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProductAdapter());
    await Hive.openBox<ProductListItem>('products');
  }

  Box<ProductListItem> getProductBox() {
    return Hive.box<ProductListItem>('products');
  }
}

class ProductAdapter extends TypeAdapter<ProductListItem> {
  @override
  final typeId = 0;

  @override
  ProductListItem read(BinaryReader reader) {
    return ProductListItem(
      id: reader.readString(),
      name: reader.readString(),
      description: reader.readString(),
      price: reader.readInt(),
      imageUrl: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductListItem obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeInt(obj.price);
    writer.writeString(obj.imageUrl);
  }
}