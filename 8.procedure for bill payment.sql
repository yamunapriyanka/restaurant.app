/*procedure for bill payment*/



DELIMITER $$

USE `yamuna_db`$$

DROP PROCEDURE IF EXISTS `bill_payment`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bill_payment`(IN ordernumber INT)
BEGIN
       UPDATE order_records SET bill_status='bill paid' WHERE order_id=ordernumber;
       
        END$$

DELIMITER ;