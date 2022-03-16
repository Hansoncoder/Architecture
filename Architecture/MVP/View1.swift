//
//  UserView1.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import UIKit

protocol UserViewData {
    var name: String { get }
    var age: String { get }
}

extension UserView1 {
    public func configInfo(_ user: UserViewData) {
        name.text = user.name
        age.text = user.age
        setNeedsLayout()
    }
}

class UserView1: UIView {
    private(set) lazy var getInfo = UIButton()
    private lazy var name = UILabel()
    private lazy var age = UILabel()

    private func setupUI() {
        addSubview(name)
        addSubview(age)
        addSubview(getInfo)

        setupAttributs()
    }

    private func setupAttributs() {
        name.text = "姓名：--"
        age.text = "年龄："

        getInfo.setTitle("获取用户信息", for: .normal)
        getInfo.setTitleColor(.black, for: .normal)
        getInfo.backgroundColor = .orange
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        name.sizeToFit()
        name.centerX = width * 0.5
        age.sizeToFit()
        age.left = name.left
        age.top = name.bottom + 10

        getInfo.size = CGSize(width: 200, height: 50)
        getInfo.centerX = name.centerX
        getInfo.top = age.bottom + 30
    }

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
