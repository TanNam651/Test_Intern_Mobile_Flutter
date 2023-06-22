import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteModel {
  static const String DATABASE_NAME = 'jokee.db';
  static const String TABLE_NAME = 'jokee';
  static const String ID = 'id';
  static const String CONTENT = 'content';
  static const String FUNNY_RATING = 'funny';
  static const String NOT_FUNNY_RATING = 'notfunny';

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, DATABASE_NAME);
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_NAME (
        $ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $CONTENT TEXT,
        $FUNNY_RATING INTEGER,
        $NOT_FUNNY_RATING INTEGER
      )
      ''');

    await db.insert(TABLE_NAME, {
      CONTENT:
          '\tA child asked his father, "How were people born?" So his father said, "Adam and Eve made babies, then their babies became adults and made babies, and so on. "The child then went to his mother, asked her the same question and she told him, "We were monkeys then we evolved to become like we are now.\n\t"The child ran back to his father and said, "You lied to me!" His father replied, "No, your mom was talking about her side of the family."',
      FUNNY_RATING: 0,
      NOT_FUNNY_RATING: 0
    });
    await db.insert(TABLE_NAME, {
      CONTENT:
          '\tTeacher: "Kids,what does the chicken give you?" Student: "Meat!" Teacher: "Very good! Now what does the pig give you?" Student: "Bacon!" Teacher: "Great! And what does the fat cow give you?" Student: "Homework!"',
      FUNNY_RATING: 0,
      NOT_FUNNY_RATING: 0
    });
    await db.insert(TABLE_NAME, {
      CONTENT:
          '\tThe teacher asked Jimmy, "Why is your cat at school today Jimmy?" Jimmy replied crying, "Because I heard my daddy tell my mommy, "I am going to eat that pussy once Jimmy leaves for school today!"',
      FUNNY_RATING: 0,
      NOT_FUNNY_RATING: 0
    });
    await db.insert(TABLE_NAME, {
      CONTENT:
          '\tA housewife, an accountant and a lawyer were asked "How much is 2+2?" The housewife replies: "Four!". The accountant says: "I think it'
              's either 3 or 4. Let me run those figures through my spreadsheet one more time." The lawyer pulls the drapes, dims the lights and asks in a hushed voice, "How much do you want it to be?"',
      FUNNY_RATING: 0,
      NOT_FUNNY_RATING: 0
    });
  }

  Future<List<Map<String, dynamic>>> getDatabase() async {
    final db = await _openDatabase();
    return db.query(TABLE_NAME);
  }

  Future<void> updateFunnyRating(int id, int rating) async {
    final db = await _openDatabase();
    await db.update(TABLE_NAME, {FUNNY_RATING: rating},
        where: '$ID = ?', whereArgs: [id]);
  }

  Future<void> updateNotFunnyRating(int id, int rating) async {
    final db = await _openDatabase();
    await db.update(TABLE_NAME, {NOT_FUNNY_RATING: rating},
        where: '$ID = ?', whereArgs: [id]);
  }
}
