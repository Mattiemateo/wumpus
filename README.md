
# Hunt the Wumpus

Hunt the Wumpus is a classic text-based adventure game where players navigate through a cave system to hunt the legendary Wumpus while avoiding hazards. This repository contains two implementations of the game: one in Bash and another in Python.

## Game Description

In Hunt the Wumpus, you find yourself in a cave with 10 interconnected rooms. Your goal is to hunt down and kill the Wumpus using your arrows before it eats you or you fall into a pit. The cave also contains super bats that can carry you to a random room.

The game provides cryptic hints to help you deduce the location of the Wumpus and other dangers in the cave, like bottomless pits and super bats. Using logic and some luck, you'll need to navigate the maze and use your limited number of arrows strategically to survive and win.

## Features

- Two implementations: Bash and Python
- 10-room cave system
- Hazards: Wumpus, pit, and super bats
- Limited arrows
- Text-based interface
- Randomized game setup for replayability

## How to Play

1. Choose either the Bash or Python version to play.
2. Navigate through the cave by moving between connected rooms.
3. Shoot arrows into adjacent rooms to try and kill the Wumpus.
4. Avoid falling into pits or encountering the Wumpus.
5. Use the hints provided to deduce the location of hazards.
6. Survive long enough to kill the Wumpus and win!

## Running the Game

### Bash Version

To play the Bash version, run:
```bash
./hunt_wumpus_bash.sh
```

Ensure that you have executable permissions for the script:
```bash
chmod +x hunt_wumpus_bash.sh
```

### Python Version

To play the Python version, run:
```bash
python3 hunt_wumpus.py
```

Make sure you have Python 3 installed on your system.

## Game Controls

- **Move**: Type `move [room number]` to move to an adjacent room.
- **Shoot**: Type `shoot [room number]` to fire an arrow into an adjacent room.
- **Help**: Type `help` to display the list of commands.
- **Quit**: Type `quit` to exit the game.

## Requirements

- Bash shell (for the Bash version)
- Python 3.x (for the Python version)

## File Structure

- `hunt_wumpus_bash.sh`: Bash version of the game
- `hunt_wumpus.py`: Python version of the game
- `README.md`: This file

## Contributing

Contributions are welcome! If you'd like to make improvements or fix bugs, feel free to submit a pull request.

## License

This project is licensed under the MIT License. See `LICENSE` for more information.
```
