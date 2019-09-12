# iOS Architecture Blueprints

The iOS framework provides a lot of flexibility in deciding how to organize and <em>architect</em> an iOS app. While this freedom is very valuable, it can also lead to apps with large classes, inconsistent naming schemes, as well as mismatching or missing architectures. These types of issues can make testing, maintaining and extending your apps difficult.

The iOS Architecture Blueprints project demonstrates strategies to help solve or avoid these common problems. This project implements the same app using different architectural concepts and tools.

You can use the samples in this project as a learning reference, or as a starting point for creating your own apps. The focus of this project is on demonstrating how to structure your code, design your architecture, and the eventual impact of adopting these patterns on testing and maintaining your app. You can use the techniques demonstrated here in many different ways to build apps. Your own particular priorities will impact how you implement the concepts in these projects, so you should not consider these samples to be canonical examples. To ensure the focus is kept on the aims described above, the app uses a simple UI.

## Explore the samples

This project hosts each sample app in separate repository branches. For more information, see the `README.md` file in each branch.

### Stable samples - Swift
| Sample | Description |
| ------------- | ------------- |
| [MVP](https://github.com/kor45cw/ios-architecture/tree/mvp/) | Demonstrates a basic [Model‑View‑Presenter](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) (MVP) architecture and provides a foundation on which the other samples are built. This sample also acts as a reference point for comparing and contrasting the other samples in this project. |
| [VIPER](https://github.com/kor45cw/ios-architecture/tree/viper/) | VIPER is an application of [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) to iOS apps. [Objc.io Article](https://www.objc.io/issues/13-architecture/viper/). |
| [RIBs](https://github.com/kor45cw/ios-architecture/tree/RIBs/) | RIBs is Uber's cross-platform mobile architecture framework. [Uber's RIBs Git Repo](https://github.com/uber/RIBs). |


## Choose a sample for your app

Each sample includes a dedicated `README.md` file where you can find related metrics, as well as subjective assessments and observations by contributors. The following factors are worth considering when selecting a particular sample for your app:

* The size of the app you are developing
* The size and experience of your team
* The amount of maintenance that you are expecting to have to do
* Your preference for the compactness of your codebase


## Open a sample in Xcode

To open one of the samples in Xcode, begin by checking out one of the sample branches, and then open the `sample/` directory in Xcode.

**Note:** The master branch does not compile.

Clone the repository:

```
git clone git@github.com:kor45cw/ios-architecture.git
```

Checkout the todo-mvp sample:
```
git checkout mvp 
```

Pod install:
```
cd sample
pod install
```

**Note:** To review a different sample, replace `mvp` with the name of sample you want to check out.

Finally open the `sample/` directory in Xcode

# License

Copyright 2019 kor45cw. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
