import Fluent
import Foundation
import Vapor

struct CourseService: ContentProtocol {
    typealias Answer = CourseModel
    typealias Request = Vapor.Request
    typealias CreateDTO = CreateCourseDTO
    typealias UpdateDTO = UpdateCourseDTO
    typealias Status = HTTPStatus
    typealias Model = CourseModel
    
    static func create(_ req: Request, createDTO: CreateCourseDTO, author: UserModel) async throws -> HTTPStatus {
        let _: String? = createDTO.title?.lowercased().replacingOccurrences(of: " ", with: "-")
        let fullAuthorName = "\(author.name) \(author.lastname)"
        let course = CourseModel()
        course.title = createDTO.title
        course.tags = createDTO.tags
        course.description = createDTO.description
        course.status = createDTO.status
        course.price = createDTO.price
        course.headerImage = URL(string: createDTO.headerImage!)
        course.article = createDTO.article
        course.topHexColor = createDTO.topHexColor
        course.bottomHexColor = createDTO.bottomHexColor
        course.sylabus = URL(string: createDTO.sylabus!)
        course.assets = URL(string: createDTO.assets!)
        course.publishedDate = createDTO.publishedDate
        course.author = fullAuthorName
        
        try await course.save(on: req.db)
        return .created
    }
    
    static func get(_ req: Request, object: String) async throws -> CourseModel {
        guard
            let course = try await CourseModel.query(on: req.db)
                .filter(\.$slug == object)
                .first()
        else {
            throw Abort(.notFound, reason: "Course not found")
        }
        return course
    }
    
    static func getAll(_ req: Request) async throws -> [CourseModel] {
        let courses = try await CourseModel.query(on: req.db).all()
        return courses
    }
    
    static func update(_ req: Request, object: String, updateDTO: UpdateCourseDTO) async throws -> CourseModel {
        guard
            let course = try await CourseModel.query(on: req.db)
                .filter(\.$slug == object)
                .first()
        else {
            throw Abort(.notFound, reason: "Course not found")
        }
        course.title = updateDTO.title ?? course.title
        course.tags = updateDTO.tags ?? course.tags
        course.description = updateDTO.description ?? course.description
        course.status = updateDTO.status ?? course.status
        course.price = updateDTO.price ?? course.price
        course.headerImage = URL(string: updateDTO.headerImage!)
        course.article = updateDTO.article ?? course.article
        course.topHexColor = updateDTO.topHexColor ?? course.topHexColor
        course.bottomHexColor = updateDTO.bottomHexColor ?? course.bottomHexColor
        course.sylabus = URL(string: updateDTO.sylabus!) ?? course.sylabus
        course.assets = URL(string: updateDTO.assets!) ?? course.assets
        course.publishedDate = updateDTO.publishedDate ?? course.publishedDate
        course.updatedAt = Date()
        try await course.save(on: req.db)
        return course
    }
    
    static func delete(_ req: Request, object: String) async throws -> HTTPStatus {
        guard
            let course = try await CourseModel.query(on: req.db)
                .filter(\.$slug == object)
                .first()
        else {
            throw Abort(.notFound, reason: "Course not found")
        }
        try await course.delete(on: req.db)
        return .noContent
    }
}

extension CourseService: BackendContentFilterProtocol {
    static func getByStatus(_ req: Vapor.Request, status: StatusEnum.RawValue) async throws -> [CourseModel] {
        let course = try await CourseModel.query(on: req.db)
            .filter(\.$status == status)
            .all()
        return course
    }
    
    static func search(_ req: Vapor.Request, query: String) async throws -> [CourseModel] {
        let course = try await CourseModel.query(on: req.db)
            .group(.or) { or in
                or.filter(\.$title =~ query)
            }.all()
        return course
    }
}

extension CourseService: FrontendProtocol {
    static func getObject(_ req: Vapor.Request, object: String) async throws -> CourseContext {
        let user = req.auth.get(UserModel.self)
        guard
            let course = try await CourseModel.query(on: req.db)
                .filter(\.$slug == object)
                .filter(\.$status == StatusEnum.published.rawValue)
                .first()
        else {
            throw Abort(.notFound)
        }
        
        let sessions = try await SessionModel.query(on: req.db)
            .filter(\.$course == course.id)
            .filter(\.$status == StatusEnum.published.rawValue)
            .all()
        
        return user?.role == RoleEum.student.rawValue ? CourseContext(course: course, sessions: sessions) : CourseContext(course: course, sessions: nil)
    }
    
    static func getAllObjects(_ req: Vapor.Request) async throws -> [CourseModel] {
        let course = try await CourseModel.query(on: req.db)
            .filter(\.$status == StatusEnum.published.rawValue)
            .all()
        return course
    }
    
    typealias model = CourseModel
    
    typealias answer = CourseContext
    
    typealias status = HTTPStatus
    
    typealias request = Vapor.Request
}


/// session的主要作用是保存状态,保住管理用户交互的过程.
/// `\.$course`表示访问 SessionModel 中的course这个外键属性, 这个属性类型为 Course
