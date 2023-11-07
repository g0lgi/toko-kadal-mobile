# Tugas 7
## Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?
**Stateless Widget**:
Stateless widget bersifat statis dan tidak berubah selama runtime.
Mereka tidak bergantung pada perubahan data atau perubahan perilaku apa pun.
Stateless widget tidak memiliki status, widget tersebut akan dirender satu kali dan tidak akan diperbarui sendiri, tetapi hanya akan diperbarui ketika data eksternal berubah.
Contoh widget stateless adalah teks, ikon, tombol ikon, dan tombol timbul.

**Stateful widget**:
Stateful widget bersifat dinamis dan dapat mengubah propertinya selama run-time.
Mereka dapat diulang beberapa kali selama masa pakainya.
Mereka dapat mengubah tampilannya sebagai respons terhadap peristiwa yang dipicu oleh interaksi pengguna atau ketika menerima data.
Contoh widget stateful adalah Checkbox, Radio Button, Slider, InkWell, Form, dan TextField.

## Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

1. **MaterialApp**: Merupakan widget root aplikasi. Ini menyediakan sejumlah fitur seperti tema, navigasi, dan judul yang umum pada banyak aplikasi.

2. **ThemeData**: Mendefinisikan keseluruhan tema visual untuk `MaterialApp` atau widget dalam aplikasi. Dalam kode saya, saya menggunakan `ColorScheme.fromSeed(seedColor: Colors.indigo)` untuk menghasilkan skema warna berdasarkan `Colors.indigo`.

3. **MyHomePage**: Widget stateless custom yang mengembalikan widget `Scaffold`, yang menyediakan kerangka kerja di mana Anda dapat mengatur widget lain dalam berbagai tata letak.

4. **Scaffold**: Top-level container yang menyediakan struktur untuk aplikasi saya. Scaffold memiliki slot untuk `AppBar`, `Drawer`, `SnackBar`, dll. Dalam kode saya, saya menggunakannya untuk membuat layout dengan `AppBar` dan isi yang berisi `SingleChildScrollView`.

5. **AppBar**: Widget yang muncul di bagian atas layar dalam aplikasi desain material, dan dapat berisi judul, actions, dan widget lainnya.

6. **SingleChildScrollView**: Ini adalah kotak tempat satu widget dapat discroll.

7. **Padding**: Widget yang menyisipkan anaknya berdasarkan padding yang diberikan.

8. **Column**: Widget yang menampilkan anaknya dalam array vertikal.

9. **GridView**: Daftar grid widget yang dapat dsicroll dan disusun dalam array 2D.

10. **ShopCard**: Widget custom yang mengembalikan widget `Material` yang meresponi sentuhan

11. **Material**: Selembar kertas konseptual tempat UI muncul. Juga membuat efek saat item diklik

12. **InkWell**: Area material berbentuk persegi panjang yang meresponi sentuhan.

13. **Container**: Widget praktis yang menggabungkan widget painting, positioning, dan sizing umum

14. **Center**: Widget yang memusatkan anaknya di dalam dirinya sendiri.

15. **Icon** dan **Text**: Widget ini masing-masing menampilkan ikon dan string teks.

## Jelaskan bagaimana cara mengimplementasikan checklist secara step-by-step
### Membuat sebuah program Flutter baru dengan tema inventory seperti tugas-tugas sebelumnya.
Saya membuat folder bernama `toko_kadal_mobile`, yaitu folder dimana saya ingin menyimpan projek ini, lalu saya ketik `cmd` di tempat path di file manager, lalu menjalankan perintah:
```
flutter create toko_kadal_mobile
cd toko_kadal_mobile
```
Lalu jalankan projek dengan `flutter run`
Saya merapikan project dengan membuka project di Android Studio, lalu membuat file baru bernama `menu.dart`. Saya memindahkan `class MyHomePage ...` dari `main.dart` ke `menu.dart`, lalu menambahkan:
```
import 'package:toko_kadal_mobile/menu.dart'
```
pada main.dart
### Membuat tiga tombol sederhana dengan ikon dan teks
Pada menu.dart, saya membuat class baru untuk tombol:
```
class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}
```
Lalu membuat class widget stateless untuk menampilkan mereka:
```
class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```
Di dalamnya terdapat kode:
```
onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        }
```
untuk menampilkan snackbar ketika tombol diclick
