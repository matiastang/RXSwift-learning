# Schedulers - 调度器

[Schedulers - 调度器](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/schedulers.html)

Schedulers 是 Rx 实现多线程的核心模块，它主要用于控制任务在哪个线程或队列运行。

如果你曾经使用过 GCD， 那你对以下代码应该不会陌生：
```Swift
// 后台取得数据，主线程处理结果
DispatchQueue.global(qos: .userInitiated).async {
    let data = try? Data(contentsOf: url)
    DispatchQueue.main.async {
        self.data = data
    }
}
```
如果用 RxSwift 来实现，大致是这样的：
```Swift
let rxData: Observable<Data> = ...

rxData
    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { [weak self] data in
        self?.data = data
    })
    .disposed(by: disposeBag)
```

## subscribeOn
我们用 subscribeOn 来决定数据序列的构建函数在哪个 Scheduler 上运行。以上例子中，由于获取 Data 需要花很长的时间，所以用 subscribeOn 切换到 后台 Scheduler 来获取 Data。这样可以避免主线程被阻塞。

## observeOn
我们用 observeOn 来决定在哪个 Scheduler 监听这个数据序列。以上例子中，通过使用 observeOn 方法切换到主线程来监听并且处理结果。

一个比较典型的例子就是，在后台发起网络请求，然后解析数据，最后在主线程刷新页面。你就可以先用 subscribeOn 切到后台去发送请求并解析数据，最后用 observeOn 切换到主线程更新页面。