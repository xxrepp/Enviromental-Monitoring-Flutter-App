import 'package:flutter_test/flutter_test.dart';
import 'package:skripsi/api/suhuhistory.dart';
import 'package:skripsi/api/anginhistory.dart';
import 'package:skripsi/api/kelembabanhistory.dart';
import 'package:skripsi/api/teganganhistory.dart';
import 'package:skripsi/api/getaranhistory.dart';

void main() {
  group('Cek Get History', () {
    group('Get Angin History Tests', () {
      test('Get Angin History Test', () async {
        var angin1hour = await getAngin1Hour();
        expect(angin1hour, isNotNull);

        var angin3hour = await getAngin3Hour();
        expect(angin3hour, isNotNull);

        var angin6hour = await getAngin6Hour();
        expect(angin6hour, isNotNull);
      });
    });
    group('Get Getaran History Tests', () {
      test('Get Getaran History Test', () async {
        var getaran1hour = await getGetaran1Hour();
        expect(getaran1hour, isNotNull);

        var getaran3hour = await getGetaran3Hour();
        expect(getaran3hour, isNotNull);

        var getaran6hour = await getGetaran6Hour();
        expect(getaran6hour, isNotNull);
      });
    });
    group('Get Kelembapan History Tests', () {
      test('Get Kelembapan History Test', () async {
        var kelembaban1hour = await getKelembaban1Hour();
        expect(kelembaban1hour, isNotNull);

        var kelembaban3hour = await getKelembaban1Hour();
        expect(kelembaban3hour, isNotNull);

        var kelembaban6hour = await getKelembaban6Hour();
        expect(kelembaban6hour, isNotNull);
      });
    });
    group('Get Suhu History Tests', () {
      test('Get Suhu History Test', () async {
        var suhu1hour = await getSuhu1Hour();
        expect(suhu1hour, isNotNull);

        var suhu3hour = await getSuhu3Hour();
        expect(suhu3hour, isNotNull);

        var suhu6hour = await getSuhu6Hour();
        expect(suhu6hour, isNotNull);
      });
    });
    group('Get Tegangan History Tests', () {
      test('Get Tegangan History Test', () async {
        var tegangan1hour = await getTegangan1hour();
        expect(tegangan1hour, isNotNull);

        var tegangan3hour = await getTegangan3Hour();
        expect(tegangan3hour, isNotNull);

        var tegangan6hour = await getTegangan6Hour();
        expect(tegangan6hour, isNotNull);
      });
    });
  });
}
