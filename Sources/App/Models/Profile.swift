import Authomatek
import ConnectableKit
import Fluent
import Vapor

final class Profile: Model, Connectable {
    static let schema = "profiles"

    enum FieldKeys {
        static let userID: FieldKey = "user_id"
        static let name: FieldKey = "name"
        static let surname: FieldKey = "surname"
        static let bio: FieldKey = "bio"
    }
    
    @ID(key: .id)
    var id: UUID?

    @Parent(key: FieldKeys.userID)
    var user: UserModel

    @Field(key: FieldKeys.name)
    var name: String

    @Field(key: FieldKeys.surname)
    var surname: String

    @Field(key: FieldKeys.bio)
    var bio: String

    init() { }

    init(id: UUID? = nil, name: String, surname: String, bio: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.bio = bio
    }
}

extension Profile {
    struct Create: Content {
        let name: String
        let surname: String
        let bio: String
    }

    struct Update: Content {
        let name: String
        let surname: String
        let bio: String
    }

    struct List: Connectable {
        let count: Int
        let profiles: [Profile]

        init(_ profiles: [Profile]) {
            self.count = profiles.count
            self.profiles = profiles
        }
    }

    static func list(_ req: Request) async throws -> List {
        let profiles = try await Profile.query(on: req.db).all()

        return List(profiles)
    }
}
