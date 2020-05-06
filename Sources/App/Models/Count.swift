import FluentSQLite
import Vapor

final class Count: SQLiteModel {
    typealias Database = SQLiteDatabase
    
    var id: Int?
    var url: String
    var count: Int

    init(id: Int? = nil, url: String, count: Int = 1) {
        self.id = id
        self.url = url
        self.count = count
    }
}

extension Count: Migration {}
extension Count: Content {}
extension Count: Parameter {}
