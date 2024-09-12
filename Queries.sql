-- The code below is finding each referee id name and games they have reffed, I made a new column game_count to show how many games they reffed.
SELECT r.referee_id, r.referee_name, COUNT(*) AS games_count
FROM referees r
JOIN GameSchedule gs ON r.referee_id = gs.referee_id
GROUP BY r.referee_id, r.referee_name;

-- This gives you the players who wear a large helmet from the equipment table.
SELECT DISTINCT Players.player_name
FROM Players
JOIN Equipment ON Players.player_id = Equipment.player_id
WHERE Equipment.helmet = 'Large';

-- When you look up players sometimes you want to know where they are from to see if you know people from that area. This queary gives you that ability.
SELECT player_name, from_before AS hometown
FROM Players;

-- This query looks up a certain stick and what player uses it and how many goals they have with it.
SELECT stick, goals, player_name
FROM players
NATURAL INNER JOIN equipment
NATURAL INNER JOIN player_stats
WHERE equipment.stick = 'Stx Surgeon'

-- For this query I was curious what trainer is making the most money and what their team record is.
SELECT trainers.salary, teams.record, trainers.trainer_name, teams.team_name
FROM trainers NATURAL INNER JOIN teams
WHERE trainers.salary = (SELECT MAX(salary)
FROM trainers);

-- This code finds all the players from everyteam and shows what players have the same number.
SELECT DISTINCT p1.Player_name, p1.Jersey_number, p1.team_name
FROM Players p1
JOIN Players p2 ON p1.Jersey_number = p2.Jersey_number AND p1.Player_id != p2.Player_id
ORDER BY p1.Jersey_number, p1.Player_name;

-- This query is giving me who has over 30 groundballs on the season. 
SELECT players.player_name, groundballs
FROM players INNER JOIN player_stats
WHERE player_stats.groundballs > 30

-- When people look at players and how many points they have, they sometimes look at who is the coach of that player is. That is why this shows who the coach is of players who have scored over 30 points
SELECT player_stats.points, players.player_name, teams.team_name, coaches.position_coach, coaches.coach_name
FROM player_stats
JOIN players ON player_stats.player_id = players.player_id
JOIN teams ON players.team_name = teams.team_name
JOIN coaches ON teams.team_name = coaches.team_name
WHERE player_stats.points > 30 AND coaches.position_coach = 'Offense';





