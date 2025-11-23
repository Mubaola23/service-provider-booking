class ServiceProvider {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final double hourlyRate;
  final bool isVerified;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.hourlyRate,
    required this.isVerified,
  });
}
