# MVP (kr)

- MVP를 사용하는 이유: 코드베이스를 테스트 가능하게 만들기 위해서
	- Clean Architecture에 따르면 우리는 비즈니스 논리와 뷰 논리 사이에 엄격한 경계를 만들어야한다.
	- 따라서 ViewController에 비즈니스 논리를 넣으면 좋지 않다.
- 이제 viewController는 view로만 간주된다.
	- 이것의 의미는 뷰와 관련된 코드만 포함된다는 이야기이다.
	- 로직과 관련된 코드는 모두 presenter에서 구현된다.
	
## View
- 모든 UI 설정과 이벤트와 연관된 것들의 코드를 작성 (GUI를 담당)
- UIView와 UIViewController로 구성된다.
- Button, UITextField, UITableView, UIImageView와 같은 뷰의 상태를 제어하는 부분이다.
- UIViewController의 라이프사이클을 관리하는 책임도 진다.
- 비즈니스 로직과 관련된 코드는 가능한 제거한다.

## Presenter
- 사용자의 행동에 응답하고 UI를 업데이트 하는 것을 포함하는 모든 논리를 담당 (via Delegate)
- View에 표현되기 위한 규칙을 담당할 수 있다.
- View에서 수행된 사용자의 동작에 반응, Model에서 Data를 검색하며, View에 표시할 수 있도록 형식을 지정
- 가장 중요한 것은 UIKit 디팬던시가 없다는 것 -> 따라서 쉽게 테스트 가능하다.

## Model
- 도메인 데이터를 담당하는 인터페이스입니다 (GUI에서 표시되거나, 다른 방식으로 작동 함).

### 장점
- MVP는 UIViewController를 멍청하고 수동적이며 덜 거대한 View 구성 요소의 일부로 만듭니다.
- 비즈니스 논리의 대부분은 캡슐화되어있어 우수한 테스트 가능성을 제공합니다.
- 모의 객체를 도입하여 도메인 부분을 테스트할 수 있습니다.
- 분리 된 엔티티는 책임은 명확하게 구분됩니다.


> MVP가 passive view pattern을 사용한다는 것은 중요하다.</br>
> 이것은 모든 액션이 presenter에게 전달된다는 것을 의미한다.</br>
> delegate를 사용하여 UI 업데이트를 트리거 하는 기능, 그래서 View는 오로지 presenter에게 이벤트를 넘기고, update를 듣는 행위를 할 것이다.