import 'dart:async';
import 'dart:math';

// Kelas untuk menghitung limit
class LimitCalculator {
  double Function(double) function;

  LimitCalculator(this.function);

  // Fungsi untuk menghitung limit dengan pendekatan numerik
  double calculateLimit(double c, double epsilon) {
    try {
      if (epsilon <= 0) {
        throw Exception("Epsilon harus lebih besar dari 0.");
      }

      // Menghitung limit menggunakan metode perbedaan kecil (difference quotient)
      double f1 = function(c - epsilon); // Nilai fungsi di c - epsilon
      double f2 = function(c + epsilon); // Nilai fungsi di c + epsilon

      // Rata-rata f1 dan f2 dianggap mendekati limit
      return (f1 + f2) / 2;
    } catch (e) {
      print("Terjadi kesalahan: ${e.toString()}");
      return double.nan; // Mengembalikan NaN jika terjadi kesalahan
    }
  }

  // Fungsi async untuk menghitung limit secara asynchronous
  Future<double> calculateLimitAsync(double c, double epsilon) async {
    return await Future.delayed(Duration(seconds: 2), () {
      return calculateLimit(c, epsilon);
    });
  }
}

void main() async {
  // Fungsi yang akan dihitung limitnya, misalnya f(x) = sin(x)/x
  double function(double x) {
    if (x == 0) {
      // Menghindari pembagian oleh nol
      return 1.0;
    }
    return sin(x) / x;
  }

  // Membuat objek dari kelas LimitCalculator
  var calculator = LimitCalculator(function);

  // Parameter untuk menghitung limit pada titik c = 0 dengan epsilon = 0.0001
  double c = 0;
  double epsilon = 0.0001;

  // Memanggil perhitungan limit secara asynchronous
  print("Menghitung limit secara asynchronous...");
  double result = await calculator.calculateLimitAsync(c, epsilon);
  print("Hasil limit: $result");

  // Struktur kontrol untuk memvalidasi hasil
  if (result.isFinite) {
    print("Perhitungan limit berhasil!");
  } else {
    print("Perhitungan limit gagal.");
  }
}
