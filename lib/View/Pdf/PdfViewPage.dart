import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../../Controller/PdfController.dart';


class PdfViewPage extends StatelessWidget {
  final String path;
  late final pdfPinchController;
  late final pdfController;
  PdfViewPage({super.key, required this.path}) {
    pdfPinchController = PdfControllerPinch(
      document: PdfDocument.openFile(path),
    );
    pdfController = PdfController(
      document: PdfDocument.openFile(path),
    );
    
  }

  // FilePdfController pdfFileController = Get.put(FilePdfController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfViewPinch(
        controller: pdfPinchController,
        builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(
            loaderSwitchDuration: const Duration(seconds: 1),
            transitionBuilder: SomeWidget.transitionBuilder,
          ),
          documentLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          pageLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, error) => Center(child: Text(error.toString())),
          builder: SomeWidget.builder,
        ),
      ),
    );
  }
}

class SomeWidget {
  static Widget builder(
    BuildContext context,
    PdfViewPinchBuilders builders,
    PdfLoadingState state,
    WidgetBuilder loadedBuilder,
    PdfDocument? document,
    Exception? loadingError,
  ) {
    final Widget content = () {
      switch (state) {
        case PdfLoadingState.loading:
          return KeyedSubtree(
            key: const Key('pdfx.root.loading'),
            child: builders.documentLoaderBuilder?.call(context) ??
                const SizedBox(),
          );
        case PdfLoadingState.error:
          return KeyedSubtree(
            key: const Key('pdfx.root.error'),
            child: builders.errorBuilder?.call(context, loadingError!) ??
                Center(child: Text(loadingError.toString())),
          );
        case PdfLoadingState.success:
          return KeyedSubtree(
            key: Key('pdfx.root.success.${document!.id}'),
            child: loadedBuilder(context),
          );
      }
    }();

    final defaultBuilder =
        builders as PdfViewPinchBuilders<DefaultBuilderOptions>;
    final options = defaultBuilder.options;

    return AnimatedSwitcher(
      duration: options.loaderSwitchDuration,
      transitionBuilder: options.transitionBuilder,
      child: content,
    );
  }

  static Widget transitionBuilder(Widget child, Animation<double> animation) =>
      FadeTransition(opacity: animation, child: child);

  static PhotoViewGalleryPageOptions pageBuilder(
    BuildContext context,
    Future<PdfPageImage> pageImage,
    int index,
    PdfDocument document,
  ) =>
      PhotoViewGalleryPageOptions(
        imageProvider: PdfPageImageProvider(
          pageImage,
          index,
          document.id,
        ),
        minScale: PhotoViewComputedScale.contained * 1,
        maxScale: PhotoViewComputedScale.contained * 3.0,
        initialScale: PhotoViewComputedScale.contained * 1.0,
        heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
      );
}
