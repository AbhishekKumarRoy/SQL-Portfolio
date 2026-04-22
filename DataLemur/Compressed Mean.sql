# Sourced from Alibaba - Easy
# https://datalemur.com/questions/alibaba-compressed-mean

SELECT 
  ROUND(
    # Casting the item_count to decimal because both the fields are integer. To avoid getting the result as integer using ::DECIMAL
    SUM(item_count::DECIMAL * order_occurrences)/SUM(order_occurrences) 
  , 1) AS mean
FROM items_per_order;
