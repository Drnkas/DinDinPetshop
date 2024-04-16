import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Store {
  String? name;
  String? image;
  String? phone;
  String? address;
  Map<String, Map<String, TimeOfDay>>? opening;

  Store({
    this.name,
    this.image,
    this.phone,
    this.address,
    this.opening,
  });

  factory Store.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    Map<String, Map<String, TimeOfDay>>? openingMap;

    if (data?['opening'] != null) {
      final Map<String, dynamic>? openingData = data?['opening'];

      openingMap = openingData!.map((key, value) {
        final timesString = value as String;

        if (timesString != null && timesString.isNotEmpty) {
          final splitted = timesString.split(RegExp(r"[:-]"));

          return MapEntry(
            key,
            {
              "from": TimeOfDay(
                hour: int.parse(splitted[0]),
                minute: int.parse(splitted[1]),
              ),
              "to": TimeOfDay(
                hour: int.parse(splitted[2]),
                minute: int.parse(splitted[3]),
              ),
            },
          );
        } else {
          return MapEntry(key, <String, TimeOfDay>{});
        }
      });
    }
    return Store(
      name: data?['name'] as String?,
      image: data?['image'] as String?,
      phone: data?['phone'] as String?,
      address: data?['address'] as String?,
      opening: openingMap,
    );
  }

  String getOpeningText() {
    String text = '';

    if (opening != null) {
      if (opening!.containsKey('monfri')) {
        final monfri = opening!['monfri'];
        if (monfri != null && monfri is Map<String, TimeOfDay>) {
          text += 'Seg-Sex: ${formattedPeriod(monfri)}\n';
        } else {
          text += 'Seg-Sex: Fechada\n';
        }
      }
      if (opening!.containsKey('saturday')) {
        final saturday = opening!['saturday'];
        if (saturday != null && saturday is Map<String, TimeOfDay>) {
          text += 'Sábado: ${formattedPeriod(saturday)}\n';
        } else {
          text += 'Sábado: Fechada\n';
        }
      }
      if (opening!.containsKey('sunday')) {
        final sunday = opening!['sunday'];
        if (sunday != null && sunday is Map<String, TimeOfDay>) {
          text += 'Domingo: ${formattedPeriod(sunday)}\n';
        } else {
          text += 'Domingo: Fechada\n';
        }
      }
    } else {
      text = 'Fechada todos os dias\n';
    }

    return text;
  }

  String formattedPeriod(Map<String, TimeOfDay> period) {
    if (period.isEmpty) {
      return "Fechada";
    } else {
      final TimeOfDay from = period['from']!;
      final TimeOfDay to = period['to']!;
      return '${from.hour}:${from.minute.toString().padLeft(2, '0')} - ${to.hour}:${to.minute.toString().padLeft(2, '0')}';
    }
  }
}