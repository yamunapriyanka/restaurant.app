DELIMITER $$
/* ordering 5 foods*/



USE `yamuna_db`$$

DROP PROCEDURE IF EXISTS `order_foods`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `order_foods`(IN food_list MEDIUMTEXT,IN qty MEDIUMTEXT,IN seat INT)
BEGIN
          DECLARE food_length_var TEXT DEFAULT NULL ;
          DECLARE q TEXT DEFAULT NULL;
          DECLARE qnext INT DEFAULT NULL;
          DECLARE foodlength INT DEFAULT NULL;
          DECLARE food_value TEXT DEFAULT NULL;
          DECLARE val TEXT DEFAULT NULL;
          DECLARE temp INT;
              SET temp = (LENGTH(food_list)-LENGTH(REPLACE(food_list,',',''))) + 1;
              IF temp<=5 THEN
          
         iterator :
         LOOP    
            IF LENGTH(TRIM(food_list)) = 0 OR food_list IS NULL THEN
              LEAVE iterator;
              END IF;
  
   
                 SET food_length_var = SUBSTRING_INDEX(food_list,',',1);
                SET q=SUBSTRING_INDEX(qty,',',1);
                 SET foodlength = LENGTH(food_length_var);
                 SET qnext = LENGTH(q);
                 SET food_value = TRIM(food_length_var);
                 SET val= TRIM(q);
                             SET food_list = INSERT(food_list,1,foodlength + 1,'');
                   SET qty = INSERT(qty,1,qnext + 1,'');
                   CALL order_food(seat,food_length_var,q);
                   
             END LOOP;
             SELECT order_id,seat_no,food_ordered FROM order_records WHERE seat_no=seat AND order_date=NOW();
             ELSE
             SELECT 'can order only 5 items' AS message;
             END IF;
                
    END$$

DELIMITER ;