# RIBs

> 주의사항: RIBs Library는 현재 swift5.0 이상을 제대로 지원하고 있지 않습니다.

- [Uber에서 만든 크로스플랫폼 아키텍쳐](https://github.com/uber/RIBs)
- 많은 nested state를 갖는 큰 모바일 어플리케이션을 위해 디자인 되었음

## 기본 원칙

- 플랫폼 간에 협업 촉진
    - 복잡한 부분은 결국 iOS, Android 둘 다 비슷
    - RIB를 통해 유사한 개발 패턴으로 개발 가능
    - 엔지니어들은 기능을 위해 공동 설계된 단일 아키텍쳐를 공유할 수 있다.
- Minimize Global state and decisions
    - Global state의 변경은 예측할 수 없는 행동을 유발한다. → 엔지니어가 변경의 영향을 제대로 알 수 없게 한다.
    - RIBs는 잘 격리된 개별 RIB의 deep hierarchy 내에서 상태를 캡슐화 하여 Global state 문제를 방지하도록 권장한다.
- Testability and Isolation
    - class는 격리된 상태에서 unit test를 구성하기 쉬워야 한다.
    - 개별 RIB 클래스는 고유한 책임을 갖는다.
    - 상위 RIB 논리는 대부분 하위 RIB 논리와 분리된다. → RIB 클래스를 독립적으로 테스트하기 쉽게 만든다.
- Tooling for 개발자 생산성
    - non-trivial 아키텍쳐 패턴을 채택하는 것은 강력한 tooling없이 소규모 어플리케이션 이상으로 확장되지 않는다.
    - RIB는 코드 생성, 정적 분석, 런타임 통합을 중심으로 IDE를 통해 제공된다.
- Open-Closed Principle (OCP)
    - 개발자는 가능할 때마다 기존 코드를 수정하지 않고도 새로운 기능을 추가할 수 있어야 한다.
- Structured around Business logic
    - 앱의 비즈니스 논리는 UI의 구조를 반영할 필요가 없어야 한다.
    - 애니메이션을 용이하게 하고 성능을 보이기 위해 뷰 계층이 더 나을 수 있다.
    - 단일 feature RIB은 UI의 서로 다른 위치에 나타나는 세 개의 보기의 모양을 제어 할 수 있다.
- Explicit Contracts
    - Requirements should be declared with compile-time safe contracts
    - 클래스는 클래스 종속성과 순서 종속성이 충족되지 않는 경우 컴파일하지 않아야 한다.
    - ReactiveX를 사용하여 Order 의존성을 나타냄
    - 클래스 의존성을 나타내는 DI 시스템을 입력하고
    - 데이터 불변성 생성을 권장하는 많은 DI 범위를 입력하라

## Parts of a RIB

- VIPER를 사용해본적이 있다면, RIB의 클래스 분류는 익숙해 보일 것이다.
- RIB는 다음과 같은 요소로 구성되며, 각 요소는 class로 구현된다.

### Interactor

- 비즈니스 로직을 담고 있다.
- Rx 구독을 수행하고, 상태 변경 결정을 내리고, 데이터를 저장할 위치를 정하고, children을 붙여야 할 다른 RIB을 결정한다.
- 모든 작업은 라이프사이클에 국한되어야 한다.
- 비즈니스 로직이 인터렉터가 활성화 될때만 실행되도록 tooling을 구축하였다.
    - 이것은 인터렉터가 비활성화 되었지만, 구독은 여전히 실행되는 상황을 막는다. (원치 않는 UI 상태 또는 비즈니스 로직의 업데이트를 유발하는)

### Router

- 인터렉터의 말을 듣고 그 output을 child RIB을 붙이고, 분리하는 것으로 변환하는 역할
- 라우터의 존재 이유 (3가지)
    - Humble 객체의 역할을 한다. → 복잡한 interactor 로직을 더 쉽게 시험할 수 있도록
    - 부모 interactor와 그 자식 interactor 사이에 추가 추상화 계층을 만든다. → interactor간 동기 통신을 어렵게 반들고 RIB 간의 직접 결합 대신 reactive 통신의 채택을 촉진
    - Interactor가 구현할 수 있는 단순하고 반복적인 routing logic을 포함한다. → 이러한 보일러 플레이트 코드를 줄이면 인터렉터가 더 작고 RIB가 제공하는 핵심 비즈니스 논리에 더 초점을 맞출 수 있다.

### Builder

- 모든 RIB 구성 계층과 각 RIB의 자녀에 대한 Builder를 인스턴스화 하는 책임을 갖는다.
- 빌더에서 클래스 생성 로직을 분리하는 것은 iOS mockability에 대한 지원이 추가된다 그리고 나머지 RIB 코드는 DI 구현의 세부사항에 무관심해진다.
- 빌더는 프로젝트에서 사용되는 DI 시스템을 인식해야 하는 유일한 RIB 부분이다.
- 다른 빌더를 구현함으로써, 다른 DI 매커니즘을 사용하여 프로젝트에서 나머지 RIB 코드를 재사용할 수 있다.

### Presenter

- 비즈니스 모델을 뷰 모델로 변환하는 상태 비저장 클래스, 반대의 경우도 있다.
- 이러한 translate는 너무 사소한 것이어서 전용 presenter 클래스의 생성을 보장하지 않는다.
- presenter가 없는 경우, 뷰모델을 변환하는 것은 view or interactor의 책임이 된다.

### View(Controller)

- Build and update UI
- 사용자 상호작용, UI 컴포넌트에 포함되는 데이터, 에니메이션등을 포함한다.
- 가능한 "dumb"하게 되도록 설계된다.
- 그저 정보를 표시한다.
- 일반적으로, unit test가 필요한 코드를 포함하지 않는다.

### Component

- RIB 디펜던시를 관리하는 데 사용
- Builder가 다른 단위들을 instance화 하는 것을 돕는다.
- RIB을 구축하는데 필요한 외부 종속성에 대한 접근권을 제공하며, RIB 자체에 의해 생성된 종속성을 소유하고 다른 RIB으로 부터 그것들에 대한 접근을 제어
- 부모 RIB의 구성요소는 대게 자식 RIB의 Builder에 주입되어 자식에게 부모 RIB의 종속성에 대한 접근권한을 부여한다.

## State Management

- Application state는 RIB 트리에 연결된 RIB으로 표시된다.
- RIB은 자신의 scope 안에서만 state decision을 내린다.
- 모든 상태를 RIB의 추가 또는 제거에 의해 저장할 수 있는 것은 아니다.
    - 세부 정보가 변경될 때 값을 다시 방출하는 불변 모델의 스트림 안에 이러한 상태를 저장
    - 이러한 스트림에 대한 읽기 엑세스를 제공하는 인터페이스를 DI graph로 전달한다.
- RIB에서는 RIB 상태를 위해 하나의 소스를 강요하는 것이 없다.
    - 각 RIB의 context 내에서 단방향 데이터 흐름을 촉진하는 패턴을 채택하거나, 효율적인 플랫폼 애니메이션 프레임워크를 활용하기 위해 비즈니스 상태와 뷰 상태가 일시적으로 분산되도록 허용할 수 있다.

## Communication Between RIBs

- Interactor가 비즈니스 로직을 결정할 때, 완료와 같은 이벤트를 다른 RIB에 알리고 데이터를 전송해야 할 수 있다.
    - RIB은 RIB간에 데이터를 전달하는 단일 방법을 포함하고 있지않다. 하지만, 몇 가지 일반적인 패턴을 용이하게 하기 위해 만들어졌다.
- 일반적으로, 통신이 child RIB으로 하향되는 경우
    - 이 정보를 Rx stream을 통해 방출한다.
    - 또는 이 데이터는 child RIB의 build() 메소드에 대한 매개변수로 포함 될 수도 있다. (이 경우, 그 파라미터는 child의 생명주기동안 불변한다)
- 통신이 parent RIB의 인터렉터로 RIB트리를 올라가는 경우
    - 부모가 자식보다 오래 살 수 있기 때문에 Listener interface를 통해 통신이 이루어진다.
    - 상위 RIB 또는 DI graph의 일부 객체는 listener interface를 구현하고 자식 RIB이 호출 할 수 있도록 DI 그래프에 배치한다.
    - 이점: memory의 leak을 방지하고, 어떤 child가 붙어 있는지 모르게 부모를 쓰고, 시험하고, 유지할 수 있게 한다. child RIB을 부착/삭제 하는데 필요한 의식의 양을 줄인다.

### Dependency & Component

- Dependency
    - RIB이 부모 인스턴스에서 올바르게 인스턴스화 하는 데 필요한 denpendencies를 나열하는 프로토콜
- Component
    - Dependency protocol의 구현체
    - RIB 빌더에 상위 dependency를 제공하는 것 외에도 RIB이 자체 및 하위에 대해 작성하는 dependency를 소유해야 한다.
- 일반적으로, 부모 RIB은 자식 RIB을 인스턴스화 할 때 자체 component를 생성자 종속성으로 자식의 빌더에 주입

### RIBs Question

- Component?
    - RIB 종속성을 관리하는 데 사용
    - 립을 구성하는 다른 유닛을 인스턴스화 하여 빌더를 지원
    - 립을 구성하는데 필요한 외부 종속성에 대한 접근을 제공
    - 립 자체에 의해 생성된 종속성을 소유하고, 다른 립에서 이들에 관한 접근을 제어
    - 부모 립의 구성요소는 일반적으로 자식 립의 빌더에 주입되며 자식에게 부모 립의 종속성에 대한 접근권한을 부여
- 왜 RIB을 써야하는가?
    - MVC도 가능한 선택지다
        - 하지만 앱의 비즈니스 scope가 view의 스코프와 일치해야한다는 제한점이 있음
        - 각 scope는 전적으로 viewController에 의해 정의
    - 립을 사용하면 두개의 개별적이고, 독립적인 scope hierachy를 갖게 된다.
    - 비즈니스 로직의 scope는 오로직 app logic scope에 의해 정의될 수 있다.
    - 뷰의 scope는 UI, animation, transition의 용이성 등을 기반으로 정의될 수 있다.
- RIB으로 화면에 내용을 표시하는 방법은?
    - 앱은 RIB에 의해 캡슐화된 비즈니스 로직에 의해 구동
    - 어떤 뷰를 표시하는 것을 생각하는 대신 앱의 상태를 생각하게 해준다.
    - 앱의 상태가 변경되면, 해당 RIB이 UI를 변경하기 위해 뷰 계층구조를 구동하고 조직
- Object Reference는 RIB에서 어떻게 작동?
    - 라우터는 립에 표시할 UI요소가 있는 경우, 인터렉터 및 뷰에 대한 강한 참조를 보유
    - presenter가 있는 경우, interactor는 presenter에 대한 강한 참조를 갖는다.
    - presenter가 없는 경우, presentable 프로토콜은 controller에 의해 직접 confirm 된다. 그 후, interactor는 view에 대한 강한 참조를 갖는다.
    - Retain Cycle을 피하기 위해 ui event를 interactor로 다시 전파하기 위해서 view는 interactor를 약한 참조를 한다.
    - interactor가 routing 호출을 수행하도록 하기 위해 interactor는 router를 약한 참조 한다.
    - builder는 참조를 하지않는다.