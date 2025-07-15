-- Finds the number of player transactions completed by each team

SELECT
  Team_From,
  COUNT(*) AS transaction_count
FROM
  Transactions
GROUP BY
  Team_From
ORDER BY
  transaction_count DESC;
