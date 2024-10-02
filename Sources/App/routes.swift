import Fluent
import Foundation
import Vapor

func routes(_ app: Application) throws {
  let basicAuthMiddleWare = UserModel.authenticator()
  let guardMiddleware = UserModel.guardMiddleware()

  let basicAuthGroup = app.routes.grouped(basicAuthMiddleWare)
  let protected = app.routes.grouped(basicAuthMiddleWare, guardMiddleware)

  let tokenAuthMiddleWare = TokenModel.authenticator()
  let tokenAuthgroup = app.routes.grouped(tokenAuthMiddleWare, guardMiddleware)

  let adminMiddleware: CheckAdminMiddleWare = CheckAdminMiddleWare()
  let adminTokenAuthGroup = app.routes.grouped(tokenAuthMiddleWare, guardMiddleware, adminMiddleware)

  let studentMiddleWare = CheckStudentMiddleWare()
  let studentTokenAuthGroup = app.routes.grouped(tokenAuthMiddleWare, studentMiddleWare)

  let authController = AuthController()
  let userController = UserController()
  let courseControllers = CourseControllers()
  let guideController = GuideController()
  let articleController = ArticleController()
  let sessionController = SessionController()

  // MARK: - 注册认证路由
  basicAuthGroup.post("users", "\(RoutesEnum.login.rawValue)", use: authController.loginHandler)
  basicAuthGroup.post("users", "\(RoutesEnum.register.rawValue)", use: userController.create)
  
  tokenAuthgroup.get("users", "\(RoutesEnum.profile.rawValue)", use: userController.get)
  tokenAuthgroup.patch("users", "\(RoutesEnum.profile.rawValue)", "\(RoutesEnum.update.rawValue)", use: userController.update)
  tokenAuthgroup.delete("users", "\(RoutesEnum.profile.rawValue)", "\(RoutesEnum.delete.rawValue)", use: userController.delete)
  
  // MARK: - 注册用户内容路由
  app.routes.get("users", "\(RoutesEnum.courses.rawValue)", use: courseControllers.getAllObject)
  app.routes.get("users", "\(RoutesEnum.courses.rawValue)", "\(RouteParameters.slug.rawValue)", use: courseControllers.getObject)
  studentTokenAuthGroup.get("users", "\(RoutesEnum.courses.rawValue)", "\(RouteParameters.slug.rawValue)", "session", "\(RouteParameters.article.rawValue)", use: sessionController.getSelectedObject)
  
  app.routes.get("users", "\(RoutesEnum.guides.rawValue)", use: guideController.getAllObject)
  app.routes.get("users", "\(RoutesEnum.guides.rawValue)", "\(RouteParameters.slug.rawValue)", use: guideController.getObject)
  studentTokenAuthGroup.get("users", "\(RoutesEnum.guides.rawValue)", "\(RouteParameters.slug.rawValue)", "article", "\(RouteParameters.article.rawValue)", use: articleController.getSelectedObject)
  
  // MARK: - 注册管理员路由
  adminTokenAuthGroup.post("\(RoutesEnum.courses.rawValue)", use: courseControllers.create)
  adminTokenAuthGroup.get("\(RoutesEnum.courses.rawValue)/by-slug/\(RouteParameters.slug.rawValue)", use: courseControllers.get)
  adminTokenAuthGroup.get("\(RoutesEnum.courses.rawValue)", use: courseControllers.getAll)
  adminTokenAuthGroup.patch("\(RoutesEnum.courses.rawValue)", "\(RouteParameters.slug.rawValue)", use: courseControllers.update)
  adminTokenAuthGroup.delete("\(RoutesEnum.courses.rawValue)", "\(RouteParameters.slug.rawValue)", use: courseControllers.delete)
  adminTokenAuthGroup.get("\(RoutesEnum.courses.rawValue)/by-status/\(RouteParameters.status.rawValue)", use: courseControllers.getByStatus)
  adminTokenAuthGroup.get("\(RoutesEnum.courses.rawValue)", "\(RoutesEnum.search.rawValue)", "\(RouteParameters.query.rawValue)", use: courseControllers.search)
  
  adminTokenAuthGroup.post("\(RoutesEnum.guides.rawValue)", use: guideController.create)
  adminTokenAuthGroup.get("\(RoutesEnum.guides.rawValue)", "by-slug", "\(RouteParameters.slug.rawValue)", use: guideController.get)
  adminTokenAuthGroup.get("\(RoutesEnum.guides.rawValue)", use: guideController.getAll)
  adminTokenAuthGroup.patch("\(RoutesEnum.guides.rawValue)", "\(RouteParameters.slug.rawValue)", use: guideController.update)
  adminTokenAuthGroup.delete("\(RoutesEnum.guides.rawValue)", "\(RouteParameters.slug.rawValue)", use: guideController.delete)
  adminTokenAuthGroup.get("\(RoutesEnum.guides.rawValue)", "by-status", "\(RouteParameters.status.rawValue)", use: guideController.getByStatus)
  adminTokenAuthGroup.get("\(RoutesEnum.guides.rawValue)", "\(RoutesEnum.search.rawValue)", "\(RouteParameters.query.rawValue)", use: guideController.search)
  
  adminTokenAuthGroup.post("\(RoutesEnum.articles.rawValue)", use: articleController.create)
  adminTokenAuthGroup.get("\(RoutesEnum.articles.rawValue)", "by-slug", "\(RouteParameters.slug.rawValue)", use: articleController.get)
  adminTokenAuthGroup.get("\(RoutesEnum.articles.rawValue)", use: articleController.getAll)
  adminTokenAuthGroup.patch("\(RoutesEnum.articles.rawValue)", "\(RouteParameters.slug.rawValue)", use: articleController.update)
  adminTokenAuthGroup.delete("\(RoutesEnum.articles.rawValue)", "\(RouteParameters.slug.rawValue)", use: articleController.delete)
  adminTokenAuthGroup.get("\(RoutesEnum.articles.rawValue)", "by-status", "\(RouteParameters.status.rawValue)", use: articleController.getByStatus)
  adminTokenAuthGroup.get("\(RoutesEnum.articles.rawValue)", "\(RoutesEnum.search.rawValue)", "\(RouteParameters.query.rawValue)", use: articleController.search)
  
  adminTokenAuthGroup.post("\(RoutesEnum.sessions.rawValue)", use: sessionController.create)
  adminTokenAuthGroup.get("\(RoutesEnum.sessions.rawValue)", "by-slug", "\(RouteParameters.slug.rawValue)", use: sessionController.get)
  adminTokenAuthGroup.get("\(RoutesEnum.sessions.rawValue)", use: sessionController.getAll)
  adminTokenAuthGroup.patch("\(RoutesEnum.sessions.rawValue)", "\(RouteParameters.slug.rawValue)", use: sessionController.update)
  adminTokenAuthGroup.delete("\(RoutesEnum.sessions.rawValue)", "\(RouteParameters.slug.rawValue)", use: sessionController.delete)
  adminTokenAuthGroup.get("\(RoutesEnum.sessions.rawValue)", "by-status", "\(RouteParameters.status.rawValue)", use: sessionController.getByStatus)
  adminTokenAuthGroup.get("\(RoutesEnum.sessions.rawValue)", "\(RoutesEnum.search.rawValue)", "\(RouteParameters.query.rawValue)", use: sessionController.search)
}
