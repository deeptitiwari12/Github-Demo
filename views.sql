Infant_list

select user_id_sender,user_id_receiver,tm.infant_id,mother_name,gender,gestational_age,first_name,last_name,organization_name,
max(tl.trip_status_id),trip_log_id,tm.trip_id
from trip_master tm
left join infant_master im on im.infant_id=tm.infant_id
left join user_details ud on ud.user_id= tm.user_id_receiver
left join trip_log tl on tl.trip_id = tm.trip_id
where user_id_sender=27 group by tm.infant_id


--------------------------------------------------------
Infant_list with Vitals and frequency_record

select tm.user_id_receiver,
       organization_name,
      tm.trip_id ,
      im.mother_name,
     im.gestational_age ,
      gestational_age,gender,
      iv.vitals_id ,
      iv.vitals_value,
      fr.frequency,
     max( iv.created_on)


       from trip_master tm
        left join infant_master im on tm.infant_id = im.infant_id
        left join infant_vitals iv on iv.trip_id = tm.trip_id
        left join frequency_record fr on fr.trip_id = tm.trip_id
        left join user_details ud on ud.user_id=tm.user_id_receiver

        where tm.trip_id =39 group by iv.vitals_id

------------------------------------------------------------------------------

ASSIGN RECEIVER 
select tm.trip_id,tm.infant_id,mother_name,gender,gestational_age,
weight,chest_x_ray,suspected_sepsis,suspected_congenital_heart_defect,
duct_dependent_systemic,duct_dependent_pulmonary,noxious_stimuli,
sgpt,serum_cr,lactate,ventricular_dysfunction,has_vascular_access,
peripheral,feeding_tube,on_ventilator,on_ventilator_value,fio2
from trip_master tm
left join trip_details td on td.trip_id =tm.trip_id
left join infant_master im on im.infant_id=tm.infant_id
where tm.trip_id =39

-----------------------------------------------------------

ASSIGNED RECEIVER

select tm.trip_id,tm.infant_id,mother_name,gender,gestational_age,
weight,chest_x_ray,suspected_sepsis,suspected_congenital_heart_defect,
duct_dependent_systemic,duct_dependent_pulmonary,noxious_stimuli,
sgpt,serum_cr,lactate,ventricular_dysfunction,has_vascular_access,
peripheral,feeding_tube,on_ventilator,on_ventilator_value,fio2,first_name,last_name,organization_name,phone_no
from trip_master tm
left join trip_details td on td.trip_id =tm.trip_id
left join infant_master im on im.infant_id=tm.infant_id
left join user_details ud on ud.user_id=tm.user_id_receiver
left join user_master um on um.user_id=tm.user_id_receiver
where tm.trip_id =39
-----------------------------------------------------------------
Pending Transporter....


select tm.trip_id,tm.infant_id,mother_name,gender,gestational_age,
weight,
chest_x_ray,
suspected_sepsis,
suspected_congenital_heart_defect,
duct_dependent_systemic,
duct_dependent_pulmonary,
noxious_stimuli,
sgpt,
serum_cr,
lactate,
ventricular_dysfunction,
has_vascular_access,
peripheral,
right_ul,
right_ll,
left_ul,
left_ll,
central,
ijv,
femoral,
umbilical,
feeding_tube,
feeding_tube_value,
iv_fluids,
iv_fluids_value,
on_ventilator,
on_ventilator_value,
fio2,
et_tube_size,
not_ventilated_oxygen,
additional_notes,
ud.user_id sender_user_id,concat(ud.first_name, ud.last_name) sender_name,
ud.organization_name sender_organization_name,um.phone_no sender_phone_no,
ud1.user_id transporter_user_id,concat(ud1.first_name,ud1.last_name) transporter_name ,ud1.organization_name transporter_organization_name,um1.phone_no transporter_phone_no
from trip_master tm
left join trip_details td on td.trip_id =tm.trip_id
left join infant_master im on im.infant_id=tm.infant_id
left join user_details ud on ud.user_id=tm.user_id_sender
left join user_master um on um.user_id=tm.user_id_sender
left join user_details ud1 on ud.user_id=tm.user_id_transporter
left join user_master um1 on um.user_id=tm.user_id_transporter


-----------------------------------------------------------------------------
Contact Detail RECEIVER
DROP PROCEDURE IF EXISTS `neoport`.`Infant_list`;

DELIMITER $$

CREATE PROCEDURE `neoport`.`Infant_list` (
                                              IN i_user_type_id int(11),
                                              IN i_user_id int(11),
                                               OUT o_status int(1)
                                              )
BEGIN
  CASE i_user_type_id
    WHEN 1 THEN
        select tm.trip_id,user_id_receiver,user_id_receiver,tm.infant_id,mother_name,gender,gestational_age,first_name,last_name,organization_name,trip_status_id,trip_log_id from trip_master tm left join infant_master im on im.infant_id=tm.infant_id left join user_details ud on ud.user_id= tm.user_id_sender left join trip_log tl on tl.trip_id = tm.trip_id where user_id_receiver=i_user_id group by tm.infant_id;
        SET o_status = 1;
    WHEN 2 THEN
        select tm.trip_id,user_id_receiver,user_id_receiver,tm.infant_id,mother_name,gender,gestational_age,first_name,last_name,organization_name,trip_status_id,trip_log_id from trip_master tm left join infant_master im on im.infant_id=tm.infant_id left join user_details ud on ud.user_id= tm.user_id_sender left join trip_log tl on tl.trip_id = tm.trip_id where user_id_sender=i_user_id group by tm.infant_id;
        SET o_status = 2;
    WHEN 3 THEN
        select tm.trip_id,user_id_receiver,user_id_receiver,tm.infant_id,mother_name,gender,gestational_age,first_name,last_name,organization_name,trip_status_id,trip_log_id from trip_master tm left join infant_master im on im.infant_id=tm.infant_id left join user_details ud on ud.user_id= tm.user_id_sender left join trip_log tl on tl.trip_id = tm.trip_id where user_id_transporter=i_user_id group by tm.infant_id;
        SET o_status = 3;
        --END IF;
      ELSE
        BEGIN
            SET o_status = -1;
        END;
  END CASE;
END
-------------------------------------------------------------------------------

Single Query for all

select tm.trip_id,tm.infant_id,mother_name,gender,gestational_age,
weight,
chest_x_ray,
suspected_sepsis,
suspected_congenital_heart_defect,
duct_dependent_systemic,
duct_dependent_pulmonary,
noxious_stimuli,
sgpt,
serum_cr,
lactate,
ventricular_dysfunction,
has_vascular_access,
peripheral,
right_ul,
right_ll,
left_ul,
left_ll,
central,
ijv,
femoral,
umbilical,
feeding_tube,
feeding_tube_value,
iv_fluids,
iv_fluids_value,
on_ventilator,
on_ventilator_value,
fio2,
et_tube_size,
not_ventilated_oxygen,
additional_notes,
ud.user_id sender_user_id,concat(ud.first_name, ud.last_name) sender_name,ud.organization_name sender_organization_name,um.phone_no sender_phone_no,ud.photo sender_photo,
ud1.user_id transporter_user_id,concat(ud1.first_name,ud1.last_name) transporter_name ,ud1.organization_name transporter_organization_name,um1.phone_no transporter_phone_no,ud1.photo transporter_photo,
ud2.user_id receiver_user_id,concat(ud.first_name, ud.last_name) receiver_name,ud2.organization_name receiver_organization_name,um2.phone_no receiver_phone_no,ud2.photo receiver_photo,trip_status_id
from trip_master tm
left join trip_details td on td.trip_id =tm.trip_id
left join infant_master im on im.infant_id=tm.infant_id
left join user_details ud on ud.user_id=tm.user_id_sender
left join user_master um on um.user_id=tm.user_id_sender
left join user_details ud1 on ud.user_id=tm.user_id_transporter
left join user_master um1 on um.user_id=tm.user_id_transporter
left join user_details ud2 on ud.user_id=tm.user_id_receiver
left join user_master um2 on um.user_id=tm.user_id_receiver
left join trip_log tl on tl.trip_id = tm.trip_id
where tm.trip_id =2

select `tm`.`trip_id` AS `trip_id`,`tm`.`infant_id` AS `infant_id`,`im`.`mother_name` AS `mother_name`,`im`.`gender` AS `gender`,`im`.`gestational_age` AS `gestational_age`,`im`.`weight` AS `weight`,`td`.`chest_x_ray` AS `chest_x_ray`,`td`.`suspected_sepsis` AS `suspected_sepsis`,`td`.`suspected_congenital_heart_defect` AS `suspected_congenital_heart_defect`,`td`.`duct_dependent_systemic` AS `duct_dependent_systemic`,`td`.`duct_dependent_pulmonary` AS `duct_dependent_pulmonary`,`td`.`noxious_stimuli` AS `noxious_stimuli`,`td`.`sgpt` AS `sgpt`,`td`.`serum_cr` AS `serum_cr`,`td`.`lactate` AS `lactate`,`td`.`ventricular_dysfunction` AS `ventricular_dysfunction`,`td`.`has_vascular_access` AS `has_vascular_access`,`td`.`peripheral` AS `peripheral`,`td`.`right_ul` AS `right_ul`,`td`.`right_ll` AS `right_ll`,`td`.`left_ul` AS `left_ul`,`td`.`left_ll` AS `left_ll`,`td`.`central` AS `central`,`td`.`ijv` AS `ijv`,`td`.`femoral` AS `femoral`,`td`.`umbilical` AS `umbilical`,`td`.`feeding_tube` AS `feeding_tube`,`td`.`feeding_tube_value` AS `feeding_tube_value`,`td`.`iv_fluids` AS `iv_fluids`,`td`.`iv_fluids_value` AS `iv_fluids_value`,`td`.`on_ventilator` AS `on_ventilator`,`td`.`on_ventilator_value` AS `on_ventilator_value`,`td`.`fio2` AS `fio2`,`td`.`et_tube_size` AS `et_tube_size`,`td`.`not_ventilated_oxygen` AS `not_ventilated_oxygen`,`td`.`additional_notes` AS `additional_notes`,`ud`.`user_id` AS `sender_user_id`,concat(`ud`.`first_name`,`ud`.`last_name`) AS `sender_name`,`ud`.`organization_name` AS `sender_organization_name`,`um`.`phone_no` AS `sender_phone_no`,`ud1`.`user_id` AS `transporter_user_id`,concat(`ud1`.`first_name`,`ud1`.`last_name`) AS `transporter_name`,`ud1`.`organization_name` AS `transporter_organization_name`,`um1`.`phone_no` AS `transporter_phone_no`,`ud2`.`user_id` AS `receiver_user_id`,concat(`ud`.`first_name`,`ud`.`last_name`) AS `receiver_name`,`ud2`.`organization_name` AS `receiver_organization_name`,`um2`.`phone_no` AS `receiver_phone_no`,`tl`.`trip_status_id` AS `trip_status_id` from (((((((((`neoport`.`trip_master` `tm` left join `neoport`.`trip_details` `td` on((`td`.`trip_id` = `tm`.`trip_id`))) left join `neoport`.`infant_master` `im` on((`im`.`infant_id` = `tm`.`infant_id`))) left join `neoport`.`user_details` `ud` on((`ud`.`user_id` = `tm`.`user_id_sender`))) left join `neoport`.`user_master` `um` on((`um`.`user_id` = `tm`.`user_id_sender`))) left join `neoport`.`user_details` `ud1` on((`ud`.`user_id` = `tm`.`user_id_transporter`))) left join `neoport`.`user_master` `um1` on((`um`.`user_id` = `tm`.`user_id_transporter`))) left join `neoport`.`user_details` `ud2` on((`ud`.`user_id` = `tm`.`user_id_receiver`))) left join `neoport`.`user_master` `um2` on((`um`.`user_id` = `tm`.`user_id_receiver`))) left join `neoport`.`trip_log` `tl` on((`tl`.`trip_id` = `tm`.`trip_id`)))


------------------------------------------------------------------------------------------------------
For transporter add vitals

select frequency_id, frequency  from frequency_record fr join infant_vitals iv on fr.trip_id=(select trip_id from infant_vitals where infant_vitals_id= "+last_insert_id+") where fr.vitals_id=1 and fr.frequency='60' and iv.vitals_value < 97





INSERT INTO `infant_vitals`(`vitals_id`, `vitals_value`, `trip_id`, `user_id`, `created_on`) VALUES ?
update infant_vitals set vitals_id = ?, vitals_value = ?, trip_id = ? , user_id = ? ,created_on = ? where trip_id = ?;
--------------------------------------------------------------------------------------------------

select tm.user_id_receiver,tm.user_id_sender,tm.user_id_transporter,
um.user_type_id as receiver_type_id,um.user_type_id as sender_type_id,um.user_type_id as transporter_type_id,concat(ud.first_name,ud.last_name) as receiver_name,concat(ud.first_name,ud1.last_name)as sender_name,concat(ud.first_name,ud2.last_name) as transporter_name,ud.organization_name, tm.trip_id, im.mother_name, im.gestational_age, gender, iv.vitals_id, iv.vitals_value, fr.frequency,max( iv.created_on) as created_on from trip_master tm left join infant_master im on tm.infant_id = im.infant_id left join infant_vitals iv on iv.trip_id = tm.trip_id
left join frequency_record fr on fr.trip_id = tm.trip_id



left join user_details ud on ud.user_id=tm.user_id_receiver
left join user_master um on um.user_id=tm.user_id_receiver
left join user_details ud1 on ud1.user_id=tm.user_id_sender
left join user_master um1 on um1.user_id=tm.user_id_sender
left join user_details ud2 on ud2.user_id=tm.user_id_transporter
left join user_master um2 on um2.user_id=tm.user_id_transporter
where tm.trip_id = 2 group by iv.vitals_id

----------------------------------------------------------------------------------------------------

select dd.dosage ,dm.drug_name,dm.data_type,tm.trip_id,suspected_congenital_heart_defect,duct_dependent_systemic,duct_dependent_pulmonary,respiratory_status,on_ventilator_value,noxious_stimuli,additional_notes from trip_master tm left join trip_details td on td.trip_id = tm.trip_id left join drug_detail dd on dd.trip_id = tm.trip_id left join drug_master dm on dm.drug_id = dd.drug_id where tm.trip_id = 16


------------------------------------------------------------------------------------------------------

select tm.user_id_receiver,tm.user_id_sender,tm.user_id_transporter,um.user_type_id as receiver_type_id,
um1.user_type_id as sender_type_id,birth_time,um2.user_type_id as transporter_type_id,
concat(ud.first_name,' ',ud.last_name) as receiver_name,ud.location_lat as receiver_location_lat,
ud.location_long as receiver_location_long,concat(ud1.first_name,' ',ud1.last_name)as sender_name,
ud1.location_lat as sender_location_lat,ud1.location_long as sender_location_long,
concat(ud2.first_name,' ',ud2.last_name) as transporter_name,ud.organization_name,
um.phone_no as receiver_phone_no,um1.phone_no as sender_phone_no,um2.phone_no as transporter_phone_no,tm.trip_id,
 im.mother_name, im.gestational_age, gender, iv.vitals_id, iv.vitals_value, fr.frequency,
 max(iv.created_on) as created_on , FROM_UNIXTIME(max(iv.created_on)/1000),time_duration ,trip_status_id from trip_master tm
  left join infant_master im on tm.infant_id = im.infant_id
  left join infant_vitals iv on iv.trip_id = tm.trip_id
  left join frequency_record fr on fr.trip_id = tm.trip_id left join user_master um on um.user_id=tm.user_id_receiver left join user_details ud on ud.user_id=tm.user_id_receiver left join user_master um1 on um1.user_id=tm.user_id_sender left join user_details ud1 on ud1.user_id=um1.user_id left join user_master um2 on um2.user_id=tm.user_id_transporter left join user_details ud2 on ud2.user_id=tm.user_id_transporter left join vw_trip_location_status tls on tls.trip_id = tm.trip_id
left join vw_trip_status ts on ts.trip_id = tm.trip_id
where tm.trip_id = 2 group by iv.vitals_id asc


-------------------------------------------------------------------------------------------------------


CALL create_new_infant('parul',15161785,2,'F',6,1,1,1,1,1,1,'Withdraws, vigorously cries',9.0,8.0,8.0,1,1,1,0,0,0,1,1,0,0,0,1,'Orogastric',1,'Other','None or mild respiratory symptoms','SIMV',75,6,0,'notes','transporter_notes',@infant,@trip);
select @infant as infant_id, @trip as trip_id ;


-----------------------------------------------------------------------------------------------------------------------

 select drug_id from drug_master
 where drug_id < 7
 union
 (select drug_id
 from drug_master
 where drug_id in (select drug_id from drug_detail where trip_id = 177))

 -------------------------------------------------------------------------------------------------
select * from drug_master dm
left join drug_detail dd on dm.drug_id = dd.drug_id and trip_id = '1' where data_type = 'fixed'
or dm.drug_id in (select d.drug_id from drug_detail d left join drug_master m on m.drug_id = d.drug_id where trip_id = 1 and data_type = 'freetext' )
order by dm.drug_id


---------------------------------------------------------------------------------------------------------------

Sender o_status
select dd.dosage ,dd.drug_id,drug_type,dm.drug_name,dm.data_type,user_type,tm.trip_id,ifNull(fio2,0) as fio2,sgpt,serum_cr,lactate,ventricular_dysfunction,ifNull(suspected_congenital_heart_defect,0) as suspected_congenital_heart_defect,ifNull(duct_dependent_systemic,0) as duct_dependent_systemic,ifNull(duct_dependent_pulmonary,0) as duct_dependent_pulmonary,respiratory_status,ifNull(on_ventilator_value,0) as on_ventilator_value,noxious_stimuli,additional_notes from trip_master tm left join trip_details td on td.trip_id = tm.trip_id left join drug_detail dd on dd.trip_id = tm.trip_id 
left join drug_master dm on dm.drug_id = dd.drug_id where tm.trip_id = ? order by user_type



