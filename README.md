# VIPER Sample

![the classic VIPER design pattern diagram](the-classic-VIPER-design-pattern-diagram.png)

## VIPER Component
- View
	- Class with code to display app interface to user and get response
- Interactor
	- Responsible for the business logic of the app (mainly responsible for API calls)
	- It is responsible for calling data, but it does not have to be implemented on its own.
	- In general, it's up to the Interactor to start working with the network, but it doesn't handle the networking code directly.
- Presenter
	- CORE
	- View gets your response and acts accordingly, communicating with all other components.
	- It is up to the Presenter to take the data returned by the Interactor and format it for present.
- Entity
	- The model class used by the interactor and the related Manager are never sent to the Presenter.
- Router (WireFrame)
	- Switch Screens, hear what screens are displayed and run from the presenter.
	- I own a UIWindow, UINavigationController, UIViewController, etc.
	- It is responsible for writing the view / view controller and installing it in the window.
- DataStore
	- Responsible for providing entities to the Interactor.
	- Manage the persistence of an entity.
	- DataManager is to facilitate the interaction between the datastore and the interactor
		- Helps the interactor focus more on the business logic.


## VIPER 구현의 프로토콜 설명
- ViewProtocol: Presenter를 통해 UI의 변경 사항을 View에 반영
- PresenterProtocol: View를 통해 획득 되는 반응을 처리 (& Binding rx에서는)
- InteractorInputProtocol: Presenter가 비즈니스 로직을 전달하는 것을 구현
- InteractorOutputProtocol: Interactor를 통해 변경된 결과를 다시 Presenter로 전달하는 것으로 구성
- RouterProtocol: View를 생성하고, 다른 뷰로 화면 전환 하는 것을 구현


## StoryBoard
- 스토리보드가 제공하는 모든 기능을 취하면서 VIPER의 모든 목표를 달성하기는 어렵다.
	- 타협하고자 하는 것: segue를 사용하지 않는 것
	- segue의 사용은 화면간의 분리는 물론 UI와 Application Logig간의 분리를 온전하게 유지하는 것을 매우 어렵게 한다는 것이다.

## Modules
- 보통 모듈이라 함은 기능으로 설명될 수 있다.
- 모듈간의 분리는 명확한 것이 좋다.
- 모듈에 대한 두가지 프로토콜의 정의
	- 모듈 Interface로 모듈이 수행할 수 있는 작업을 정의
	- 모듈이 무엇을 했는지 설명하는 Delegate
- 모듈에는 여러 화면에서 사용할 수 있는 entity, interactor 및 일반적인 응용프로그램 로직계층이 포함될 수 있다.
- 이점은 여러 폼팩터로 확장하기가 쉬워진다는 것이다. (mac, iPad, iPhone 등)


## Test
- Interactor는 어떤 UI와도 독립적인 순수 로직을 포함하고 있어 쉽게 테스트 할 수 있다. 
- Presenter는 디스플레이를 위한 데이터를 준비하는 논리를 포함하고 있으며 UIKit 위젯과는 독립적이다.
- 선호하는 방법은 인터랙터부터 시작하는 것이다. 
	- UI의 모든 것은 사용 사례의 요구에 부응하기 위해 존재합니다. 
	- 인터랙터의 API 드라이브를 테스트하기 위해 TDD를 사용하면 UI와 사용 사례 간의 관계를 더 잘 이해할 수 있습니다.
- Interactor를 먼저 개발하고, 그 다음 Presenter를 개발하면, 먼저 그 계층들을 중심으로 일련은 Test를 구현하고, 기초를 닦을 수 있을 것이다.
	- Test를 위해 UI와 상호작용할 필요가 없기 때문에 이러한 클래스에서 빠르게 반복할 수 있다.
	- 그 후에 뷰를 개발한다면, 작동되고 test된 논리와 Present layer를 갖고 시작하는것이 된다는 의미이다.

