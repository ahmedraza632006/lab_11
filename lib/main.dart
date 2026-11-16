import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.photo_library,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  'My Gallery',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Capture Your Memories',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> images = const [
    'assets/images/travel.jpg',
    'assets/images/wildlife.jpg',
    'assets/images/mountain.jpg',
    'assets/images/beach.jpg',
    'assets/images/favourite.jpg',
    'assets/images/landscape.jpg',
    'assets/images/adventure.jpg',
    'assets/images/Night sky.jpg',
    'assets/images/nature.jpg',
    'assets/images/sunset.jpg',
  ];

  void openPage(BuildContext context, Widget page) {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      PicturesPage(images: images),
      AlbumPage(images: images),
      ListPage(images: images),
      AboutPage(images: images),
    ];

    final List<String> pageTitles = [
      'Hero Animation',
      'My Album',
      'List Screen',
      'About',
    ];

    return Scaffold(
      appBar: selectedIndex == 0
          ? null
          : AppBar(
        title: Text(pageTitles[selectedIndex]),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              accountName: Text('Student'),
              accountEmail: Text('student@example.com'),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person, size: 35),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home / Pictures'),
              onTap: () {
                Navigator.pop(context);
                changePage(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('Albums'),
              onTap: () {
                Navigator.pop(context);
                changePage(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('List Screen'),
              onTap: () {
                Navigator.pop(context);
                changePage(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                changePage(3);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.cake),
              title: const Text('Birthdays'),
              onTap: () {
                openPage(
                  context,
                  const SimplePage(title: 'Birthdays'),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sentiment_satisfied),
              title: const Text('Gratitude'),
              onTap: () {
                openPage(
                  context,
                  const SimplePage(title: 'Gratitude'),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_alarm),
              title: const Text('Reminders'),
              onTap: () {
                openPage(
                  context,
                  const SimplePage(title: 'Reminders'),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                openPage(
                  context,
                  const SimplePage(title: 'Settings'),
                );
              },
            ),
          ],
        ),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: changePage,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Pictures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Album',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

class PicturesPage extends StatelessWidget {
  final List<String> images;

  const PicturesPage({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 220,
          pinned: true,
          backgroundColor: Colors.green,
          title: const Text('My Gallery'),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  images[0],
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.65),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  left: 20,
                  bottom: 35,
                  child: Text(
                    'Capture Your Memories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(15),
          sliver: SliverGrid(
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.2,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          image: images[index],
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'picture-$index',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                );
              },
              childCount: images.length,
            ),
          ),
        ),
      ],
    );
  }
}

class AlbumPage extends StatelessWidget {
  final List<String> images;

  const AlbumPage({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                images[0],
                width: 75,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),
            title: const Text(
              'My Memories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('4 Photos'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.green,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumDetailPage(
                    title: 'My Memories',
                    images: images,
                  ),
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                images[1],
                width: 75,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),
            title: const Text(
              'Favourites',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('2 Photos'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.green,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumDetailPage(
                    title: 'Favourites',
                    images: [images[1], images[2]],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AlbumDetailPage extends StatelessWidget {
  final String title;
  final List<String> images;

  const AlbumDetailPage({
    super.key,
    required this.title,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.2,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              images[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String image;
  final int index;

  const DetailPage({
    super.key,
    required this.image,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture Detail'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: 'picture-$index',
          child: InteractiveViewer(
            minScale: 0.8,
            maxScale: 4.0,
            child: Image.asset(
              image,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  final List<String> images;

  const ListPage({
    super.key,
    required this.images,
  });

  final List<String> items = const [
    'Nature Photography',
    'Sunset Views',
    'Travel Photos',
    'Mountain Views',
    'Wildlife Photography',
    'Beach Photography',
    'Night Sky Views',
    'Beautiful Landscapes',
    'Adventure Photos',
    'Favourite Moments',
  ];

  final List<String> descriptions = const [
    'Explore beautiful nature scenes and greenery.',
    'Enjoy beautiful sunset colors and evening views.',
    'Discover memorable places and travel experiences.',
    'Explore peaceful mountains and scenic views.',
    'Discover wildlife and the beauty of animals.',
    'Enjoy relaxing beach scenes and coastal views.',
    'Explore beautiful night skies and stars.',
    'Enjoy amazing natural landscapes and scenery.',
    'Discover exciting places and outdoor adventures.',
    'A collection of special and memorable moments.',
  ];

  final List<String> categoryImages = const [
    'assets/images/nature.jpg',
    'assets/images/sunset.jpg',
    'assets/images/travel.jpg',
    'assets/images/mountain.jpg',
    'assets/images/wildlife.jpg',
    'assets/images/beach.jpg',
    'assets/images/Night sky.jpg',
    'assets/images/landscape.jpg',
    'assets/images/adventure.jpg',
    'assets/images/favourite.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              items[index],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.green,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListDetailPage(
                    title: items[index],
                    image: categoryImages[index],
                    description: descriptions[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ListDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const ListDetailPage({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  final List<String> images;

  const AboutPage({
    super.key,
    required this.images,
  });

  final List<String> captions = const [
    'Nature',
    'Memories',
    'Photography',
    'Beautiful Views',
    'Favourite Moments',
    'Gallery',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  images[index % images.length],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  captions[index],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;

  const SimplePage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          '$title Page',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
