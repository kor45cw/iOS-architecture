# RIBs

> Note: RIBs Library currently does not support swift 5.0 or higher.

- [Uber's cross-platform mobile architecture framework.](https://github.com/uber/RIBs)
- This framework is designed for mobile apps with a large number of engineers and nested states.

## Basic principles

- Facilitate collaboration between platforms
	- The complex part is similar for both iOS and Android after all.
	- Possible to develop with similar development pattern through RIB
	- Engineers can share a single architecture that is co-designed for functionality.

- Minimize Global state and decisions
    - Changes in the global state cause unpredictable behavior → Make sure the engineer is not aware of the impact of the change.
    - RIBs recommend encapsulating state within the well-separated deep hierarchy of individual RIBs to prevent global state issues.

- Testability and Isolation
    - Class should be easy to construct unit tests in isolation.
    - Each RIB class has its own responsibility.
    - The upper RIB logic is mostly separated from the lower RIB logic. → Make it easy to test RIB classes independently.

- Tooling for developer productivity
    - Adopting a non-trivial architecture pattern does not extend beyond small applications without powerful tooling.
    - RIBs are provided through the IDE around code generation, static analysis, and runtime integration.

- Open-Closed Principle (OCP)
    - Whenever possible, developers should be able to add new functionality without modifying existing code.

- Structured around Business logic
    - The business logic of the app should not need to reflect the structure of the UI.
    - The view hierarchy can be better to facilitate animation and show performance.
    - A single feature RIB can control the appearance of three views that appear in different locations on the UI.

- Explicit Contracts
    - Requirements should be declared with compile-time safe contracts
    - Classes should not be compiled unless class dependencies and order dependencies are met.
    - Representing Order dependencies using ReactiveX
    - Input a DI system representing class dependencies
    - Enter many DI ranges that encourage data invariant generation.


## Parts of a RIB

- If you've used VIPER before, class classification in the RIB may seem familiar.
- The RIB consists of the following elements, each of which is implemented as a class.

### Interactor
- Contains business logic
- Perform Rx subscriptions, make state change decisions, determine where to store data, and determine other RIBs to which children should be attached.
- All work should be confined to the lifecycle.
- We have built tooling so that the business logic runs only when the interactor is activated.
    - This prevents the interruptor from being deactivated but still running. (Which causes unwanted UI state or business logic updates)

### Router
- It listens for the interpreter and converts its output into a child RIB attached and detached.
- 3 reasons why routers exist
    - It acts as a Humble object. → To make testing complex interactor logic easier
    - Create an additional abstraction layer between the parent interactor and its child interactors. → It makes synchronous communication between interactors difficult and promotes the adoption of reactive communication instead of direct coupling between RIBs.
    - It contains simple and iterative routing logic that Interactor can implement. → Reducing these boilerplate codes allows for smaller, more focused focus on the core business logic provided by the RIB.


### Builder
- Responsible for instantiating the Builder for all RIB component hierarchies and for each child of each RIB.
- Separating the class generation logic from the builder adds support for iOS mockability and the rest of the RIB code becomes indifferent to the details of the DI implementation.
- The builder is the only part of the RIB that needs to be aware of the DI system used in the project.
- By implementing different builders, you can reuse the rest of the RIB code in your project using different DI mechanisms.


### Presenter
- Stateless classes that transform business models into view models, and vice versa.
- This translate is so trivial that it does not guarantee the creation of a dedicated presenter class.
- If there is no presenter, it is the responsibility of the view or interactor to transform the view model.


### View(Controller)
- Build and update UI
- Contains user interactions, data contained in UI components, and animations.
- Designed to be as "dumb" as possible.
- Just display information
- In general, It does not contain code that requires unit testing.

### Component
- Used to manage RIB dependencies
- Help Builder instantiate other units
- Provides access to the external dependencies required to build the RIB, owns the dependencies created by the RIB itself, and controls access to them from other RIBs
- The component of the parent RIB is usually injected into the builder of the child RIB to give the child access to the parent RIB's dependencies.

## State Management

- The application state is represented by the RIB connected to the RIB tree.
- The RIB makes state decisions only within its scope.
- Not all states can be saved by adding or removing RIBs.
    - Store these states in a stream of immutable models that emit back values when details change
    - Pass the interface to the DI graph that provides read access to these streams.
- RIB does not force one source for RIB state.
    - Within the context of each RIB, you can adopt patterns that facilitate one-way data flow, or allow business and view states to be temporarily distributed to take advantage of an efficient platform animation framework.


## Communication Between RIBs
- When the Interactor decides on business logic, it may be necessary to notify other RIBs and send data, such as completion.
    - The RIB does not contain a single method of transferring data between RIBs. However, it is made to facilitate some common patterns.
- In general, when communication is passed down to a child RIB
    - Emit this information through the Rx stream.
    - Alternatively, this data may be included as a parameter to the build() method of the child RIB. (In this case, that parameter is invariant during the child's life cycle.)
- If communication goes up the RIB tree to the parent RIB's selector
    - Since the parent can live longer than the child, communication occurs through the Listener interface.
    - Some objects in the parent RIB or DI graph implement the listener interface and place them in the DI graph for the child RIB to call.
    - Benefits: Prevents memory leaks and allows parents to write, test, and maintain without knowing which child is attached. Reduce the amount of ritual required to attach / remove child RIBs.

### Dependency & Component

- Dependency
    - A protocol that lists the denpendencies required for the RIB to instantiate correctly in the parent instance.
- Component
    - Implementation of dependency protocol
    - In addition to providing a parent dependency to the RIB builder, it must also have a dependency that the RIB creates for itself and its children.
- In general, when a parent RIB instantiates a child RIB, it injects its own component into the child's builder as a constructor dependency.

### RIBs Question

- Component?
    - Used to manage RIB dependencies
    - Support builders by instantiating other units that make up a RIB
    - Provide access to the external dependencies required to construct a RIB
    - Owns the dependencies created by the RIBs themselves, and controls access to them from other RIBs
    - The component of the parent RIB is usually injected into the builder of the child RIB and gives the child access to the parent RIB's dependencies.
- Why should I use a RIB?
    - MVC is also a possible option
        - However, there is a limitation that the business scope of the app must match the scope of the view.
        - Each scope is defined entirely by viewController
    - Using RIBs gives you two separate, independent scope hierachy.
    - The scope of the business logic can only be defined by the app logic scope.
    - The scope of the view can be defined based on the UI, animation, and ease of transition.
- How do I display content on the screen with the RIB?
    - Apps are driven by business logic encapsulated by RIB
    - Allows you to think about the state of your app instead of thinking about displaying some views.
    - When an app's state changes, its RIB drives and organizes the view hierarchy to change its UI.
- How does the Object Reference work with the RIB?
    - The router holds strong references to the selector and view if there is a UI element to display on the RIB
    - If there is a presenter, the interactor has a strong reference to the presenter.
    - If there is no presenter, the presentable protocol is confirmed directly by the controller. After that, the interactor has a strong reference to the view.
    - In order to propagate the ui event back to the interactor to avoid a retain cycle, the view has a weak reference to the interactor.
    - In order for the interactor to perform routing calls, the interactor has a weak reference to the router.
    - The builder does not reference it.