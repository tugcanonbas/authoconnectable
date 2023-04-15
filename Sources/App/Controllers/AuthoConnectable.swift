//
//  AuthoConnectable.swift
//  re-viewed-backend
//
//  Created by Tuğcan ÖNBAŞ on 14.04.2023.
//

import Authomatek
import ConnectableKit
import Vapor

extension AuthoToken: Connectable {}

struct AuthoConnectable: AuthoControllable {
    func register(_ req: Request) async throws -> Connector.DTO {
        try await UserModel.register(req)

        return Connector.toDTO(.created, status: .success, message: "User created successfully!")
    }

    func login(_ req: Request) async throws -> AuthoToken.DTO {
        let token = try await UserModel.login(req)

        return token.toDTO(.ok, status: .success, message: "User logged in successfully!")
    }

    func logout(_ req: Request) throws -> Connector.DTO {
        try UserModel.logout(req)

        return Connector.toDTO(.ok, status: .success, message: "User logged out successfully!")
    }

    func refresh(_ req: Request) async throws -> AuthoToken.DTO {
        let token = try await UserModel.refresh(req)

        return token.toDTO(.ok, status: .success, message: "User token refreshed successfully!")
    }
}
