import 'dart:math';
import 'dart:typed_data';
// import 'package:convert/convert.dart';

class Parsing {
  static double parseFromFloat_64(List<int> list) {
    ByteBuffer buffer = Int8List.fromList(list).buffer;
    ByteData data = ByteData.view(buffer);
    double result = data.getFloat64(0, Endian.little);
    return result;
  }

  static double parseFromFloat_32(List<int> list) {
    ByteBuffer buffer = Int8List.fromList(list).buffer;
    ByteData data = ByteData.view(buffer);
    double result = data.getFloat32(0, Endian.little);
    return result;
  }

  static int parseFromUint_16(List<int> list) {
    ByteBuffer buffer = Int8List.fromList(list).buffer;
    ByteData data = ByteData.view(buffer);
    int result = data.getUint16(0, Endian.little);
    return result;
  }

  static int parseFromUint_32(List<int> list) {
    ByteBuffer buffer = Int8List.fromList(list).buffer;
    ByteData data = ByteData.view(buffer);
    int result = data.getUint32(0, Endian.little);
    return result;
  }

  static int parseFromINT_16(List<int> list) {
    ByteBuffer buffer = Int8List.fromList(list).buffer;
    ByteData data = ByteData.view(buffer);
    int result = data.getInt16(0, Endian.little);
    return result;
  }

  static int parseFromINT_32(List<int> list) {
    ByteBuffer buffer = Int8List.fromList(list).buffer;
    ByteData data = ByteData.view(buffer);
    int result = data.getInt32(0, Endian.little);
    return result;
  }

  static Uint8List parseToFloat_64(double data) {
    var byte = Uint8List(8)
      ..buffer.asByteData().setFloat64(0, data, Endian.little);
    return byte;
  }

  static Uint8List parseToFloat_32(double data) {
    var byte = Uint8List(4)
      ..buffer.asByteData().setFloat32(0, data, Endian.little);
    return byte;
  }

  static Uint8List parseToUint_16(int data) {
    var byte = Uint8List(2)
      ..buffer.asByteData().setUint16(0, data, Endian.little);
    return byte;
  }

  static String buatToken(int jumlah) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        jumlah,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }

  static int buatID() {
    final rnd = Random();
    return rnd.nextInt(99999999);
  }

  static List<int> stringToList(String data) {
    return data.codeUnits;
  }

  // static String toHex(List<int> list) {
  //   String result = hex.encoder.convert(list);
  //   return result;
  // }
}
