//
//  Observable.swift
//  MT-RxSwiftLearning
//
//  Created by yunxi on 2020/7/17.
//  Copyright © 2020 matias. All rights reserved.
//

import Foundation
import RxSwift

/// 生成随机Int序列
/// - Parameter number: 序列长度
/// - Returns: 序列
func randomIntObservable(_ number: Int = 1) -> Observable<Int> {
    return Observable.create { (anyObserver) -> Disposable in
        if (number < 1) {
            anyObserver.onError(NSError.init(domain: "参数不能小于1", code: 001, userInfo: nil))
            anyObserver.onCompleted()
            return Disposables.create()
        }
        for _ in 0..<number {
            anyObserver.onNext(Int(arc4random_uniform(100) + 1))
        }
        anyObserver.onCompleted()
        return Disposables.create()
    }
}
