DELIMITER $$

ALTER ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `show_stock` AS 
SELECT
  `food_schedule`.`schedule_name` AS `schedule_name`,
  `food_menu`.`items`             AS `items`,
  (`food_feast`.`quantity` - SUM(`order_records`.`quantity`)) AS `remaining`
FROM (((`food_menu`
     JOIN `food_feast`
       ON ((`food_menu`.`id` = `food_feast`.`food_items`)))
    JOIN `food_schedule`
      ON ((`food_feast`.`schedule_id` = `food_schedule`.`id`)))
   JOIN `order_records`
     ON ((`food_feast`.`id` = `order_records`.`food_ordered`)))
WHERE (CAST(`order_records`.`order_date` AS DATE) = CURDATE())
GROUP BY `order_records`.`food_ordered`$$

DELIMITER ;