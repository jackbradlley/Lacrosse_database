CREATE TABLE Coaches (Coaching_id int,
    		 	      Coach_Name VARCHAR(50),
    				  Position_coach VARCHAR(30),
                      Coaching_position VARCHAR(20) CHECK (Coaching_position IN ('Head Coach', 'Assistant Coach', 'Grad Assistant')),
                      Salary numeric(8, 2) CHECK (Salary BETWEEN 20000.00 AND 80000.00),
                      Start_year   varchar(4),
                      Team_name VARCHAR(30),
					  CONSTRAINT coahes_pkey PRIMARY KEY (coaching_id)
);

Drop table coaches




CREATE TABLE teams (team_name VARCHAR(50), 
    				 coaching_id int,
    				 location VARCHAR(50),
    				 mascot VARCHAR(20),
    				 record VARCHAR(20),
					CONSTRAINT teams_pkey PRIMARY KEY (team_name)
);

DROP TABLE Teams;
				  
CREATE TABLE GameSchedule (game_id		 varchar(4),    
						team_name      varchar(50),
						opponent_team_name    varchar(50),
					    home_or_away_or_neutral      varchar(7),
					    score       varchar(6),
						winning_team   varchar(50),
					    location         varchar(50),
						referee_id		int,    CHECK(referee_id in (10,11,12,13,14,15,16)),
						CONSTRAINT GameSchedule_pkey PRIMARY KEY (game_id),
						CONSTRAINT GameSchedule_fkey FOREIGN KEY (team_name) REFERENCES teams (team_name)
					   );

					   
DROP TABLE GameSchedule;

CREATE TABLE Players (player_id     char(4),
    				  player_Name     varchar(30),
    			      team_name     varchar(30),
    				  jersey_number     varchar(2),
    				  position_name     varchar(20),
    				  grade        varchar(30)          CHECK(grade in ('Freshman', 'Sophomore', 'Junior', 'Senior', 'Grad')),     
    				  height      varchar(30),      
    				  weight     varchar(6),
    				  from_before   varchar(30),
					  CONSTRAINT Players_pkey PRIMARY KEY (player_id),
					  CONSTRAINT Players_fkey FOREIGN KEY (team_name) REFERENCES teams (team_name)
);

DROP TABLE players

CREATE TABLE Player_Stats (player_id     char(4),
   						   Goals       int,
   						   Assists     int,
    					   Points      int,
    				       Groundballs     int,
   						   Caused_turnovers  int,
    					   Faceoffs        varchar(10),
    					   Saves           varchar(10),
						   CONSTRAINT Player_stats_pkey PRIMARY KEY (player_id),
					  	   CONSTRAINT Players_Stats_fkey FOREIGN KEY (player_id) REFERENCES players (Player_id)
);

DROP TABLE Player_stats

CREATE TABLE referees (referee_id INT       CHECK(referee_id in (10,11,12,13,14,15,16)),
    				   referee_name VARCHAR(30),    
    				   referee_phone_number char(12),
    				   salary numeric(6,2)          CHECK(salary >= 100 AND salary <= 501),
					   CONSTRAINT referees_pkey PRIMARY KEY (referee_id)
);
 DROP TABLE REFEREES


CREATE TABLE equipment (player_id		char(4),
					  	stick		varchar(30),
					 	elbow_pads     varchar(30),
					  	gloves     varchar(15),
					  	helmet	    varchar(15),
						CONSTRAINT equipment_pkey PRIMARY KEY (player_id),
						FOREIGN KEY (player_id) REFERENCES Players (player_id)
					  );
DROP TABLE equipment

CREATE TABLE Trainers (trainer_id char(5),
					   trainer_name VARCHAR(50),
					   team_name VARCHAR(50),
					   training_position VARCHAR(40),
					   trainers_phone_number VARCHAR(15),
					   Salary Numeric(8, 2)     CHECK (Salary > 19999.00),
					   CONSTRAINT trainers_pkey PRIMARY KEY (trainer_id),
					   CONSTRAINT trainer_fkey FOREIGN KEY (team_name) REFERENCES teams (team_name)
);

DROP TABLE Trainers




CREATE OR REPLACE PROCEDURE goals_season() 
	RETURNS INTEGER
	LANGUAGE plpgsql
	AS
	$$
		DECLARE 
    		 total_goals = int;
		BEGIN
			 total_goals :0;
			 
			 FOR total_goals(SELECT (*) FROM player_stats)LOOP
			 	total_goals := total_goals + player_stats.goals
				END LOOP;
				RETURN total_goals;
		END;
$$;
	
	



SELECT player_stats.points, players.player_name, coaches.position_coach, coaches.coach_name
FROM player_stats
JOIN players ON player_stats.player_id = players.player_name
JOIN coaches ON players.team_n = coaches.coaching_name
WHERE player_stats.points > 30;

SELECT player_stats.points, players.player_name, teams.team_name, coaches.position_coach, coaches.coach_name
FROM player_stats
JOIN players ON player_stats.player_id = players.player_id
JOIN teams ON players.team_name = teams.team_name
JOIN coaches ON teams.team_name = coaches.team_name
WHERE player_stats.points > 30 AND coaches.position_coach = 'Offense';
--How do I update this without dropping tables

-- Top for teams in the mac fot lacrosse
INSERT INTO teams(team_name, coaching_id, location, mascot, record) 
VALUES('Eastern University', 1000, 'St.Davids, Pa', 'Eagle', '4-9');

INSERT INTO teams(team_name, coaching_id, location, mascot, record) 
VALUES('Stevenson University', 2000, 'Owings Mills, Md', 'Mustang', '8-5');

INSERT INTO teams(team_name, coaching_id, location, mascot, record) 
VALUES('Messiah University', 3000, 'Grantham, PA', 'Falcons', '10-3');

INSERT INTO teams(team_name, coaching_id, location, mascot, record) 
VALUES('York College of Pennsylvania', 4000, 'York, PA', 'Spartans', '6-7');

SELECT * 
FROM teams



-- What do I do if the same game is on more then one schedule
-- Schedule for each team
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('100', 'Eastern University', 'Washington College', 'away', '14-7', 'Eastern University', 'Chestertown, MD', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('110*', 'Eastern University', 'Swarthmore College', 'home', '16-12', 'Swarthmore College', '1300 Eagle Rd, St Davids, PA 19087', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('111', 'Eastern University', 'University of Mary Washington', 'away', '14-8', 'University of Mary Washington', 'Fredericksburg, VA', 11);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('112', 'Eastern University', 'Ursinus College', 'away', '45631', 'Ursinus College', 'Collegeville, PA', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('113', 'Eastern University', 'Arcadia College', 'away', '45635', 'Eastern University', 'Glenside, PA', 11);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('114*', 'Eastern University', 'Nichols College', 'home', '45599', 'Eastern University', 'St.Davids, Pa', 14);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('115*', 'Eastern University', 'Stockton University', 'home', '45573', 'Stockton University', 'St.Davids, Pa', 11);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('116', 'Eastern University', 'Cabrini University', 'away', '17-13', 'Cabrini University', 'Radnor, Pa', 12);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('117', 'Eastern University', 'Stevens Institute of Technology', 'away', '22-7', 'Stevens Institute of Technology', 'Hoboken, NJ', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('118*', 'Eastern University', 'Hartwick College', 'home', '18-10', 'Eastern University', 'St.Davids, Pa', 12);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('119*', 'Eastern University', 'Stevenson University', 'home', '22-7', 'Stevenson University', 'St.Davids, Pa', 13);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('120*', 'Eastern University', 'Messiah University', 'home', '15-12', 'Messiah University', 'St.Davids, Pa', 11);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('121', 'Eastern University', 'York College of Pennsylvania', 'away', '15-11', 'York College of Pennsylvania', 'York, Pa', 11);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('122', 'Eastern University', 'Alvernia University', 'away', 'null', 'null', 'Reading, Pa', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('123*', 'Eastern University', 'Albright College', 'home', 'null', 'null', 'St.Davids, Pa', 16);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('124', 'Eastern University', 'Widener University', 'away', 'null', 'null', 'Chester, Pa', 15);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('126', 'Eastern University', 'Hood College', 'away', 'null', 'null', '', 14);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('127*', 'Stevenson University', 'Muhlenberg College', 'home', '15-10', 'Stevenson University', 'Owings Mills, Md', 12);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('128', 'Stevenson University', 'Christopher Newport University', 'away', '14-9', 'Christopher Newport University', 'Newport News, Va', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('130', 'Stevenson University', 'Catholic University', 'away', '18-12', 'Stevenson University', 'Washington, D.C', 14);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('131', 'Stevenson University', 'Gettysburg College', 'away', '45605', 'Gettysburg College', 'Gettysburg, Pa', 15);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('132*', 'Stevenson University', 'Dickinson College', 'home', '14-6', 'Dickinson College', 'Owings Mills, Md', 14);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('133*', 'Stevenson University', 'University of Lynchburg', 'home', '15-9', 'University of Lynchburg', 'Owings Mills, Md', 13);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('134*', 'Stevenson University', 'Washington and Lee University', 'home', '45574', 'Stevenson University', 'Owings Mills, Md', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('135', 'Stevenson University', 'Salisbury University', 'away', '18-8', 'Salisbury University', 'Salisbury, MD', 16);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('136*', 'Stevenson University', 'Elizabethtown College', 'home', '16-4', 'Stevenson University', 'Owings Mills, Md', 13);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('137*', 'Stevenson University', 'Franklin and Marshall College', 'home', '21-11', 'Stevenson University', 'Owings Mills, Md', 12);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('119', 'Stevenson University', 'Eastern Unviersity', 'away', '22-7', 'Stevenson University', 'St.Davids, Pa', 13);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('139', 'Stevenson University', 'Hood College', 'away', '28-5', 'Stevenson University', 'Frederick, Md', 16);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('140*', 'Stevenson University', 'Alvernia University', 'home', '21-3', 'Stevenson University', 'Owings Mills, Md', 13);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('141', 'Stevenson University', 'York College of Pennsylvania', 'away', 'null', 'null', 'York, Pa', 13);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('142*', 'Stevenson University', 'Messiah University', 'home', 'null', 'null', 'Owings Mills, Md', 14);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('143', 'Stevenson University', 'Albright College', 'away', 'null', 'null', 'Reading, Pa', 11);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('144*', 'Stevenson University', 'Widener University', 'home', 'null', 'null', 'Owings Mills, Md', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('145', 'Messiah University', 'Catholic University', 'away', '45606', 'Messiah University', 'Washington, D.C', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('146*', 'Messiah University', 'Marymount University', 'home', '21-8', 'Messiah University', 'Grantham, PA', 12);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('147', 'Messiah University', 'Franklin and Marshall College', 'away', '45631', 'Franklin and Marshall College', 'Lancaster, PA', 14);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('148', 'Messiah University', 'Stevens Institute of Technology', 'away', '45336', 'Stevens Institute of Technology', 'Hoboken, Pa', 16);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('149*', 'Messiah University', 'Bridgewater College', 'home', '17-11', 'Messiah University', 'Grantham, PA', 15);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('150*', 'Messiah University', 'University of Mary Washington', 'home', '13-12', 'Messiah University', 'Grantham, PA', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('151', 'Messiah University', 'Southern Virginia University', 'away', '21-9', 'Messiah University', 'Buena Vista, VA', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('152', 'Messiah University', 'Guilford College', 'away', '19-9', 'Messiah University', 'Greensboro, NC', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('153', 'Messiah University', 'St. Marys College of Maryland', 'away', '15-19', 'St. Marys College of Maryland', 'St. Marys City, Md', 14);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('154*', 'Messiah University', 'Lebanon Valley College', 'home', '21-10', 'Messiah University', 'Grantham, PA', 12);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('155*', 'Messiah University', 'Hood College', 'home', '14-12', 'Messiah University', 'Grantham, PA', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('120', 'Messiah University', 'Eastern Unviersity', 'away', '15-12', 'Messiah University', 'St.Davids, Pa', 11);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('157', 'Messiah University', 'Albright College', 'away', '21-10', 'Messiah University', 'Reading, Pa', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('158*', 'Messiah University', 'Widener University', 'home', 'null', 'null', 'Grantham, PA', 15);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('142', 'Messiah University', 'Stevenson University', 'away', 'null', 'null', 'Owings Mills, Md', 14);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('160*', 'Messiah University', 'Alvernia University', 'home', 'null', 'null', 'Grantham, PA', 11);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('161', 'Messiah University', 'York College of Pennsylvania', 'away', 'null', 'null', 'York, Pa', 12);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('162*', 'York College of Pennsylvania', 'RPI', 'home', '45511', 'RPI', 'York, Pa', 15);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('163*', 'York College of Pennsylvania', 'Washinton and Lee University', 'home', '16-15', 'York College of Pennsylvania', 'York, Pa', 11);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('164', 'York College of Pennsylvania', 'Franklin and Marshall College', 'away', '15-6', 'York College of Pennsylvania', '', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('165*', 'York College of Pennsylvania', 'RIT', 'home', '45606', 'RIT', 'York, Pa', 16);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('166*', 'York College of Pennsylvania', 'Salisbury University', 'home', '17-11', 'Salisbury University', 'York, Pa', 13);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('167', 'York College of Pennsylvania', 'St. Lawrence University', 'nuetral', '45543', 'St. Lawrence University', '', 16);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('168', 'York College of Pennsylvania', 'Dickinson College', 'nuetral', '45604', 'Dickinson College', '', 12);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('169', 'York College of Pennsylvania', 'Denison College', 'away', '45605', 'York College of Pennsylvania', '', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('170', 'York College of Pennsylvania', 'Gettysburg College', 'away', '45574', 'Gettysburg College', '', 12);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('171*', 'York College of Pennsylvania', 'Albright College', 'home', '20-4', 'York College of Pennsylvania', 'York, Pa', 16);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('172*', 'York College of Pennsylvania', 'Alvernia University', 'away', '13-2', 'York College of Pennsylvania', '', 10);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('141*', 'York College of Pennsylvania', 'Eastern Unviersity', 'home', '15-11', 'York College of Pennsylvania', 'York, Pa', 14);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('174*', 'York College of Pennsylvania', 'Stevenson University', 'home', 'null', 'null', 'York, Pa', 13);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('175', 'York College of Pennsylvania', 'Widener University', 'away', 'null', 'null', '', 13);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('176', 'York College of Pennsylvania', 'Hood College', 'away', 'null', 'null', '', 16);
INSERT INTO GameSchedule(game_id, team_name, opponent_team_name, home_or_away_or_neutral, score, winning_team, location, referee_id) VALUES('161*', 'York College of Pennsylvania', 'Messiah University', 'home', 'null', 'null', 'York, Pa', 12);



SELECT *
FROM GameSchedule

-- This view is viewing all of eastern home games.
CREATE VIEW EasternUniversityHomeGames AS
SELECT *
FROM GameSchedule
WHERE team_name = 'Eastern University' AND home_or_away_or_neutral = 'home';

CREATE OR REPLACE FUNCTION add_points()
	RETURNS TRIGGER
	LANGUAGE plpgsql
	AS 
	$$
	BEGIN
		UPDATE player_stats
		SET points = points + 1;
		RETURN NEW;
	END;
$$;

DROP Function Add_points

CREATE TRIGGER update_points
AFTER UPDATE ON player_stats
FOR EACH ROW
WHEN((NEW.goals = OLD.goals + 1) OR (NEW.Assists = OLD.Assists + 1))
EXECUTE PROCEDURE add_points();


SELECT * FROM EasternUniversityHomeGames 
-- Players of each teams data base
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1000', 'Charlie Harrison', 'Eastern University', 14, 'Faceoff', 'Sophomore', '5''8"', 230, 'Jackson, Nj');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1100', 'Andrew Collins', 'Eastern University', 39, 'Midfield', 'Sophomore', '6''5"', 190, 'Fogelsville, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1110', 'Jack Bradley', 'Eastern University', 25, 'Long-Stick Midfield', 'Sophomore', '6''3"', 195, 'Broomall, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1111', 'Christopher Fanelli', 'Eastern University', 1, 'Attack', 'Junior', '5''7"', 155, 'Perkasie, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1112', 'Lucien trudel', 'Eastern University', 2, 'Midfield', 'Senior', '5''7"', 165, 'Phoenixville, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1113', 'Jake Vitone', 'Eastern University', 3, 'Midfield', 'Junior', '5''7"', 155, 'West Grove, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1114', 'Gavin Stark', 'Eastern University', 4, 'Midfield', 'Sophomore', '6''4"', 190, 'Baltimore, MD');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before)VALUES('1115', 'Nicholas Fanelli', 'Eastern University', 7, 'Attack', 'Grad', '5''10"', 170, 'Perkasie, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1116', 'Connor Bachman', 'Eastern University', 8, 'Midfield', 'Grad', '6''0"', 195, 'Butler, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1117', 'Braden Wagner', 'Eastern University', 9, 'Midfield', 'Senior', '5''8"', 160, 'West Chester, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1118', 'Nick Litzenburger', 'Eastern University', 10, 'Midfield', 'Senior', '6''2"', 180, 'Freeville, NY');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1119', 'Sean Dendall', 'Eastern University', 11, 'Close Defense', 'Sophomore', '6''4"', 205, 'Sinking Spring, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before)VALUES('1120', 'Ethan Myers', 'Eastern University', 12, 'Goalie', 'Senior', '5''11"', 175, 'Cortland, NY');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1121', 'Brett Williamson', 'Eastern University', 16, 'Midfield', 'Sophomore', '5''10"', 195, 'Austin, Texas');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1122', 'Ryan Drobnick', 'Eastern University', 17, 'Midfield', 'Junior', '5''11"', 180, 'Sinking Spring, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1123', 'Greyson Sprinkle', 'Eastern University', 19, 'Midfield', 'Junior', '5''11"', 185, 'Landenberg, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1124', 'Zach Puckett', 'Eastern University', 20, 'Defense', 'Sophomore', '5''10"', 175, 'Media, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1125', 'Avery Porter', 'Eastern University', 22, 'Attack', 'Senior', '5''7"', 190, 'Poulsbo, Wash');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1126', 'Patrick Obal', 'Eastern University', 24, 'Defense', 'Sophomore', '6''0"', 195, 'West Grove, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1127', 'Zack Klym', 'Eastern University', 27, 'Goalie', 'Junior', '6''0"', 205, 'Shamong, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1128', 'Brennan Kaut', 'Eastern University', 29, 'Midfield', 'Sophomore', '6''2"', 205, 'Media, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1129', 'Dominic Maragoni', 'Eastern University', 31, 'Midfield', 'Sophomore', '6''0"', 175, 'Chambersburg, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1130', 'Ryan Poole', 'Eastern University', 35, 'Long-Stick Midfield', 'Junior', '5''8"', 155, 'Media, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1131', 'Brady Palmer', 'Eastern University', 36, 'Long-Stick Midfield', 'Junior', '6''2"', 180, 'Owings Mills, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1132', 'Nathan Gilbert', 'Eastern University', 44, 'Defense', 'Senior', '6''4"', 200, 'West Grove, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1133', 'Sam Chester', 'Eastern University', 48, 'Defense', 'Sophomore', '6''0"', 185, 'Havertown, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1134', 'Nick Cimpaglio', 'Eastern University', 53, 'Long-Stick Midfield', 'Sophomore', '5''8"', 190, 'Pylesville, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1135', 'Sean Mcnamera', 'Eastern University', 54, 'Defense', 'Sophomore', '6''2"', 190, 'Phoenixville, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1136', 'Dan Divita', 'Eastern University', 55, 'Midfield', 'Junior', '5''7"', 155, 'Warminster, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1137', 'Ed Masterson', 'Stevenson University', 2, 'Long-Stick Midfield', 'Grad', '6''0"', 155, 'Ambler, Pa.');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1139', 'Hunter Bryant', 'Stevenson University', 1, 'Midfield', 'Freshman', '6''2"', 185, 'Frederick, Md.');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1140', 'Jered Monar', 'Stevenson University', 6, 'Attack', 'Junior', '5''9"', 160, 'Salisbury, Md.');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1141', 'Max Racich', 'Stevenson University', 28, 'Attack', 'Sophomore', '6''1"', 175, 'Chatham, N.J');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1142', 'Gavin Gossen', 'Stevenson University', 25, 'Attack', 'Freshman', '5''9"', 165, 'Newport Beach, Calif.');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1143', 'Darrell Curtis', 'Stevenson University', 11, 'Attack', 'Freshman', '6''0"', 212, 'Rancho Santa Margarita, Calif. ');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1144', 'Grant Zick', 'Stevenson University', 27, 'Midfield', 'Junior', '6''1"', 200, 'Maple Grove, Minn');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1145', 'Jack Scaliti', 'Stevenson University', 26, 'Midfield', 'Junior', '6''1"', 185, 'Skippack, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1146', 'Graeme McCrory', 'Stevenson University', 46, 'Midfield', 'Junior', '5''11"', 185, 'Oshawa, ON, CA');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1147', 'Andrew Searing', 'Stevenson University', 31, 'Midfield', 'Senior', '6''1"', 185, 'Seaford, N.Y');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1148', 'Conor Halpin', 'Stevenson University', 20, 'Faceoff', 'Senior', '5''10"', 170, 'Cranford, N.J.');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1149', 'Carter Grear', 'Stevenson University', 63, 'Midfield', 'Freshman', '5''7"', 165, 'Catonsville, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1150', 'Justin Tepper', 'Stevenson University', 57, 'Midfield', 'Senior', '5''10"', 185, 'Baltimore, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1151', 'Robbie Vanderklugt', 'Stevenson University', 50, 'Midfield', 'Junior', '6''0"', 185, 'Brentwood, Calif');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1152', 'Brennan McKneely', 'Stevenson University', 48, 'Midfield', 'Sophomore', '5''10"', 163, 'Brookeville, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1153', 'Ayden Fadrowski', 'Stevenson University', 12, 'Long-Stick Midfield', 'Freshman', '6''0"', 180, 'Westminster, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1154', 'Damien Schmidt', 'Stevenson University', 19, 'Long-Stick Midfield', 'Senior', '6''3"', 200, 'Niantic, Conn');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1155', 'Ryan Quinn', 'Stevenson University', 14, 'Defense', 'Senior', '6''3"', 215, 'Summit, N.J');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1156', 'Nicholas Mulvey', 'Stevenson University', 40, 'Defense', 'Grad', '6''4"', 225, 'Glenn Dale, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1157', 'Jack Seals', 'Stevenson University', 36, 'Defense', 'Grad', '6''1"', 200, 'Whittier, Calif');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1158', 'Thomas Bethune', 'Stevenson University', 64, 'Defense', 'Senior', '6''2"', 220, 'Westminster, MD');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1159', 'Justin Scorese', 'Stevenson University', 16, 'Goalie', 'Grad', '5''10"', 190, 'Bridgewater, NJ');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1160', 'Bobby Berg', 'Messiah University', 13, 'Attack', 'Sophomore', '6''0"', 215, 'San Diego, Calif');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1161', 'Chad Teresky', 'Messiah University', 3, 'Attack', 'Junior', '6''1"', 195, 'Derry, N.H');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1162', 'Mike McKnelly', 'Messiah University', 0, 'Attack', 'Sophomore', '6''3"', 215, 'Baltimore, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1163', 'Seth Libby', 'Messiah University', 25, 'Midfield', 'Senior', '6''2', 205, 'Pomfret, Conn');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1164', 'RJ Mellor', 'Messiah University', 24, 'Midfield', 'Senior', '6''0"', 180, 'Emmitsburg, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1165', 'Owen Hammel', 'Messiah University', 2, 'Midfield', 'Freshman', '6''2"', 200, 'Dillsburg, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1166', 'Jesse Lynch', 'Messiah University', 4, 'Midfield', 'Sophomore', '6''0"', 165, 'Dowingtown, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1167', 'Ben Antel', 'Messiah University', 22, 'Faceoff', 'Sophomore', '5''11"', 185, 'Rockford, Mich');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1168', 'James Myers', 'Messiah University', 8, 'Midfield', 'Junior', '5''11"', 190, 'Sykesville, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1169', 'Caden Green', 'Messiah University', 44, 'Midfield', 'Freshman', '6''2"', 185, 'Mount Airy, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1170', 'Jed Davis', 'Messiah University', 12, 'Midfield', 'Sophomore', '5''10"', 185, 'Chester County, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1171', 'Tristan Lynch', 'Messiah University', 99, 'Long-Stick Midfield', 'Grad', '6''3"', 210, 'Coatsville, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1172', 'Bradley Simons', 'Messiah University', 30, 'Long-Stick Midfield', 'Freshman', '5''10"', 185, 'Cadours, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1173', 'Nate Jaloszynski', 'Messiah University', 23, 'Defense', 'Senior', '6''3"', 185, 'Middletown, N.Y.');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1174', 'Walker Penchansky', 'Messiah University', 18, 'Defense', 'Sophomore', '6''4"', 205, 'Culver City, Calif');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1175', 'Grant Peffall', 'Messiah University', 27, 'Defense', 'Freshman', '5''10"', 185, 'Mount Airy, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1176', 'Jourdain Algarin', 'Messiah University', 41, 'Goalie', 'Freshman', '6''0"', 165, 'Havre de Grace, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1177', 'David Gross', 'Messiah University', 1, 'Defense', 'Sophomore', '6''0', 190, 'Lancaster, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1178', 'Will Harnick', 'York College of Pennsylvania', 28, 'Attack', 'Grad', '5''11"', 180, 'Gibsonia, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1179', 'Davis Fisher', 'York College of Pennsylvania', 44, 'Attack', 'Sophomore', '6''1"', 180, 'Arnold, Md.');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1180', 'Michael Russo', 'York College of Pennsylvania', 2, 'Attack', 'Freshman', '5''5"', 160, 'West Grove, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1181', 'Jack Grayson', 'York College of Pennsylvania', 7, 'Midfield', 'Grad', '5''10"', 170, 'Sinking Spring, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1182', 'Garrett Keogh', 'York College of Pennsylvania', 26, 'Midfield', 'Grad', '6''1"', 185, 'Richmond, VA');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1183', 'Coleton Mahorney', 'York College of Pennsylvania', 13, 'Midfield', 'Sophomore', '6''2"', 215, 'York, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1184', 'Cory Bergmann', 'York College of Pennsylvania', 31, 'Midfield', 'Freshman', '5''11"', 170, 'Long Beach, Calif');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1185', 'Asher Poppleton', 'York College of Pennsylvania', 12, 'Midfield', 'Freshman', '5''11"', 205, 'Denver, Colo');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1186', 'Blake Morton', 'York College of Pennsylvania', 16, 'Midfield', 'Freshman', '5''8"', 185, 'Austin, Texas');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1187', 'Jackson Shields', 'York College of Pennsylvania', 19, 'Midfield', 'Junior', '5''11"', 175, 'Harrisburg, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1189', 'Zach Mentzer', 'York College of Pennsylvania', 20, 'Midfield', 'Grad', '6''2"', 200, 'York, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1190', 'Vinny Facciponti', 'York College of Pennsylvania', 23, 'Faceoff', 'Grad', '5''10"', 210, 'Annapolis, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1191', 'Erik Pearl', 'York College of Pennsylvania', 11, 'Midfield', 'Freshman', '5''10"', 195, 'Sykesville, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1192', 'Zach Rutledge', 'York College of Pennsylvania', 10, 'Long-Stick Midfield', 'Junior', '6''0"', 190, 'Apex, N.C');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1193', 'Aaron Rubeling', 'York College of Pennsylvania', 30, 'Long-Stick Midfield', 'Junior', '6''0"', 190, 'Baltimore, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1194', 'Brent Blackmon', 'York College of Pennsylvania', 43, 'Defense', 'Grad', '6''3"', 220, 'Henrico, Va');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1195', 'Colin Kane', 'York College of Pennsylvania', 45, 'Defense', 'Sophomore', '6''2"', 200, 'Haverford, Pa');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1196', 'Nick Biava', 'York College of Pennsylvania', 35, 'Defense', 'Junior', '6''3"', 180, 'Damascus, Md');
INSERT INTO Players(player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before) VALUES('1197', 'Nash Womack ', 'York College of Pennsylvania', 17, 'Goalie', 'Sophomore', '5''11"', 180, 'King of Prussia, Pa');

SELECT players.player_name, groundballs
FROM players NATURAL INNER JOIN player_stats
WHERE player_stats.groundballs > 30

-- This code finds all the players from everyteam and shows what players have the same number.
SELECT DISTINCT p1.Player_name, p1.Jersey_number, p1.team_name
FROM Players p1
JOIN Players p2 ON p1.Jersey_number = p2.Jersey_number AND p1.Player_id != p2.Player_id
ORDER BY p1.Jersey_number, p1.Player_name;

SELECT DISTINCT Players.player_name
FROM Players
JOIN Equipment ON Players.player_id = Equipment.player_id
WHERE Equipment.helmet = 'Large';
-- Every a team will recruit new players that will be added to a team. I have created a procedure that adds players to the players table.
CREATE OR REPLACE PROCEDURE recruits() 
	LANGUAGE plpgsql
	AS 
	$$
		BEGIN
			INSERT INTO Players (player_id, player_name, team_name, jersey_number, position_name, grade, height, weight, from_before)
	        VALUES ('1200', 'Joey Yuke', 'York College of Pennsylvania', '0', 'Attack', 'Freshman', '5''8"', '160', 'Broomall, Pa'); 
		END;
	$$;
	
CALL recruits();
SELECT * FROM players
WHERE team_name = 'York College of Pennsylvania'

CALL recruits();



-- Stats for each player on each team
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1000', 0, 0, 0, 15, 3, '30%', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1100', 1, 2, 3, 2, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1110', 0, 1, 1, 13, 8, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1111', 20, 6, 26, 15, 5, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1112', 2, 0, 2, 6, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1115', 27, 16, 43, 26, 6, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1114', 15, 17, 32, 20, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1113', 3, 3, 6, 3, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1116', 16, 7, 23, 3, 10, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1117', 0, 0, 0, 4, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1118', 24, 6, 30, 25, 7, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1119', 0, 0, 0, 15, 8, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1120', 1, 0, 1, 30, 2, 'null', '54%');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1121', 9, 2, 11, 5, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1122', 1, 1, 2, 1, 0, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1123', 0, 1, 1, 8, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1124', 0, 0, 0, 25, 19, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1125', 13, 4, 17, 10, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1126', 0, 0, 0, 8, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1127', 0, 0, 0, 4, 0, 'null', '32%');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1128', 4, 1, 5, 3, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1129', 5, 3, 8, 27, 13, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1130', 0, 0, 0, 2, 3, '11%', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1131', 0, 0, 0, 10, 10, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1132', 0, 0, 0, 12, 26, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1133', 0, 0, 0, 8, 0, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1134', 0, 0, 0, 18, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1135', 0, 0, 0, 0, 0, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1136', 1, 1, 2, 10, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1137', 2, 1, 3, 24, 10, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1139', 10, 3, 13, 15, 3, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1140', 24, 10, 34, 6, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1141', 35, 10, 45, 15, 5, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1142', 7, 3, 10, 0, 0, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1143', 16, 2, 18, 8, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1144', 30, 20, 50, 22, 5, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1145', 26, 15, 41, 16, 7, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1146', 13, 1, 14, 10, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1147', 8, 6, 14, 11, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1148', 3, 0, 3, 80, 3, '62%', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1149', 2, 1, 3, 15, 7, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1150', 0, 2, 2, 10, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1151', 5, 1, 6, 23, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1152', 2, 1, 3, 6, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1153', 0, 1, 1, 12, 3, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1154', 0, 0, 0, 5, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1155', 2, 0, 2, 35, 17, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1156', 1, 1, 2, 40, 25, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1157', 0, 0, 0, 22, 12, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1158', 0, 0, 0, 12, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1159', 0, 0, 0, 25, 2, 'null', '52%');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1160', 36, 5, 41, 22, 6, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1161', 34, 26, 60, 24, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1162', 40, 6, 46, 15, 0, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1163', 10, 10, 20, 23, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1164', 13, 1, 14, 12, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1165', 12, 3, 15, 6, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1166', 8, 4, 12, 24, 8, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1167', 1, 0, 1, 40, 2, '43%', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1168', 3, 3, 6, 21, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1169', 0, 1, 1, 13, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1170', 2, 3, 5, 7, 3, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1171', 4, 2, 6, 52, 23, '12%', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1172', 0, 0, 0, 10, 3, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1173', 0, 0, 0, 20, 14, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1174', 2, 1, 3, 24, 12, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1175', 0, 0, 0, 30, 14, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1176', 0, 0, 0, 22, 2, 'null', '56%');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1177', 1, 0, 1, 20, 14, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1178', 32, 7, 39, 22, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1179', 24, 8, 32, 24, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1180', 10, 8, 18, 12, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1181', 15, 11, 26, 13, 6, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1182', 10, 1, 11, 8, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1183', 12, 1, 13, 4, 0, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1184', 3, 10, 13, 6, 0, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1185', 4, 6, 10, 4, 1, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1186', 2, 3, 5, 2, 2, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1187', 15, 7, 22, 25, 10, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1189', 3, 3, 6, 22, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1190', 10, 8, 18, 92, 2, '65%', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1191', 1, 1, 2, 15, 11, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1192', 0, 0, 0, 10, 4, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1193', 1, 0, 1, 8, 6, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1194', 2, 2, 4, 52, 25, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1195', 0, 0, 0, 32, 17, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1196', 0, 0, 0, 17, 10, 'null', 'null');
INSERT INTO Player_stats(player_id, Goals, Assists, Points, Groundballs, Caused_turnovers, Faceoffs, Saves) VALUES('1197', 0, 0, 0, 14, 0, 'null', '51%');

DELETE FROM Player_stats
WHERE Goals = 0 AND Assists = 0 AND Points = 0 AND Groundballs = 0 AND Caused_turnovers = 0;

SELECT *
FROM Player_stats

CREATE OR REPLACE FUNCTION CalculateAverageGoals(player_id VARCHAR(30))
	RETURNS DECIMAL(2,2)
	LANGUAGE plpgsql
	AS
	$$
    	DECLARE 
			total_goals FLOAT;
			total_games FLOAT; 
			avg_goals FLOAT;
		BEGIN 
			SELECT SUM(Goals) INTO total_goals
			FROM Player_stats
			WHERE Player_stats.player_id = CalculateAverageGoals.Player_id;
			SELECT COUNT(*) INTO total_games
			FROM GameSchedule, Players
			WHERE GameSchedule.team_name = Players.team_name AND Players.player_id = CalculateAverageGoals.Player_id;
			SELECT (total_goals) / (total_games) INTO avg_goals;
			
			RETURN avg_goals;
		END;
	$$;
	
	SELECT * FROM player_stats WHERE player_stats = 
	
DROP FUnction CalculateAverageGoals

SELECT player_name, from_before AS hometown
FROM Players;

SELECT * FROM CalculateAverageGoals('1115')

-- This view shows who in the top 4 mac teams who has more then 40 points in the season and shows the player name and points
CREATE VIEW Players_40_points AS
SELECT p.player_name, ps.points
FROM Players p
JOIN Player_stats ps ON p.player_id = ps.player_id
WHERE ps.Points > 40;

SELECT * FROM Players_40_points

DROP VIEW players_40_points

-- dave Bert the ref
INSERT INTO referees(referee_id, referee_name, referee_phone_number, salary) 
VALUES(10, 'Dave Bertoline', '215-354-6126', 220.50);

-- rick games reffed
INSERT INTO referees(referee_id, referee_name, referee_phone_number, salary) 
VALUES(11, 'Rick Dickson', '555-987-6543', 340.50);

-- Joe d games reffed
INSERT INTO referees(referee_id, referee_name, referee_phone_number, salary) 
VALUES(12, 'Joe Downs', '555-987-6543', 420.50);

-- Joe m game ref
INSERT INTO referees(referee_id, referee_name, referee_phone_number, salary) 
VALUES(13, 'Joe Mcginnis', '555-234-5678', 420.50);

-- owen games reffed
INSERT INTO referees(referee_id, referee_name, referee_phone_number, salary) 
VALUES(14, 'Owen Mathes', '555-876-5432', 330.50);

--coop games reffed
INSERT INTO referees(referee_id, referee_name, referee_phone_number, salary) 
VALUES(15, 'Coop Conroy', '555-345-6789', 220.50);

-- mike games reffed
INSERT INTO referees(referee_id, referee_name, referee_phone_number, salary) 
VALUES(16, 'Mike Govan', '610-234-5609', 420.50);

SELECT *
FROM referees


	
DROP FUNCTION referee_games

SELECT * FROM referee_games(11)

RETURNS DECIMAL(2,2)
	LANGUAGE plpgsql
	AS
	$$
    	DECLARE 
			total_goals FLOAT;
			total_games FLOAT; 
			avg_goals FLOAT;
		BEGIN 
			SELECT SUM(Goals) INTO total_goals
			FROM Player_stats
			WHERE Player_stats.player_id = CalculateAverageGoals.Player_id;
			SELECT COUNT(*) INTO total_games
			FROM GameSchedule, Players
			WHERE GameSchedule.team_name = Players.team_name AND Players.player_id = CalculateAverageGoals.Player_id;
			SELECT (total_goals) / (total_games) INTO avg_goals;
			
			RETURN avg_goals;
		END;

SELECT r.referee_id, r.referee_name, COUNT(*) AS games_count
FROM referees r
JOIN GameSchedule gs ON r.referee_id = gs.referee_id
GROUP BY r.referee_id, r.referee_name;

-- Coaches for each team
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(1000, 'Colin Piper', 'Offense', 'Head Coach', 40000, '2023', 'Eastern University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(1110, 'Anthony Courcelle', 'Defense', 'Assistant Coach', 20000, '2023', 'Eastern University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(1111, 'Tony Verna', 'Recruit', 'Assistant Coach', 20000, '2019', 'Eastern University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(1112, 'Conor Evans', 'Goalie', 'Grad Assistant', 20000, '2023', 'Eastern University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(2000, 'Paul Cantwin', 'Offense', 'Head Coach', 70000, '2005', 'Stevenson University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(2220, 'Tim Plus', 'Offense', 'Assistant Coach', 40000, '2008', 'Stevenson University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(2222, 'Dom Defazio', 'Defense', 'Assistant Coach', 40000, '2019', 'Stevenson University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(2223, 'Parker Bratton', 'Defense', 'Assistant Coach', 25000, '2020', 'Stevenson University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(3000, 'Dan Carson', 'Offense', 'Head Coach', 75000, '2003', 'Messiah University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(3330, 'Sean Ireland', 'Defense', 'Assistant Coach', 30000, '2010', 'Messiah University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(3333, 'Drake Porter', 'Goalie', 'Assistant Coach', 26000, '2023', 'Messiah University');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(4000, 'Brandon', 'Offense', 'Head Coach', 80000, '2015', 'York College of Pennsylvania');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(4440, 'Ryan Kennedy', 'Defense', 'Assistant Coach', 50000, '2016', 'York College of Pennsylvania');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(4444, 'Jacob Wilhem', 'Defense', 'Assistant Coach', 35000, '2022', 'York College of Pennsylvania');
INSERT INTO coaches(coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, Team_name) VALUES(4445, 'Shane Brookhart', 'Goalie', 'Grad Assistant', 20000, '2023', 'York College of Pennsylvania');

CREATE OR REPLACE FUNCTION team_info(team_name varchar(50))
		RETURNS TABLE(coaching_idd int,
					  coach_namee varchar(50),
					  Position_coachh  varchar(30), 
					  Coaching_positionn  varchar(20), 
					  Salaryy   numeric(8,2), 
					  Start_yearr  varchar(4),
					  team_namee    varchar(4))
		LANGUAGE plpgsql
		AS
		$$
			BEGIN
				RETURN QUERY
				SELECT coaching_id, coach_name, Position_coach, Coaching_position, Salary, Start_year, coaches.Team_name
				FROM coaches
				WHERE coaches.team_name = team_info.team_name;
			END;
		$$;
		
DROP FUNCTION team_info

SELECT *
FROM team_info('Eastern University')

SELECT *
FROM coaches

DELETE FROM coaches
WHERE coaching_id = 1110;

UPDATE coaches
SET position_coach = 'Defense'
WHERE coaching_id = 1111;

-- Each Players equipment
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1000', 'Stringking 2f', 'Warrior', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1100', 'Warrior Evo', 'Warrior', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1110', 'Maverick Havoc', 'Warrior', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1111', 'Warrior Evo', 'Warrior', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1112', 'Nike Lakota', 'Warrior', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1113', 'Nike Lakota', 'Warrior', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1114', 'Nike Lakota', 'Warrior', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1115', 'Warrior Evo', 'Warrior', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1116', 'Warrior Evo', 'Warrior', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1117', 'Nike Lakota', 'Warrior', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1118', 'Warrior Evo', 'Warrior', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1119', 'Maverick Tank', 'Warrior', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1120', 'Stx Goalie', 'Warrior', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1121', 'Warrior Evo', 'Warrior', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1122', 'Nike Lakota', 'Warrior', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1123', 'Nike Lakota', 'Warrior', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1124', 'Maverick Havoc', 'Warrior', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1125', 'Warrior Evo', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1126', 'Maverick Tank', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1127', 'Stx Goalie', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1128', 'Warrior Evo', 'Warrior', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1129', 'Warrior Evo', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1130', 'Maverick Havoc', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1131', 'Stringking 2d', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1132', 'Stringking 2d', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1133', 'Stringking 2d', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1134', 'Maverick Havoc', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1135', 'Stringking 2d', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1136', 'Nike Lakota', 'Warrior', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1137', 'Stringking 2d', 'Stx', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1139', 'Warrior Evo', 'Stx', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1140', 'Warrior Evo', 'Stx', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1141', 'Warrior Evo', 'Stx', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1142', 'Stx Surgeon', 'Stx', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1143', 'Nike Lakota', 'Stx', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1144', 'Warrior Evo', 'Stx', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1145', 'Warrior Evo', 'Stx', 'Small', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1146', 'Stx Surgeon', 'Stx', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1147', 'Stx Surgeon', 'Stx', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1148', 'Stringking 2f', 'Stx', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1149', 'Stx Surgeon', 'Stx', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1150', 'Nike Lakota', 'Stx', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1151', 'Nike Lakota', 'Stx', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1152', 'Maverick Havoc', 'Stx', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1153', 'Stx Surgeon', 'Stx', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1154', 'Maverick Havoc', 'Stx', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1155', 'Stx Surgeon', 'Stx', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1156', 'Warrior Evo', 'Stx', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1157', 'Maverick Havoc', 'Stx', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1158', 'Maverick Havoc', 'Stx', 'Large', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1159', 'Stx Goalie', 'Stx', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1160', 'Maverick Havoc', 'Evo', 'Large', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1161', 'Maverick Havoc', 'Evo', 'Small', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1162', 'Maverick Havoc', 'Evo', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1163', 'Stx Surgeon', 'Evo', 'Small', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1164', 'Maverick Havoc', 'Evo', 'Large', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1165', 'Stx Surgeon', 'Evo', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1166', 'Stx Surgeon', 'Evo', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1167', 'Stringking 2f', 'Evo', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1168', 'Stx Surgeon', 'Evo', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1169', 'Stx Surgeon', 'Evo', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1170', 'Maverick Havoc', 'Evo', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1171', 'Maverick Havoc', 'Evo', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1172', 'Stx Surgeon', 'Evo', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1173', 'Stx Surgeon', 'Evo', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1174', 'Nike Lakota', 'Evo', 'Large', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1175', 'Nike Lakota', 'Evo', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1176', 'Stx Goalie', 'Evo', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1177', 'Maverick Havoc', 'Maverick', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1178', 'Maverick Havoc', 'Maverick', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1179', 'Nike Lakota', 'Maverick', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1180', 'Nike Lakota', 'Maverick', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1181', 'Nike Lakota', 'Maverick', 'Small', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1182', 'Stx Surgeon', 'Maverick', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1183', 'Nike Lakota', 'Maverick', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1184', 'Stx Surgeon', 'Maverick', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1185', 'Maverick Havoc', 'Maverick', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1186', 'Maverick Havoc', 'Maverick', 'Large', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1187', 'Maverick Havoc', 'Maverick', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1189', 'Nike Lakota', 'Maverick', 'Small', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1190', 'Stringking 2f', 'Maverick', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1191', 'Maverick Havoc', 'Maverick', 'Small', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1192', 'Maverick Havoc', 'Maverick', 'Medium', 'Medium');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1193', 'Maverick Tank', 'Maverick', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1194', 'Maverick Tank', 'Maverick', 'Medium', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1195', 'Maverick Tank', 'Maverick', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1196', 'Stx Goalie', 'Maverick', 'Large', 'Large');
INSERT INTO equipment(player_id, stick, elbow_pads, gloves, helmet) VALUES('1197', 'Stx Goalie', 'Maverick', 'Large', 'Large');

SELECT stick, goals, player_name
FROM players
NATURAL INNER JOIN equipment
NATURAL INNER JOIN player_stats
WHERE equipment.stick = 'Stx Surgeon'

SELECT * 
FROM equipment

-- trainers at each school
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('11111', 'John Post', 'Eastern University', 'Head Athletic Trainer', '215-732-8999', 91000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('22222', 'Tristy Collin', 'Eastern University', 'Assistant Athletic Trainer', '610-735-2344', 63000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('33333', 'Arturo Gomez', 'Eastern University', 'Strength Trainer', '215-243-6234', 45000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('44444', 'Grady Sizemore', 'Stevenson University', 'Head Athletic Trainer', '610-253-9238', 82000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('55555', 'Amanda Glennan', 'Stevenson University', 'Assistant Athletic Trainer', '484-000-1244', 79000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('66666', 'Charlie Mizell', 'Stevenson University', 'Strength Trainer', '610-342-9238', 30000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('77777', 'Makayla Cox', 'Messiah University', 'Head Athletic Trainer', '215-111-0193', 72000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('88888', 'Analisa Year', 'Messiah University', 'Assistant Athletic Trainer', '610-293-0193', 50000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('99999', 'Brady Runner', 'Messiah University', 'Strength Trainer', '610-120-1236', 50000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('11112', 'Jarold Simons', 'York College of Pennsylvania', 'Head Athletic Trainer', '484-909-3617', 95000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('22223', 'Nathan Myers', 'York College of Pennsylvania', 'Assistant Athletic Trainer', '610-201-9999', 52000.00);
INSERT INTO trainers(trainer_id, trainer_name, team_name, training_position, trainers_phone_number, Salary) VALUES('33334', 'Ben Lynch', 'York College of Pennsylvania', 'Strength Trainer', '484-633-8111', 63000.00);


SELECT trainers.salary, teams.record, trainers.trainer_name, teams.team_name
FROM trainers NATURAL INNER JOIN teams
WHERE trainers.salary = (SELECT MAX(salary)
FROM trainers);

SELECT *
FROM trainers
WHERE trainer_id = '33333';

UPDATE trainers
SET salary = salary * 1.04
WHERE trainer_id = '33333';

