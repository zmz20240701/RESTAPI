//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/28.
//

import Foundation
import Fluent

extension UserModel {
    struct FieldKeys {
        static var name: FieldKey { "姓氏" }
        static var lastname: FieldKey { "名称" }
        static var username: FieldKey { "用户名" }
        static var password: FieldKey { "密码" }
        static var email: FieldKey { "邮箱" }
        static var city: FieldKey { "城市" }
        static var country: FieldKey { "国家" }
        static var address: FieldKey { "地址" }
        static var postalcode: FieldKey { "邮编" }
        static var role: FieldKey { "特权" }
        static var subscriptionIsActiveTill: FieldKey { "订阅有效期至" }
        static var myCourse: FieldKey { "我的课程" }
        static var bio: FieldKey { " 个人简介" }
        static var completedCourse: FieldKey { "已完成课程" }
        static var createdAt: FieldKey { "创建于" }
        static var updateAt: FieldKey { "更新于" }
        static var userImage: FieldKey { "用户图像" }
    }
}
