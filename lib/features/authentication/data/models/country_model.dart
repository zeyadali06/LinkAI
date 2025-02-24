class Country {
  final String code;
  final String flag;
  final String countryName;
  final String nickName;

  const Country({required this.nickName, required this.code, required this.countryName, required this.flag});
}

const List<Country> countries = [
  Country(code: '+61', nickName: 'AU', countryName: 'Australia', flag: '🇦🇺'),
  Country(code: '+43', nickName: 'AT', countryName: 'Austria', flag: '🇦🇹'),
  Country(code: '+32', nickName: 'BE', countryName: 'Belgium', flag: '🇧🇪'),
  Country(code: '+55', nickName: 'BR', countryName: 'Brazil', flag: '🇧🇷'),
  Country(code: '+86', nickName: 'CN', countryName: 'China', flag: '🇨🇳'),
  Country(code: '+357', nickName: 'CY', countryName: 'Cyprus', flag: '🇨🇾'),
  Country(code: '+45', nickName: 'DK', countryName: 'Denmark', flag: '🇩🇰'),
  Country(code: '+2', nickName: 'EG', countryName: 'Egypt', flag: '🇪🇬'),
  Country(code: '+372', nickName: 'EE', countryName: 'Estonia', flag: '🇪🇪'),
  Country(code: '+33', nickName: 'FR', countryName: 'France', flag: '🇫🇷'),
  Country(code: '+49', nickName: 'DE', countryName: 'Germany', flag: '🇩🇪'),
  Country(code: '+30', nickName: 'GR', countryName: 'Greece', flag: '🇬🇷'),
  Country(code: '+36', nickName: 'HU', countryName: 'Hungary', flag: '🇭🇺'),
  Country(code: '+354', nickName: 'IS', countryName: 'Iceland', flag: '🇮🇸'),
  Country(code: '+91', nickName: 'IN', countryName: 'India', flag: '🇮🇳'),
  Country(code: '+62', nickName: 'ID', countryName: 'Indonesia', flag: '🇮🇩'),
  Country(code: '+353', nickName: 'IE', countryName: 'Ireland', flag: '🇮🇪'),
  Country(code: '+81', nickName: 'JP', countryName: 'Japan', flag: '🇯🇵'),
  Country(code: '+60', nickName: 'MY', countryName: 'Malaysia', flag: '🇲🇾'),
  Country(code: '+52', nickName: 'MX', countryName: 'Mexico', flag: '🇲🇽'),
  Country(code: '+31', nickName: 'NL', countryName: 'Netherlands', flag: '🇳🇱'),
  Country(code: '+47', nickName: 'NO', countryName: 'Norway', flag: '🇳🇴'),
  Country(code: '+92', nickName: 'PK', countryName: 'Pakistan', flag: '🇵🇰'),
  Country(code: '+48', nickName: 'PL', countryName: 'Poland', flag: '🇵🇱'),
  Country(code: '+351', nickName: 'PT', countryName: 'Portugal', flag: '🇵🇹'),
  Country(code: '+7', nickName: 'RU', countryName: 'Russia', flag: '🇷🇺'),
  Country(code: '+966', nickName: 'SA', countryName: 'Saudi Arabia', flag: '🇸🇦'),
  Country(code: '+65', nickName: 'SG', countryName: 'Singapore', flag: '🇸🇬'),
  Country(code: '+27', nickName: 'ZA', countryName: 'South Africa', flag: '🇿🇦'),
  Country(code: '+82', nickName: 'KR', countryName: 'South Korea', flag: '🇰🇷'),
  Country(code: '+34', nickName: 'ES', countryName: 'Spain', flag: '🇪🇸'),
  Country(code: '+46', nickName: 'SE', countryName: 'Sweden', flag: '🇸🇪'),
  Country(code: '+41', nickName: 'CH', countryName: 'Switzerland', flag: '🇨🇭'),
  Country(code: '+886', nickName: 'TW', countryName: 'Taiwan', flag: '🇹🇼'),
  Country(code: '+66', nickName: 'TH', countryName: 'Thailand', flag: '🇹🇭'),
  Country(code: '+90', nickName: 'TR', countryName: 'Turkey', flag: '🇹🇷'),
  Country(code: '+1', nickName: 'US', countryName: 'United States', flag: '🇺🇸'),
  Country(code: '+44', nickName: 'GB', countryName: 'United Kingdom', flag: '🇬🇧'),
  Country(code: '+998', nickName: 'UZ', countryName: 'Uzbekistan', flag: '🇺🇿'),
  Country(code: '+84', nickName: 'VN', countryName: 'Vietnam', flag: '🇻🇳'),
];
