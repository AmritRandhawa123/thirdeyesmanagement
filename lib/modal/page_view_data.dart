class Slide {
  String title;
  String description;
  String image;

  Slide({required this.title, required this.description, required this.image});
}

final slideList = [
  Slide(
      title: "Analytics",
      description: "See all the analytics of Your\nclients.",
      image: "assets/slider1.png"),
  Slide(
      title: "Manage Sales",
      description: "Manage your sales with Leading\napp.",
      image: "assets/slider2.png"),

  Slide(
      title: "Secure",
      description:
      "All of your data will be secure with\nus.",
      image: "assets/slider3.png"),

];
