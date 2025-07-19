SELECT
  SUM(HeavesAtt) AS Total_Heaves_Attempted,
  SUM(HeavesMd) AS Total_Heaves_Made,
  SUM(HeavesMd) * 3 AS Total_Points_From_Heaves,
  ROUND(CAST(SUM(HeavesMd) AS FLOAT) / NULLIF(SUM(HeavesAtt), 0), 3) AS Heave_Success_Rate
  
FROM
  Player_Shooting_Advanced;
