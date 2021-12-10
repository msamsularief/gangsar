/// RouteArguments digunakan untuk memberikan
/// argument pada setiap route yang membutuhkan parameter
/// pada class Widget-nya
class RouteArgument {
  final Ref? reference;
  final Function? fn;

  RouteArgument({
    this.reference = Ref.None,
    this.fn,
  });
}

enum Ref { Notif, None }
