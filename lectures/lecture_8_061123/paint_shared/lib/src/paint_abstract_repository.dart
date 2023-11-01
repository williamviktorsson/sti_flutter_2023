
import 'paint_crud_utils.dart';
import 'paint_data.dart';

abstract class AbstractPaintRepository {
  const AbstractPaintRepository();

  Future<CRUDResult<Paint>> create(Paint item);
  Future<CRUDResult<Paint>> read(String id);
  Future<CRUDResult<Paint>> update(String id, Paint item);
  Future<CRUDResult<void>> delete(String id);
  Future<CRUDResult<List<Paint>>> list();
  Future<Stream<Paint?>> changes(String itemId);

}
