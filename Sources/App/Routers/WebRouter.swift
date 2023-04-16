//
//  WebRouter.swift
//  authoconnectable
//
//  Created by Tuğcan ÖNBAŞ on 16.04.2023.
//

import Vapor
import Leaf

struct WebRouter: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
        routes.get(.anything, use: catchAll)
    }

    func index(req: Request) async throws -> View {
        return try await req.view.render("index", ["title": "AuthoConnectable Template"])
    }

    func catchAll(req: Request) async throws -> View {
        // MARK: - Custom 404 page
        return try await req.view.render("index", ["title": "NOT FOUND"])
    }
}