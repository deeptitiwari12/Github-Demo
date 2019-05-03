select  mother_name,gestational_age,gender,iv.vitals_id,iv.vitals_value,iv.created_on from trip_master tm
left join infant_master im on tm.infant_id=im.infant_id
 join infant_vitals iv on  iv.trip_id=tm.trip_id
where tm.trip_id=38
and iv.created_on= (select max(created_on) from infant_vitals where trip_id=38  )order by iv.vitals_id


select `tm`.`trip_id` AS `trip_id`,`im`.`infant_id` AS `infant_id`,`im`.`mother_name` AS `mother_name`,`im`.`gender` AS `gender`,`im`.`gestational_age` AS `gestational_age`,`utm`.`user_type_desc` AS `user_type_desc`,`tsm`.`trip_status_text` AS `trip_status_text`,`im`.`created_on` AS `created_on`,`ud`.`organization_name` AS `organization_name` from ((((((`neoport`.`infant_master` `im` left join `neoport`.`trip_master` `tm` on((`tm`.`infant_id` = `im`.`infant_id`))) left join `neoport`.`user_details` `ud` on((`ud`.`user_id` = `tm`.`user_id_sender`))) left join `neoport`.`user_master` `um` on((`um`.`user_id` = `ud`.`user_id`))) left join `neoport`.`user_type_master` `utm` on((`utm`.`user_type_id` = `um`.`user_type_id`))) left join `neoport`.`trip_log` `tl` on((`tl`.`trip_id` = `tm`.`trip_id`))) 
  left join `neoport`.`trip_status_master` `tsm` on((`tsm`.`trip_status_id` = `tl`.`trip_status_id`)))










Historical Data for Sender

SELECT    `neoport`.`infant_master`.`infant_id`
 AS `infant_id`,`neoport`.`infant_master`.`mother_name`
AS `mother_name`,`neoport`.`infant_master`.`gestational_age`
 AS `gestational_age`,`neoport`.`infant_master`.`gender`
 AS `gender`,`tl_a`.`created_on`
 AS `trasporter_handover`,`tl_b`.`created_on`
 AS `receiver_handover`,concat(`ud_a`.`first_name`,' ',`ud_a`.`last_name`)
 AS `sender_name`,`um_a`.`phone_no` AS `sender_phone_no`,`um_a`.`user_id`
 AS `sender_id`,`ud_a`.`organization_name`
 AS `sender_organization_name`,`ud_a`.`photo`
 AS `sender_photo`,concat(`ud_b`.`first_name`,' ',`ud_b`.`last_name`)
 AS `transporter_name`,`um_b`.`phone_no`
 AS `transporter_phone_no`,`um_b`.`user_id`
 AS `transporter_id`,`ud_b`.`organization_name`
 AS `transporter_organization_name`,`ud_b`.`photo`
 AS `transporter_photo`
FROM    trip_master
          left JOIN infant_master ON trip_master.infant_id = infant_master.infant_id
          left join trip_log tl_a on trip_master.trip_id=tl_a.trip_id and tl_a.trip_status_id='6'
          left join trip_log tl_b on trip_master.trip_id=tl_b.trip_id and tl_b.trip_status_id='8'
          left JOIN user_details ud_a ON trip_master.user_id_sender = ud_a.user_id
          left join user_details ud_b on trip_master.user_id_transporter=ud_b.user_id
          left JOIN user_master um_a ON trip_master.user_id_sender = um_a.user_id
          left join user_master um_b on trip_master.user_id_receiver=um_b.user_id
where infant_master.infant_id =75;



 
SELECT mother_name,gestational_age,gender,
  tl_a.created_on as trasporter_handover,
  tl_b.created_on as receiver_handover,
  concat(ud_a.first_name,' ',ud_a.last_name) as sender_name,
  um_a.phone_no as sender_phone_no,
  um_a.user_id as sender_id,
  ud_a.organization_name as sender_organization_name,
  ud_a.photo as sender_photo,
  concat(ud_b.first_name,' ',ud_b.last_name) as transporter_name,
  um_b.phone_no as transporter_phone_no,
   um_b.user_id as transporter_id,
  ud_b.organization_name as transporter_organization_name,
  ud_b.photo as transporter_photo
FROM    trip_master
          left JOIN infant_master ON trip_master.infant_id = infant_master.infant_id
          left join trip_log tl_a on trip_master.trip_id=tl_a.trip_id and tl_a.trip_status_id='6'
          left join trip_log tl_b on trip_master.trip_id=tl_b.trip_id and tl_b.trip_status_id='8'
          left JOIN user_details ud_a ON trip_master.user_id_sender = ud_a.user_id
          left join user_details ud_b on trip_master.user_id_transporter=ud_b.user_id
          left JOIN user_master um_a ON trip_master.user_id_sender = um_a.user_id
          left join user_master um_b on trip_master.user_id_transporter=um_b.user_id
where trip_master.trip_id =75;



create view detail_for_sender as
SELECT mother_name,gestational_age,gender,
  tl_a.created_on as trasporter_handover,
  tl_b.created_on as receiver_handover,
  concat(ud_a.first_name,' ',ud_a.last_name) as sender_name,
  um_a.phone_no as receiver_phone_no,
  um_a.user_id as receiver_id,
  ud_a.organization_name as receiver_organization_name,
  ud_a.photo as receiver_photo,
  concat(ud_b.first_name,' ',ud_b.last_name) as transporter_name,
  um_b.phone_no as transporter_phone_no,
   um_b.user_id as transporter_id,
  ud_b.organization_name as transporter_organization_name,
  ud_b.photo as transporter_photo
FROM    trip_master
          left JOIN infant_master ON trip_master.infant_id = infant_master.infant_id
          left join trip_log tl_a on trip_master.trip_id=tl_a.trip_id and tl_a.trip_status_id='6'
          left join trip_log tl_b on trip_master.trip_id=tl_b.trip_id and tl_b.trip_status_id='8'
          left JOIN user_details ud_a ON trip_master.user_id_receiver = ud_a.user_id
          left join user_details ud_b on trip_master.user_id_transporter=ud_b.user_id
          left JOIN user_master um_a ON trip_master.user_id_receiver = um_a.user_id
          left join user_master um_b on trip_master.user_id_transporter=um_b.user_id
where infant_master.infant_id =75;



 select tm.trip_id,vm.vitals_id,vm.vitals_name,iv.vitals_value
   from infant_vitals iv
   left join vitals_master vm
   on vm.vitals_id=iv.vitals_id
   left join trip_master tm
   on tm.trip_id=iv.trip_id
   where tm.trip_id =23;


   create view profile as select photo,first_name,last_name,user_type_desc,phone_no,email,organization_name,is_available
   from user_details ud
   left join user_master um
   on um.user_id=ud.user_id
   left join user_type_master utm
   on utm.user_type_id=um.user_type_id
   --where um.user_id =13;




   create view as SELECT im.infant_id,mother_name,gender,gestational_age,user_type_desc ,tsm.trip_status_text

,ud.organization_name
 FROM infant_master im
left join trip_master tm on tm.infant_id=im.infant_id
left join user_details ud on ud.user_id=tm.user_id_sender
left join user_master um on um.user_id=ud.user_id
left join user_type_master utm on utm.user_type_id=um.user_type_id
left join trip_log tl on tl.trip_id=tm.trip_id
left join trip_status_master tsm on tsm.trip_status_id=tl.trip_status_id
where im.infant_id =60
select `neoport`.`trip_master`.`trip_id` AS `trip_id`,`neoport`.`infant_master`.`infant_id`
 AS `infant_id`,`neoport`.`infant_master`.`mother_name` 
 AS `mother_name`,`neoport`.`infant_master`.`gestational_age` 
 AS `gestational_age`,`neoport`.`infant_master`.`gender`
  AS `gender`,`tl_a`.`created_on` AS `trasporter_handover`,`tl_b`.`created_on` 
  AS `receiver_handover`,concat(`ud_a`.`first_name`,' ',`ud_a`.`last_name`) AS `sender_name`,`um_a`.`phone_no` AS `receiver_phone_no`,`um_a`.`user_id` AS `receiver_id`,`ud_a`.`organization_name` AS `receiver_organization_name`,`ud_a`.`photo` AS `receiver_photo`,concat(`ud_b`.`first_name`,' ',`ud_b`.`last_name`) AS `transporter_name`,`um_b`.`phone_no` AS `transporter_phone_no`,`um_b`.`user_id` AS `transporter_id`,`ud_b`.`organization_name` AS `transporter_organization_name`,`ud_b`.`photo` AS `transporter_photo` from (((((((`neoport`.`trip_master` left join `neoport`.`infant_master` on((`neoport`.`trip_master`.`infant_id` = `neoport`.`infant_master`.`infant_id`))) left join `neoport`.`trip_log` `tl_a` on(((`neoport`.`trip_master`.`trip_id` = `tl_a`.`trip_id`) and (`tl_a`.`trip_status_id` = '6')))) left join `neoport`.`trip_log` `tl_b` on(((`neoport`.`trip_master`.`trip_id` = `tl_b`.`trip_id`) and (`tl_b`.`trip_status_id` = '8')))) left join `neoport`.`user_details` `ud_a` on((`neoport`.`trip_master`.`user_id_receiver` = `ud_a`.`user_id`))) left join `neoport`.`user_details` `ud_b` on((`neoport`.`trip_master`.`user_id_transporter` = `ud_b`.`user_id`))) left join `neoport`.`user_master` `um_a` on((`neoport`.`trip_master`.`user_id_receiver` = `um_a`.`user_id`))) left join `neoport`.`user_master` `um_b` on((`neoport`.`trip_master`.`user_id_transporter` = `um_b`.`user_id`)))

select `tm`.`trip_id` AS `trip_id`,`tm`.`user_id_sender` 
AS `user_id_sender`,`tm`.`user_id_transporter` 
AS `user_id_transporter`,`tm`.`infant_id` 
AS `infant_id`,`um`.`user_type_id` 
AS `user_type_id`,`um`.`user_id`
 AS `user_id`,`um`.`phone_no` AS `phone_no`,`ud`.`first_name` 
 AS `first_name`,`ud`.`last_name` AS `last_name`,`ud`.`organization_name` 
 AS `organization_name`,`ud`.`photo` AS `photo`,`im`.`birth_time`
  AS `birth_time`,`im`.`weight` AS `weight`,`im`.`gender` 
  AS `gender`,`im`.`gestational_age` AS `gestational_age`,`td`.`suspected_sepsis` 
  AS `suspected_sepsis`,`td`.`suspected_congenital_heart_defect` 
  AS `suspected_congenital_heart_defect`,`td`.`duct_dependent_systemic` 
  AS `duct_dependent_systemic`,`td`.`duct_dependent_pulmonary` 
  AS `duct_dependent_pulmonary`,`td`.`noxious_stimuli` 
  AS `noxious_stimuli`,`td`.`sgpt` AS `sgpt`,`td`.`serum_cr` 
  AS `serum_cr`,`td`.`lactate` AS `lactate`,`td`.`ventricular_dysfunction` 
  AS `ventricular_dysfunction`,`td`.`has_vascular_access`
   AS `has_vascular_access`,`td`.`peripheral` AS `peripheral`,`td`.`right_ul`
    AS `right_ul`,`td`.`right_ll` AS `right_ll`,`td`.`left_ul` 
    AS `left_ul`,`td`.`left_ll` AS `left_ll`,`td`.`central` AS `central`,`td`.`ijv`
     AS `ijv`,`td`.`femoral` AS `femoral`,`td`.`umbilical` 
     AS `umbilical`,`td`.`feeding_tube` AS `feeding_tube`,`td`.`feeding_tube_value`
      AS `feeding_tube_value`,`td`.`iv_fluids` AS `iv_fluids`,`td`.`iv_fluids_value` 
      AS `iv_fluids_value`,`td`.`on_ventilator` AS `on_ventilator`,`td`.`on_ventilator_value`
      AS `on_ventilator_value`,`td`.`fio2` AS `fio2`,`td`.`et_tube_size` 
      AS `et_tube_size`,`td`.`not_ventilated_oxygen`
       AS `not_ventilated_oxygen`,`td`.`additional_notes` AS `additional_notes` 
       from ((((`neoport`.`trip_master` `tm` 
        left join `neoport`.`user_master` `um` on(((`um`.`user_id` = `tm`.`user_id_sender`) 
          or (`um`.`user_id` = `tm`.`user_id_sender`))))
           left join `neoport`.`user_details` `ud` on((`um`.`user_id` = `ud`.`user_id`))) 
       left join `neoport`.`infant_master` `im` on((`tm`.`infant_id` = `im`.`infant_id`))) 
  left join `neoport`.`trip_details` `td` on((`td`.`trip_id` = `tm`.`trip_id`)))