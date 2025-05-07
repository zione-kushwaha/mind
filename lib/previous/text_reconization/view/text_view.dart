import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../../reader/view/reader_screen.dart';

class TextReconization extends StatefulWidget {
  static const routeName = "/textReconization";
  const TextReconization({super.key});

  @override
  State<TextReconization> createState() => _TextReconizationState();
}

class _TextReconizationState extends State<TextReconization>
    with SingleTickerProviderStateMixin {
  bool textIsScanning = false;
  XFile? imageFile;
  String scannedText = "";
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.teal.shade700, Colors.teal.shade400],
            ),
          ),
        ),
        title: const Text(
          "Text Scanner",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          if (scannedText.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                setState(() {
                  scannedText = "";
                  imageFile = null;
                });
              },
            ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeaderCard(),
                  const SizedBox(height: 30),
                  _buildImagePreview(),
                  const SizedBox(height: 30),
                  _buildActionButtons(),
                  const SizedBox(height: 30),
                  if (scannedText.isNotEmpty) _buildAnalyzeButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const Icon(Icons.text_fields, size: 40, color: Colors.teal),
            const SizedBox(height: 10),
            Text(
              "Extract Text from Images",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Capture or select an image to scan text",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.teal.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Card(
        key: ValueKey<String>(imageFile?.path ?? 'empty'),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child:
                textIsScanning
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.teal.shade400,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Processing Image...",
                            style: TextStyle(
                              color: Colors.teal.shade700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                    : imageFile == null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_search,
                          size: 80,
                          color: Colors.teal.shade300,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "No image selected",
                          style: TextStyle(
                            color: Colors.teal.shade500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                    : Image.file(File(imageFile!.path), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconButton(
          icon: Icons.photo_library,
          label: "Gallery",
          color: Colors.teal.shade600,
          onPressed: () => getImage(ImageSource.gallery),
        ),
        const SizedBox(width: 30),
        _buildIconButton(
          icon: Icons.camera_alt,
          label: "Camera",
          color: Colors.teal.shade800,
          onPressed: () => getImage(ImageSource.camera),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: IconButton(
              icon: Icon(icon, size: 30, color: Colors.white),
              onPressed: onPressed,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildAnalyzeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 5,
          shadowColor: Colors.teal.shade200,
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      ReaderScreen(Text_to_Read: scannedText),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOutQuart;

                var tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_stories, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              "Analyze Text",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        setState(() {
          textIsScanning = true;
          imageFile = pickedImage;
        });
        await getRecognizedText(pickedImage);
      }
    } catch (e) {
      setState(() {
        textIsScanning = false;
        imageFile = null;
        scannedText = "Error occurred while scanning.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> getRecognizedText(XFile img) async {
    try {
      final inputImage = InputImage.fromFilePath(img.path);
      final textRecognizer = TextRecognizer();

      RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );
      await textRecognizer.close();

      scannedText = "";
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          scannedText += '${line.text}\n';
        }
      }

      setState(() {
        textIsScanning = false;
      });

      if (scannedText.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No text found in the image"),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      setState(() {
        textIsScanning = false;
        scannedText = "Error processing image";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Processing error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
