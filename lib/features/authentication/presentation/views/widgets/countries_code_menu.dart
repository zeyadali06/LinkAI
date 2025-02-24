import 'package:flutter/material.dart';
import 'package:linkai/features/authentication/data/models/country_model.dart';

class CountriesCodeMenu extends StatefulWidget {
  const CountriesCodeMenu({super.key, required this.onChanged});

  final void Function(Country country) onChanged;

  @override
  State<CountriesCodeMenu> createState() => _CountriesCodeMenuState();
}

class _CountriesCodeMenuState extends State<CountriesCodeMenu> {
  late Country selectedCountryCode;
  late String countryCode;
  late String phoneNumber;

  @override
  void initState() {
    selectedCountryCode = countries[0];
    countryCode = "";
    phoneNumber = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xffe6e6e6)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<Country>(
        value: selectedCountryCode,
        underline: const SizedBox(),
        onChanged: (Country? newValue) {
          selectedCountryCode = newValue!;
          widget.onChanged(selectedCountryCode);
          setState(() {});
        },
        items: countries.map<DropdownMenuItem<Country>>((Country value) {
          return DropdownMenuItem<Country>(
            value: value,
            child: Row(
              children: [
                Text(
                  "${value.code} ${value.flag}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
