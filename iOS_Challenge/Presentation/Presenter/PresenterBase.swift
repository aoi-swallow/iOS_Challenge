//
//  PresenterBase.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

protocol Presenter {
    associatedtype ViewController
    init(_ viewController: ViewController)
}
