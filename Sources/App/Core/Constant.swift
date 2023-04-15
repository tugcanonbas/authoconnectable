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
        static let port: Int = Environment.get("DATABASE_PORT").flatMap(Int.init) ?? 5432
        static let username: String = Environment.get("DATABASE_USERNAME") ?? "postgres"
        static let password: String = Environment.get("DATABASE_PASSWORD") ?? "postgres"
        static let database: String = Environment.get("DATABASE_NAME") ?? "db"
    }
}
