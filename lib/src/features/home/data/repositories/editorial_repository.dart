import '../../../../../../widgets/images.dart';
import '../../widgets/editorial_data.dart';
import '../../widgets/editorial_image_data.dart';
import '../../domain/entities/editorial_type.dart';

class EditorialRepository {
  static List<EditorialData> getSections(EditorialType type) {
    switch (type) {

      case EditorialType.home:
        return const [
          EditorialData(
            title: "Fresh Drops",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.couple1,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.couple2,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.couple3,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),


          EditorialData(
            title: "Style Buzz",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.men_shoes2,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.couple3,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.men_watch2,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

          EditorialData(
            title: "Style Spotlight",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.women_watch,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.couple6,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.men_shoes3,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
              EditorialImageData(
                image: AppImages.men_watch2,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
              EditorialImageData(
                image: AppImages.women_boots,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
              EditorialImageData(
                image: AppImages.women_handbag1,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),

            ],
          ),

          EditorialData(
            title:  "House of Trends",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.women_sandal2,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.women_handbag,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.sandal_bag,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

          EditorialData(
            title:  "Hot Right Now",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.men_watch3,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.men_shoes3,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.home_banner_2,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

        ];

      case EditorialType.women:
        return const [
          EditorialData(
            title: "Boost Your Style Sense",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.women1,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.women2,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.women3,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

          EditorialData(
            title:"Trend Queen",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.women4,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.women5,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.women6,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

          EditorialData(
            title: "The Power Closet",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.women7,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.women8,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.women9,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

        ];

      case EditorialType.men:
        return const [
          EditorialData(
            title: "Essential",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.men1,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.men2,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.men3,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

          EditorialData(
            title: "Wear your story",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.men4,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.men5,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.men6,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

          EditorialData(
            title: "Where Fashion Lives",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.men7,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.men8,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.men9,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

        ];

      case EditorialType.kids:
        return const [
          EditorialData(
            title: "Little Legends",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.kids1,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.kids2,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.kids3,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),

          EditorialData(
            title: "Mini Trendsetter",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.kids4,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.kids5,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.kids6,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),
          EditorialData(
            title: "Little Fashion Hub",
            subtitle: "New arrivals you’ll love ✨",
            items: [
              EditorialImageData(
                image: AppImages.kids7,
                brand: "ZARA",
                tag: "New Collection",
                offer: "Up to 40% OFF",
              ),
              EditorialImageData(
                image: AppImages.kids8,
                brand: "H&M",
                tag: "Trending Now",
                offer: "Flat ₹999",
              ),
              EditorialImageData(
                image: AppImages.kids9,
                brand: "AJIO",
                tag: "Style Picks",
                offer: "Extra 10% OFF",
              ),
            ],
          ),


        ];
    }
  }
}
