//
//  ServerConfiguration.swift
//  re-viewed-backend
//
//  Created by Tuğcan ÖNBAŞ on 02.04.2023.
//

import Authomatek
import ConnectableKit
import Fluent
import Fluent{{fluent.module}}Driver
{{#leaf}}import Leaf
{{/leaf}}import Vapor

public struct ServerConfiguration {
    let app: Application

    public init(app: Application) {
        self.app = app
    }

    public func configure() throws {
        status()
        settings()
        try authomatek()
        try database()
        try migrations()
        try routes()
    }

    private func status() {
        switch app.environment {
        case .development:
            app.console.info("🚀 Server is running in development mode.")
        case .production:
            app.console.info("🚀 Server is running in production mode.")
        default:
            app.console.info("🚀 Server is running in \(app.environment) mode.")
        }
    }

    //MARK: - ConnectableKit Settings
    private func connectableKit() {
        ConnectableKit.configureErrorMiddleware(app)
        ConnectableKit.configureCORS(app)
    }

    private func settings() {
        app.console.info("Confiuring settings...")

        app.http.server.configuration.hostname = Constant.Server.hostname
        app.http.server.configuration.port = Constant.Server.port

        connectableKit()

        app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

        {{#leaf}}

        app.views.use(.leaf)

        {{/leaf}}
    }

    //MARK: - Authomatek Settings
    private func authomatek() throws {
        let config = RouteConfig(path: Endpoint.api, Endpoint.v1, Endpoint.auth)
        let controller = AuthoConnectable()
        try Authomatek.configure(app, configuration: config, controller: controller)
    }

    private func database() throws {
        app.console.info("Configuring database...")

    {{#fluent.is_postgres}}app.databases.use(.postgres(
        hostname: Constant.Database.hostname,
        port: Constant.Database.port,
        username: Constant.Database.username,
        password: Constant.Database.password,
        database: Constant.Database.database
    ), as: .psql){{/fluent.is_postgres}}{{#fluent.is_mysql}}app.databases.use(.mysql(
        hostname: Constant.Database.hostname,
        port: Constant.Database.port,
        username: Constant.Database.username,
        password: Constant.Database.password,
        database: Constant.Database.database
    ), as: .mysql){{/fluent.is_mysql}}
    }

    private func migrations() throws {
        app.console.info("Configuring migrations...")

        // MARK: - MIGRATIONS

        app.migrations.add([
            // Profile Related
            CreateProfile(),
        ])

        try app.autoMigrate().wait()
    }

    private func routes() throws {
        app.console.info("Configuring routes...")

        app.routes.defaultMaxBodySize = "10mb"

        try app.register(collection: APIRouter())
    }
}
