import 'package:flutter/material.dart';
import 'package:gemini_chat_bot/api_service.dart'; // Import the API service
import 'package:video_player/video_player.dart'; // Import the video player package
import 'about_pace.dart'; // Import the details screen
import 'package:audioplayers/audioplayers.dart'; // Import audio player package
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Import PDF view package
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// Define your podcast assets

final List<Map<String, String>> _podcastAssets = [
  {
    'title': 'Ocean Atmosphere Understanding',
    'url': 'assets/podcasts/episode-16-ocean-atmosphere-understanding.mp3',
  },
  {
    'title': 'Keeping Up the PACE with NASA',
    'url': 'assets/podcasts/Keeping_Up_the_PACE_with_NASA.mp3',
  },
];



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  late Future<List<dynamic>> _data;
  final ApiService apiService = ApiService('http://localhost:3000'); // Update with your local server IP

  @override
  void initState() {
    super.initState();
    _fetchData(_selectedCategoryIndex);
  }

  void _fetchData(int index) {
    String category;
    switch (index) {
      case 0:
        category = 'videos';
        break;
      case 1:
        category = 'podcasts';
        break;
      case 2:
        category = 'maps';
        break;
      case 3:
        category = 'docs';
        break;
      case 4:
        category = 'images';
        break;
      case 5:
        category = 'brochures';
        break;
      case 6:
        category = 'news';
        break;
      default:
        category = 'videos';
    }
    setState(() {
      _data = apiService.fetchData(category); // Fetch data based on selected category
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, There 👋",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Let's explore PACE!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 45),

            // Category Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(7, (index) {
                  return GestureDetector(
                    child: _buildCategoryTab(
                      ["videos", "podcasts", "storymaps", "documents", "images", "brochures", "newsletter"][index],
                      index,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                        _fetchData(index); // Fetch data when category is tapped
                      });
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Display Data
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final dataList = snapshot.data!;
                    return PageView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return _buildContent(dataList[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build category tabs
  Widget _buildCategoryTab(String title, int index) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _selectedCategoryIndex == index ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: _selectedCategoryIndex == index ? Colors.white : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Method to build content based on type
  Widget _buildContent(dynamic item) {
    String url = item['url'] ?? '';
    String title = item['title'] ?? 'Untitled Video'; // Default title if not found
    print('Item URL: $url');

// Handle podcasts
// Inside your widget
if (_selectedCategoryIndex == 1) {
  return Card(
    child: ListTile(
      title: Text(title), // Display podcast title
      subtitle: Text('Click to play podcast'),
      onTap: () {
        // Create an instance of AudioPlayer
        AudioPlayer audioPlayer = AudioPlayer();

        // Play the podcast using AudioPlayer
        audioPlayer.play(AssetSource('assets/podcasts/episode-16-ocean-atmosphere-understanding.mp3'));

        // Optionally, navigate to the podcast detail page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PodcastDetailPage(
              title: title,
              url: 'assets/podcasts/episode-16-ocean-atmosphere-understanding.mp3',
            ),
          ),
        );
      },
    ),
  );
}


    // Handle images
    if (url.contains('.png') || url.contains('.jpg')) {
      return Card(
        child: GestureDetector(
          onTap: () {
            // Optionally navigate to a detail view for the image
          },
          child: Image.network(url, fit: BoxFit.cover), // Display the image
        ),
      );
    }
if (url.contains('storymaps')) {
    return Card(
      child: ListTile(
        title: Text('Open Web Page: $title'),
        subtitle: Text('Click to view'),
        onTap: () {
          print('Opening Web Page: $url');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: url), // Navigate to WebView
            ),
          );
        },
      ),
    );
  }
    // Handle story maps and newsletters (PDFs)
    if (url.contains('Brochure') || url.contains('brochure') || url.contains('brochures')) {
      return Card(
        child: ListTile(
          title: Text(item['title'] ?? 'Document'), // Display title
          subtitle: Text('Click to view'),
          onTap: () {
            print('Opening PDF or Story Map: $url');
            // Open the PDF viewer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewerScreen(url: url), // Navigate to PDF viewer
              ),
            );
          },
        ),
      );
    }
     if (url.contains('Newsletter') ) {
      return Card(
        child: ListTile(
          title: Text(item['title'] ?? 'Document'), // Display title
          subtitle: Text('Click to view'),
          onTap: () {
            print('Opening PDF or Story Map: $url');
            // Open the PDF viewer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewerScreen(url: url), // Navigate to PDF viewer
              ),
            );
          },
        ),
      );
    }
if (url.contains('docs') ) {
      return Card(
        child: ListTile(
          title: Text(item['title'] ?? 'Document'), // Display title
          subtitle: Text('Click to view'),
          onTap: () {
            print('Opening PDF or Story Map: $url');
            // Open the PDF viewer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewerScreen(url: url), // Navigate to PDF viewer
              ),
            );
          },
        ),
      );
    }

    // Handle other types (like videos)
    return VideoPlayerWidget(
      videoUrl: url,
      title: title, // Pass the title to VideoPlayerWidget
      onTap: () {
        print('Navigating to Video: $url');
        // Navigate to the VideoPlayerScreen with the selected item
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(data: item), // Pass video data
          ),
        );
      },
    );
  }
}


class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String url;

  PDFViewerScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    // Print the URL to the console
    print('Loading PDF from URL: $url');

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.network(
        url,
        // onLoadFailed: (PdfDocumentLoadFailedDetails details) { ... },
      ),
    );
  }
}


// Video Player Widget
class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String title; // Add title parameter
  final VoidCallback? onTap; // Add onTap parameter

  VideoPlayerWidget({
    required this.videoUrl,
    required this.title,
    this.onTap,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Refresh the widget when initialized
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {}, // Use an empty function if onTap is null
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Center(child: CircularProgressIndicator()),
          // Title overlay
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              widget.title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}


class PodcastDetailPage extends StatelessWidget {
  final String title;
  final String url;

  PodcastDetailPage({required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = AudioPlayer();

    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Display the title in the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Podcast: $title',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                print('Playing Podcast: $url');
AudioPlayer audioPlayer = AudioPlayer();

        // Play the podcast using AudioPlayer
        audioPlayer.play(AssetSource('assets/podcasts/episode-16-ocean-atmosphere-understanding.mp3'));

              },
              child: Text('Play Podcast'),
            ),
          ],
        ),
      ),
    );
  }
}
