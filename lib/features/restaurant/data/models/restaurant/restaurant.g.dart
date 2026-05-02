// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestaurantAdapter extends TypeAdapter<Restaurant> {
  @override
  final int typeId = 1;

  @override
  Restaurant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Restaurant(
      id: fields[0] as String,
      name: fields[1] as String,
      rating: fields[2] as double,
      address: fields[4] as String,
      category: fields[5] as String,
      image: fields[3] as String?,
      about: fields[6] as String,
      connectInfo: (fields[7] as List).cast<String>(),
      operationOfWork: (fields[8] as List).cast<String>(),
      parkings: (fields[9] as List).cast<String>(),
      paymentOptions: (fields[10] as List).cast<String>(),
      services: (fields[11] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Restaurant obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.about)
      ..writeByte(7)
      ..write(obj.connectInfo)
      ..writeByte(8)
      ..write(obj.operationOfWork)
      ..writeByte(9)
      ..write(obj.parkings)
      ..writeByte(10)
      ..write(obj.paymentOptions)
      ..writeByte(11)
      ..write(obj.services);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
