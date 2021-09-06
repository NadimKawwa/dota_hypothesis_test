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
/*Patch 7.24 released on 26 Jan 2020*/
AND matches.start_time >= extract(epoch from timestamp '2020-01-27T00:00:00.000Z')
/*Patch 7.28 released on 17 Dec 2020, aghanim's shard and hoodwink introduced*/
AND matches.start_time <= extract(epoch from timestamp '2020-12-17T00:00:00.000Z')