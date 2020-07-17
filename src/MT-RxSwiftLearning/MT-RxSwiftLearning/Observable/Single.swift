//
//  Single.swift
//  MT-RxSwiftLearning
//
//  Created by yunxi on 2020/7/17.
//  Copyright © 2020 matias. All rights reserved.
//

import Foundation
import RxSwift

extension Int {
    
    var odd: Single<Bool> {
        get {
            self.isOdd()
        }
    }
    
    /// 是否为奇数
    /// - Returns: <#description#>
    func isOdd() -> Single<Bool> {
        return Single.create { single in
            single(.success((self & 1) != 0)) as! Disposable
        }
    }
    
    var even: Single<Bool> {
        get {
            self.isEven()
        }
    }
    
    /// 是否为偶数
    /// - Returns: <#description#>
    func isEven() -> Single<Bool> {
        return Single.create { single in
            single(.success((self & 1) == 0)) as! Disposable
        }
    }
}
