import 'package:cached_network_image/cached_network_image.dart';
import 'package:entrance_test/src/utils/number_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/color.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/icon.dart';
import '../../../../constants/image.dart';
import '../../../../widgets/empty_list_state_widget.dart';
import 'component/product_detail_controller.dart';

class ProducDetailtPage extends GetWidget<ProductDetailController> {
  const ProducDetailtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text(
            "Detail Product",
            style: TextStyle(
              fontSize: 18,
              color: black,
              fontFamily: FontsApp.interMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
          backgroundColor: white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: gray200,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    boardingImage2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Triple Set Concentrate WX Bpom for Dark Spots",
                      style: TextStyle(
                        fontSize: 20,
                        color: black,
                        fontFamily: FontsApp.interMedium,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Rp334.000",
                      style: TextStyle(
                        fontSize: 20,
                        color: black,
                        fontFamily: FontsApp.interMedium,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: yellow,
                          // size: 16,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          "4.8",
                          style: TextStyle(
                            fontSize: 16,
                            color: black,
                            fontFamily: FontsApp.interMedium,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          "(248 Reviews)",
                          style: TextStyle(
                            fontSize: 16,
                            color: black600,
                            fontFamily: FontsApp.interMedium,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: gray100,
                width: double.infinity,
                height: 4,
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Product Description",
                      style: TextStyle(
                        fontSize: 18,
                        color: black,
                        fontFamily: FontsApp.interMedium,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Triple Set Concentrate WX BPOM for Dark Spots terdiri dari 3 produk:\n1. Concentrate Glowhite Serum Essence\n2. WX Night Cream BPOM\n3. Luminous Physical Sunscreen SPF50\nTriple Set Concentrate WX BPOM for Dark Spots merupakan paket hemat untuk mengatasi flek melasma, mencerahkan dan merawat kulit. *Bumil & busui friendly.",
                      style: TextStyle(
                        fontSize: 14,
                        color: black,
                        fontFamily: FontsApp.interMedium,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: gray100,
                width: double.infinity,
                height: 4,
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Terms & Conditions of Return / Refund",
                      style: TextStyle(
                        fontSize: 18,
                        color: black,
                        fontFamily: FontsApp.interMedium,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "1. Mohon untuk bisa melakukan video unboxing (pembukaan paket), foto penerimaan produk, foto resi dan label pembeli saat paket sudah berhasil diterima sehingga jika ada kerusakan, kekurangan produk/hadiah, atau ketidaksesuaian produk yang diterima bisa dilakukan validasi melalui kelengkapan tersebut\n2. Jika tidak ada atau hanya memiliki salah satu dari kelengkapan yang disebutkan, maka segala bentuk komplain yang masuk tidak bisa ditindaklanjuti atau dianggap tidak sah, kecuali memang ada kesalahan dari sisi penjual\n3. Kerusakan packaging hanya pada bagian luar (bagian dalam utuh, produk tidak ada kerusakan/kekurangan, dll) disebabkan penanganan paket dari pihak jasa ekspedisi yang kurang baik, diharapkan agar pembeli bisa melakukan komplain langsung ke pihak jasa ekspedisi",
                      style: TextStyle(
                        fontSize: 14,
                        color: black,
                        fontFamily: FontsApp.interMedium,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: gray100,
                width: double.infinity,
                height: 4,
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Product Review",
                          style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontFamily: FontsApp.interMedium,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "See More",
                          style: TextStyle(
                            fontSize: 16,
                            color: primary,
                            fontFamily: FontsApp.interMedium,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Icon(
                      Icons.star,
                      color: yellow,
                      // size: 16,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      "1. Mohon untuk bisa melakukan video unboxing (pembukaan paket), foto penerimaan produk, foto resi dan label pembeli saat paket sudah berhasil diterima sehingga jika ada kerusakan, kekurangan produk/hadiah, atau ketidaksesuaian produk yang diterima bisa dilakukan validasi melalui kelengkapan tersebut\n2. Jika tidak ada atau hanya memiliki salah satu dari kelengkapan yang disebutkan, maka segala bentuk komplain yang masuk tidak bisa ditindaklanjuti atau dianggap tidak sah, kecuali memang ada kesalahan dari sisi penjual\n3. Kerusakan packaging hanya pada bagian luar (bagian dalam utuh, produk tidak ada kerusakan/kekurangan, dll) disebabkan penanganan paket dari pihak jasa ekspedisi yang kurang baik, diharapkan agar pembeli bisa melakukan komplain langsung ke pihak jasa ekspedisi",
                      style: TextStyle(
                        fontSize: 14,
                        color: black,
                        fontFamily: FontsApp.interMedium,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
