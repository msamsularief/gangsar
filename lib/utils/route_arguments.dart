import 'package:klinik/core/image_initial.dart';
import 'package:klinik/model/image_component.dart';

/// RouteArguments digunakan untuk memberikan
/// argument pada setiap route yang membutuhkan parameter
/// pada class Widget-nya
class RouteArgument {
  final Ref? reference;
  final Function? fn;
  final String? imgUrl;
  final ImageComponent? imageComponent;
  final ImageInitial? imageInitial;
  final List<String>? imageUrls;

  RouteArgument({
    this.reference = Ref.None,
    this.fn,
    this.imgUrl,
    this.imageUrls,
    this.imageComponent,
    this.imageInitial,
  });
}

enum Ref { Notif, None }
