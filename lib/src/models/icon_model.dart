class IconModel {
  String icon;
  String title;

  IconModel({
    required this.icon,
    required this.title,
  });

  static List<IconModel> icons = [
    IconModel(
      icon: "assets/icons/mercado.png",
      title: "Mercado",
    ),
    IconModel(
      icon: "assets/icons/hortifruti.png",
      title: "HortiFruti",
    ),
    IconModel(
      icon: "assets/icons/padaria.png",
      title: "Padaria",
    ),
    IconModel(
      icon: "assets/icons/farmacia.png",
      title: "Farmácia",
    ),
  ];
}
