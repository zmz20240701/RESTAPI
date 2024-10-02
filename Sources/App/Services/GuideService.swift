import Fluent
import Foundation
import Vapor

struct GuideService: ContentProtocol {
    typealias Answer = GuideModel
    typealias Request = Vapor.Request
    typealias CreateDTO = CreateGuideDTO
    typealias UpdateDTO = UpdateGuideDTO
    typealias Status = HTTPStatus
    typealias Model = GuideModel

    static func create(_ req: Request, createDTO: CreateDTO, author: UserModel) async throws -> Status
    {
        let fullAuthorName = "\(author.name) \(author.lastname)"
        let guide = GuideModel(
            id: UUID(),
            title: createDTO.title,
            slug: createDTO.title?.lowercased().replacingOccurrences(of: " ", with: "-"),
            tags: createDTO.tags,
            description: createDTO.description,
            status: createDTO.status,
            price: createDTO.price,
            headerImage: URL(string: createDTO.headerImage!),
            author: fullAuthorName,
            createdAt: Date(),
            updatedAt: Date(),
            publishedDate: createDTO.publishedDate
        )
        try await guide.save(on: req.db)
        return .created
    }

    static func get(_ req: Request, object: String) async throws -> Model {
        guard
            let guide = try await GuideModel.query(on: req.db)
            .filter(\.$slug == object)
            .first()
        else {
            throw Abort(.notFound, reason: "Guide not found")
        }
        return guide
    }

    static func getAll(_ req: Request) async throws -> [Model] {
        let guides = try await GuideModel.query(on: req.db).all()
        return guides
    }

    static func update(_ req: Request, object: String, updateDTO: UpdateDTO) async throws -> Model {
        guard
            let guide = try await GuideModel.query(on: req.db)
            .filter(\.$slug == object)
            .first()
        else {
            throw Abort(.notFound, reason: "Guide not found")
        }
        guide.title = updateDTO.title ?? guide.title
        guide.tags = updateDTO.tags ?? guide.tags
        guide.description = updateDTO.description ?? guide.description
        guide.status = updateDTO.status ?? guide.status
        guide.price = updateDTO.price ?? guide.price
        guide.headerImage = URL(string: updateDTO.headerImage!) ?? guide.headerImage
        guide.publishedDate = updateDTO.publishedDate ?? guide.publishedDate
        guide.updatedAt = Date()
        try await guide.save(on: req.db)
        return guide
    }

    static func delete(_ req: Request, object: String) async throws -> Status {
        guard
            let guide = try await GuideModel.query(on: req.db)
            .filter(\.$slug == object)
            .first()
        else {
            throw Abort(.notFound, reason: "Guide not found")
        }
        try await guide.delete(on: req.db)
        return .noContent
    }
}

extension GuideService: BackendContentFilterProtocol {
    static func getByStatus(_ req: Vapor.Request, status: StatusEnum.RawValue) async throws -> [GuideModel] {
        let guides = try await GuideModel.query(on: req.db)
            .filter(\.$status == status)
            .all()
        return guides
    }

    static func search(_ req: Vapor.Request, query: String) async throws -> [GuideModel] {
        let guides = try await GuideModel.query(on: req.db)
            .group(.or) { or in
                or.filter(\.$title == query)
            }.all()
        return guides
    }
}

extension GuideService: FrontendProtocol {
    static func getObject(_ req: Vapor.Request, object: String) async throws -> GuideContext {
        let user = req.auth.get(UserModel.self)
        guard
            let guide = try await GuideModel.query(on: req.db)
                .filter(\.$slug == object)
                .filter(\.$status == StatusEnum.published.rawValue)
                .first()
        else {
            throw Abort(.notFound)
        }
        
        let articles = try await ArticleModel.query(on: req.db)
            .filter(\.$guide == guide.id)
            .filter(\.$status == StatusEnum.published.rawValue)
            .all()
        return user?.role == RoleEum.student.rawValue ? GuideContext(guide: guide, articles: articles) : GuideContext(guide: guide, articles: nil)
    }
    
    static func getAllObjects(_ req: Vapor.Request) async throws -> [GuideModel] {
        let guides = try await GuideModel.query(on: req.db)
            .filter(\.$status == StatusEnum.published.rawValue)
            .all()
        return guides
    }
    
    typealias model = GuideModel
    
    typealias answer = GuideContext
    
    typealias status = HTTPStatus
    
    typealias request = Vapor.Request
    
    
    
}
