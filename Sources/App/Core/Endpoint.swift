//
//  Endpoint.swift
//  re-viewed-backend
//
//  Created by Tuğcan ÖNBAŞ on 03.04.2023.
//

import Vapor

enum Endpoint {
    // MARK: - General

    static let api: PathComponent = "api"

    // MARK: - Versioning

    static let v1: PathComponent = "v1"

    // MARK: - Authentication

    static let auth: PathComponent = "auth"

    // MARK: - Profile

    static let profiles: PathComponent = "profiles"
    static let profileID: PathComponent = ":profileID"
}
