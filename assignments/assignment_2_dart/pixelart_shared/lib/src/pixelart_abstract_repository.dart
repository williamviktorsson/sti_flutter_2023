
import 'pixelart_crud_utils.dart';
import 'pixelart_data.dart';

abstract class AbstractPixelArtRepository {
  const AbstractPixelArtRepository();

  Future<CRUDResult<PixelArt>> create(PixelArt item);
  Future<CRUDResult<PixelArt>> read(String id);
  Future<CRUDResult<PixelArt>> update(String id, PixelArt item);
  Future<CRUDResult<void>> delete(String id);
  Future<CRUDResult<List<PixelArt>>> list();
  Future<Stream<PixelArt?>> changes(String itemId);

}
