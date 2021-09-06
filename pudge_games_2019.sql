SELECT 
matches.match_id, /*match id and primary key to tie everything together*/
matches.start_time, /*start time*/ 
matches.duration, /*duration in seconds*/
matches.radiant_win, /*radiant victory as BOOL*/
player_matches.hero_id, /*unique hero hero*/
player_matches.account_id, /*the player id associated with the match*/
match_patch.patch, /*patch of game*/
/*specify what side hero was on*/
CASE WHEN (player_matches.player_slot < 128) THEN 1 ELSE 0 END AS is_radiant
FROM matches
/*match_id column name is present in both tables being joined*/
JOIN match_patch USING(match_id)
JOIN player_matches using(match_id)
WHERE TRUE 
AND (player_matches.hero_id = 14) /* pudge id is 14*/
/*Patch 7.21 released on 29 Jan 2019*/
AND matches.start_time >= extract(epoch from timestamp '2019-01-29T00:00:00.000Z')
/*Patch 7.23e released on 14 Dec 2019*/
AND matches.start_time <= extract(epoch from timestamp '2019-12-14T00:00:00.000Z')