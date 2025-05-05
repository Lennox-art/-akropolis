enum SettingOptions {
  forEveryone(title: 'For everyone', code: 0),
  off(title: 'Off', code: 1),
  on(title: 'On', code: 2);

  final String title;
  final int code;

  const SettingOptions({required this.title, required this.code});
  
  static List<SettingOptions> get forEveryoneOff => [SettingOptions.forEveryone, SettingOptions.off];
  static List<SettingOptions> get offOn => [SettingOptions.on, SettingOptions.off];
}
