//
//  File.swift
//  RESTAPI
//
//  Created by 赵康 on 2024/9/28.
//

import Foundation;
import Fluent;
import Vapor;

extension ArticleModel {
    struct FieldKeys {
        static var title: FieldKey { "标题" };
        static var slug: FieldKey { "slug" };
        
        static var excerpt: FieldKey { "摘要" };
        static var content: FieldKey { "内容" };
        static var guide: FieldKey { "指导" };
        static var headerImage: FieldKey { "头图" };
        static var author: FieldKey { "作者" };
        static var status: FieldKey { "状态" };
        static var price: FieldKey { "价格" };
        static var role: FieldKey { "特权" };
        static var createdAt: FieldKey { "创建于" };
        static var updatedAt: FieldKey { "更新于" };
        static var publishedDate: FieldKey { "发表于" };
        static var tags: FieldKey { "标签" };
    };
};
