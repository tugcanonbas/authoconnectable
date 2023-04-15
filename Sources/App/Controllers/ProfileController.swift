import Authomatek
import ConnectableKit
import Fluent
import Vapor

struct ProfileController {
    func index(req: Request) async throws -> Profile.List.DTO {
        let profiles = try await Profile.query(on: req.db).all()
        let list = Profile.List(profiles)

        return list.toDTO(.ok, status: .success, message: "Profiles fetched successfully!")
    }

    func get(req: Request) async throws -> Profile.DTO {
        guard let profile = try await Profile.find(req.parameters.get("profileID"), on: req.db) else {
            throw Abort(.notFound)
        }

        return profile.toDTO(.ok, status: .success, message: "Profile fetched successfully!")
    }

    func create(req: Request) async throws -> Profile.DTO {
        let createRequest = try req.content.decode(Profile.Create.self)

        let user = try req.auth.require(UserModel.self)

        guard try await Profile.query(on: req.db).filter(\.$user.$id == user.requireID()).first() == nil else {
            throw Abort(.badRequest, reason: "Profile already exists!")
        }

        let profile = Profile(name: createRequest.name, surname: createRequest.surname, bio: createRequest.bio)

        profile.$user.id = try user.requireID()

        try await profile.save(on: req.db)

        return profile.toDTO(.created, status: .success, message: "Profile created successfully!")
    }

    func update(req: Request) async throws -> Profile.DTO {
        let updateRequest = try req.content.decode(Profile.Update.self)

        let user = try req.auth.require(UserModel.self)

        guard let profile = try await Profile.query(on: req.db).filter(\.$user.$id == user.requireID()).first() else {
            throw Abort(.notFound)
        }

        profile.name = updateRequest.name
        profile.surname = updateRequest.surname
        profile.bio = updateRequest.bio

        try await profile.save(on: req.db)

        return profile.toDTO(.ok, status: .success, message: "Profile updated successfully!")
    }

    func delete(req: Request) async throws -> Connector.DTO {
        guard let profile = try await Profile.find(req.parameters.get("profileID"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await profile.delete(on: req.db)

        return Connector.toDTO(.ok, status: .success, message: "Profile deleted successfully!")
    }
}
