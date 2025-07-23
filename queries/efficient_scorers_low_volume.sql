-- Pulls the top 25 players with elite scoring efficiency despite low usage --

SELECT 
    a.Player,
    s.Team,
    s.G AS Games,
    s.MP AS Minutes,
    s.FGA AS FGA,
    s.PTS AS Points,
    ROUND(CAST(s.FGA AS FLOAT) / s.G, 2) AS FGA_per_game,
    ROUND(CAST(s.MP AS FLOAT) / s.G, 1) AS MPG,
    a.[TS%],
    s.[eFG%]
	
FROM 
    Player_Stats_Per_Game s
	
JOIN 
    Player_Advanced_Stats a ON s.Player = a.Player
	
WHERE 
    s.G >= 20  -- Filters out fringe players
    AND (CAST(s.FGA AS FLOAT) / s.G) <= 8  -- Low shot volume
    AND (CAST(s.MP AS FLOAT) / s.G) <= 25  -- Limited minutes
    AND a.[TS%] IS NOT NULL
    AND s.[eFG%] IS NOT NULL
	
ORDER BY 
    a.[TS%] DESC
LIMIT 25;
