import Authomatek
import Fluent

struct CreateProfile: AsyncMigration {

    typealias FieldKey = Profile.FieldKeys
    let schema = Profile.schema

    func prepare(on database: Database) async throws {
        try await database.schema(schema)
            .id()
            .field(FieldKey.userID, .uuid, .required, .references(UserModel.schema, .id, onDelete: .cascade))
            .field(FieldKey.name, .string, .required)
            .field(FieldKey.surname, .string, .required)
            .field(FieldKey.bio, .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(schema).delete()
    }
}
