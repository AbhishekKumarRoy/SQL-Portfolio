# Sourced from Snapchat - Medium
# https://datalemur.com/questions/time-spent-snaps
# There are two solutions, one with CASE and another with FILTER

# CASE  
SELECT 
  ab.age_bucket,
  ROUND(100.0 * SUM(
    CASE 
      WHEN activity_type = 'send' 
      THEN time_spent ELSE 0 
    END
  )/SUM(time_spent), 2) AS send_perc,
  ROUND(100.0 * SUM(
    CASE 
      WHEN activity_type = 'open' 
      THEN time_spent ELSE 0 
    END
  )/SUM(time_spent), 2) AS open_perc
FROM activities a
INNER JOIN age_breakdown ab ON a.user_id = ab.user_id
WHERE activity_type IN ('send', 'open')
GROUP BY ab.age_bucket;

---

# FILTER
SELECT 
  age.age_bucket, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'send')/
    SUM(activities.time_spent),2) AS send_perc, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'open')/
    SUM(activities.time_spent),2) AS open_perc
FROM activities
INNER JOIN age_breakdown AS age 
  ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket;
