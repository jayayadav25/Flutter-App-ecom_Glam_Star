import 'package:flutter/material.dart';
import '../../../../../widgets/images.dart';
import '../domain/entities/editorial_layout_type.dart';
import '../domain/entities/editorial_type.dart';
import '../widgets/editorial_data.dart';
import '../widgets/editorial_image_data.dart';

class EditorialRepository {
  static List<EditorialData> getSections(EditorialType type,) {
    switch (type) {
      case EditorialType.home:
        return _homeSections;

      case EditorialType.women:
        return _womenSections;

      case EditorialType.men:
        return _menSections;

      case EditorialType.kids:
        return _kidsSections;
    }
  }

  // HOME
  static final List<EditorialData> _homeSections = [
    EditorialData(
      title: "Fresh Drops",
      subtitle: "New arrivals you’ll love ✨",
      layout: EditorialLayoutType.horizontal,
      category: 'home',

      colors: const [
        Color(0xFFFFF4EA),
        Color(0xFFFFE1CC),
      ],

      items: const [

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
      subtitle: "Luxury looks for modern fashion",
      layout: EditorialLayoutType.carousel,
      category: 'home',

      colors: const [
        Color(0xFFEFF4FF),
        Color(0xFFDCE8FF),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.men_shoes2,
          brand: "NIKE",
          tag: "Sneaker Drop",
          offer: "NEW ARRIVAL",
        ),

        EditorialImageData(
          image: AppImages.men_watch2,
          brand: "ROLEX",
          tag: "Luxury Watches",
          offer: "LIMITED EDITION",
        ),

        EditorialImageData(
          image: AppImages.home_banner_2,
          brand: "PRADA",
          tag: "Streetwear Edit",
          offer: "TRENDING",
        ),
      ],
    ),

    EditorialData(
      title: "Style Spotlight",
      subtitle: "Trending premium accessories",
      layout: EditorialLayoutType.horizontal,
      category: 'home',

      colors: const [
        Color(0xFFFFF0F6),
        Color(0xFFFFD9E8),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.women_watch,
          brand: "FOSSIL",
          tag: "Elegant Picks",
          offer: "Flat 30% OFF",
        ),

        EditorialImageData(
          image: AppImages.women_boots,
          brand: "GUCCI",
          tag: "Winter Luxe",
          offer: "BESTSELLER",
        ),

        EditorialImageData(
          image: AppImages.women_handbag1,
          brand: "LV",
          tag: "Luxury Bags",
          offer: "HOT DROP",
        ),

        EditorialImageData(
          image: AppImages.couple6,
          brand: "BALENCIAGA",
          tag: "Modern Style",
          offer: "UP TO 50% OFF",
        ),
      ],
    ),

    EditorialData(
      title: "House of Trends",
      subtitle: "Curated fashion essentials",
      layout: EditorialLayoutType.horizontal,
      category: 'home',

      colors: const [
        Color(0xFFF5F5F5),
        Color(0xFFEAEAEA),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.women_sandal2,
          brand: "ALDO",
          tag: "Summer Collection",
          offer: "SAVE ₹2000",
        ),

        EditorialImageData(
          image: AppImages.women_handbag,
          brand: "CHANEL",
          tag: "Luxury Bags",
          offer: "TREND ALERT",
        ),

        EditorialImageData(
          image: AppImages.sandal_bag,
          brand: "VERSACE",
          tag: "Complete Look",
          offer: "BUY 2 GET 1",
        ),
      ],
    ),
  ];

  // WOMEN

  static final List<EditorialData> _womenSections = [

    EditorialData(
      title: "Boost Your Style Sense",
      subtitle: "Luxury fashion for women",
      layout: EditorialLayoutType.carousel,
      category: 'women',

      colors: const [
        Color(0xFFFFF0F5),
        Color(0xFFFFD6E7),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.women1,
          brand: "ZARA",
          tag: "New Collection",
          offer: "40% OFF",
        ),

        EditorialImageData(
          image: AppImages.women2,
          brand: "H&M",
          tag: "Trending",
          offer: "Flat ₹999",
        ),

        EditorialImageData(
          image: AppImages.women3,
          brand: "AJIO",
          tag: "Fashion Picks",
          offer: "Extra 10% OFF",
        ),
        EditorialImageData(
          image: AppImages.women10,
          brand: "VERSACE",
          tag: "Bold Style",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.women8,
          brand: "BALMAIN",
          tag: "Luxury Wear",
          offer: "EXCLUSIVE",
        ),

        EditorialImageData(
          image: AppImages.women12,
          brand: "CHANEL",
          tag: "Signature Looks",
          offer: "UP TO 50% OFF",
        ),
      ],
    ),

    EditorialData(
      title: "Trend Queen",
      subtitle: "Modern feminine aesthetics",
      layout: EditorialLayoutType.horizontal,
      category: 'women',

      colors: const [
        Color(0xFFF4F0FF),
        Color(0xFFE5DAFF),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.women4,
          brand: "PRADA",
          tag: "Elegant Wear",
          offer: "LIMITED DROP",
        ),

        EditorialImageData(
          image: AppImages.women5,
          brand: "GUCCI",
          tag: "Luxury Edit",
          offer: "HOT NOW",
        ),

        EditorialImageData(
          image: AppImages.women6,
          brand: "DIOR",
          tag: "Premium Fashion",
          offer: "NEW ARRIVAL",
        ),
        EditorialImageData(
          image: AppImages.women7,
          brand: "VERSACE",
          tag: "Bold Style",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.women8,
          brand: "BALMAIN",
          tag: "Luxury Wear",
          offer: "EXCLUSIVE",
        ),

        EditorialImageData(
          image: AppImages.women9,
          brand: "CHANEL",
          tag: "Signature Looks",
          offer: "UP TO 50% OFF",
        ),
      ],
    ),

    EditorialData(
      title: "The Power Closet",
      subtitle: "Statement looks curated for you",
      layout: EditorialLayoutType.quilted,
      category: 'women',

      colors: const [
        Color(0xFFFFF6EC),
        Color(0xFFFFE4C7),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.women7,
          brand: "VERSACE",
          tag: "Bold Style",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.women8,
          brand: "BALMAIN",
          tag: "Luxury Wear",
          offer: "EXCLUSIVE",
        ),

        EditorialImageData(
          image: AppImages.women9,
          brand: "CHANEL",
          tag: "Signature Looks",
          offer: "UP TO 50% OFF",
        ),
        EditorialImageData(
          image: AppImages.women10,
          brand: "VERSACE",
          tag: "Bold Style",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.women11,
          brand: "BALMAIN",
          tag: "Luxury Wear",
          offer: "EXCLUSIVE",
        ),

        EditorialImageData(
          image: AppImages.women12,
          brand: "CHANEL",
          tag: "Signature Looks",
          offer: "UP TO 50% OFF",
        ),
      ],
    ),
  ];

  // MEN

  static final List<EditorialData> _menSections = [

    EditorialData(
      title: "Essential",
      subtitle: "Modern menswear essentials",
      layout: EditorialLayoutType.horizontal,
      category: 'men',

      colors: const [
        Color(0xFFEFF7FF),
        Color(0xFFDCEEFF),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.men1,
          brand: "ZARA",
          tag: "Classic Wear",
          offer: "UP TO 30% OFF",
        ),

        EditorialImageData(
          image: AppImages.men2,
          brand: "H&M",
          tag: "Street Style",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.men3,
          brand: "AJIO",
          tag: "Daily Fashion",
          offer: "LIMITED DROP",
        ),
        EditorialImageData(
          image: AppImages.men4,
          brand: "GUCCI",
          tag: "Designer Fits",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.men5,
          brand: "PRADA",
          tag: "Luxury Wear",
          offer: "HOT RIGHT NOW",
        ),

        EditorialImageData(
          image: AppImages.men6,
          brand: "ARMANI",
          tag: "Modern Classics",
          offer: "UP TO 60% OFF",
        ),
      ],
    ),

    EditorialData(
      title: "Wear Your Story",
      subtitle: "Premium fashion for every vibe",
      layout: EditorialLayoutType.carousel,
      category: 'men',

      colors: const [
        Color(0xFFF5F5F5),
        Color(0xFFE7E7E7),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.men4,
          brand: "NIKE",
          tag: "Urban Fashion",
          offer: "NEW COLLECTION",
        ),

        EditorialImageData(
          image: AppImages.men5,
          brand: "PUMA",
          tag: "Sport Luxe",
          offer: "BESTSELLER",
        ),

        EditorialImageData(
          image: AppImages.men6,
          brand: "ADIDAS",
          tag: "Fresh Styles",
          offer: "40% OFF",
        ),
        EditorialImageData(
          image: AppImages.men2,
          brand: "GUCCI",
          tag: "Designer Fits",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.men3,
          brand: "PRADA",
          tag: "Luxury Wear",
          offer: "HOT RIGHT NOW",
        ),

        EditorialImageData(
          image: AppImages.men1,
          brand: "ARMANI",
          tag: "Modern Classics",
          offer: "UP TO 60% OFF",
        ),
      ],
    ),

    EditorialData(
      title: "Where Fashion Lives",
      subtitle: "Luxury menswear collection",
      layout: EditorialLayoutType.horizontal,
      category: 'men',

      colors: const [
        Color(0xFFFFF6EE),
        Color(0xFFFFE6D2),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.men7,
          brand: "GUCCI",
          tag: "Designer Fits",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.men8,
          brand: "PRADA",
          tag: "Luxury Wear",
          offer: "HOT RIGHT NOW",
        ),

        EditorialImageData(
          image: AppImages.men9,
          brand: "ARMANI",
          tag: "Modern Classics",
          offer: "UP TO 60% OFF",
        ),
        EditorialImageData(
          image: AppImages.men2,
          brand: "GUCCI",
          tag: "Designer Fits",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.men3,
          brand: "PRADA",
          tag: "Luxury Wear",
          offer: "HOT RIGHT NOW",
        ),

        EditorialImageData(
          image: AppImages.men5,
          brand: "ARMANI",
          tag: "Modern Classics",
          offer: "UP TO 60% OFF",
        ),
      ],
    ),
  ];

  // KIDS

  static final List<EditorialData> _kidsSections = [

    EditorialData(
      title: "Little Legends",
      subtitle: "Cute styles for little stars",
      layout: EditorialLayoutType.carousel,
      category: 'kids',

      colors: const [
        Color(0xFFFFF7E8),
        Color(0xFFFFEBC2),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.kids1,
          brand: "ZARA Kids",
          tag: "Cute Styles",
          offer: "UP TO 40% OFF",
        ),

        EditorialImageData(
          image: AppImages.kids2,
          brand: "H&M Kids",
          tag: "Playful Fashion",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.kids3,
          brand: "AJIO Kids",
          tag: "Mini Fashion",
          offer: "BUY 2 GET 1",
        ),
        EditorialImageData(
          image: AppImages.kids15,
          brand: "BALMAIN Kids",
          tag: "Mini Luxury",
          offer: "EXCLUSIVE",
        ),

        EditorialImageData(
          image: AppImages.kids16,
          brand: "VERSACE Kids",
          tag: "Designer Edit",
          offer: "UP TO 50% OFF",
        ),
      ],
    ),

    EditorialData(
      title: "Mini Trendsetter",
      subtitle: "Fun colorful collections",
      layout: EditorialLayoutType.horizontal,
      category: 'kids',

      colors: const [
        Color(0xFFEFFFFB),
        Color(0xFFD7FFF3),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.kids4,
          brand: "NIKE Kids",
          tag: "Sporty Vibes",
          offer: "LIMITED DROP",
        ),

        EditorialImageData(
          image: AppImages.kids5,
          brand: "PUMA Kids",
          tag: "Play Edition",
          offer: "HOT NOW",
        ),

        EditorialImageData(
          image: AppImages.kids6,
          brand: "ADIDAS Kids",
          tag: "Color Pop",
          offer: "30% OFF",
        ),
        EditorialImageData(
          image: AppImages.kids15,
          brand: "BALMAIN Kids",
          tag: "Mini Luxury",
          offer: "EXCLUSIVE",
        ),

        EditorialImageData(
          image: AppImages.kids16,
          brand: "VERSACE Kids",
          tag: "Designer Edit",
          offer: "UP TO 50% OFF",
        ),
      ],
    ),

    EditorialData(
      title: "Little Fashion Hub",
      subtitle: "Premium mini fashion edits",
      layout: EditorialLayoutType.quilted,
      category: 'kids',

      colors: const [
        Color(0xFFF4F1FF),
        Color(0xFFE2DBFF),
      ],

      items: const [

        EditorialImageData(
          image: AppImages.kids11,
          brand: "GUCCI Kids",
          tag: "Luxury Kidswear",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.kids12,
          brand: "BALMAIN Kids",
          tag: "Mini Luxury",
          offer: "EXCLUSIVE",
        ),

        EditorialImageData(
          image: AppImages.kids13,
          brand: "VERSACE Kids",
          tag: "Designer Edit",
          offer: "UP TO 50% OFF",
        ),
        EditorialImageData(
          image: AppImages.kids14,
          brand: "GUCCI Kids",
          tag: "Luxury Kidswear",
          offer: "TRENDING",
        ),

        EditorialImageData(
          image: AppImages.kids15,
          brand: "BALMAIN Kids",
          tag: "Mini Luxury",
          offer: "EXCLUSIVE",
        ),

        EditorialImageData(
          image: AppImages.kids16,
          brand: "VERSACE Kids",
          tag: "Designer Edit",
          offer: "UP TO 50% OFF",
        ),
      ],
    ),
  ];
}

