import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReadSettingsPageScreen extends StatefulWidget {
  final Function(RichText, bool) updateTextCallback;
  final Function(Color) updateBackgroundColorCallback;
  final Function(RichText, TextStyle) updateTextAndStyleCallback;
  final Function(bool) updateBrightnessCallback;
  final Function onCloseOverlay;
  final Color scaffoldBackgroundColor;
  final bool passbright;
  bool isRoboto;
  final RichText chapter;

  ReadSettingsPageScreen({
    Key? key,
    required this.updateTextCallback,
    required this.chapter,
    required this.updateBackgroundColorCallback,
    required this.scaffoldBackgroundColor,
    required this.updateTextAndStyleCallback,
    required this.updateBrightnessCallback,
    required this.passbright,
    required this.isRoboto,
    required this.onCloseOverlay,
  }) : super(key: key);

  @override
  State<ReadSettingsPageScreen> createState() => _ReadSettingsPageScreenState();
}

class _ReadSettingsPageScreenState extends State<ReadSettingsPageScreen> {
  double _fontSize = 16.0;
  double _lineSpacing = 1.5;
  bool _isFocusMode = false;
  bool _isBoldMode = false;
  bool _isScrollingMode = true;
  bool _isDarkMode = false;
  bool _isSepiaMode = false;
  bool _isLightMode = true;

  @override
  void initState() {
    super.initState();
    // Initialize with current settings
    _fontSize = widget.chapter.text.style?.fontSize ?? 16.0;
    _lineSpacing = widget.chapter.text.style?.height ?? 1.5;
    _isBoldMode = widget.chapter.text.style?.fontWeight == FontWeight.bold;
    _isLightMode = widget.scaffoldBackgroundColor == Colors.white;
    _isSepiaMode = widget.scaffoldBackgroundColor == Color(0xFFF4ECD8);
    _isDarkMode = !_isLightMode && !_isSepiaMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => widget.onCloseOverlay(),
        child: Container(
          color: Colors.black54,
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Prevent taps on the card from closing
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: BoxConstraints(maxHeight: 600),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    _buildHeader(),
                    Divider(height: 1, color: Colors.grey[300]),
                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Font Settings
                            _buildSectionTitle("Text Settings"),
                            _buildFontSettings(),
                            SizedBox(height: 20),
                            // Display Modes
                            _buildSectionTitle("Display Mode"),
                            _buildDisplayModeOptions(),
                            SizedBox(height: 20),
                            // Reading Features
                            _buildSectionTitle("Reading Features"),
                            _buildReadingFeatures(),
                          ],
                        ),
                      ),
                    ),
                    // Close Button
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          widget.onCloseOverlay();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Apply Settings",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.settings, color: Colors.blueAccent, size: 24),
          SizedBox(width: 10),
          Text(
            "Reading Settings",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              HapticFeedback.lightImpact();
              widget.onCloseOverlay();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSettings() {
    return Column(
      children: [
        // Font Size
        Row(
          children: [
            Icon(Icons.text_fields, color: Colors.grey[600], size: 20),
            SizedBox(width: 10),
            Text("Font Size", style: TextStyle(fontSize: 14)),
            Spacer(),
            IconButton(
              icon: Icon(Icons.remove, size: 20),
              onPressed: _decreaseFontSize,
              splashRadius: 20,
            ),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                _fontSize.toInt().toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, size: 20),
              onPressed: _increaseFontSize,
              splashRadius: 20,
            ),
          ],
        ),
        SizedBox(height: 10),
        // Line Spacing
        Row(
          children: [
            Icon(Icons.format_line_spacing, color: Colors.grey[600], size: 20),
            SizedBox(width: 10),
            Text("Line Spacing", style: TextStyle(fontSize: 14)),
            Spacer(),
            IconButton(
              icon: Icon(Icons.remove, size: 20),
              onPressed: _decreaseLineSpacing,
              splashRadius: 20,
            ),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                _lineSpacing.toStringAsFixed(1),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, size: 20),
              onPressed: _increaseLineSpacing,
              splashRadius: 20,
            ),
          ],
        ),
        SizedBox(height: 10),
        // Font Style
        Row(
          children: [
            Icon(Icons.font_download, color: Colors.grey[600], size: 20),
            SizedBox(width: 10),
            Text("Font Style", style: TextStyle(fontSize: 14)),
            Spacer(),
            _buildFontStyleButton(
              "Default",
              !widget.isRoboto,
              onPressed: _setDefaultFont,
            ),
            SizedBox(width: 8),
            _buildFontStyleButton(
              "Dyslexic",
              widget.isRoboto,
              onPressed: _setDyslexicFont,
            ),
          ],
        ),
        SizedBox(height: 10),
        // Font Weight
        Row(
          children: [
            Icon(Icons.format_bold, color: Colors.grey[600], size: 20),
            SizedBox(width: 10),
            Text("Bold Text", style: TextStyle(fontSize: 14)),
            Spacer(),
            Switch(
              value: _isBoldMode,
              onChanged: (value) => _toggleBoldMode(value),
              activeColor: Colors.blueAccent,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFontStyleButton(
    String text,
    bool isSelected, {
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayModeOptions() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildDisplayModeOption(
          "Light",
          Icons.wb_sunny,
          _isLightMode,
          () => _setDisplayMode(0),
          Colors.grey[200]!,
        ),
        _buildDisplayModeOption(
          "Sepia",
          Icons.filter_vintage,
          _isSepiaMode,
          () => _setDisplayMode(1),
          Color(0xFFF4ECD8),
        ),
        _buildDisplayModeOption(
          "Dark",
          Icons.nights_stay,
          _isDarkMode,
          () => _setDisplayMode(2),
          Colors.grey[800]!,
        ),
      ],
    );
  }

  Widget _buildDisplayModeOption(
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
    Color color,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border:
              isSelected
                  ? Border.all(color: Colors.blueAccent, width: 3)
                  : Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: isSelected ? Colors.blueAccent : Colors.grey[700],
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blueAccent : Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadingFeatures() {
    return Column(
      children: [
        // Focus Mode
        _buildFeatureToggle(
          "Focus Mode",
          Icons.highlight,
          _isFocusMode,
          (value) => _toggleFocusMode(value),
        ),
        SizedBox(height: 10),
        // Auto Brightness
        _buildFeatureToggle(
          "Auto Brightness",
          Icons.brightness_auto,
          widget.passbright,
          (value) {
            setState(() {
              widget.updateBrightnessCallback(value);
            });
          },
        ),
        SizedBox(height: 10),
        // Scrolling Mode
        _buildFeatureToggle(
          "Vertical Scrolling",
          Icons.swap_vert,
          _isScrollingMode,
          (value) => _toggleScrollingMode(value),
        ),
      ],
    );
  }

  Widget _buildFeatureToggle(
    String label,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700], size: 20),
          SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 14)),
          Spacer(),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  void _increaseFontSize() {
    setState(() {
      _fontSize += 1.0;
      _applyTextStyles();
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 8.0) {
        _fontSize -= 1.0;
        _applyTextStyles();
      }
    });
  }

  void _increaseLineSpacing() {
    setState(() {
      _lineSpacing += 0.1;
      _applyTextStyles();
    });
  }

  void _decreaseLineSpacing() {
    setState(() {
      if (_lineSpacing > 0.8) {
        _lineSpacing -= 0.1;
        _applyTextStyles();
      }
    });
  }

  void _toggleBoldMode(bool value) {
    setState(() {
      _isBoldMode = value;
      _applyTextStyles();
    });
  }

  void _toggleFocusMode(bool value) {
    setState(() {
      _isFocusMode = value;
      _applyTextStyles();
    });
  }

  void _toggleScrollingMode(bool value) {
    setState(() {
      _isScrollingMode = value;
    });
  }

  void _setDefaultFont() {
    setState(() {
      widget.isRoboto = false;
      _applyTextStyles();
      widget.updateTextCallback(widget.chapter, false);
    });
  }

  void _setDyslexicFont() {
    setState(() {
      widget.isRoboto = true;
      _applyTextStyles();
      widget.updateTextCallback(widget.chapter, true);
    });
  }

  void _setDisplayMode(int mode) {
    setState(() {
      _isLightMode = mode == 0;
      _isSepiaMode = mode == 1;
      _isDarkMode = mode == 2;

      if (_isLightMode) {
        widget.updateBackgroundColorCallback(Colors.white);
        _applyTextStyles(textColor: Colors.black87);
      } else if (_isSepiaMode) {
        widget.updateBackgroundColorCallback(Color(0xFFF4ECD8));
        _applyTextStyles(textColor: Colors.brown[800]!);
      } else if (_isDarkMode) {
        widget.updateBackgroundColorCallback(Colors.grey[900]!);
        _applyTextStyles(textColor: Colors.white);
      }
    });
  }

  void _applyTextStyles({Color? textColor}) {
    final TextStyle newStyle = TextStyle(
      fontFamily: widget.isRoboto ? 'OpenDyslexic' : 'Roboto',
      fontSize: _fontSize,
      height: _lineSpacing,
      fontWeight: _isBoldMode ? FontWeight.bold : FontWeight.normal,
      color: textColor ?? widget.chapter.text.style?.color ?? Colors.black87,
      backgroundColor: _isFocusMode ? Colors.yellow.withOpacity(0.2) : null,
    );

    final List<TextSpan> spans = [];
    if (widget.chapter.text is TextSpan) {
      final originalSpans = (widget.chapter.text as TextSpan).children;
      if (originalSpans != null) {
        for (final span in originalSpans) {
          if (span is TextSpan) {
            spans.add(
              TextSpan(
                text: span.text,
                style: span.style?.copyWith(
                  fontFamily: newStyle.fontFamily,
                  fontSize: newStyle.fontSize,
                  height: newStyle.height,
                  fontWeight: newStyle.fontWeight,
                  backgroundColor: newStyle.backgroundColor,
                ),
              ),
            );
          }
        }
      }
    }

    final RichText updatedRichText = RichText(
      text: TextSpan(
        style: newStyle,
        children:
            spans.isNotEmpty
                ? spans
                : [TextSpan(text: widget.chapter.text.toPlainText())],
      ),
    );

    widget.updateTextAndStyleCallback(updatedRichText, newStyle);
  }
}
