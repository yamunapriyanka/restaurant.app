/*order cancel */


DELIMITER $$

USE `yamuna_db`$$

DROP PROCEDURE IF EXISTS `order_cancel`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `order_cancel`(IN ordernumber INT, IN foodname INT)
BEGIN
   
  UPDATE order_records SET order_status='cancelled' WHERE food_ordered=foodname AND order_id=ordernumber;
  SELECT 'your order is cancelled' AS message;
  END$$

DELIMITER ;