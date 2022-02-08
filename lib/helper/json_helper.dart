import 'dart:convert';

Map<String, dynamic> tryDecode(String txtData) {
  try {
    Map<String, dynamic> data = json.decode(txtData);
    return data;
  } catch (e) {
    print("cannot decode json message: $e");
    // throw SodaException(
    //   "cannot communicate with server ${e.hashCode}",
    // );
    throw e;
  }
}
