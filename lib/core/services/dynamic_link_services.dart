import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class _DynamicLinkServices {
  /// for creting dynamic for particular blog reaction
  /// * pass [blogId] as [String] for getting particular blog
  Future<String> createBlogsDynamicLink({required String blogId}) async {
    final link = 'https://www.minglewise.com/blogs?blogId=$blogId';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://minglewise.page.link',
      link: Uri.parse(link),
      androidParameters: const AndroidParameters(
        packageName: 'com.appsynergies.minglewise',
      ),
      iosParameters:
          const IOSParameters(bundleId: 'com.appsynergies.minglewise'),
    );

    Uri dynamicUrl;

    try {
      dynamicUrl =
          (await FirebaseDynamicLinks.instance.buildShortLink(parameters))
              .shortUrl;
    } on Exception catch (_) {
      dynamicUrl =
          (await FirebaseDynamicLinks.instance.buildShortLink(parameters))
              .shortUrl;
    }

    return dynamicUrl.toString();
  }
}

final dynamicLinkServices = _DynamicLinkServices();
