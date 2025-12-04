import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.url, this.title});

  final String url;
  final String? title;

  static const routeName = 'webview';

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  double _leftWidth = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              SizedBox(
                width: _leftWidth,
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.grey.withValues(alpha: 0.1),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'ID',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Description',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // List
                    Expanded(
                      child: ListView.separated(
                        itemCount: 20,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text('${index + 1}')),
                                Expanded(
                                  flex: 2,
                                  child: Text('Item ${index + 1}'),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Description for item ${index + 1}',
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.resizeColumn,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _leftWidth = (_leftWidth + details.delta.dx).clamp(
                        100.0,
                        constraints.maxWidth - 100.0,
                      );
                    });
                  },
                  child: Container(
                    width: 8,
                    color: Colors.grey.withValues(alpha: 0.2),
                    child: const Center(
                      child: VerticalDivider(thickness: 1, width: 1),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    WebViewWidget(controller: _controller),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
