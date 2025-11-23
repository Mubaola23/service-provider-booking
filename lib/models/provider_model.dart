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

final providers = [
  ServiceProvider(
    id: '1',
    name: 'John Smith',
    imageUrl: 'https://i.pravatar.cc/150?img=1',
    rating: 4.8,
    hourlyRate: 45.0,
    isVerified: true,
  ),
  ServiceProvider(
    id: '2',
    name: 'Jane Doe',
    imageUrl: 'https://i.pravatar.cc/150?img=2',
    rating: 4.9,
    hourlyRate: 50.0,
    isVerified: true,
  ),
  ServiceProvider(
    id: '3',
    name: 'Robert Brown',
    imageUrl: 'https://i.pravatar.cc/150?img=3',
    rating: 4.7,
    hourlyRate: 40.0,
    isVerified: false,
  ),
  ServiceProvider(
    id: '4',
    name: 'Emily Jones',
    imageUrl: 'https://i.pravatar.cc/150?img=4',
    rating: 4.8,
    hourlyRate: 55.0,
    isVerified: true,
  ),
  ServiceProvider(
    id: '5',
    name: 'Michael Wilson',
    imageUrl: 'https://i.pravatar.cc/150?img=5',
    rating: 4.6,
    hourlyRate: 35.0,
    isVerified: false,
  ),
  ServiceProvider(
    id: '6',
    name: 'Micharl kors',
    imageUrl: 'https://i.pravatar.cc/150?img=6',
    rating: 4.9,
    hourlyRate: 60.0,
    isVerified: true,
  ),
  ServiceProvider(
    id: '7',
    name: 'Olatunbosun Adeoye',
    imageUrl: 'https://i.pravatar.cc/150?img=7',
    rating: 4.7,
    hourlyRate: 48.0,
    isVerified: true,
  ),
  ServiceProvider(
    id: '8',
    name: 'Sarah Wiliams',
    imageUrl: 'https://i.pravatar.cc/150?img=8',
    rating: 4.8,
    hourlyRate: 52.0,
    isVerified: false,
  ),
  ServiceProvider(
    id: '9',
    name: 'Kamala Hariss',
    imageUrl: 'https://i.pravatar.cc/150?img=9',
    rating: 4.5,
    hourlyRate: 38.0,
    isVerified: true,
  ),
  ServiceProvider(
    id: '10',
    name: 'John Doe',
    imageUrl: 'https://i.pravatar.cc/150?img=10',
    rating: 4.9,
    hourlyRate: 65.0,
    isVerified: true,
  ),
];
