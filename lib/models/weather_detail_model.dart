import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:weather_check/utils/json_helper.dart';

//part 'weather_detail_model.g.dart';



// @HiveType(typeId: 1)
// class WeatherModel {
//   @HiveField(0)
//   String accounttype;
//   @HiveField(1)
//   String status;
//   @HiveField(2)
//   String paymentstatus;
//   @HiveField(3)
//   String paymentmethod;
//   @HiveField(4)
//   num accountbalance;
//   @HiveField(5)
//   num orderamount;
//   @HiveField(6)
//   String id;
//   @HiveField(7)
//   String name;
//   @HiveField(8)
//   String email;
//   @HiveField(9)
//   String phone;
//   @HiveField(10)
//   String merchant;
//   @HiveField(11)
//   String cashpoint;
//   @HiveField(12)
//   String transactionref;
//   @HiveField(13)
//   String accountnumber;
//   @HiveField(14)
//   DateTime createdon;
//   @HiveField(15)
//   String inboundReference;

//   WeatherModel(
//       {this.accounttype = "",
//       this.status = "",
//       this.paymentstatus = "",
//       this.paymentmethod = "",
//       this.accountbalance = 0,
//       this.orderamount = 0,
//       this.id = "",
//       this.name = "",
//       this.email = "",
//       this.phone = "",
//       this.merchant = "",
//       this.cashpoint = "",
//       this.transactionref = "",
//       this.accountnumber = "",
//       required this.createdon,
//       this.inboundReference = ""});

//   factory WeatherModel.fromJson(Map<String, dynamic> json) =>
//       WeatherModel(
//         accounttype: ParserUtil.parseJsonString(json, "accounttype"),
//         status: json["status"],
//         paymentstatus: ParserUtil.parseJsonString(json, "paymentstatus"),
//         paymentmethod: ParserUtil.parseJsonString(json, "paymentmethod"),
//         accountbalance: json["accountbalance"],
//         orderamount: json["orderamount"],
//         id: ParserUtil.parseJsonString(json, "_id"),
//         name: ParserUtil.parseJsonString(json, "name"),
//         email: ParserUtil.parseJsonString(json, "email"),
//         phone: ParserUtil.parseJsonString(json, "phone"),
//         merchant: ParserUtil.parseJsonString(json, "merchant"),
//         cashpoint: ParserUtil.parseJsonString(json, "cashpoint"),
//         transactionref: ParserUtil.parseJsonString(json, "transactionref"),
//         accountnumber: ParserUtil.parseJsonString(json, "accountnumber"),
//         inboundReference: ParserUtil.parseJsonString(json, "inbound_reference"),
//         createdon: DateTime.parse(json["createdon"]).add(Duration(hours: 1)),
//       );

//   Map<String, dynamic> toJson() => {
//         "accounttype": accounttype,
//         "status": status,
//         "paymentstatus": paymentstatus,
//         "paymentmethod": paymentmethod,
//         "accountbalance": accountbalance,
//         "orderamount": orderamount,
//         "_id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "merchant": merchant,
//         "cashpoint": cashpoint,
//         "transactionref": transactionref,
//         "accountnumber": accountnumber,
//         "createdon": createdon.toIso8601String(),
//       };
// }

// TransactionsData transactionsDataFromJson(String str) =>
//     TransactionsData.fromJson(json.decode(str));

// String transactionsDataToJson(TransactionsData data) =>
//     json.encode(data.toJson());

// @HiveType(typeId: 10)
// class TransactionsData {
//   TransactionsData({
//     this.status = false,
//     this.total = 0,
//     this.cashpointTotal = 0,
//     this.message = "",
//     this.data = const [],
//     this.page = "",
//     this.pages = 0,
//   });

//   @HiveField(0)
//   bool status;
//   @HiveField(1)
//   num total;
//   @HiveField(2)
//   num cashpointTotal;
//   @HiveField(3)
//   String message;
//   @HiveField(4)
//   List<TransactionsDatum> data;
//   @HiveField(5)
//   String page;
//   @HiveField(6)
//   int pages;

//   factory TransactionsData.fromJson(Map<String, dynamic> json) =>
//       TransactionsData(
//         status: json["status"],
//         total: json["total"],
//         cashpointTotal: json["cashpoint_total"],
//         message: json["message"],
//         data: List<TransactionsDatum>.from(
//             json["data"].map((x) => TransactionsDatum.fromJson(x))),
//         page: ParserUtil.parseJsonString(json, "page"),
//         pages: json["pages"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "total": total,
//         "cashpoint_total": cashpointTotal,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "page": page,
//         "pages": pages,
//       };
// }

// @HiveType(typeId: 11)
// class TransactionsDatum {
//   TransactionsDatum({
//     this.id = "",
//     this.visible = false,
//     this.accounttype = "",
//     this.status = "",
//     this.paymentstatus = "",
//     this.paymentmethod = "",
//     this.accountbalance = 0,
//     this.orderamount = 0,
//     this.name = "",
//     this.email = "",
//     this.phone = "",
//     this.merchant = "",
//     this.cashpoint = "",
//     this.accountnumber = "",
//     this.transactionref = "",
//     this.paymentcode = "",
//     this.inboundReference = "",
//     required this.createdon,
//     required this.createdAt,
//     required this.updatedAt,
//     this.merchanttransactiondata = const [],
//   });

//   @HiveField(0)
//   String id;
//   @HiveField(1)
//   bool visible;
//   @HiveField(2)
//   String accounttype;
//   @HiveField(3)
//   String status;
//   @HiveField(4)
//   String paymentstatus;
//   @HiveField(5)
//   String paymentmethod;
//   @HiveField(6)
//   num accountbalance;
//   @HiveField(7)
//   num orderamount;
//   @HiveField(8)
//   String name;
//   @HiveField(9)
//   String email;
//   @HiveField(10)
//   String phone;
//   @HiveField(11)
//   String merchant;
//   @HiveField(12)
//   String cashpoint;
//   @HiveField(13)
//   String accountnumber;
//   @HiveField(14)
//   String transactionref;
//   @HiveField(15)
//   String paymentcode;
//   @HiveField(16)
//   String inboundReference;
//   @HiveField(17)
//   DateTime createdon;
//   @HiveField(18)
//   DateTime createdAt;
//   @HiveField(19)
//   DateTime updatedAt;
//   @HiveField(20)
//   List<Merchanttransactiondatum> merchanttransactiondata;

//   factory TransactionsDatum.fromJson(Map<String, dynamic> json) =>
//       TransactionsDatum(
//         id: ParserUtil.parseJsonString(json, "_id"),
//         visible: json["visible"],
//         accounttype: ParserUtil.parseJsonString(json, "accounttype"),
//         status: ParserUtil.parseJsonString(json, "status"),
//         paymentstatus: ParserUtil.parseJsonString(json, "paymentstatus"),
//         paymentmethod: ParserUtil.parseJsonString(json, "paymentmethod"),
//         accountbalance: json["accountbalance"],
//         orderamount: json["orderamount"],
//         name: ParserUtil.parseJsonString(json, "name"),
//         email: ParserUtil.parseJsonString(json, "email"),
//         phone: ParserUtil.parseJsonString(json, "phone"),
//         merchant: ParserUtil.parseJsonString(json, "merchant"),
//         cashpoint: ParserUtil.parseJsonString(json, "cashpoint"),
//         accountnumber: ParserUtil.parseJsonString(json, "accountnumber"),
//         transactionref: ParserUtil.parseJsonString(json, "transactionref"),
//         paymentcode: ParserUtil.parseJsonString(json, "paymentcode"),
//         inboundReference: ParserUtil.parseJsonString(json, "inbound_reference"),
//         createdon: DateTime.parse(json["createdon"]).add(Duration(hours: 1)),
//         createdAt: DateTime.parse(json["createdAt"]).add(Duration(hours: 1)),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         merchanttransactiondata: json["merchanttransactiondata"].isEmpty
//             ? []
//             : List<Merchanttransactiondatum>.from(
//                 json["merchanttransactiondata"]
//                     .map((x) => Merchanttransactiondatum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "visible": visible,
//         "accounttype": accounttype,
//         "status": status,
//         "paymentstatus": paymentstatus,
//         "paymentmethod": paymentmethod,
//         "accountbalance": accountbalance,
//         "orderamount": orderamount,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "merchant": merchant,
//         "cashpoint": cashpoint,
//         "accountnumber": accountnumber,
//         "transactionref": transactionref,
//         "paymentcode": paymentcode,
//         "inbound_reference": inboundReference == null ? null : inboundReference,
//         "createdon": createdon.toIso8601String(),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "merchanttransactiondata":
//             List<dynamic>.from(merchanttransactiondata.map((x) => x.toJson())),
//       };
// }

// @HiveType(typeId: 12)
// class Merchanttransactiondatum {
//   Merchanttransactiondatum(
//       {this.id = "",
//       this.type = "",
//       this.feebelongsto = "",
//       this.amount = 0,
//       this.issetselfie = false,
//       this.ismasked = false,
//       this.hidechallenge = false,
//       this.hideselfie = false,
//       this.hidereversal = false,
//       this.reversed = false,
//       this.isqualifyforchallenge = false,
//       this.repeatCustomerCount = 0,
//       this.narrative = "",
//       this.transactionref = "",
//       this.wallet = "",
//       this.inboundReference = "",
//       required this.createdon,
//       this.canReverse = false,
//       this.issetVideoConfirmation = false,
//       this.selfieUrl = "",
//       required this.reversalexpireson});

//   @HiveField(0)
//   String id;
//   @HiveField(1)
//   String type;
//   @HiveField(2)
//   String feebelongsto;
//   @HiveField(3)
//   num amount;
//   @HiveField(4)
//   bool issetselfie;
//   @HiveField(5)
//   bool ismasked;
//   @HiveField(6)
//   bool hidechallenge;
//   @HiveField(7)
//   bool hideselfie;
//   @HiveField(8)
//   bool hidereversal;
//   @HiveField(9)
//   bool reversed;
//   @HiveField(10)
//   bool isqualifyforchallenge;
//   @HiveField(11)
//   String narrative;
//   @HiveField(12)
//   String transactionref;
//   @HiveField(13)
//   String wallet;
//   @HiveField(14)
//   String inboundReference;
//   @HiveField(15)
//   DateTime createdon;
//   @HiveField(16)
//   String selfieUrl;
//   @HiveField(17)
//   bool canReverse;
//   @HiveField(18)
//   DateTime reversalexpireson;
//   @HiveField(19)
//   num repeatCustomerCount;
//   @HiveField(20)
//   bool issetVideoConfirmation;

//   factory Merchanttransactiondatum.fromJson(Map<String, dynamic> json) =>
//       Merchanttransactiondatum(
//         id: json["_id"] ?? "",
//         type: json["type"] ?? "",
//         feebelongsto: json["feebelongsto"] ?? "",
//         amount: json["amount"] ?? 0,
//         issetselfie: json["issetselfie"] ?? false,
//         ismasked: json["ismasked"] ?? null,
//         hidechallenge: json["hidechallenge"] ?? false,
//         hideselfie: json["hideselfie"] ?? false,
//         hidereversal: json["hidereversal"] ?? false,
//         issetVideoConfirmation: json["issetvideoconfirmation"] ?? false,
//         reversed: json["reversed"] ?? false,
//         isqualifyforchallenge: json["isqualifyforchallenge"] == null
//             ? null
//             : json["isqualifyforchallenge"],
//         narrative: json["narrative"] ?? "",
//         transactionref: json["transactionref"] ?? "",
//         wallet: json["wallet"] ?? "",
//         inboundReference: json["inbound_reference"] ?? "",
//         canReverse: json["canreverse"] ?? false,
//         selfieUrl: json["selfie_url"] ?? "",
//         repeatCustomerCount: json["repeat_customer_count"] ?? 1,
//         createdon: DateTime.parse(json["createdon"]).add(Duration(hours: 1)),
//         reversalexpireson: DateTime.parse(json["reversalexpireson"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "type": type,
//         "feebelongsto": feebelongsto,
//         "amount": amount,
//         "issetselfie": issetselfie,
//         "ismasked": ismasked,
//         "hidechallenge": hidechallenge,
//         "hideselfie": hideselfie,
//         "hidereversal": hidereversal,
//         "reversed": reversed,
//         "isqualifyforchallenge":
//             isqualifyforchallenge == null ? null : isqualifyforchallenge,
//         "narrative": narrative,
//         "transactionref": transactionref,
//         "wallet": wallet,
//         "inbound_reference": inboundReference,
//         "canreverse": canReverse,
//         "selfie_url": selfieUrl,
//         "createdon": createdon.toIso8601String(),
//         "reversalexpireson": reversalexpireson.toIso8601String(),
//       };
// }
// //flutter packages pub run build_runner build


// // To parse this JSON data, do
// //
// //     final weatherInfoModel = weatherInfoModelFromJson(jsonString);

// import 'dart:convert';

WeatherInfoModel weatherInfoModelFromJson(String str) => WeatherInfoModel.fromJson(json.decode(str));

String weatherInfoModelToJson(WeatherInfoModel data) => json.encode(data.toJson());

class WeatherInfoModel {
    Coord coord;
    List<Weather> weather;
    String base;
    Main main;
    int visibility;
    Clouds clouds;
    int dt;
    Sys sys;
    int timezone;
    int id;
    String name;
    int cod;

    WeatherInfoModel({
        required this.coord,
        required this.weather,
        required this.base,
        required this.main,
        required this.visibility,
        required this.clouds,
        required this.dt,
        required this.sys,
        required this.timezone,
        required this.id,
        required this.name,
        required this.cod,
    });

    factory WeatherInfoModel.fromJson(Map<String, dynamic> json) => WeatherInfoModel(
        coord: Coord.fromJson(json["coord"]),
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        clouds: Clouds.fromJson(json["clouds"]),
        dt: json["dt"],
        sys: Sys.fromJson(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
    );

    Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "base": base,
        "main": main.toJson(),
        "visibility": visibility,
        "clouds": clouds.toJson(),
        "dt": dt,
        "sys": sys.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
    };
}

class Clouds {
    int all;

    Clouds({
        required this.all,
    });

    factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
    );

    Map<String, dynamic> toJson() => {
        "all": all,
    };
}

class Coord {
    num lon;
    num lat;

    Coord({
        required this.lon,
        required this.lat,
    });

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
    };
}

class Main {
    num temp;
    num feelsLike;
    num tempMin;
    num tempMax;
    num pressure;
    num humidity;
   
    Main({
        required this.temp,
        required this.feelsLike,
        required this.tempMin,
        required this.tempMax,
        required this.pressure,
        required this.humidity,
        
    });

    factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
    };
}

// class Rain {
//     double the1H;

//     Rain({
//         required this.the1H,
//     });

//     factory Rain.fromJson(Map<String, dynamic> json) => Rain(
//         the1H: json["1h"]?.toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "1h": the1H,
//     };
// }

class Sys {
   
    String country;
    int sunrise;
    int sunset;

    Sys({
        required this.country,
        required this.sunrise,
        required this.sunset,
    });

    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
       
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toJson() => {
    
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Weather {
    int id;
    String main;
    String description;
    String icon;

    Weather({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };
}

// class Wind {
    
//     int deg;
//     double gust;

//     Wind({
//         required this.deg,
//         required this.gust,
//     });

//     factory Wind.fromJson(Map<String, dynamic> json) => Wind(
//         deg: json["deg"],
//         gust: json["gust"]?.toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "deg": deg,
//         "gust": gust,
//     };
// }
