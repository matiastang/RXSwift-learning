# RXSwift安装

[cocoaPads 安装及使用](https://github.com/matiastang/cocoaPads)
[RxSwift cocoaPads安装](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/)

1. 搜索查看版本：
```
pod search RxSwift
```

2. 编写Podfile文件：
```
# Podfile

# 指定源(换源后需要指定到更换的源)
# source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

# 指定最低版本
platform :ios, '13.6'

use_frameworks!

target 'MT-RxSwiftLearning' do
    pod 'RxSwift'
    pod 'RxCocoa'
end

# RxTests 和 RxBlocking 将在单元/集成测试中起到重要作用
target 'MT-RxSwiftLearningTests' do
    pod 'RxBlocking'
    pod 'RxTest'
end
```
3. 安装：
```
pod install
```
4. 项目根目录下找到`.xcworkspace`打开