CREATE OR REPLACE FUNCTION house_staff() RETURNS TRIGGER AS $works_block$
    BEGIN
        INSERT INTO  works_in(hid,block_no)values(new.hid,'B1');
        RETURN NEW;
    END;
$works_block$ LANGUAGE plpgsql;


CREATE TRIGGER works_block AFTER INSERT ON housekeeping_staff 
FOR EACH ROW EXECUTE PROCEDURE house_staff();



insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0028','Surya',59,'NO.65,Vidyapeetha','M','Transportation',9007000897);




CREATE OR REPLACE FUNCTION nurses_takes() RETURNS TRIGGER AS $care_taker$
    BEGIN
        INSERT INTO takescare(bed_no,nid)values(new.bed_no,'NR0015');
        UPDATE patients set admit_date=current_timestamp where bed_no=new.bed_no;
        RETURN NEW;
    END;
$care_taker$ LANGUAGE plpgsql;


CREATE TRIGGER care_taker AFTER INSERT ON patients 
FOR EACH ROW EXECUTE PROCEDURE nurses_takes();


insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,block_no,did)values('BD0032','Leela',60,'NO.564,2nd stage,Jayanagar','F',9611862581,'Y','A3','DC0008');


/*drop TRIGGER care_taker on patients;
drop TRIGGER  works_block on  housekeeping_staff; */