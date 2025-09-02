# TicTacToe Tested
[tic_tac_toe_tdd.webm](https://github.com/user-attachments/assets/8dd9a486-0913-4121-9c58-02723722de0a)

Lesson: https://www.theodinproject.com/lessons/ruby-connect-four#assignment

Usage: Clone the repo and run `bundle install`, then `bundle exec ruby main.rb` to play the game or `bundle exec rspec` to run the specs.

For some context, I originally attempted to come back and write tests for my previous TicTacToe as part of the Connect Four lesson, but I ultimately decided to rewrite the entire project because my original was practically impossible to test and work with. I understand the lesson probably didn't expect me to rewrite it, but this is what made sense to me, and I didn't mind the practice.

Alongside gaining experience with RSpec and testing, I think the main value of this project was to realize the importance of proper object-oriented design and encapsulation. I paid much closer attention this time to what objects knew about and revealed to each other. Though, I still found myself relying heavily on `attr_reader` to expose instance variables and I'm not sure if this is something that I should strive to avoid as well.

Additionally, I learned the significance of designing around dependency injection: allowing dependent objects to be passed in as arguments in the constructor. This makes stubbing and mocking these dependent objects in the tests much less of a headache. I wonder if this kind of dependency injection is effectively mandatory in order for code to be conducive to testing.

Furthermore, I noticed while building this project that I barely employed TDD whatsoever, instead writing tests after writing a method or several methods. When I tried to force myself to adhere to TDD and red-green-refactor, I found it exceedingly difficult to visualize what the method might look like, to identify the type of message and how to test it, and to determine what needed to be mocked and stubbed. Overall, I'm fairly averse to TDD at this point because it feels more natural to write the test after the method rather than before. Granted, that could just be due to a lack of experience. I do plan to give TDD another fair shot in Connect Four, but I don't know how much I should try to enforce it if it doesn't work for me.

I plan to brush up a bit on the concepts I've mentioned before tackling Connect Four.
