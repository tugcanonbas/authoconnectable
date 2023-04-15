//
//  APIRouter.swift
//  re-viewed-backend
//
//  Created by Tuğcan ÖNBAŞ on 03.04.2023.
//

import ConnectableKit
import Vapor

struct APIRouter: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        {{#leaf}}routes.get { req -> View in
            return try await req.view.render("index", ["title": "AuthoConnectable Template"])
        }{{/leaf}}

        let api = routes.grouped(Endpoint.api)
        try registerV1Routes(routes: api)

        try catchAll(routes: api)
    }

    func registerV1Routes(routes: RoutesBuilder) throws {
        let v1 = routes.grouped(Endpoint.v1)

        try v1.register(collection: ProfileRouter())
    }

    func catchAll(routes: RoutesBuilder) throws {
        routes.get(.catchall) { _ throws -> Connector.DTO in
            // TODO: - Implement Custom 404 page
            throw Abort(.notFound, reason: "Not Found")
        }

        routes.post(.catchall) { _ throws -> Connector.DTO in
            // TODO: - Implement Custom 404 page
            throw Abort(.notFound, reason: "Not Found")
        }

        routes.put(.catchall) { _ throws -> Connector.DTO in
            // TODO: - Implement Custom 404 page
            throw Abort(.notFound, reason: "Not Found")
        }

        routes.delete(.catchall) { _ throws -> Connector.DTO in
            // TODO: - Implement Custom 404 page
            throw Abort(.notFound, reason: "Not Found")
        }

        routes.patch(.catchall) { _ throws -> Connector.DTO in
            // TODO: - Implement Custom 404 page
            throw Abort(.notFound, reason: "Not Found")
        }
    }
}
