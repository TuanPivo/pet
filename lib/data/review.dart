final reviewList = [
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "John Travolta",
    rating: 3.5,
    date: "01 Jan 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Scarlett Johansson",
    rating: 2.5,
    date: "21 Feb 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Jennifer Lawrence",
    rating: 4.5,
    date: "17 Mar 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Michael Jordan",
    rating: 1.5,
    date: "12 Apr 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Nicole Kidman",
    rating: 2.0,
    date: "28 May 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "James Franco",
    rating: 4.0,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Margot Robbie",
    rating: 1.0,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Nicolas Cage",
    rating: 3.0,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Emma Stone",
    rating: 5.0,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Johnny Depp",
    rating: 3.5,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Natalie Portman",
    rating: 3.5,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Anne Hathaway",
    rating: 3.5,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "https://testvui.000webhostapp.com/images/uploads/a5.png",
    name: "Charlize Theron",
    rating: 3.5,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
];

class ReviewModal {
  final String image;
  final String name;
  final double rating;
  final String date;
  final String comment;

  ReviewModal(
      {required this.image,
      required this.name,
      required this.rating,
      required this.date,
      required this.comment});

  factory ReviewModal.fromJson(Map<String, dynamic> json) {
    return ReviewModal(
      image: json['image'],
      name: json['name'],
      rating: json['rating'],
      date: json['date'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['date'] = this.date;
    data['comment'] = this.comment;
    return data;
  }
}
