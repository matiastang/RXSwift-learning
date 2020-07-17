# Disposable - 可被清除的资源

[Disposable - 可被清除的资源](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/disposable.html)

## DisposeBag

```swift
var disposeBag = DisposeBag() // 来自父类 ViewController

override func viewDidLoad() {
    super.viewDidLoad()

    ...

    usernameValid
        .bind(to: passwordOutlet.rx.isEnabled)
        .disposed(by: disposeBag)

    usernameValid
        .bind(to: usernameValidOutlet.rx.isHidden)
        .disposed(by: disposeBag)

    passwordValid
        .bind(to: passwordValidOutlet.rx.isHidden)
        .disposed(by: disposeBag)

    everythingValid
        .bind(to: doSomethingOutlet.rx.isEnabled)
        .disposed(by: disposeBag)

    doSomethingOutlet.rx.tap
        .subscribe(onNext: { [weak self] in self?.showAlert() })
        .disposed(by: disposeBag)
}
```
disposeBag 和 ViewController 具有相同的生命周期。当退出页面时， ViewController 就被释放，disposeBag 也跟着被释放了，那么这里的 5 次绑定（订阅）也就被取消了。

## takeUntil

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    ...

    _ = usernameValid
        .takeUntil(self.rx.deallocated)
        .bind(to: passwordOutlet.rx.isEnabled)

    _ = usernameValid
        .takeUntil(self.rx.deallocated)
        .bind(to: usernameValidOutlet.rx.isHidden)

    _ = passwordValid
        .takeUntil(self.rx.deallocated)
        .bind(to: passwordValidOutlet.rx.isHidden)

    _ = everythingValid
        .takeUntil(self.rx.deallocated)
        .bind(to: doSomethingOutlet.rx.isEnabled)

    _ = doSomethingOutlet.rx.tap
        .takeUntil(self.rx.deallocated)
        .subscribe(onNext: { [weak self] in self?.showAlert() })
}
```
这将使得订阅一直持续到控制器的 dealloc 事件产生为止