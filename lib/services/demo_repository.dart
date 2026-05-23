import '../app_assets.dart';
import '../models/travel_bag.dart';
import '../models/travel_item.dart';

class DemoRepository {
  static final bags = <TravelBag>[
    TravelBag(
      name: 'Beg Bagasi',
      icon: AppAssets.manageIcon,
      items: [
        _item('1', 'Passport', 'Dokumen', 'Beg Bagasi', PackingStatus.missing, .92),
        _item('2', 'Iphone 16 Pro Max', 'Elektronik', 'Beg Bagasi', PackingStatus.packed, .98),
        _item('3', 'Berus gigi', 'Toiletries', 'Beg Bagasi', PackingStatus.missing, .86),
      ],
    ),
    TravelBag(
      name: 'Beg sandang',
      icon: AppAssets.checkoutIcon,
      items: [
        _item('4', 'Cable Phone', 'Elektronik', 'Beg sandang', PackingStatus.missing, .91),
        _item('5', 'Power bank', 'Elektronik', 'Beg sandang', PackingStatus.packed, .94),
      ],
    ),
    TravelBag(
      name: 'Beg Tangan',
      icon: AppAssets.snapIcon,
      items: [
        _item('6', 'Wallet', 'Peribadi', 'Beg Tangan', PackingStatus.packed, .96),
        _item('7', 'Tiket penerbangan', 'Dokumen', 'Beg Tangan', PackingStatus.optional, .83),
      ],
    ),
  ];

  static List<TravelItem> get allItems => bags.expand((bag) => bag.items).toList();

  static TravelItem _item(
    String id,
    String name,
    String category,
    String bag,
    PackingStatus status,
    double confidence,
  ) {
    return TravelItem(
      id: id,
      name: name,
      category: category,
      bag: bag,
      status: status,
      confidence: confidence,
    );
  }
}
