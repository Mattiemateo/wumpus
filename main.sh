#!/bin/bash

# Hunt the Wumpus - Bash version

# Initialize game variables
declare -A rooms
rooms[1]="2 3"
rooms[2]="1 4"
rooms[3]="1 5"
rooms[4]="2 6"
rooms[5]="3 7"
rooms[6]="4 8"
rooms[7]="5 9"
rooms[8]="6 10"
rooms[9]="7 10"
rooms[10]="8 9"

player_pos=$((RANDOM % 10 + 1))
wumpus_pos=$((RANDOM % 10 + 1))
pit_pos=$((RANDOM % 10 + 1))
bat_pos1=$((RANDOM % 10 + 1))
bat_pos2=$((RANDOM % 10 + 1))
arrows=3

# Function to check if a value is in an array
contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            return 0
        fi
    }
    return 1
}

# Function to move the player
move() {
    local room=$1
    if contains ${rooms[$player_pos]} $room; then
        player_pos=$room
        echo -e "\nMoving to room $room..."
        sleep 0.5
    else
        echo "You can't move there!"
    fi
}

# Function to shoot an arrow
shoot_arrow() {
    local room=$1
    if contains ${rooms[$player_pos]} $room; then
        ((arrows--))
        echo -e "\nShooting an arrow into room $room..."
        sleep 0.5
        if [ $room -eq $wumpus_pos ]; then
            echo "You killed the Wumpus! Congratulations!"
            exit 0
        else
            echo "The arrow misses..."
            wumpus_move
        fi
    else
        echo "You can't shoot there!"
    fi
}

# Function to move the Wumpus
wumpus_move() {
    if [ $((RANDOM % 100)) -lt 85 ]; then
        local new_pos
        read -ra connected_rooms <<< "${rooms[$wumpus_pos]}"
        new_pos=${connected_rooms[$((RANDOM % ${#connected_rooms[@]}))]}
        wumpus_pos=$new_pos
        echo "You hear the Wumpus moving nearby..."
        sleep 0.5
    fi
}

# Function to check for hazards
check_hazards() {
    read -ra nearby_rooms <<< "${rooms[$player_pos]}"
    
    for room in "${nearby_rooms[@]}"; do
        if [ $room -eq $wumpus_pos ]; then
            echo "You smell something foul... the Wumpus is nearby!"
        fi
        if [ $room -eq $pit_pos ]; then
            echo "You feel a cold draft... a pit must be nearby!"
        fi
    done

    if [ $player_pos -eq $wumpus_pos ]; then
        echo "Oh no! You've been eaten by the Wumpus!"
        exit 1
    elif [ $player_pos -eq $pit_pos ]; then
        echo "You fell into a bottomless pit!"
        exit 1
    elif [ $player_pos -eq $bat_pos1 ] || [ $player_pos -eq $bat_pos2 ]; then
        echo "Bats swoop down and carry you away!"
        player_pos=$((RANDOM % 10 + 1))
        sleep 0.5
    fi
}

# Main game loop
echo "Welcome to Hunt the Wumpus!"

while [ $arrows -gt 0 ]; do
    echo -e "\nYou are in room $player_pos."
    sleep 0.5
    echo "Connected rooms: ${rooms[$player_pos]}"
    echo "Arrows left: $arrows"
    check_hazards

    read -p "Move (M), Shoot (S), or Exit (E)? " -n 1 -r command
    echo
    case $command in
        [Mm])
            read -p "Which room? " room
            if [[ $room =~ ^[0-9]+$ ]]; then
                move $room
            else
                echo "Invalid input. Please enter a valid room number."
            fi
            ;;
        [Ss])
            read -p "Shoot into which room? " room
            if [[ $room =~ ^[0-9]+$ ]]; then
                shoot_arrow $room
            else
                echo "Invalid input. Please enter a valid room number."
            fi
            ;;
        [Ee])
            echo "Exiting the game... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid command. Please enter M to Move, S to Shoot, or E to Exit."
            ;;
    esac
done

echo "You're out of arrows. Game over!"