# P1-Avengers-Console


This project is part of my OpenClassrooms iOS developer courses and aims at understanding the very fundamentals of Object-Oriented-Programming with Swift.
It consists of a simple game based on Mac Console, no view is displayed on screen unlike usual iOS apps. The game is just a simple fight scenario, 
where two players must alternatively select characters and attack each other. More specifically the game is divided in 3 parts:

- 1) Initialization: The game first welcome players and lists out all types of characters. Both players must select 3 characters in their team and 
rename them after unique names. Players are not allowed to select same character or same name twice. If a Player intends to do so, 
functions have been defined to handle such intention by throwing errors and printing accordingly the corresponding message. Also, throughout the whole
initialization, players are guided with available characters. When initialization is over, the game displays a full recap of both team selection and the game starts off.
<img width="1543" alt="Capture d’écran 2023-04-16 à 17 38 17" src="https://user-images.githubusercontent.com/125874768/232323914-0c00ab59-c0ef-4af2-9d30-22b6bdfb3cdb.png">


<img width="1526" alt="Capture d’écran 2023-04-16 à 17 39 45" src="https://user-images.githubusercontent.com/125874768/232323997-9f34f851-92a0-477d-a94d-113bafc5a627.png">



- 2) Main fight: Successive rounds will then occur in which, players will have to face up, until one player becomes dead. For each round, a player is designated 
and has to pick one character among three available in its team. According to its weapon, this character will be able to either attack other team 
or heal characters in its own team. When a character has no more life (0), it becomes dead. Moreover, character's life cannot exceed 100.0.
After reach round, the console displays a recap of alive and dead characters. When a character gets killed it becomes obviously unavailable for selection
and cannot get resurrected by healer. Therefore, a player becomes dead if all characters are dead or if healer is the only remaining character alive in the 
team.

<img width="1556" alt="Capture d’écran 2023-04-16 à 17 56 12" src="https://user-images.githubusercontent.com/125874768/232324932-8c8ee532-bd06-4be3-a314-de48749217f7.png">







- 3) Results: At the end of the game, the console is able to display the winner with the number of rounds to knock out oponent. 

<img width="1032" alt="Capture d’écran 2023-04-16 à 17 57 41" src="https://user-images.githubusercontent.com/125874768/232325007-e61460ff-5278-4c52-a6c8-c687767d8e10.png">



Main concepts used : 
- Class, Structures, Enumerations
- Single Responsability principle, Reference type and value type.
- MVC architecture (although there is no view) 
- Stored/computed/static properties 
- Functions with void, return and throw type.
- Optionals
- Extension, protocol
- Version control with git
