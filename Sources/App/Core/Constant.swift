//
//  Constant.swift
//  re-viewed-backend
//
//  Created by Tuğcan ÖNBAŞ on 02.04.2023.
//

import Foundation
import Vapor

enum Constant {
    enum Server {
        static let hostname: String = Environment.get("SERVER_HOST") ?? "localhost"
        static let port: Int = Environment.get("SERVER_PORT").flatMap(Int.init) ?? 8080
    }

    enum Database {
        static let hostname: String = Environment.get("DATABASE_HOST") ?? "localhost"
        static let port: Int = Environment.get("DATABASE_PORT").flatMap(Int.init) ?? {{#fluent.is_postgres}}5432{{/fluent.is_postgres}}{{#fluent.is_mysql}}3306{{/fluent.is_mysql}}
        static let username: String = Environment.get("DATABASE_USERNAME") ?? "vapor_username"
        static let password: String = Environment.get("DATABASE_PASSWORD") ?? "vapor_password"
        static let database: String = Environment.get("DATABASE_NAME") ?? "vapor_database"
    }
}
