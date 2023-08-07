
class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}
final slideList = [
  Slide(
    imageUrl: 'assets/images/imagel.jpeg',
    title: 'Best Attraction sites',
    description: 'In this application we will provide you with the best attraction sites that are found in Ethiopia so that our customer can decide '
        'where he is heading from the start  ',
  ),
  Slide(
    imageUrl: 'assets/images/imagesh.jpeg',
    title: 'Near by Hotels',
    description: 'In this application all near by hotels and available hotels are included where ever you go it will show you where you have to go and settle '
        'for the night this will safe time for you ',
  ),
  Slide(
    imageUrl: 'assets/images/imagesg.jpeg',
    title: 'Tour Guides',
    description: 'In this application we provide you with certified tour guides that are available in Ethiopia you can choose '
        'your own tour guide based on the information they put in there profile.  ',
  ),
  Slide(
    imageUrl: 'assets/images/imagesc.jpeg',
    title: 'Popular Destinations',
    description: 'In this application we provide you with the most visited cities here in Ethiopia we will have a brief description and we will also include there '
        'location so that you can decide if you want to go there.',
  ),
];
