// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
    String status;
    String message;
    Data data;

    ModelLogin({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String idUser;
    String nama;
    String nobp;
    String nohp;
    String email;
    DateTime created;
    dynamic updated;

    Data({
        required this.idUser,
        required this.nama,
        required this.nobp,
        required this.nohp,
        required this.email,
        required this.created,
        required this.updated,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idUser: json["id_user"],
        nama: json["nama"],
        nobp: json["nobp"],
        nohp: json["nohp"],
        email: json["email"],
        created: DateTime.parse(json["created"]),
        updated: json["updated"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "nobp": nobp,
        "nohp": nohp,
        "email": email,
        "created": created.toIso8601String(),
        "updated": updated,
    };
}
