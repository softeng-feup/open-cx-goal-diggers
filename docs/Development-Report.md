# openCX Development Report

Welcome to the documentation pages of the **openCX- UpQuestion** project!

You can find here detailed information about the project, from a high-level product vision to low-level implementation decisions, organized as a kind of Software Development Report 

* #### Business modeling

    *  [Product Vision](#Product-Vision)

    *  [Elevator Pitch](#Elevator-Pitch)

* #### Requirements

    *  [Use Case Diagram](#Use-case-diagram)

    *  [User stories](#User-stories)

    * [Mockups](#Mockups)

* #### Architectural Structure
    * [MVC](#Architectural-Structure)
 
* #### Tasks Management Tool

***

So far, contributions are exclusively made by the initial Goal Diggers team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

Team Members:
  - [André Gomes](https://github.com/andremsgomes)
  - [Manuel Coutinho](https://github.com/ManelCoutinho) 
  - [Roberto Mourato](https://github.com/RobertoMourato)
  - [Ruben Almeida](https://github.com/arubenruben) 
  - [Tiago Silva](https://github.com/tiagogsilva) 

***

## Product Vision

To make great questions heard (by the speaker)


## Elevator Pitch

Tired of the long awkward silences when speaker asks "Any questions??"; Tired of hearing the front line old lady telling her life story taking up your question space? Don't worry!! Send us your questions and upvote your favorites. Make your voice heard without the hassle of waiting for a mic.


## Requirements


UpQuestion was designed to end up with the inefficient experience of the participants in a conference at the end moment when questions are made/answered.

The main stakeholders identified in the given context are:

* The Participant- Person who attend to listen the speaker in   a certain talk. Has the capability to Submit questions and   to upvote other participants questions he thinks deserve     being answered.

* The Speaker- Person expert on the subject who performs the   talk. Has limited time to answer an, also, limited number     of questions and intend to invest that time to answer the     most interesting questions.

We believe that a communitarian forum open to all conference participants with features of upvote is our greatest ally to cluster the greatest questions, those that will be answered in that limited period.

A more detailed analysis of this topic is made below targeting RUP & AGILE methodologies of requirement engineering:


### Use case diagram 

#### Ask Questions
* **Actor**. Any user attending a lecture.
* **Description**. The purpose of this use case is to make questions and saving all of them on a list
* **Preconditions and Postconditions**. Users first need to login, which they can do using twitter. Then they need to choose from the schedule the lecture they are attending. Finally they need to click the plus button. In the end the system will add the question to the list. When the lecture is over, users can't ask questions anymore.
* **Normal Flow**. After the plus button is clicked, the system will open a pop-up with a box for a user to write a question. Then the user can click on the button to share the question and the system will close the pop-up and add the question to the list.
* **Alternative Flows and Exceptions**. In the pop-up there is a checkout box that, when clicked, the user will be able to share the question anonymously. There is also another button to share the question, that will share it also with twitter. If the user is not logged in with twitter, the system will show an error message.

#### See Questions
* **Actors**. Any user attending a lecture and the speaker who is giving it.
* **Description**. The purpose of this use case is to make all the questions visible for everyone who is in the lecture.
* **Preconditions and Postconditions**. Users first need to login, which they can do using twitter. Then they need to choose from the schedule the lecture they are attending. All the questions can be seen even after the lecture is over.
* **Normal Flow**. After choosing the lecture from the schedule, the system shows a list of all the questions made at the moment, sorted by number of votes. The system is always updating this list, as more questions are made.
* **Alternative Flows and Exceptions**. The sorting can be changed by the user, when clicked the sorting dropdown box. It allows the user to select from 'Top', 'Trending' and 'New', to which the system will update the questions order, based on the option selected.

#### Vote on Questions
* **Actor**. Any user attending a lecture.
* **Description**. The purpose of this use case is to be able to vote on the questions.
* **Preconditions and Postconditions**. Users first need to login, which they can do using twitter. Then they need to choose from the schedule the lecture they are attending. When the lecture is over, users can't vote on the questions anymore.
* **Normal Flow**. After choosing the lecture from the schedule, the system shows a list of all the questions made at the moment, sorted by number of votes. Users can click on upvote and downvote on all the questions and the system will update the number of votes and the order of the list.

#### Answer Questions
* **Actor**. The speaker who is giving the lecture.
* **Description**. The purpose of this use case is to be able to answer the questions.
* **Preconditions and Postconditions**. Speakers first need to login, which they can do using twitter. Then they need to choose from the schedule the lecture they are giving.
* **Normal Flow**. After choosing the lecture from the schedule, the system shows a list of all the questions made at the moment, sorted by number of votes. At the end of each lecture, speakers can answer this questions to clarify the audience.
* **Alternative Flows and Exceptions**. After the lecture is over, speaker can answer the questions, by clicking on the comment button of a giving question.

![User Case Diagram](UserCase.jpg)
 *Fig.1: User Case Diagram*

### User stories

User Stories | MoSCoW | Tshirt_Size | Acceptance Tests|
---|---|---|---|
 As a participant, I want to be able to ask my question. | Must | | GIVEN participant has logged on on the application <br> AND participant has selected the right conference <br> WHEN the participant submittes a question <br> THEN other people on the talk will be able to see the question|
 As speaker, i want to be able to see all questions done, so that i could reply them | Must | | GIVEN participants have submitted their questions <br> AND speaker have logged on on the application <br> AND speaker has selected the right conference <br> WHEN speaker sees the questions asked <br> THEN the speaker can reply the questions asked
 As a participant, I want to be able to vote previously asked questions so that the most interesting questions get answered by the speaker | Should | | GIVEN participant has logged on on the application <br> AND participant has selected the right conference <br> WHEN participant sees the previously asked questions <br> THEN participant is able to vote on the previously voted questions
 As a speaker, I want to be able to see the most voted questions so that I can answer them first. | Should | | GIVEN speaker has logged on on the application <br> AND speaker has selected the right conference <br> AND participants have submitted their questions <br> AND speaker is able to see the most voted questions made by the participants <br> WHEN speaker sees the questions made by the participants <br> THEN speaker is able to answer the most voted questions first
 As a participant, I want to be able to select the conference I'm in so that I can ask questions in the proper site. | Should | | GIVEN participant has logged on on the application <br> WHEN participant selects the conference <br> THEN participant can ask question in the proper site
 As a participant, I would like to ask anonymous questions so that I don't reveal my identity.  | Should | | GIVEN participant has logged on on the application <br> AND participant has selected the right conference <br> AND participant has written a quetion <br> WHEN participant select the checkbox anonymous <br> AND participant share the question <br> THEN the participant asked a question without revealing his identity
 As a speaker and user, I want to be able to authenticate in order to connect my profile with the activity that I'm attending.|Should| | GIVEN both participant or user have launched the application <br> WHEN both participant or user have logged in <br> THEN both participant or user are able to connect their profile to the activity they are intending
 As a user, I want to share my questions on Twitter so that my followers know what my interests are.|Should | | GIVEN user as logged on on the application with Twitter <br> AND user has selected the right conference <br> AND user has written his question <br> WHEN user selects the option "Share with Twitter" <br> THEN the user's question has been shared on Twitter
 As an organizer, I want to share the most voted questions to promote the conference.|Should | | GIVEN the organizer has logged on on the application <br> AND the organizer has selected the right conference <br> WHEN the organizer selects the share option on the intended question <br> THEN the question selected by the organizer has been shared
 As an organizer, I want to use the data in order to make networking easier.| Should| | GIVEN the organizer has logged on on the application <br> AND the organizer has selected the right conference <br> AND the organizer has privileged acess to the app data <br> WHEN the organizer acess the app data <br> THEN the organizer is able to make networking easier
 As user i would like to share my question with my Twitter followers|Should| | GIVEN user has submitted a question <br> AND has logged on on Twitter <br> WHEN user shares the question on Twitter <br> THEN user followers will be able to see the question
 
 ### Mockups
 
 The mockups for this project were developed in Figma and can be found [here](https://www.figma.com/file/BlnF2GOIbviAUOwevrIHnR/UpQuestion?node-id=0%3A1). 
 <br> (or, as an alternative, in the folder [mockups](https://github.com/softeng-feup/open-cx-goal-diggers/tree/master/docs/mockups) of this directory)

 
## Architectural Structure


### MVC
We are developing code bearing in mind the MVC architectural structure. At the time of this first report, it is revealing itself harder than we anticipated the division between the View and Controller due to the code structures that Flutter implies. More refactoring will be done in the next iterations.
 
## Tasks Management Tools
To communicate more efficiently we chose to use **Trello**  as our main tool of tasks management. User Stories with their BDD text, User Case Diagram and the work flow can be found [there](https://trello.com/b/08Qa7QyI).





