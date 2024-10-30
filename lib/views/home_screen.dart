import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/app_color.dart';
import '../controller/home_controller.dart';
import '../widget/small_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Image Container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                width: double.infinity,
                height: min(screenHeight / 5.8, 150),
                decoration: BoxDecoration(
                  color: AppColors.whiteBackground,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://plus.unsplash.com/premium_photo-1701590725747-ac131d4dcffd?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8d2Vic2l0ZSUyMGJhbm5lcnxlbnwwfHwwfHx8MA%3D%3D'),
                  ),
                ),
              ),
              SizedBox(height: min(screenHeight / 89, 10)),

              // Currency Information Container
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 15, bottom: 0),
                width: double.infinity,
                height: min(screenHeight / 4.23, 210),
                decoration: BoxDecoration(
                  color: AppColors.whiteBackground,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: min(screenHeight / 19.7, 45),
                      decoration: BoxDecoration(
                        color: AppColors.blackColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: infoText(
                        screenWidth: screenWidth,
                        fontSize: min(screenWidth / 25, 18),
                        buy: 'ဝယ်',
                        item: 'အမျိူးအစား',
                        sell: 'ရောင်း',
                        color: AppColors.whiteBackground,
                      ),
                    ),
                    SizedBox(
                      height: min(screenHeight / 6.5, 230),
                      child: Consumer<HomeController>(
                        builder: (context, homeController, child) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            shrinkWrap: true,
                            itemCount: homeController.itemPrices.length,
                            itemBuilder: (context, index) {
                              String itemName = homeController.itemPrices.keys
                                  .elementAt(index);
                              double buyPrice =
                                  homeController.itemPrices[itemName]?["buy"] ??
                                      0.0;
                              double sellPrice = homeController
                                      .itemPrices[itemName]?["sell"] ??
                                  0.0;
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: infoText(
                                  screenWidth: screenWidth,
                                  item: itemName,
                                  fontSize: min(screenWidth / 25.6875, 14),
                                  buy: buyPrice.toString(),
                                  sell: sellPrice.toString(),
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: min(screenHeight / 89, 10)),

              // Currency Selection Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.whiteBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Consumer<HomeController>(
                  builder: (context, model, child) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: model.selectedItem,
                        hint: const Text('Select Currency'),
                        items: model.itemPrices.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(key),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          model.updateSelectedItem(newValue);
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.blackColor,
                        ),
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                        ),
                        dropdownColor: AppColors.whiteBackground,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: min(screenHeight / 89, 10)),

              // Exchange Direction Radio Buttons
              Consumer<HomeController>(
                builder: (context, model, child) {
                  if (model.selectedItem == null) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.whiteBackground,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value:
                                  '${model.selectedItem?.toLowerCase()}ToKyat',
                              groupValue: model.selectedExchangeDirection,
                              onChanged: (String? value) {
                                model.updateExchangeDirection(value!);
                              },
                              activeColor: AppColors.polarGreen,
                            ),
                            SmallText(
                              textName: '${model.selectedItem ?? ''} → ကျပ်',
                              fontSize: 14,
                              color: model.selectedExchangeDirection ==
                                      '${model.selectedItem?.toLowerCase()}ToKyat'
                                  ? AppColors.polarGreen
                                  : AppColors.blackColor,
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value:
                                  'kyatTo${model.selectedItem?.toLowerCase()}',
                              groupValue: model.selectedExchangeDirection,
                              onChanged: (String? value) {
                                model.updateExchangeDirection(value!);
                              },
                              activeColor: AppColors.polarGreen,
                            ),
                            SmallText(
                              textOverflow: TextOverflow.ellipsis,
                              textName: 'ကျပ် → ${model.selectedItem ?? ''}',
                              fontSize: 14,
                              color: model.selectedExchangeDirection ==
                                      'kyatTo${model.selectedItem?.toLowerCase()}'
                                  ? AppColors.polarGreen
                                  : AppColors.blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: min(screenHeight / 59, 15)),

              // Amount Input Field with Label
              Consumer<HomeController>(
                builder: (context, model, child) {
                  String? labelText;
                  if (model.selectedItem != null &&
                      model.selectedExchangeDirection != '') {
                    labelText =
                        model.selectedExchangeDirection.startsWith('kyatTo')
                            ? 'ကျပ်'
                            : model.selectedItem;
                  }
                  if (model.selectedItem == null) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.whiteBackground,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: model.amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter amount',
                        labelText: labelText ?? '',
                        labelStyle: TextStyle(
                          color: AppColors.textColor,
                          fontSize: min(screenWidth / 25, 16),
                        ),
                      ),
                      onChanged: (value) {
                        model.updateAmount(value);
                      },
                    ),
                  );
                },
              ),

              // Calculated Result Display
              SizedBox(height: min(screenHeight / 44, 20)),
              Consumer<HomeController>(
                builder: (context, model, child) {
                  return Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: BigText(
                        textName:
                            '${model.calculatedResult.toStringAsFixed(2)} ကျပ်',
                        fontSize: min(screenWidth / 25, 18),
                        color: AppColors.whiteBackground,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: min(screenHeight / 59, 15)),

              // Exchange Button
              Container(
                width: screenWidth / 2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(
                        textName: 'လှယ်လဲမည်',
                        fontSize: min(screenWidth / 25, 18),
                        color: AppColors.whiteBackground,
                      ),
                      const Icon(
                        Icons.show_chart,
                        color: AppColors.whiteBackground,
                        size: 32,
                      )
                    ],
                  ),
                ),
              ),

              // Facebook and Telegram Links
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           launchFacebookPage();
              //         },
              //         child: Image.asset(
              //           'assets/facebook1.png',
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       InkWell(
              //         onTap: () async {
              //           final Uri telegramUrl =
              //               Uri.parse('https://t.me/+fpQjTxkqg5I0ZWY1');
              //           if (await canLaunchUrl(telegramUrl)) {
              //             await launchUrl(
              //               telegramUrl,
              //               mode: LaunchMode.externalApplication,
              //             );
              //           } else {
              //             print('Could not launch Telegram');
              //           }
              //         },
              //         child: Image.asset('assets/telegram1.png'),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget infoText({
  required double screenWidth,
  required String item,
  required String buy,
  required String sell,
  required Color color,
  FontWeight fontWeight = FontWeight.w500,
  double fontSize = 18,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      SmallText(
        textName: item,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        textAlgin: TextAlign.start,
      ),
      SmallText(
        textName: buy,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        textAlgin: TextAlign.start,
      ),
      SmallText(
        textName: sell,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        textAlgin: TextAlign.start,
      )
    ],
  );
}
