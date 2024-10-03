import random
import time

class HuntTheWumpus:
    def __init__(self):
        self.rooms = self.create_cave()  # Create cave structure
        self.player_pos = random.randint(1, 10)  # Random start in smaller map
        self.wumpus_pos = random.randint(1, 10)  # Random Wumpus start
        self.pits = random.sample(range(1, 11), 1)  # One random pit (smaller map)
        self.bats = random.sample(range(1, 11), 2)  # Two random bat rooms
        self.arrows = 3  # Fewer arrows to increase difficulty

    def create_cave(self):
        # A smaller cave structure with only 10 rooms, each connected to 2 others.
        return {
            1: [2, 3], 2: [1, 4], 3: [1, 5], 4: [2, 6], 5: [3, 7],
            6: [4, 8], 7: [5, 9], 8: [6, 10], 9: [7, 10], 10: [8, 9]
        }

    def move(self, room):
        if room in self.rooms[self.player_pos]:
            self.player_pos = room
            print(f"\nMoving to room {room}...")
            time.sleep(0.5)
        else:
            print("You can't move there!")

    def shoot_arrow(self, room):
        if room in self.rooms[self.player_pos]:
            self.arrows -= 1
            print(f"\nShooting an arrow into room {room}...")
            time.sleep(0.5)
            if room == self.wumpus_pos:
                print("You killed the Wumpus! Congratulations!")
                return True  # Game won
            else:
                print("The arrow misses...")
                self.wumpus_move()
        else:
            print("You can't shoot there!")
        return False

    def wumpus_move(self):
        if random.random() < 0.85:  # Increase Wumpus movement probability
            self.wumpus_pos = random.choice(self.rooms[self.wumpus_pos])
            print("You hear the Wumpus moving nearby...")
            time.sleep(0.5)

    def check_hazards(self):
        # Add hints for nearby hazards.
        nearby_rooms = self.rooms[self.player_pos]
        if self.wumpus_pos in nearby_rooms:
            print("You smell something foul... the Wumpus is nearby!")
        if any(pit in nearby_rooms for pit in self.pits):
            print("You feel a cold draft... a pit must be nearby!")

        if self.player_pos == self.wumpus_pos:
            print("Oh no! You've been eaten by the Wumpus!")
            return True  # Game over
        elif self.player_pos in self.pits:
            print("You fell into a bottomless pit!")
            return True  # Game over
        elif self.player_pos in self.bats:
            print("Bats swoop down and carry you away!")
            self.player_pos = random.randint(1, 10)
            time.sleep(0.5)
        return False

    def play(self):
        print("Welcome to Hunt the Wumpus!")
        while self.arrows > 0:
            print(f"\nYou are in room {self.player_pos}.")
            time.sleep(0.5)
            print(f"Connected rooms: {self.rooms[self.player_pos]}")
            print(f"Arrows left: {self.arrows}")
            self.check_hazards()  # Show nearby hazards to add tension
            
            command = input("Move (M), Shoot (S), or Exit (E)? ").strip().upper()

            if command == "M":
                room = input("Which room? ")
                if room.lower() == "exit":
                    print("Exiting the game... Goodbye!")
                    break
                try:
                    room = int(room)
                    self.move(room)
                    if self.check_hazards():
                        break  # Game over
                except ValueError:
                    print("Invalid input. Please enter a valid room number.")

            elif command == "S":
                room = input("Shoot into which room? ")
                if room.lower() == "exit":
                    print("Exiting the game... Goodbye!")
                    break
                try:
                    room = int(room)
                    if self.shoot_arrow(room):
                        break  # Game won
                except ValueError:
                    print("Invalid input. Please enter a valid room number.")

            elif command == "E":
                print("Exiting the game... Goodbye!")
                break

            else:
                print("Invalid command. Please enter M to Move, S to Shoot, or E to Exit.")

        if self.arrows == 0:
            print("You're out of arrows. Game over!")

if __name__ == "__main__":
    game = HuntTheWumpus()
    game.play()
