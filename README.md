# Tugas 9
## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? 
Ya, dengan menggunakan map di Dart.
### Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Apakah lebih baik membuat model sebelum mengambil data JSON atau tidak bergantung pada use case. Jika kita sudah mengetahui struktur data JSON sebelumnya, membuat model dapat mempermudah pengerjaan data. Namun, jika struktur data JSON tidak diketahui atau dinamis, penguraiannya secara dinamis menggunakan json.decode() di Flutter bisa lebih mudah.

## Fungsi dari CookieRequest dan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Sepengetahuan saya setelah membaca class CookieRequest, sepertinya CookieRequest menyediakan fungsionalitas yang dibutuhkan untuk mengimplementasikan autentikasi dari Django di Flutter, seperti contohnya method untuk mengirim HTTP request ke Django dan untuk memanage cookies. Instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter untuk memastikan bahwa status autentikasi dan cookies konsisten di seluruh app kita.

## Mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.
Untuk mengambil data dari file JSON di Flutter, kita dapat menggunakan method `json.decode()` yang disediakan oleh library `dart:convert`. Metode ini mengambil string JSON sebagai input dan return objek dinamis yang mewakili data JSON yang telah di parse. Kemudian kita dapat mengakses properti objek JSON menggunakan dot notation atau square bracket notation. Untuk menampilkan data, contohnya dapat menggunakan ListView.builder

## Mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
User menginput username dan password pada `LoginPage`, dan saat tombol login diclick, sebuah HTTP request terkirim dengan endpoint URL proyek Django. Django melakukan verifikasi pada data tersebut, lalu mengirimkan token pada Flutter, yang lalu memberikan response yang sesuai.

## Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.
- **FutureBuilder**: Widget yang membangun dirinya sendiri berdasarkan cuplikan terkini dari masa depan. Digunakan untuk menampilkan data dari sumber asynchronous, seperti layanan web.
- **ListView**: Widget yang menampilkan daftar yang dapat di-scroll, baik secara horizontal maupun vertikal. Digunakan untuk menampilkan banyak item dalam tata letak linier.
- **TextField**: Widget yang menampilkan kolom teks yang dapat diedit, biasanya dengan label, ikon, dan petunjuk. Digunakan untuk menerima input pengguna.
- **ElevatedButton**: Widget yang menampilkan tombol timbul, biasanya dengan label teks dan ikon. Digunakan untuk melakukan suatu tindakan saat ditekan.
- **SnackBar**: Widget yang menampilkan pesan singkat di bagian bawah layar, biasanya disertai action. Digunakan untuk memberikan feedback kepada pengguna.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step
### Membuat halaman login pada proyek tugas Flutter.
Saya membuat sebuah app baru bernama `authentication` di Django, lalu membuat fungsi login pada `views.py` nya, dengan memanfaatkan `pbp_django_auth`. Lalu saya membuat halaman login di dart.

## Membuat model kustom sesuai dengan proyek aplikasi Django.
Saya memanfaatkan Quicktype untuk mengconvert database JSON di proyek Django menjadi Dart

## Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.
Saya membuat file baru di `screens` bernama `list_view.dart`, yang berisi kode berikut:
```
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toko_kadal_mobile/models/product.dart';
import 'package:toko_kadal_mobile/widgets/left_drawer.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://localhost:8000/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Product> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Product.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data![index].fields.name}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.price}"),
                            const SizedBox(height: 10),
                            Text(
                                "${snapshot.data![index].fields.description}")
                          ],
                        ),
                      ));
                }
              }
            }));
  }
}
```
Lalu membuat agar ketika tombol lihat produk di `left_drawer.dart` dan `menu.dart` mengarah kesitu


# Tugas 8
## Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!
`Navigator.push()` digunakan untuk menavigasi ke screen baru, sekaligus menyimpan screen saat ini di stack. Artinya jika tombol kembali ditekan, kita akan kembali ke screen sebelumnya. Berikut ini contoh penggunaannya:

```
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);
```

`Navigator.pushReplacement()` juga digunakan untuk menavigasi ke screen baru, namun **mengganti** screen saat ini di stack dengan yang baru. Artinya jika tombol back ditekan, kita tidak akan kembali ke screen sebelumnya, karena sudah diganti. Berikut ini contoh penggunaannya:

```
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);
```

Singkatnya, perbedaan utamanya adalah `Navigator.push()` mempertahankan screen lama di stack (memungkinkan kita kembali ke sana), sementara `Navigator.pushReplacement()` menghapus screen lama dari stack.

## Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!
Di Flutter, ada dua jenis layout widget utama: Single-child layout widgets dan Multi-child layout widgets. Berikut penjelasan singkat tentang beberapa yang paling umum digunakan:
**Single-child layout widgets**:
- `Container`: Widget  yang menggabungkan widget painting, positioning, dan sizing.
- `Padding`: Menyisipkan child nya berdasarkan padding yang diberikan.
- `Align`: Menyejajarkan child nya dengan dirinya sendiri
- `Center`: Memusatkan child nya ke dalam dirinya sendiri.
- `SizedBox`: Kotak dengan ukuran tertentu.

**Multi-child layout widgets**:
- `Row`: Menata child widgets secara horizontal.
- `Column`: Menata child widgets secara vertikal.
- `Stack`: Overlap beberapa child widget
- `ListView`: Daftar widget yang dapat discroll.
- `GridView`: Daftar grid terdiri dari pola sel berulang yang disusun dalam tata letak vertikal dan horizontal.

## Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
Saya menggunakan `TextFormField` karena semua atribut produk saya, yaitu: nama, deskripsi, dan harga semuanya berupa string, maka `TextFormField` cocok karena saya membutuhkan cara untuk menginput string bebas.

## Bagaimana penerapan clean architecture pada aplikasi Flutter?
Menerapkan arsitektur bersih dalam aplikasi Flutter melibatkan penataan kode menjadi beberapa lapisan dengan tanggung jawab berbeda, contohnya di aplikasi saya adalah `screens` dan `widgets`. Ini meningkatkan kerapihan kode, kemampuan testing, dan maintanability.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step!
### Membuat Halaman Form untuk Tambah Item Baru
Saya membuat file `shoplist_form.dart` di folder `screens` lalu menambahkan kode berikut:
```
import 'package:flutter/material.dart';
import 'package:toko_kadal_mobile/widgets/left_drawer.dart';

class ShopFormPage extends StatefulWidget {
  const ShopFormPage({super.key});

  @override
  State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Produk',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nama Produk",
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _name = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Harga",
                  labelText: "Harga",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _price = int.parse(value!);
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Harga harus berupa angka!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Deskripsi",
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _description = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Produk berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: $_name'),
                                  Text('Harga: $_price'),
                                  Text('Deskripsi: $_description')
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                      _formKey.currentState!.reset();
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
```
Lalu tambahkan potongan kode ini pada `ontap()` di `shop_card.dart`:
```
onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShopFormPage()));
            },
```
untuk mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item pada halaman utama.

### Menambahkan Drawer Menu
Saya membuat file `left_drawer.dart` di folder `widgets` lalu menambahkan kode berikut:
```
import 'package:flutter/material.dart';
import 'package:toko_kadal_mobile/screens/menu.dart';
import 'package:toko_kadal_mobile/screens/shoplist_form.dart';


class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Shopping List',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Catat seluruh keperluan belanjamu di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Produk'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShopFormPage()));
            },
          ),
        ],
      ),
    );
  }
}
```

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
