# LPOO_5G43 - Craft Miner 


Craft Miner is a multi-level arena game based on Minecraft. The goal of Craft Miner is to complete all levels. The player have the oportunity to access the next level by mining collectibles while trying to avoid monsters that appear in his path.

This project was developed for LPOO (Object Oriented Programming Laboratory) course in the Integrated Master in Computer Engineering degree in FEUP in the year of 2020⁄21. This course has a special focus on SOLID's topics and quality solutions in the OOP paradigm. The game was developed using Java and it's library Lanterna for supporting a GUI interface. This project was made by José Guerra (up201706421@fe.up.pt) and Rúben Almeida (up201704618@fe.up.pt)


## Index

1. [Explanation](#Explanation)
2. [Implemented Features](#Implemented-Features)
3. [Planned Features](#Planned-Features)
4. [Design](#Design)
5. [Known Code Smells and Refactoring Suggestions](#Know-code-smmells-and-refactoring-suggestions)
6. [Testing](#Testing)
7. [Self-Evaluation](#Self-evaluation)

### Explanation
**Hero (main character)**

The hero of this game will be a smiley face , he will be able to move up, down, left and right and will have a range weapon at his disposal, a sort of fireball cannon, that shoots fireballs. This weapon has regenarative capabilites, regenerating 1 fireball in 2 seconds and is capable of holding a maximum of 10 fireballs at any time. This hero will have a maximum of 4 lifes. The hero will loose a life if he gets attacked by a enemy but fear not there will be heart shaped symbol in a level that the hero can collect to increase his life counter.

* Graphical Representation: ☺


**Enemies**

Zombie - The zombie is the most commom enemy in the game and the simplest, if the hero gets close to him and stay near him, he looses one life for each second passed.

* Graphical Representation: ⚉

Archer - The creeper will be a easy to kill enemy. Although its low resistance to the hero firepower, in order to shoot him, we become in range with his attack abilities. Managing it's reloading time will be the solution for the player.

* Graphical Representation: A


Beamer - This enemy is probably the most dangerous in the game. The beamer will shoot a straigth beam of light in the direction he is moving, this beam of light will have a length of 4 squares. If the hero comes in contact with this beam of light, he will loose 2 lifes instatly and 2 more for every 2 seconds in contact with him.

* Graphical Representation: ⚉

**Levels**

Each level will be a maze surround with walls and enemys, to advance to the next level besides reaching a set score, the hero must also reach the exit of said maze.


### Implemented Features


* Hero - The player controlable character is already implemented. It is represented in the GUI by a smile face.
* Pickaxe - When an hero is near of a minable object, the pickaxe is rendered. The the pickaxe is avaiable, the player can hit the correct key and mine the block.
* Multi-Level-After collecting a certain ammout of score, the level doors open and the hero has the ability to proceeed it's journey to the next level.
* Key Processing - The hero is already responding to commands. 
* Playing State Header Interface - The GUI for display the in game information is already defined
* Mining - The hero can mine a block by getting close to it when he has a pickaxe
* Zombie Monster - The primary enemy type of the game is designed. It follow the player while in range reducing it life if close enough from hero
* Life Restoring - The hero can collect life points in the map to face the attack effects from enemies
* Reading Levels From Files - The game levels are constructed from a file .txt
* Hero Attacks. Firebals - The elementary attack of the hero toward enemy elimination is defined with throwable firebals
* Starting, High score, Winning and Gameover Menus- We implemented a simple, functional interface.
* Limited Hero sight range - The hero cannot see elements that are farther than 5 screen unit.
* Hidden Surround Elements - The hero cannot see collectible and enemies that are surroended. Expect suprises while you mine.
* Pickaxe Resistance boost - Killing enemies restores you pickaxe boost.
* Impossible game - Every Time you run out of pickaxe, if there are any more enemies to restore your pickaxe, you lose the game. Use it wisely.

### Partially implemented Features

* Squared Font Design - This feature can be found in fontFix branch. It's implementation was abandoned since we didn't found all icons that we use in our game to represent elements in any font library. 

### Planned Features

* Change collision's implementation in order to achieve greater flexibility
* Creeper Enemy type - A explosive enemy


### Design

#### Enemy Behaviour Defined as Strategy

##### Problem in Context

In every game iteration it is necessary to test the possibility of the hero being attacked by an enemy in the map.
Every enemy has it's specific attacking behaviour, completly different from their pears. The goal is to enforce the SRP SOLID principle while dealing the enemies.

#### The Pattern

The solution found to this problem was to follow the strategy design pattern. Each enemy has is own strategy that defines the way he should behaves while attacking and when he should do it. Furthermore, keeps the code simple with every enemy isolated from each other

#### Implementation
The UML representation of the adaptation of the pattern to the context of the problem is the following:


![](https://i.imgur.com/SC7Veu7.png)


The classes that are involved in this implementation are the following:
 * [PlayModel](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/menu/PlayModel.java)
 * [Enemy](#https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/elements/movable/enemies/Enemy.java)
 * [EnemyStrategy](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/enemies/EnemyStrategy.java)
 * [ArcherStrategy](#https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/enemies/ArcherStrategy.java)
 * [ZombieStrategy](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/enemies/ZombieStrategy.java)
 * [BeamerStrategy](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/enemies/BeamerStrategy.java)

#### Consequences

With this implementation it is possible to:

* Isolate the distinct and independent behaviour of each enemy
* The implementation of the control of a certain type of enemy becomes abstracted to the application layer above.
* In the POV of application the only need to execute the attacking action of every enemy becomes calling a shared method attack defined in the interace required by  

#### Collision Detection Abstracted as a Strategy Pattern

##### Problem in Context

This problem wasn't, actually, a thing, before implemented the last enemy, the Beamer. Until Beamer, every collision in the game was almost made the same way. 

1. We simulate a movement by generate the destination position
2. We test that position it's equals to every other element position
3. If not we set the position.

Beamer is an element with two parts, the body, and it's variable size rod. Testing a collision with it, requires testing this two parts. Which means it's a different way of testing from all elements considered until that moment. Different elements, may, this is important, may, because many of them share the same "equal position" methodology, require different collision testing, different strategies.

Since we needed to implement this pattern we took the oportunity to move the functionalities associated with the filtering of the elements to test collision to the collision strategy class. This methods have the responsibility to decided for each element what part of the model should be tested, per example, while testing the hero class we don't want to test collision with the hearts across the map, but we dont want enemies to take those hearts for them.


#### The Pattern

Since elements may have different collision testing strategies we implemented other strategy pattern. Every element has now associated with him a strategy object.

#### Implementation
The UML representation of the adaptation of the pattern to the context of the problem is the following:

![](https://i.imgur.com/com1K6R.png)



#### Consequences

* With this implementation the difference between collision checking is hidden from the POV of the application. To the exterior, the only need becomes calling the method "testCollision" independently from the type of element without any extra requirement

* Every time we define a new Element we need to specify what kind of collision pollicy it has.

* Every collision strategy must define the method that filter the elements that it will be considered in the collision testing. 


The classes that are involved in this implementation are the following:
* [PlayModel](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/menu/PlayModel.java)
 * [Enemy](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/elements/movable/enemies/Enemy.java)
* [BeamerCollisionStrategy](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/collisions/BeamerCollisionStrategy.java)
* [HeroCollisionStrategy](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/collisions/HeroCollisionStrategy.java)
* [GeneralCollisionStrategy](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/collisions/GeneralCollisionStrategy.java)
* [ProjectileCollisionStrategy](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/collisions/ProjectileCollisionStrategy.java)

#### GUI implementation abstraction

##### Problem in Context

Lanterna isn't by far the greastest graphical experience, furthermore, since in the previous year, the course changed to Swing in the middle of the work. We decided to take this step further. It wasn't necessary implement a abstract factory, but we couldn't escape use the the factory pattern in order to delegate the responsibility of creating the different state's views to a specific classe enforcing SOLID principles, but from a factory to an abstract factory the difference isn't much, so we decided to implement it empowering flexibility of our code in the view sector.
Also we need a solution to ensure the isolation of view part of the project. We needed to achieve that for the controller his interface with view would be abstracted as a simple call to a method draw()


#### The Pattern

Abstract factory pattern let us obtain a level of isolation where for every view library used we need to implement view for each state. This could appears to be overkilled, but in any case flexibility was earned and SOLID was enforced. 

#### Implementation

The implementation of this design pattern has two different phases:

* Implementation of the interface View Factory, this interface is responsible for delagating the creation task using the correct library
* Implementation of the interfaces that represent the methods required to render a specific view of each state of the game

![](https://i.imgur.com/1rWiurB.png)





The classes that are involved in this implementation are the following:

 * [GameController](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/GameController.java)
 * [State](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/State.java)
 * [View](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/view/View.java)
 * [ViewFactory](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/view/ViewFactory.java)
 * [LanternaFactory](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/view/lanterna/LanternaFactory.java)
 * [LanternaPlayStateView](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/view/lanterna/views/playState/LanternaPlayStateView.java)
 * [LanternaMenuStateView](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/view/lanterna/views/menuState/LanternaMenuStateView.java)
 * [LanternaHighScoreView](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/view/lanterna/views/highScores/LanternaHighScoresStateView.java)
 * [LanternaGameOverStateView](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/view/lanterna/views/gameoverState/LanternaGameOverStateView.java)
 * [PlayState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/PlayState.java)
 * [HighScoreState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/HighscoresState.java)
 * [MenuState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/MenuState.java)
 * [GameOverState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/GameOverState.java)




#### Consequences

The implementation of this pattern makes views being implemented in the project as members of a family associated with a specific and unique library. In our project there is a great family of Lanterna Views. 

## Different Game Menu with completly different functions and behaviours

##### Problem in Context
The menu implementation of the game is completly distinct from the implementation of the play implementation. Furthermore, there would generate a violation to the ISP SOLID's principle. There is any necessity to the menu to know what is a enemy or a a life, elements exclusive to the play state.

#### The Pattern

The solution to this problem is the most radical of the behaviour patterns, the state. Using this design pattern we are able to specify a complete distinct behaviour with a dedicated model to work with for any state of the game

#### Implementation

The implementation of this pattern requires to State to receive a reference of the controller so that transitions between states can occur

![](https://i.imgur.com/2JDCACb.png)



#### Consequences
* The game execution is delegated to their states
* Every step of execution deals with the correct portion of the model block.
* Arises the necessity to manage the transitions in the main controller of the game

The classes that are involved in this implementation are the following:

* [GameController](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/GameController.java)
* [PlayState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/PlayState.java)
 * [HighScoreState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/HighscoresState.java)
 * [MenuState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/MenuState.java)
 * [GameOverState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/GameOverState.java)
 * [State](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/State.java)


## Changing state by using the command pattern

##### Problem in Context
 As was said previously one of the consequences of the state pattern is that its necessary to change the state in the controller whenever the need arises to, this can either be when a button is pressed, the game reaches a end state either by the player dying or winning the game and finnaly whenever the user decides to close the terminal where the game is being played on. To ensure the state doesnt have to endure checking if the transition needs to happen and executing it, this last function is delegated another class.
 
 ###### The pattern 
 The pattern used is the command pattern.
 
 ###### Implementation
 
Whenever the state determines a transition is to be made it executes the selected button this then executes the command which will call the changeState function on the controller. This happens on all states related to menus in the games. In the playstate the transition of states is done on the state itself. 
 
![](https://i.imgur.com/rkXDNGd.png)

###### Consequences
* The changing of the state is not done on the state itself but is instead delegated to the button class
* Each button needs to have his command set in the construtor of the state 

The classes that are involved in this implementation are the following:

* [Model](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/Model.java)
* [MenuModel](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/menu/MenuModel.java)
 * [GameOverModel](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/menu/GameOverModel.java)
 * [PlayModel](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/menu/PlayModel.java)
 * [HighScoresModel](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/menu/HighScoresModel.java)
 * [GameController](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/GameController.java)
* [PlayState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/PlayState.java)
 * [HighScoreState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/HighscoresState.java)
 * [MenuState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/MenuState.java)
 * [GameOverState](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/GameOverState.java)
 * [State](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/state/State.java)
 * [Button](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/model/common/Button.java)
* [ButtonCommand](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/command/ButtonCommand.java)
 * [HighScoresCommand](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/command/HighScoresCommand.java)
 * [MainMenuCommand](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/command/MainMenuCommand.java)
 * [PlayCommand](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/command/PlayCommand.java)
 * [ExitCommand](https://github.com/FEUP-LPOO/lpoo-2020-g54/blob/master/src/main/java/controller/command/ExitCommand.java)

 
 


### Know code smmells and refactoring suggestions

#### Large Class

PlayStateUpdater is the class where are implemented all updates done during the game loop. This class has the responsability to update everykind of elements with different purposes, such as movement, hero life, game level. One solution may be create bunch of classes for every specific purpose. Follow strictly the SOLID principle of single responsability, the number of classes would escalate in number

#### Bi directional association on Testing Collisions

This is one smell that isn't a theoretical example of books, if so it would be fixed. But there is very much point of a strategy pattern requires to instantiate with the object that strategy is related on. This case appears in the collision strategy part of our project. Although Strategy pattern is a greater option rather than a bunch of spaghetti code. It appears to be a unknown by the authors pattern that can handle the situation described above 


#### Long Parameter List

This smell became more obvious as result of testing. Where we end up need to inject dependencies in order to achive isolation. One example of this escalation was the division made, in order to enforce SOLID principle of isolation in the view part, the LanternaPlayStateView parameters became huge. One solution may be create a dedicated class of data with the methods to obtain that information inside of it

#### Dead Method

This smell appears as consequence of the application of the strategy pattern to abstract the enemy behaviour. The attack method on the zombie is an empty void method, since the unique feature of attack of zombie is following the player while in range, which is other method. This smell may indicate that we may have exagerate in the strict in the try of application of the SOLID principle of single responsability. The attack and movementOnAttack may be joined together. 

### Testing

Coverage Tests

![](https://i.imgur.com/6bFXRh5.png)

Mutation Tests

![](https://i.imgur.com/hVTMZQv.png)



### Screenshot of the game
![](https://i.imgur.com/3ykKTii.gif)






### Self-evaluation

* José Guerra - 50%
* Rúben Almeida - 50 %

