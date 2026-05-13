-- Sourced from Verizon - Medium
-- https://datalemur.com/questions/international-call-percentage

SELECT 
  ROUND(
    100.0*SUM(
      CASE 
        WHEN pi.country_id != pi2.country_id
        THEN 1 ELSE 0
      END
    )/COUNT(ph.caller_id), 1
  ) AS international_calls_pct
FROM phone_calls ph 
INNER JOIN phone_info pi ON ph.caller_id = pi.caller_id
INNER JOIN phone_info pi2 ON ph.receiver_id = pi2.caller_id
