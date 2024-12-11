import 'package:flutter/material.dart';
import 'package:toko_kita/model/produk.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  const ProdukForm({super.key, this.produk});

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _judul = "TAMBAH PRODUK";
  String _tombolSubmit = "SIMPAN";

  final TextEditingController _kodeProdukController = TextEditingController();
  final TextEditingController _namaProdukController = TextEditingController();
  final TextEditingController _hargaProdukController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.produk != null) {
      setState(() {
        _judul = "UBAH PRODUK";
        _tombolSubmit = "UBAH";
        _kodeProdukController.text = widget.produk!.kodeProduk;
        _namaProdukController.text = widget.produk!.namaProduk;
        _hargaProdukController.text = widget.produk!.hargaProduk.toString();
      });
    } else {
      _judul = "TAMBAH PRODUK";
      _tombolSubmit = "SIMPAN";
    }
  }

  @override
  void dispose() {
    // Membersihkan controller untuk menghindari memory leaks
    _kodeProdukController.dispose();
    _namaProdukController.dispose();
    _hargaProdukController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_judul),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _kodeProdukController,
                  labelText: "Kode Produk",
                  validator: (value) => value == null || value.isEmpty
                      ? "Kode Produk harus diisi"
                      : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _namaProdukController,
                  labelText: "Nama Produk",
                  validator: (value) => value == null || value.isEmpty
                      ? "Nama Produk harus diisi"
                      : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _hargaProdukController,
                  labelText: "Harga",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harga harus diisi";
                    }
                    final harga = double.tryParse(value);
                    if (harga == null || harga <= 0) {
                      return "Harga harus berupa angka positif";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget builder untuk TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  // Widget untuk tombol submit
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () {
                if (_formKey.currentState?.validate() == true) {
                  setState(() {
                    _isLoading = true;
                  });

                  // Simulasi proses submit
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      _isLoading = false;
                    });
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.produk != null
                              ? "Produk berhasil diubah"
                              : "Produk berhasil ditambahkan",
                        ),
                      ),
                    );
                  });
                }
              },
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(_tombolSubmit),
      ),
    );
  }
}
