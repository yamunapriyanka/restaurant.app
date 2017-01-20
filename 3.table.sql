create table `food_schedule` (
	`id` int (11),
	`schedule_name` varchar (300),
	`from_time` time ,
	`to_time` time ,
	`quantity` int (11)
); 
insert into `food_schedule` (`id`, `schedule_name`, `from_time`, `to_time`, `quantity`) values('1','breakfast','08:00:00','11:00:00','100');
insert into `food_schedule` (`id`, `schedule_name`, `from_time`, `to_time`, `quantity`) values('2','lunch','11:15:00','15:00:00','75');
insert into `food_schedule` (`id`, `schedule_name`, `from_time`, `to_time`, `quantity`) values('3','refreshment','15:15:00','23:00:00','200');
insert into `food_schedule` (`id`, `schedule_name`, `from_time`, `to_time`, `quantity`) values('4','dinner','19:00:00','23:00:00','100');
