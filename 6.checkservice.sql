/*function to check service*/

DELIMITER $$

USE `yamuna_db`$$

DROP FUNCTION IF EXISTS `check_service`$$

CREATE DEFINER=`root`@`localhost` FUNCTION `check_service`() RETURNS INT(11)
BEGIN
   RETURN EXISTS(SELECT id FROM food_schedule WHERE CURTIME() BETWEEN from_time AND to_time);/*no service=0*/
   
   END$$

DELIMITER ; 