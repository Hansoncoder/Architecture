//
//  Presenter.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import Foundation

// 刷新数据接口协议
protocol Userview1Protoco: AnyObject {
    func refreshData(_ data: UserViewData)
}

// 数据处理
struct ViewData: UserViewData {
    let user: User
    var name: String { return "姓名：" + user.name }
    var age: String { return "年龄：\(user.age)" }
}

/// Presenter:
/// 1.负责处理业务逻辑
/// 2.负责将处理好的数据，调用刷新UI的协议
class UserView1Presenter {
    private weak var delegate: Userview1Protoco?
    init(delegate: Userview1Protoco) {
        self.delegate = delegate
    }
    
    // 1.提供 UI 处理能力， 处理业务逻辑
    public func getUserInfo() {
        let user = User(name: "李四", age: Int(arc4random()) % 30)
        
        // 2. 拿到数据，处理将数据，调用刷新协议
        delegate?.refreshData(ViewData(user: user))
    }
}
