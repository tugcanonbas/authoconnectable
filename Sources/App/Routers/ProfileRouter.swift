//
//  ProfileRouter.swift
//  re-viewed-backend
//
//  Created by Tuğcan ÖNBAŞ on 09.04.2023.
//

import Vapor
import Authomatek

struct ProfileRouter: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let controller = ProfileController()

        let profiles = routes.grouped(Endpoint.profiles)
        profiles.get(use: controller.index)
        profiles.group(Endpoint.profileID) { profile in
            profile.get(use: controller.get)
        }
        
        let protected = profiles.grouped(AuthoMiddleware())
        protected.post(use: controller.create)
        protected.put(use: controller.update)
        protected.group(Endpoint.profileID) { profile in
            profile.delete(use: controller.delete)
        }
    }
}