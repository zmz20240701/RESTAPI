import Fluent
import FluentMySQLDriver
import NIOSSL
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

  app.databases.use(
    DatabaseConfigurationFactory.mysql(
      hostname: "localhost",
      port: 3306,
      username: "vapor_username",
      password: "vapor_password",
      database: "vapor_database"
    ), as: .mysql)

  // migrations setup
  app.migrations.add(UserModelMigration())
  app.migrations.add(GuideModelMigration())
  app.migrations.add(AticleModelMigration())
  app.migrations.add(SessionModelMigration())
  app.migrations.add(GuideModelMigration())
  app.migrations.add(TokenModelMigration())
  app.migrations.add(CreateUserSeed())
  // register routes
  try routes(app)
}
