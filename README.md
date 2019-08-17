# MVP

- Reasons to use MVP: To make your codebase testable
	- According to the Clean Architecture, we must create strict boundaries between business logic and view logic.
	- So it's not a good idea to put business logic in the ViewController.
- The viewController is now considered a view only.
	- This means that only the code associated with the view is included.
	- All the code related to the logic is implemented in the presenter.
	
## View
- Write code for all UI settings and events and related things (GUI)
- Consists of UIView and UIViewController.
- This part controls the state of the view such as Button, UITextField, UITableView, UIImageView.
- It is also responsible for managing the lifecycle of the UIViewController.
- Eliminate code related to business logic where possible.

## Presenter
- Responsible for all logic, including responding to user actions and updating the UI (via Delegate)
- Can handle the rules to be displayed in the view.
- Responds to the user's actions performed in the view, retrieves data from the model, and specifies the format to display in the view
- The most important thing is that there is no UIKit dependency-> so it's easy to test.

## Model
- Interface responsible for domain data (visible in GUI)

### Advantages
- MVP makes UIViewController a part of dumb, passive and less huge View components.
- Most of the business logic is encapsulated, providing excellent testability.
- You can test the domain part by introducing mock objects.
- Detached entities have responsibilities clearly separated.


> It is important that MVP uses a passive view pattern. </br>
> This means that all actions are passed to the presenter. </br>
> The ability to trigger UI updates using delegates, so View will only pass events to the presenter and listen for updates.
