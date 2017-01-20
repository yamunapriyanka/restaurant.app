DELIMITER $$

USE `yamuna_db`$$



CREATE DEFINER=`root`@`localhost` PROCEDURE `order_food`( IN seatnumber INT, IN fooditem VARCHAR(100), IN qty INT)
BEGIN
    DECLARE f_id INT;
    DECLARE flag INT;
    DECLARE var INT;
    DECLARE Noservice INT; 
    DECLARE temp INT;
    DECLARE quan_var INT;
    DECLARE remaining_qty INT;
    DECLARE AMOUNT_REQ INT;
    DECLARE remainingfood INT;
    SELECT check_service() INTO Noservice;
    IF Noservice=1 THEN
    SELECT food_feast.id INTO f_id FROM food_menu JOIN food_feast ON food_feast.food_items=food_menu.id JOIN food_schedule ON food_feast.`schedule_id`=food_schedule.id
    WHERE food_menu.items=fooditem AND CURTIME() BETWEEN food_schedule.from_time AND food_schedule.to_time;
     
IF EXISTS(SELECT id FROM seat_availability WHERE seat_no=seatnumber) THEN
IF EXISTS(SELECT id FROM food_menu WHERE items=fooditem) THEN
IF fooditem IN(SELECT food_ordered FROM order_records WHERE order_date=CURDATE()) THEN
   SELECT SUM(quantity) INTO temp FROM order_records WHERE food_ordered=f_id AND order_status='granted' AND bill_status='bill paid';
   SELECT quantity INTO quan_var FROM food_feast WHERE food_items=f_id;
   SET remaining_qty= quan_var-temp;
ELSE
	SELECT quantity INTO AMOUNT_REQ FROM food_feast WHERE food_items=f_id;
	SET remainingfood=AMOUNT_REQ;
 END IF;
 IF (qty>remainingfood) THEN
	SELECT 'we do not have sufficient food' AS message;
 ELSE 
INSERT INTO order_records (seat_no,food_ordered,quantity) VALUES (seatnumber,fooditem,qty);
  SELECT 'food ordered' AS message;
  END IF;
     SELECT id INTO flag FROM food_menu WHERE items=f_id;
     SELECT schedule_id INTO var FROM food_feast WHERE food_items=flag;
     IF var IN (SELECT id INTO var FROM food_schedule WHERE from_time<=CURTIME() AND to_time>=CURTIME())THEN
     CALL remaining(flag,qty,seatnumber);
     ELSE
     SELECT 'your ordered item is beyond the time limits' AS message;
     END IF;
     ELSE
     SELECT 'ordered food is not available' AS message;
     END IF;
     ELSE
     SELECT 'please enter a valid seat from 1 to 10' AS message;
     END IF;
     ELSE
     SELECT 'service is not provided at this time' AS message;
     END IF;
     END$$

DELIMITER ;