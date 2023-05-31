class CityReview {
  String avatar;
  DateTime date;
  String title;
  String subtitle;
  String description;
  String image;
  
  CityReview(this.avatar, this.date, this.title, this.subtitle, this.description, this.image);
}

class City {
  String name;
  double price;
  String place;
  String data;
  String image;
  List<CityReview> reviews;
  
  City(this.name, this.price, this.place, this.data, this.image, this.reviews);
}

final cities = [
    City(
      "New York City",
      150.0,
      "USA",
      "May 1, 2023",
      "https://i.insider.com/5d07e42b6fc92037f505d5ea?width=1136&format=jpeg",
      [
        CityReview(
          "user_avatar1.jpg",
          DateTime(2023, 5, 1),
          "Amazing city!",
          "A must-visit destination",
          "The historical sites and museums exceeded my expectations. Highly recommended!",
          "https://e360.yale.edu/assets/site/Green_In_The_Middle_Of_Concrete_Jungle_256972475.jpg",
        ),
        CityReview(
          "user_avatar2.jpg",
          DateTime(2023, 4, 20),
          "Unforgettable experience",
          "Rich cultural heritage",
          "The historical sites and museums exceeded my expectations. Highly recommended!",
          "https://www.nationsonline.org/gallery/USA/Times-Square-New-York.jpg",
        ),
      ],
    ),
    City(
      "Paris",
      200.0,
      "France",
      "May 1, 2023",
      "https://i0.wp.com/imgs.hipertextual.com/wp-content/uploads/2013/04/Paris.jpg",
      [
        CityReview(
          "user_avatar3.jpg",
          DateTime(2023, 5, 10),
          "Romantic getaway",
          "Captivating architecture",
          "Walking along the Seine River and exploring the charming neighborhoods was a dream come true.",
          "https://www.viveparis.es/sites/default/files/imagenes/articulos/bateaux_mouches.jpg",
        ),
      ],
    ),
    City(
      "Tokyo",
      180.0,
      "Japan",
      "May 1, 2023",
      "https://hips.hearstapps.com/hmg-prod/images/high-angle-view-of-tokyo-skyline-at-dusk-japan-royalty-free-image-1664309926.jpg",
      [
        CityReview(
          "user_avatar4.jpg",
          DateTime(2023, 5, 15),
          "Incredible city",
          "Delicious cuisine",
          "The city's bustling streets, stunning temples, and mouth-watering food left me in awe.",
          "https://cdn.tohokuandtokyo.org/front_assets/images_other/pref/sp/tokyo.jpg",
        ),
        CityReview(
          "user_avatar5.jpg",
          DateTime(2023, 4, 28),
          "Unique experience",
          "Fascinating culture",
          "From the futuristic skyline to the tranquil gardens, Tokyo offers an unforgettable journey.",
          "https://viajes.nationalgeographic.com.es/medio/2021/01/26/templo-de-asakusa_46a4b335_1200x630.jpg",
        ),
      ],
    ),
    City(
      "Rome",
      190.0,
      "Italy",
      "May 1, 2023",
      "https://www.fodors.com/wp-content/uploads/2018/10/HERO_UltimateRome_Hero_shutterstock789412159.jpg",
      [
        CityReview(
          "user_avatar6.jpg",
          DateTime(2023, 5, 5),
          "Historical marvel",
          "Gastronomic delights",
          "Exploring the Colosseum and indulging in authentic Italian pasta made my visit truly memorable.",
          "https://americadomani.com/wp-content/uploads/2023/02/rome7th.jpg",
        ),
      ],
    ),
    City(
      "Rio de Janeiro",
      170.0,
      "Brazil",
      "May 1, 2023",
      "https://www.civitatis.com/blog/wp-content/uploads/2022/10/panoramica-rio-janeiro-brasil.jpg",
      [
        CityReview(
          "user_avatar7.jpg",
          DateTime(2023, 4, 25),
          "Spectacular city",
          "Lively atmosphere",
          "The vibrant energy of Rio de Janeiro is contagious. I danced, relaxed on stunning beaches, and enjoyed delicious caipirinhas.",
          "https://a.cdn-hotels.com/gdcs/production7/d1549/960889d0-c31d-11e8-9739-0242ac110006.jpg",
        ),
      ],
    ),
    City(
      "Sydney",
      220.0,
      "Australia",
      "May 1, 2023",
      "https://dingoos.com/wp-content/uploads/2017/11/estudiar-en-sydney-1.jpg",
      [
        CityReview(
          "user_avatar8.jpg",
          DateTime(2023, 5, 20),
          "Breathtaking views",
          "Surfer's paradise",
          "I fell in love with Sydney's stunning coastline, friendly locals, and laid-back lifestyle.",
          "https://gostudyaus.es/wp-content/uploads/2018/09/SYD_header.jpg",
        ),
        CityReview(
          "user_avatar9.jpg",
          DateTime(2023, 4, 18),
          "Must-visit destination",
          "Eclectic cityscape",
          "The blend of modern architecture and natural beauty makes Sydney an unforgettable experience.",
          "https://a.travel-assets.com/findyours-php/viewfinder/images/res70/474000/474772-Australia.jpg",
        ),
      ],
    ),
  ];