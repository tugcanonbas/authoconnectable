# AuthoConnectable Template

A template to create a new Vapor project with ease of Authomatek and ConnectableKit packages!

## Features

- Pre-configured with Authomatek and ConnectableKit packages
  - That mean you can directly use Authentication with the structured JSON response
- Pre-configured `ServerConfiguration` for the API
  - Server status info logs for environment that is using.
  - Settting for the hostname and port.
  - `ConnectableKit` configurations
    - `ConnectableErrorMiddleware` and `ConnectableCORSMiddleware` are pre-configured
  - Default `FileMiddleware` for public directory
  - Use `.leaf` if you did choose to use Leaf as the template engine
  - `Authomatek` configurations
    - Custom `RouteConfig` for the versioning
    - `AuthoConnectable` controller to use `Connectable` protocol for the `AuthoController`
  - Database configurations (Just for SQL databases)
    - Can be choose between `PostgreSQL`, `MySQL` (Because I tested it with these two only 😬)
    - Migrations for the Profile model and it's DTO's like `Create`, `Login`, `Update` and `List` (UserModel and UserStatus added by `Authomatek`)
    - Auto migration and wait for the database to be ready
  - Route configurations
    - Default max body size is 10MB
    - `WEBRouter` for the web routes if you did choose to use Leaf as the template engine
    - `APIRouter` for all routes
      - Pre-configured versioning routes for the `ProfileRouter` (Authentication routes added by `Authomatek`)
    - `ProfileRouter` for the GET all, `GET` by `:profileID`, `POST`, `PUT` and `PUT` routes
      - `POST`, `PUT` and `DELETE` is protected by `AuthoMiddleware`
  - Pre-configured `Constant`s and `Endpoint`s
    - `Constant` for the `Server` and `Database` related
    - `Endpoint` for the route and versioning related

---

## Installation

### - Using Vapor CLI

- It's easy to create a new project with this template using Vapor CLI (toolbox) like creating a new project with the default template.

```bash
vapor new {{project_name}} --template https://github.com/tugcanonbas/authoconnectable.git
```

- The process is the same with the default template with minimum adjustments for `Authomatek` package. Just follow the steps and you are good to go!

  - It will not ask you to use fluent,

  ```bash
  Would you like to use Fluent? (--fluent/--no-fluent)
  ```

  because fluent is a must for `Authomatek` package.

  - It will ask you to choose the database type, choose one of the following (Because I tested it with these two only 😬):

    - `PostgreSQL`
    - `MySQL`

  - It will ask you to use Leaf as the template engine.

---

## Environment Variables

- You need to set the environment variables:
  - for the database connection.
  - for the JWT secret key.
  - for the JWT access and refresh expiration time.

| Key                                | Default Value                           | Description               |
| ---------------------------------- | --------------------------------------- | ------------------------- |
| `SERVER_HOST`                      | `localhost`                             | For the server host       |
| `SERVER_PORT`                      | `8080`                                  | For the server port       |
| `DATABASE_HOST`                    | `localhost`                             | For the database host     |
| `DATABASE_PORT`                    | `5432` for PostgreSQL, `3306` for MySQL | For the database port     |
| `DATABASE_USERNAME`                | `vapor_username`                        | For the database username |
| `DATABASE_PASSWORD`                | `vapor_password`                        | For the database password |
| `DATABASE_NAME`                    | `vapor_database`                        | For the database name     |
| `SECRET_KEY_FILE_PATH`             | none                                    | .pem file path for JWT    |
| `ACCESS_EXPIRATION_DATE_INTERVAL`  | `3600`                                  | Access Token expiration   |
| `REFRESH_EXPIRATION_DATE_INTERVAL` | `604800`                                | Refresh Token expiration  |

---

## Routes

---

| URL                         | HTTP Method | Description                           | Content (Body)                                              |
| --------------------------- | :---------: | ------------------------------------- | ----------------------------------------------------------- |
| /                           |     GET     | Welcoming page                        | index.leaf with title                                       |
| /\*                         |     GET     | Catch All                             | index.leaf with title                                       |
| /api/v1/auth/register       |    POST     | Registers a new user                  | `User.DTO.Register`                                         |
| /api/v1/auth/login          |    POST     | Login with existing user              | `User.DTO.Login`                                            |
| /api/v1/auth/logout         |     GET     | Logout with existing user             | Bearer Token with `Connector.DTO`                           |
| /api/v1/auth/refresh        |     GET     | Refresh the existing JWT token        | Bearer Token with `Connector.DTO`                           |
| /api/v1/profiles            |     GET     | Fetch all profiles                    | `Profile.List.DTO`                                          |
| /api/v1/profiles/:profileID |     GET     | Fetch profile with provided id        | `Profile.DTO`                                               |
| /api/v1/profiles/           |    POST     | Create profile for authenticated user | `Profile.DTO`                                               |
| /api/v1/profiles/           |     PUT     | Update profile for authenticated user | `Profile.DTO`                                               |
| /api/v1/profiles/           |   DELETE    | Delete profile for authenticated user | `Connector.DTO`                                             |
| /api/\*\*                   |     GET     | Catch All                             | `Abort(.notFound, reason: "Not Found)` with `Connector.DTO` |
| /api/\*\*                   |    POST     | Catch All                             | `Abort(.notFound, reason: "Not Found)` with `Connector.DTO` |
| /api/\*\*                   |     PUT     | Catch All                             | `Abort(.notFound, reason: "Not Found)` with `Connector.DTO` |
| /api/\*\*                   |   DELETE    | Catch All                             | `Abort(.notFound, reason: "Not Found)` with `Connector.DTO` |
| /api/\*\*                   |    PATCH    | Catch All                             | `Abort(.notFound, reason: "Not Found)` with `Connector.DTO` |

---

## That's it!

- From now on, you can start developing your project with the `AuthoConnectable` template.

- If you have any questions, feel free to ask me.

- If you find any bugs, please open an issue.

- If you want to contribute, feel free to open a pull request.

- If you like this template, please give it a star ⭐️

---

## Check out my other packages:

  <!-- ConnectableKit Section Start -->

# [📦 ConnectableKit](https://github.com/tugcanonbas/connectable-kit)

ConnectableKit is a Swift package for the Vapor framework that simplifies the response DTOs and JSON structures for API projects.

#### Features

- Generic JSON structure: The Connectable protocol allows you to define a wrapped Vapor Content structs.
- Custom HTTPStatus for every responses.
- ErrorMiddleware configurations for handling Vapor's error as ConnectableKit JSON output.
- CORSMiddleware configurations for handling Vapor's CORSMiddleware with ease.

<!-- ConnectableKit Section Start -->

# [📦 Authomatek](https://github.com/tugcanonbas/authomatek)

Authomatek is a Swift package for Vapor that provides pre-configured authentication for relational databases. It automates the process of creating all the necessary routes, controllers, and models, allowing you to quickly and easily set up authentication for your Vapor application.

With Authomatek, you can get up and running with secure user authentication in no time. Additionally, Authomatek supports JSON Web Tokens (JWT) for secure user authentication and authorization.

#### Features

- User registration
- User login (with JWT)
- User logout
- User JWT refresh

## License

AuthoConnectable is released under the MIT license. See LICENSE for details.
