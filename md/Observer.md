# Observer观察者

[观察者](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/observer.html)

```swift
tap.subscribe(onNext: { [weak self] in
    self?.showAlert()
}, onError: { error in
    print("发生错误： \(error.localizedDescription)")
}, onCompleted: {
    print("任务完成")
})
```

创建观察者最直接的方法就是在 Observable 的 subscribe 方法后面描述，事件发生时，需要如何做出响应。而观察者就是由后面的 onNext，onError，onCompleted的这些闭包构建出来的。

## AnyObserver

AnyObserver 可以用来描叙任意一种观察者。

## Binder

Binder 主要有以下两个特征：

* 不会处理错误事件
* 确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息。
```swift
let observer: Binder<Bool> = Binder(usernameValidOutlet) { (view, isHidden) in
    view.isHidden = isHidden
}

usernameValid
    .bind(to: observer)
    .disposed(by: disposeBag)
```
Binder 可以只处理 next 事件，并且保证响应 next 事件的代码一定会在给定 Scheduler 上执行，这里采用默认的 MainScheduler。