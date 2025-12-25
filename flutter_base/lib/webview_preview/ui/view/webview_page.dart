import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.url, this.title});

  final String url;
  final String? title;

  static const routeName = 'webview';

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? _controller;
  bool _isLoading = true;
  double _leftWidth = 300;
  double _topHeight = 300;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WebView ${widget.title} ${isPortrait ? 'Portrait' : 'Landscape'}',
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isPortrait) {
            return Column(
              children: [
                SizedBox(height: _topHeight, child: _buildListContent()),
                MouseRegion(
                  cursor: SystemMouseCursors.resizeRow,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onVerticalDragUpdate: (details) {
                      setState(() {
                        _topHeight = (_topHeight + details.delta.dy).clamp(
                          100.0,
                          constraints.maxHeight - 100.0,
                        );
                      });
                    },
                    child: Container(
                      height: 8,
                      color: Colors.grey.withValues(alpha: 0.2),
                      child: const Center(
                        child: Divider(thickness: 1, height: 1),
                      ),
                    ),
                  ),
                ),
                Expanded(child: _buildWebViewStack()),
              ],
            );
          } else {
            return Row(
              children: [
                SizedBox(width: _leftWidth, child: _buildListContent()),
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
                Expanded(child: _buildWebViewStack()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildListContent() {
    return Column(
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
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text('${index + 1}')),
                    Expanded(flex: 2, child: Text('Item ${index + 1}')),
                    Expanded(
                      flex: 3,
                      child: Text('Description for item ${index + 1}'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWebViewStack() {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onLoadStart: (controller, url) {
            setState(() {
              _isLoading = true;
            });
          },
          onLoadStop: (controller, url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
        if (_isLoading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
