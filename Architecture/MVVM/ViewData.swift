//
//  ViewData2.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import Foundation

// 数据处理
struct ViewData2: UserViewData2 {
    let user: User
    var name: String { return "姓名：" + user.name }
    var age: String { return "年龄：\(user.age)" }
}
