//
//  UserViewModel.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import UIKit

// VM 方便了单元测试
class UserViewModel {
    typealias Input = Observable<Void>
    typealias Output = Observable<UserViewData2>
    
    private(set) var input: Input?
    public var output: Output?
    
    public func transfom(_ input: Input) -> Output {
        self.input = input
        self.output = Output(value: ViewData2(user: User(name: "", age: 0)))
        
        /// 1.处理业务逻辑
        input.subscrib(fireNow: false) {[weak self] _ in
            let user = User(name: "张三", age: Int(arc4random()) % 30)
            self?.output?.value = ViewData2(user: user)
        }
        
        /// 2.返回处理结果信号
        return output!
    }
}
