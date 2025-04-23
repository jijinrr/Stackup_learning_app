import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  const AppWebView({
    super.key,
    required this.webUrl,
    required this.title,
  });
  final String webUrl;
  final String title;

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // log('NavigationRequest: ${request.url}');
            // Check if the URL is a Google OAuth request
            if (request.url.contains(
                    'accounts.google.com') || //if need apple login add hear
                request.url.contains('oauth2')) {
              Get.back();
              _launchInSystemBrowser(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webUrl));
  }

  Future<void> _launchInSystemBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true, // Uses SFSafariViewController on iOS
        forceWebView: false, // Ensures system browser
        universalLinksOnly: false,
      );
    } else {
      Get.snackbar('Error', 'Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          centerTitle: false,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 10),
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: MyColors.white,
            ),
          ),
          titleSpacing: 5,
          title: Text(
            widget.title,
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
