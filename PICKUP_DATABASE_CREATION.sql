DROP SCHEMA IF EXISTS pickup;

CREATE SCHEMA pickup;
USE pickup;

CREATE TABLE sports(
	sport_id int NOT NULL AUTO_INCREMENT,
    sport_name varchar(255) NOT NULL,
    PRIMARY KEY(sport_id)
);

CREATE TABLE accounts(
	account_id int NOT NULL AUTO_INCREMENT,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    account_username varchar(255) NOT NULL, 
    account_password varchar(255) NOT NULL,
    games_joined int NOT NULL,
    games_attended int NOT NULL,
    rating int NOT NULL,
    PRIMARY KEY(account_id)
);

CREATE TABLE pickup_events(
	event_id int NOT NULL AUTO_INCREMENT,
    event_name varchar(255),
    account_id int NOT NULL,
    sport_id int NOT NULL,
    maximum_players int NOT NULL,
    current_players int NOT NULL,
    event_location varchar(255),
    event_date varchar(255),
    event_time varchar(255),
    PRIMARY KEY (event_id),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (sport_id) REFERENCES sports(sport_id) ON DELETE CASCADE
);

# JUNCTION TABLES #

# If we query by the player's ID then it will give us all events the person is attending.
# If we query by the event ID it will give us all the players associated with that event
CREATE TABLE player_event(
	account_id INT NOT NULL,
    event_id INT NOT NULL,
    is_leader BOOLEAN,
    PRIMARY KEY (account_id, event_id),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES pickup_events(event_id) ON DELETE CASCADE
);

# This table will allow us to list out this player's favorite sports
CREATE TABLE player_sport_favorite(
	account_id INT NOT NULL,
    sport_id INT NOT NULL,
    PRIMARY KEY (account_id, sport_id),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (sport_id) REFERENCES sports(sport_id) ON DELETE CASCADE
);

# This table should be a two way releationship. I read online somewhere that it was the case.
CREATE TABLE player_friend(
	account_id INT NOT NULL,
    friend_id INT NOT NULL,
	FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

INSERT INTO sports(sport_name)
VALUES ('Soccer'), ('Football'), ('Basketball');

INSERT INTO accounts(first_name, last_name, email, account_username, account_password, games_joined, games_attended, rating)
VALUES 
	('Thomas', 'Zbdoula', 'email', 'tz', '123', 10, 10, 0),
    ('john', 'jr', 'email', 'god_of_balls', 'abc', 5, 5, 0),
    ('aaa', 'aaa', 'email' ,'aaa', 'aaa', 9, 100, 0);

INSERT INTO pickup_events(event_name, account_id, sport_id, maximum_players, current_players, event_location, event_date, event_time)
VALUES 
    ("name one", 1, 1, 6, 4, "urec nc charlotte", "10/13/2022", "6:30 PM"),
	("name 2", 1, 1, 6, 4, "urec nc charlotte", "10/13/2022", "6:30 PM"),
	("name 3", 3, 2, 6, 4, "urec nc charlotte", "10/13/2022", "6:30 PM"),
	("name four", 2, 2, 6, 4, "urec nc charlotte", "10/13/2022", "6:30 PM");
    
INSERT INTO player_event(account_id, event_id, is_leader)
VALUES 
	(1, 1, true),
    (1, 2, true),
    (2, 1, false),
    (3, 1, false),
    (3, 3, true),
    (2, 4, true)
;
    
INSERT INTO player_sport_favorite(account_id, sport_id)
VALUES
    (1, 1),
    (1, 3),
    (2, 1),
    (3, 3)
;

SELECT * FROM  pickup_events;
SELECT * FROM player_event;
