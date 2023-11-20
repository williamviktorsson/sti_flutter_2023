
import 'game_crud_utils.dart';
import 'game_data.dart';

// 
abstract interface class AbstractBoardRepository {

  Future<CRUDResult<Board>> create(Board item);
  Future<CRUDResult<Board>> read(String id);
  Future<CRUDResult<Board>> update(String id, Board item);
  Future<CRUDResult<void>> delete(String id);
  Future<CRUDResult<List<Board>>> list();
  Future<Stream<Board?>> changes(String itemId);

}
