--Pulls players with high scoring efficiency, but low usage--

WITH RankedStats AS (
    SELECT 
        s.Player,
        ROUND(s."eFG%", 3) AS eFG_Percentage,-- Effective Field Goal % (adjusts for 3-point shots being worth more)
        ROUND(a."TS%", 3) AS TS_Percentage,-- True Shooting % (accounts for 2s, 3s, and free throws)
        CAST(s.FGA AS FLOAT) / s.G AS FGA_per_game,-- Field Goal Attempts per game
        s."MP" AS MP_per_game,-- Minutes played per game
        ROW_NUMBER() OVER (PARTITION BY s.Player ORDER BY a."TS%" DESC) AS rn -- Ranks each stint (team) per player, keeping the one with the highest TS%
  
    FROM 
        Player_Stats_Per_Game s
  
    JOIN 
        Player_Advanced_Stats a ON s.Player = a.Player
  
    WHERE 
        s.G >= 20 -- Only includes players who played at least 20 games
        AND (CAST(s.FGA AS FLOAT) / s.G) <= 8 -- Only includes players who shoot 8 or fewer times per game
        AND s."MP" <= 20 -- Only includes players who average 20 minutes or less per game
        )

--Selects only the best stint per player (rn = 1), so no duplicates
SELECT Player, eFG_Percentage, TS_Percentage, FGA_per_game, MP_per_game
FROM RankedStats
WHERE rn = 1
ORDER BY TS_Percentage DESC
LIMIT 20;


