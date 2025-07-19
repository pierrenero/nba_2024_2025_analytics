-- Finds heave stats by player --

SELECT
  Player,
  SUM(HeavesAtt) AS Total_Heaves_Attempted,
  SUM(HeavesMd) AS Total_Heaves_Md,
  ROUND(CAST(SUM(HeavesMd) AS FLOAT) / NULLIF(SUM(HeavesAtt), 0), 3) AS Heave_Pct
  
FROM
  Player_Shooting_Advanced
  
GROUP BY
  Player
  
ORDER BY
  Total_Heaves_Md DESC;
