//
//  UserViewModel.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import UIKit

class UserViewModel {
    typealias Input = Observable<Void>
    typealias Output = Observable<UserViewData2>

    private var input: Input?
    private var output: Output?

    public func transfom(_ input: Input) -> Output {
        self.input = input
        output = Output(value: ViewData2(user: User(name: "", age: 0)))

        /// 1.处理业务逻辑
        input.subscrib(fireNow: false) { [weak self] _ in
            let age = Int(arc4random()) % 30
            let user = User(name: "张三", age: age)
            self?.output?.value = ViewData2(user: user)
        }

        /// 2.返回处理结果信号
        return output!
    }
}

// 数据处理，如果比较复杂，分文件
struct ViewData2: UserViewData2 {
    let user: User
    var name: String { return "姓名：" + user.name }
    var age: String { return "年龄：\(user.age)" }
}
