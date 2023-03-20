class BookModel {
  String image;
  String secondImage;
  String title;
  String subtitle;
  bool favorite;

  BookModel({
    required this.image,
    required this.secondImage,
    required this.title,
    required this.subtitle,
    required this.favorite,
  });

  //The new book

  static BookModel newBook = BookModel(
    image: "assets/images/cerveja.png",
    secondImage: "assets/images/cerveja.png",
    title: "Raft Of Stars",
    subtitle: "Andrew J. Graff",
    favorite: true,
  );

  //Let's create our list of books

  static List<BookModel> books = [
    BookModel(
      image: "assets/images/cerveja.png",
      secondImage: "assets/images/cerveja.png",
      title: "Cerveja Heineken",
      subtitle: "Promoção",
      favorite: true,
    ),
    BookModel(
      image: "assets/images/bebida.png",
      secondImage: "assets/images/bebida.png",
      title: "Espumante Espanhol",
      subtitle: "Promoção",
      favorite: false,
    ),
    BookModel(
      image: "assets/images/lamina.png",
      secondImage: "assets/images/lamina.png",
      title: "Lâmina Gillette",
      subtitle: "Promoção",
      favorite: false,
    ),
    BookModel(
      image: "assets/images/cafe.png",
      secondImage: "assets/images/cafe.png",
      title: "Amara The Brave",
      subtitle: "Matt Zhang",
      favorite: true,
    ),
    BookModel(
      image: "assets/images/azeite.png",
      secondImage: "assets/images/azeite.png",
      title: "Harry Potter",
      subtitle: "A History Of Magic",
      favorite: true,
    ),
    //5 books
  ];
}
