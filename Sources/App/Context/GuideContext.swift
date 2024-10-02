//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/10/1.
//

import Foundation
import Fluent
import Vapor

struct GuideContext: Content {
    let guide: GuideModel
    let articles: [ArticleModel]?
}
