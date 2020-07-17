# Observable可监听序列

[Observable可监听序列](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/observable.html)

## Observable继承体系

## Single

Single 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。

## Completable

Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。

## Maybe

Maybe 是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。

## Driver

Driver 是一个精心准备的特征序列。它主要是为了简化 UI 层的代码。不过如果你遇到的序列具有以下特征，你也可以使用它：

* 不会产生 error 事件
* 一定在 MainScheduler 监听（主线程监听）
* 共享附加作用
这些都是驱动 UI 的序列所具有的特征。

## Signal

Signal 和 Driver 相似，唯一的区别是，Driver 会对新观察者回放（重新发送）上一个元素，而 Signal 不会对新观察者回放上一个元素。

## ControlEvent

ControlEvent 专门用于描述 UI 控件所产生的事件，它具有以下特征：

不会产生 error 事件
一定在 MainScheduler 订阅（主线程订阅）
一定在 MainScheduler 监听（主线程监听）