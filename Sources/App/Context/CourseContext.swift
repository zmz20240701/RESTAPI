//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/10/1.
//

import Foundation
import Fluent
import Vapor


/// 将课程信息和会话信息组合在一起返回给前端, 这种设计是为了方便数据传输
/// 作为响应体的一部分, 当 CourseContext 被返回时, Vapor框架会将其自动编码为JSON, 客户端
/// 收到的数据是JSON格式
struct CourseContext: Content {
    let course: CourseModel
    let sessions: [SessionModel]?
}
