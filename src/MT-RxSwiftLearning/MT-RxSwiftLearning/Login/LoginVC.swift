//
//  LoginVC.swift
//  MT-RxSwiftLearning
//
//  Created by yunxi on 2020/7/17.
//  Copyright © 2020 matias. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let minUserNameLength = 5
fileprivate let minPasswordLength = 6

/// RxSwift登录
final class LoginVC: UIViewController {
    
    /// 账号
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameValidLabel: UILabel!
    
    /// 密码
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidLabel: UILabel!
    
    /// 登录
    @IBOutlet weak var loginButton: UIButton!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 用户名是否有效
        let usernameValid = userNameTextField.rx.text.orEmpty
            // 用户名 -> 用户名是否有效
            .map { $0.count >= minUserNameLength }
            .share(replay: 1)
        
        // 密码是否有效
        let passwordValid = passwordTextField.rx.text.orEmpty
            // 密码 -> 密码是否有效
            .map { $0.count >= minPasswordLength }
            .share(replay: 1)
        
        // 所有输入是否有效
        let everythingValid = Observable.combineLatest(
              usernameValid,
              passwordValid
            ) { $0 && $1 } // 取用户名和密码同时有效
            .share(replay: 1)
        
        // 用户名是否有效 -> 密码输入框是否可用
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        // 用户名是否有效 -> 用户名提示语是否隐藏
        usernameValid
            .bind(to: userNameValidLabel.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        // 密码是否有效 -> 密码提示语是否隐藏
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        // 所有输入是否有效 -> 绿色按钮是否可点击
        everythingValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        // 点击绿色按钮 -> 弹出提示框
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.loginAlert() })
            .disposed(by: self.disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginVC {
    
    private func loginAlert() {
        
        let alertController = UIAlertController.init(title: "提示", message: "登录成功", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
