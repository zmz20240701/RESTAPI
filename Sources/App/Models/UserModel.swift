//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/28.
//

import Fluent
import Foundation
import Vapor

final class UserModel: Model, @unchecked Sendable {
    static var schema: String {
        SchemaEnum.users.rawValue
    }

    @ID(key: .id)
    var id: UUID?

    @OptionalField(key: FieldKeys.name) // 可选字段
    var name: String?

    @OptionalField(key: FieldKeys.lastname)
    var lastname: String?

    @OptionalField(key: FieldKeys.username)
    var username: String?

    @Field(key: FieldKeys.password)
    var password: String?

    @Field(key: FieldKeys.email)
    var email: String

    @OptionalField(key: FieldKeys.city)
    var city: String?

    @OptionalField(key: FieldKeys.country)
    var country: String?

    @OptionalField(key: FieldKeys.address)
    var address: String?

    @OptionalField(key: FieldKeys.postalcode)
    var postalcode: String?

    @Field(key: FieldKeys.role)
    var role: RoleEum.RawValue

    @OptionalField(key: FieldKeys.subscriptionIsActiveTill)
    var subscriptionIsActiveTill: Date?

    @OptionalField(key: FieldKeys.myCourse)
    var myCourse: [UUID]?

    @OptionalField(key: FieldKeys.completedCourse)
    var completedCourse: [UUID]?

    @OptionalField(key: FieldKeys.bio)
    var bio: String?

    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createAt: Date?

    @Timestamp(key: FieldKeys.updateAt, on: .update)
    var updateAt: Date?
    @OptionalField(key: FieldKeys.username)
    var userImage: URL?
    init() {}

    init(username: String?, email: String, password: String, role: RoleEum.RawValue, createAt: Date?, updateAt: Date?) {
        self.username = username
        self.email = email
        self.password = password
        self.role = role
        self.createAt = createAt
        self.updateAt = updateAt
    }

    init(id: UUID? = nil, name: String? = nil, lastname: String? = nil, username: String? = nil, password: String? = nil, email: String, city: String? = nil, country: String? = nil, address: String? = nil, postalcode: String? = nil, role: RoleEum.RawValue, subscriptionIsActiveTill: Date? = nil, myCourse: [UUID]? = nil, completedCourse: [UUID]? = nil, bio: String? = nil, createAt: Date? = nil, updateAt: Date? = nil) {
        self.name = name
        self.lastname = lastname
        self.username = username
        self.password = password
        self.email = email
        self.city = city
        self.country = country
        self.address = address
        self.postalcode = postalcode
        self.bio = bio
        self.createAt = createAt
        self.updateAt = updateAt
    }

    init(subscriptionIsActiveTill: Date?) {
        self.subscriptionIsActiveTill = subscriptionIsActiveTill
    }

    init(myCourse: [UUID]?) {
        self.myCourse = myCourse
    }

    init(completedCourse: [UUID]?) {
        self.completedCourse = completedCourse
    }

    init(userImage: URL?) {
        self.userImage = userImage
    }
}

extension UserModel: Content {
}

// 多个构造函数为 UserModel 提供了极大的灵活性, 以适应不同场景下的对象创建需求
// 你可以根据不同的场景传递不同的数量的参数, 从而避免不必要的数据
