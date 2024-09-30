//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/28.
//

import Fluent
import Foundation
import Vapor

extension SessionModel {
  struct FieldKeys {
    static var title: FieldKey { "标题" }
    static var mp4URL: FieldKey { "MP4 链接" }
    static var hlsURL: FieldKey { "hls 链接" }
    static var createdAt: FieldKey { "创建于" }
    static var updatedAt: FieldKey { "更新于" }
    static var publishedAt: FieldKey { "发表于" }
    static var status: FieldKey { "状态" }
    static var price: FieldKey { "价格" }
    static var article: FieldKey { "文章" }
    static var course: FieldKey { "课程" }
    static var slug: FieldKey { "slug" }
  }
}
