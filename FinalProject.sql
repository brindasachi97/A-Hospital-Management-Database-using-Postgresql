create database hospitaldb;
\c hospitaldb

create table doctors
	(did varchar(6),
	 name varchar(120),
	 age     numeric(3),
	 address 		varchar(120),
	 salary integer,
	 sex	 	varchar(1) check (sex in ('F','M')),
	 specialization   varchar(30) ,
	 phone_no		 numeric(10,0),
	 avail  varchar(120),
	 consult  varchar(1)   check (consult in ('Y','N')) ,
	 primary key (did)
	);
	
	
	
create table nurses
	(nid	 	varchar(6),
	 name	 		varchar(120),
	 age     numeric(3),
	 address	 	varchar(120),
	 salary integer,
	 sex		 varchar(1) check (sex in ('F','M')),
	 qualification   varchar(30) ,
	 phone_no		 numeric(10,0),
	 did  varchar(6),
	 primary key (nid) , foreign key(did) references doctors(did) 
	);
	
	
	
create table managerial_staff
	(mid	 	varchar(6),
	 name	 		varchar(120),
	 age     numeric(3),
	 address	 	varchar(120),
	 salary integer,
	 sex		 varchar(1) check (sex in ('F','M')),
	 cader   varchar(30) ,
	 phone_no	 	numeric(10,0),
	 primary key (mid)
	);
	
	
	
create table facilities
	(code		 varchar(6),
	 name		 	varchar(120),
	 price  numeric(7,0),
	 facility_availability  varchar(120),
	 primary key (code)
	);

	
create table building
	(block_no  varchar(2),
	no_wards integer , 
	no_beds integer,
	coordinator varchar(6),
	bed_avail integer,
	 primary key (block_no) , foreign key(coordinator) references managerial_staff(mid)
	);
		
	
create table patients
	(bed_no	 	varchar(6),
	 name	 		varchar(120),
	 age     numeric(3),
	 address 		varchar(120),
	 sex	 	varchar(1) check (sex in ('F','M')),
	 phone_no	 	numeric(10,0),
	 prev_stay  varchar(1) check (prev_stay in ('Y','N')),
	 admit_date  date ,
	 block_no      varchar(2),
	 did  varchar(6),
	 primary key (bed_no) , foreign key(did) references doctors(did), 
	 foreign key(block_no) references building(block_no)
	 );
	
	
	
	
create table housekeeping_staff
	(hid        varchar(6),
	 name		 	varchar(120),
	 age     numeric(3),
	 address	 	varchar(120),
	 sex		 varchar(1) check (sex in ('F','M')),
	 cader   varchar(30) ,
	 phone_no	 	numeric(10,0),
	 primary key (hid)
	);
	
	
create table accounts
	(acc_no varchar(12),
	payment varchar(120),
	bed_no varchar(6),
	amount integer,
    primary key (acc_no),
	 foreign key(bed_no) references patients(bed_no)
	);	
	
	
	create table pharmacy
	(pcode varchar(6),
	 medicine_name varchar(120),
	 stock varchar(10),
	 price_per_unit integer,
	
	 primary key (pcode)
	 );
	
	
	create table treatment
	(tid varchar(6),
	disease varchar(50),
	symptoms varchar(120),
	diagnosis varchar(120),
	treatment varchar(120),
	spcode varchar(6),
primary key (tid) , foreign key(spcode) references pharmacy(pcode) );
	
	
create table consult_patients
	(app_no	 	varchar(6),
	 name	 		varchar(120),
	 age     numeric(3),
	 address	 	varchar(120),
	 sex		 varchar(1) check (sex in ('F','M')),
	 phone_no	 	numeric(10,0),
	 tid  varchar(6),
	 primary key (app_no) , foreign key(tid) references treatment(tid)
	 );
	
create table takescare
	(bed_no varchar(6),
	nid varchar(6),
	 primary key (bed_no,nid) , foreign key(bed_no) references patients(bed_no) , foreign key(nid) references nurses(nid)
	 );
	 
	 
create table manage
	(acc_no varchar(12),
	mid varchar(6),
	 primary key (acc_no,mid) , foreign key(acc_no) references accounts(acc_no) , foreign key(mid) references managerial_staff(mid)
	 );
	 
	 
	 
create table dperformst
	(did varchar(6),
	tid varchar(6),
	 primary key (did,tid) , foreign key(did) references doctors(did) , foreign key(tid) references treatment(tid)
	 );
	 
	 
	 
create table requirement
	(tid varchar(6),
	code varchar(6),
	 primary key (tid,code) , foreign key(tid) references treatment(tid) , foreign key(code) references facilities(code)
	 );
	 
create table pundergoest
	(tid varchar(6),
	bed_no varchar(6),
	opdate date,
	 primary key (tid,bed_no) , foreign key(tid) references treatment(tid) , foreign key(bed_no) references patients(bed_no)
	 );
	 
	 
create table works_in
	(hid varchar(6),
	block_no varchar(6),
	 primary key (hid,block_no) , foreign key(hid) references housekeeping_staff(hid) , foreign key(block_no) references building(block_no)
	 );
	 
create table cpundergoest
	(app_no varchar(6),
	tid varchar(6),
	 primary key (tid,app_no) , foreign key(tid) references treatment(tid) , foreign key(app_no) references consult_patients(app_no)
	 );



/*DOCTORS*/
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0001','Dhanush',30,'NO.128,2nd block,Jayanagar',200000,'M','Cardiology',9800712345,'Wednesday,9AM to 1PM','Y');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0002','Kavya',28,'NO.271,5th stage,Vidyapeeta',100000,'F','Dentistry',8657054321,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0003','Geetha',35,'NO.768,4th phase,JPNagar',250000,'F','Gynaecology',9447265490,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0004','Latha',38,'NO.561,3rd main,Bannerghatta',300000,'F','Oncology',7788128967,'Monday to Wednesday,10AM to 2PM','Y');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0005','Rakshith',40,'NO.72,2nd cross,Kathriguppe',120000,'M','Gastroenterology',8937169043,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0006','Gautham',45,'NO.360,3rd stage,Malleshwaram',280000,'M','Physician',9848809555,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0007','Varun',33,'NO.429,1st phase,VijayNagar',200000,'M','Radiology',9884099356,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0008','Keerthi',39,'NO.400,3rd cross,RajajiNagar',50000,'F','Psychiatry',7998169111,'Thursday to Saturday,11AM to 5PM','Y');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0009','Kalavathi',41,'NO.89,4th stage,Magadi',500000,'F','Neurology',8667799340,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0010','Ravi',49,'NO.108,5th main,Ramnagar',100000,'M','Dermatology',997213467,'Friday to Sunday,3PM to 6PM','Y');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0011','Srinivasan',52,'NO.221,4th block,Electronic City',80000,'M','Gastroenterology',7664578901,'Thursday to Saturday,9AM to 4PM','Y');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0012','Anand',47,'NO.399,3rd stage,Hoskote',150000,'M','Nephrology',8881129801,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0013','Renuka',40,'NO.465,2nd phase,BTM Layout',140000,'F','Gynaecology',997230943,'Thursday to Sunday,11AM to 2PM','Y');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0014','Venkatesh',50,'NO.201,7th stage,PadmanabhNagar',200000,'M','Radiology',7651239087,'Tuesday,10AM to 2PM','Y');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0015','Ramesh',61,'NO.890,2nd cross,Whitefield',100000,'M','Physician',7722133445,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0016','Suresh',52,'NO.567,3rd block,IndiraNagar',90000,'M','Dentistry',8178978917,'Thursday to Sunday,3PM to 8PM','Y');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0017','Vijaya',44,'NO.699,6th phase,ShivajiNagar',200000,'F','Surgery',8657054321,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0018','Ram',26,'NO.245,9th cross,MGRoad',300000,'M','General Practitioner',8999911222,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0019','Satish',50,'NO.488,3rd cross,Ulsoor',500000,'M','Cardiology',9446098761,'All days,9AM to 6PM','N');
insert into doctors(did,name,age,address,salary,sex,specialization,phone_no,avail,consult)values('DC0020','Lakshmi',42,'NO.765,2nd phase,Majestic',280000,'F','Pediatrician',9988899900,'All days,9AM to 6PM','N');

/*NURSES*/
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0001','Aruna',30,'NO.123,3rd stage,Banashankari',50000,'F','ADN',9611862581,'DC0006');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0002','Manjunath',24,'NO.571,3rd main,Bannerghatta',10000,'M','ADN',9571866580,'DC0010');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0003','Rashmi',28,'NO.756,3rd block,IndiraNagar',25000,'F','ADN',9414862584,'DC0008');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0004','Shobha',32,'NO.732,2nd cross,Kathriguppe',30000,'F','BSN',9391562581,'DC0002');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0005','Prajwal',22,'NO.698,6th phase,ShivajiNagar',40000,'M','BSN',9641865583,'DC0003');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0006','Anand',29,'NO.698,3rd phase,JPNagar',35000,'M','ADN',9964627807,'DC0006');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0007','Bhuvana',32,'NO.554,4th block,Electronic City',90000,'F','BSN',9621780612,'DC0004');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0008','Varsha',34,'NO.221,3rd stage,Hoskote',32000,'F','ADN',9611843114,'DC0008');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0009','Anil',30,'NO.878,1st phase,VijayNagar',15000,'M','ADN',9611853197,'DC0001');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0010','Naveen',36,'NO.183,3rd block,Jayanagar',42000,'M','BSN',9863328907,'DC0019');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0011','Roshni',33,'NO.249,9th cross,MGRoad',28000,'F','BSN',9097126795,'DC0020');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0012','Tanya',31,'NO.443,2nd phase,BTM Layout',35000,'F','BSNN',9746793578,'DC0007');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0013','Ravi',26,'NO.438,3rd cross,Ulsoor',30000,'M','ADN',9215790764,'DC0012');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0014','Lavanya',25,'NO.765,2nd phase,Majestic',50000,'F','BSN',9097257904,'DC0015');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0015','Uma',24,'NO.200,7th stage,PadmanabhNagar',70000,'F','ADN',9468904257,'DC0011');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0016','Gagan',28,'NO.123,5th cross,Koramangala',30000,'M','ADN',9458901276,'DC0018');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0017','Mahesh',27,'NO.163,3rd cross,BasaveshwarNagar',55000,'M','BSN',9613680954,'DC0019');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0018','Dhanush',31,'NO.545,4th block,Rajajinagar',62000,'M','BSN',9967542345,'DC0007');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0019','Harish',30,'NO.193,7th cross,Ejipura',22000,'M','BSN',9535188116,'DC0013');
insert into nurses(nid,name,age,address,salary,sex,qualification,phone_no,did)values('NR0020','Bhanu',35,'NO.127,8th cross,Sadashivnagar',52000,'F','ADN',9945520527,'DC0005');


/*MANAGERIAL STAFF*/
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0001','Rashmi',27,'NO.199,IndraNagar',100000,'F','Reception',7888899999);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0002','Akarsh',30,'NO.223,Ulsoor',80000,'M','Accounting',9887770011);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0003','Sanjay',32,'NO.345.MGRoad',100000,'M','Therapy Center',9912367890);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0004','Chandana',33,'NO.456,Kathriguppe',120000,'F','Clinical Engeneering',8976512091);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0005','Kushal',25,'NO.511,Whitefield',90000,'M','Dietry Center',8123509897);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0006','Megha',35,'NO.634,Brigade Road',150000,'F','Cardiology Center',7658977666);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0007','Priyanka',40,'NO.777,Hoskote',80000,'F','Neurology Center',7991919190);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0008','Dinesh',42,'NO.888,Magadi',75000,'M','Nursing',9998800231);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0009','Bharath',46,'NO.999IndraNagar',100000,'M','Radiology',9265649988);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0010','Sushma',29,'NO.111,Majestic',200000,'F','Safety',8989891212);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0011','Teju',38,'NO.222,Ittmudu',55000,'F','Pharmacy',9665544339);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0012','Shubham',27,'NO.333,Malleshwaram',90000,'M','Accounting',7676897978);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0013','Vinod',50,'NO.444,JP Nagar',100000,'M','Nursing',8001123344);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0014','Vinitha',44,'NO.555,Ramnagar',120000,'F','Dietry Center',9898978789);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0015','Sirisha',37,'NO.666,Whitefield',50000,'F','Therapy Center',9595475754);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0016','Praveen',32,'NO.712,RajajiNagar',90000,'M','Accounting',9090456322);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0017','Aditya',40,'NO.866,VijayNagar',120000,'M','Clinical Engeneering',8563432091);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0018','Sparsha',25,'NO409,Ulsoor',150000,'F','Cardiology Center',8760909901);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0019','Nidhi',34,'NO.976,Jaynagar',80000,'F','Neurology Center',8989065650);
insert into managerial_staff(mid,name,age,address,salary,sex,cader,phone_no)values('MS0020','Eshwar',46,'NO.520,Magadi',750000,'M','Nursing',7755188991);



/*FACILITIES*/
insert into facilities(code,name,price,facility_availability)values('FC0001','X-ray',5000,'Mon-Fri,8AM-4PM');
insert into facilities(code,name,price,facility_availability)values('FC0002','CT-Scan',6000,'Mon-Fri,8AM-4PM');
insert into facilities(code,name,price,facility_availability)values('FC0003','MRI-Scan',7500,'Mon-Fri,8AM-4PM');
insert into facilities(code,name,price,facility_availability)values('FC0004','Ultrasound',8000,'Mon-Thu,9AM-1PM');
insert into facilities(code,name,price,facility_availability)values('FC0005','Blood Test',3000,'Mon-Sat,7AM-7PM');
insert into facilities(code,name,price,facility_availability)values('FC0006','Urine-Drug Test',4000,'Mon-Sat,7AM-7PM');
insert into facilities(code,name,price,facility_availability)values('FC0007','PET Scan',9000,'Mon-Thu,10AM-1PM');
insert into facilities(code,name,price,facility_availability)values('FC0008','Foetal Ultrasound',10000,'Mon-Thu,10AM-2PM');
insert into facilities(code,name,price,facility_availability)values('FC0009','Renal Scan',10000,'Mon-Thu,9AM-1PM');
insert into facilities(code,name,price,facility_availability)values('FC0010','Cardiac Calcium Scoring',19000,'Mon-Wed,10AM-4PM');
insert into facilities(code,name,price,facility_availability)values('FC0011','Breast Scan',15000,'Mon-Wed,10AM-2PM');
insert into facilities(code,name,price,facility_availability)values('FC0012','Transvaginal Scan',20000,'Mon-Wed,8AM-11AM');
insert into facilities(code,name,price,facility_availability)values('FC0013','Neuroimaging',20000,'Mon-Fri,11AM-2PM');
insert into facilities(code,name,price,facility_availability)values('FC0014','Creatinine Test',12000,'Wed-Fri,12PM-6PM');
insert into facilities(code,name,price,facility_availability)values('FC0015','Spirometry',13000,'Thu-Sat,3PM-7PM');
insert into facilities(code,name,price,facility_availability)values('FC0016','Bone Scan',8500,'Tue-Sat,3PM-7PM');
insert into facilities(code,name,price,facility_availability)values('FC0017','Gastrscopy',5500,'Mon-Thu,7AM-11AM');
insert into facilities(code,name,price,facility_availability)values('FC0018','Glucose Test',45000,'Thu-Fri,7AM-12PM');
insert into facilities(code,name,price,facility_availability)values('FC0019','Semen Analysis',17000,'Sat,10AM-3PM');
insert into facilities(code,name,price,facility_availability)values('FC0020','Liver Biopsy',18000,'Fri-Sat,2PM-6PM');

/*BUILDING*/

insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('A1',50,100,'MS0003',25);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('A2',75,120,'MS0008',30);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('A3',60,100,'MS0005',40);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('A4',100,200,'MS0019',88);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('A5',50,100,'MS0012',80);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('B1',120,175,'MS0015',122);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('B2',50,150,'MS0003',75);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('B3',25,70,'MS0001',44);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('B4',50,100,'MS0016',29);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('B5',80,170,'MS0013',52);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('C1',70,180,'MS0008',63);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('C2',50,100,'MS0018',40);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('C3',50,130,'MS0006',59);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('C4',90,170,'MS0020',78);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('C5',50,100,'MS0011',67);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('D1',40,140,'MS0014',98);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('D2',55,100,'MS0016',20);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('D3',65,170,'MS0017',25);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('D4',85,180,'MS0001',54);
insert into building(block_no,no_wards,no_beds,coordinator,bed_avail)values('D5',50,100,'MS0007',32);

/*PATIENTS*/

insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0001','Shashikala',35,'NO.564,2nd stage,BTMLayout','F',9965124567,'Y','02/03/2017','A3','DC0008');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0002','Raj',39,'NO.698,3rd phase,JPNagar','M',9786278956,'Y','19/03/2017','A4','DC0006');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0003','Prokshith',43,'NO.222,Ittmudu','M',9095673869,'N','02/11/2016','A5','DC0011');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0004','Sonali',27,'NO.765,3rd block,RajajiNagar','F',9964563287,'Y','03/03/2017','B1','DC0012');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0005','Amulya',47,'NO.554,5th cross,BasaveshwarNagar','F',9853902673,'N','12/09/2016','C1','DC0019');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0006','Jai',38,'NO.324,2nd stage,IndiraNagar','M',9583728927,'N','02/03/2016','A2','DC0009');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0007','Guru',56,'NO.345,12th cross,Koramangala','M',9472689034,'Y','02/01/2016','D1','DC0008');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0008','Kavitha',68,'NO.675,2nd stage,Banashankari','F',9456890765,'Y','01/08/2015','D2','DC0006');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0009','Venu',36,'NO.987,22nd cross,Bannerghatta','M',9345678976,'N','09/06/2015','C1','DC0016');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0010','Darshan',49,'NO.453,15th cross,Malleshwaram','M',9945890765,'N','12/12/2016','A3','DC0020');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0011','Namratha',50,'NO.567,16th cross,Sheshadripuram','F',9126789098,'N','02/03/2016','A1','DC0013');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0012','Tanisha',55,'NO.498,18th cross,Hebbal','F',9789076543,'Y','12/03/2015','D4','DC0017');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0013','Sharath',45,'NO.455,23rd cross,Yelahanka','M',9098632467,'Y','06/03/2017','C1','DC0011');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0014','Harshith',23,'NO.345,7th cross,MG Road','M',9098765434,'N','08/05/2014','C1','DC0001');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0015','Chandhan',65,'NO.612,3rd cross,Ittmudu','M',9987654323,'Y','17/11/2014','C3','DC0002');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0016','Shradha',85,'NO.765,8th block,Jayanagar','F',9987424678,'N','02/08/2015','A2','DC0007');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0017','Jayanthi',35,'NO.432,3rd cross,RRNagar','F',9098754234,'N','02/09/2016','A3','DC0009');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0018','Ziva',78,'NO.621,1st cross,Ejipura','F',9872347890,'Y','05/07/2014','D2','DC0010');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0019','Karthik',35,'NO.432,13th cross,Malleshwaram','M',9098345674,'Y','06/04/2015','A3','DC0015');
insert into patients(bed_no,name,age,address,sex,phone_no,prev_stay,admit_date,block_no,did)values('BD0020','Bhaskar',39,'NO.100,1st stage,BTMLayout','M',9097543467,'N','05/01/2017','A2','DC0018');

/*HOUSEKEEPING_STAFF*/
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0001','Ramu',27,'NO.65,Vidyapeetha','M','Cleanliness',9001000101);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0002','Sarla',25,'NO.167,Magadi','F','Resources',8899122556);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0003','Palani',32,'NO.345,JP Nagar','F','Transportation',767657676);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0004','Lakshmi',35,'NO.234,Indra Nagar','F','Waste Disposal',7789012345);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0005','Raju',40,'NO.198,ShivajiNagar','M','Sewage Disposal',8541085410);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0006','Dilip',45,'NO.501,Silk Board','M','Laundry',9786534512);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0007','Ramesh',47,'NO.333,Hoskote','M','Repair Services',8845189451);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0008','Gauri',37,'NO.456,Ramnagar','F','Patient meals',8654396543);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0009','Rekha',48,'NO.722,Ulsoor','F','Laundry',9977166551);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0010','Jagadish',38,'NO.12,Kathriguppe','M','Resources',9645138926);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0011','Naresh',50,'NO.590,Vijaynagar','M','Waste Disposal',7979167677);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0012','Manga',36,'NO.499,Rajajinagar','F','Repair Services',8123456789);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0013','Sulekha',43,'NO.88,Itmudugu','F','Cleanlines',9546701234);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0014','Babu',53,'NO.401,Majestic','M','Transportation',7000189892);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0015','Lokesh',51,'NO.399,Ashokanagar','M','Sewage Disposal',8900078900);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0016','Saroja',36,'NO.899,Basavangudi','F','Laundry',9745698459);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0017','Vasantha',44,'NO.677,Gandhibazar','F','Patient meals',7012789067);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0018','Shekhar',37,'NO.121,Hanumanthanagar','M','Cleanliness',8881199900);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0019','Ravi',43,'NO.221,Bankcolony','M','Laundry',9665558900);
insert into housekeeping_staff(hid,name,age,address,sex,cader,phone_no)values('HS0020','Srimukhi',24,'NO.789,Jaynagar','F','Resources',7532198654);




/*ACCOUNTS*/

insert into accounts(acc_no,payment,bed_no,amount )values(0532013000,'OnlinePayment','BD0006' , 25000);
insert into accounts(acc_no,payment,bed_no,amount)values(0535678907,'DebitCard','BD0008', 2000);
insert into accounts(acc_no,payment,bed_no,amount)values(0890456789,'CreditCard','BD0012', 150000);
insert into accounts(acc_no,payment,bed_no,amount)values(0045678945,'OnlinePayment','BD0010', 2500);
insert into accounts(acc_no,payment,bed_no,amount)values(0345679004,'OnlinePayment','BD0019', 3000);
insert into accounts(acc_no,payment,bed_no,amount)values(0576768788,'Cheque','BD0015', 120000);
insert into accounts(acc_no,payment,bed_no,amount)values(0036666888,'OnlinePayment','BD0006', 25000);
insert into accounts(acc_no,payment,bed_no,amount)values(0483739367,'CreditCard','BD0017', 100000);
insert into accounts(acc_no,payment,bed_no,amount)values(0467892578,'CreditCard','BD0008', 2000);
insert into accounts(acc_no,payment,bed_no,amount)values(0004565546,'Cash','BD0015',40000);
insert into accounts(acc_no,payment,bed_no,amount)values(0255479575,'DebitCard','BD0016', 5000);
insert into accounts(acc_no,payment,bed_no,amount)values(0354774847,'OnlinePayment','BD0020', 12000);
insert into accounts(acc_no,payment,bed_no,amount)values(0534634745,'Cheque','BD0001', 200000);
insert into accounts(acc_no,payment,bed_no,amount)values(0257887950,'Cash','BD0004', 15000);
insert into accounts(acc_no,payment,bed_no,amount)values(0476849368,'CreditCard','BD0018', 2000);
insert into accounts(acc_no,payment,bed_no,amount)values(0164798584,'OnlinePayment','BD0017', 2500);
insert into accounts(acc_no,payment,bed_no,amount)values(0746383548,'DebitCard','BD0009', 250000);
insert into accounts(acc_no,payment,bed_no,amount)values(0467282647,'Cheque','BD0018', 14000);
insert into accounts(acc_no,payment,bed_no,amount)values(0538464648,'Cash','BD0012', 55000);
insert into accounts(acc_no,payment,bed_no,amount)values(0634847484,'CreditCard','BD0005', 90000);






/*PHARMACY*/
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0001','Amoxicillin',1000,100);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0002','Baclofen',1200,200);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0003','Cardizem',2000,300);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0004','Demerol',2500,400);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0005','Evista',800,500);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0006','Flonase',500,600);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0007','Gleevec',1500,700);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0008','Heparin',1800,800);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0009','Intuniv',600,900);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0010','Jalyn',2130,1000);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0011','Keppra',789,1100);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0012','Lovenox',349,1200);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0013','Miralax',920,1300);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0014','Niaspan',1300,1400);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0015','Oxycontin',1900,1500);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0016','Protonix',300,1600);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0017','Qtenza',450,1700);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0018','Rocephin',210,1800);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0019','Sttratera',850,1900);
insert into pharmacy(pcode,medicine_name,stock,price_per_unit)values('PH0020','Tegretol',700,2000);

/*TREATMENT*/
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0001','Whooping Cough','Mild Fever,Sneezing,Runny Nose','X-ray','Antibiotics','PH0020');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0002','GERD','Chest pain,Burning Sensation','Gastroscopy','GERD Surgery','PH0018');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0003','Alzeimer','Memory Loss','CT-Scan','Aricept','PH0017');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0004','Sinus','Congestion,Breathing Problem','Spirometry','Antihistamines','PH0010');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0005','Chronic kidney disease','Fatigue,Weakness,Sleep Problems','Urine-Drug Test','Dialysis','PH0006');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0006','Diabetes','Frequent Urination,Blurred vision,Weight Loss','Glucose Test','Insulin Therapy','PH0001');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0007','Liver Disease','Jaundice,Nausea,Weakness','Liver-Biopsy','ARLD','PH0008');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0008','Breast Cancer','Lump in the breast','Breast Scan','Adjuvent Therapy','PH0013');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0009','Bone Cancer','Bone Pain,Swelling,Weight Loss','Bone Scan','Chemotherapy','PH0003');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0010','High Blood Pressure','Blood spots in the eyes,Dizziness,Facial Flushing','Creatinine Test','ACE Inhibitors','PH0009');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0011','Brain Tumor','Headache,Drowsiness,Fatigue','MRI-Scan','Radiation Therapy','PH0012');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0012','HIV','Diarrhoea,Rapid weight loss,rashes','PET Scan','Antiretroviral Therapy','PH0019');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0013','Cancer','Fever,Extreme Tiredness,Belly Pain','Ultrasound','Chemotherapy','PH0002');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0014','Achondroplasia','Bowed legs,Decreased muscle tone','Foetal Ultrasound','Constant Medication','PH0015');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0015','Heart Disease','Choking,Sweating,Dizziness','Cardiac Calcium Scoring','CABG','PH0006');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0016','Paralysis','Confusion,Siezure,Changes in vision','Neuroimaging','Baclofen Therapy','PH0011');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0017','Renal Disease','Fatigue,Dizziness,Nausea','Renal Scan','Hemodialysis','PH0004');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0018','Pelvic Infection','High Fever,Painful Urination','Transvaginal Scan','Antibiotics','PH0007');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0019','Malaria','Nausea,Vomitting,Fever','Blood Test','Drugs','PH0014');
insert into treatment(tid,disease,symptoms,diagnosis,treatment,spcode)values('TM0020','Infertility','Changes in hair growth,Swelling in testicles','Semen Analysis','Insemination','PH0005');


/*CONSULTING PATIENTS*/
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0001','Adarsh',26,'NO.11,Basavangudi','M',9911123234,'TM0006');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0002','Bhagya',32,'NO.112,Vidyapeetha','F',7123489012,'TM0019');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0003','Chetan',41,'NO.209,Magadi','M',8090706050,'TM0017');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0004','Disha',38,'NO.342,Hoskote','F',9445566770,'TM0014');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0005','Ganga',45,'NO.99,Jaynagar','F',8987868584,'TM0013');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0006','Hema',50,'NO.456,Whitefield','F',7851123234,'TM0006');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0007','Jagadish',52,'NO.85,Shivajinagar','M',9776655441,'TM0007');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0008','Kumar',55,'NO.271,BTM Layout','M',8445551122,'TM0005');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0009','Lekha',47,'NO.560,Ulsoor','F',7554443321,'TM0018');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0010','Manga',62,'NO.666,IndraNagar','F',9911889900,'TM0010');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0011','Nagesh',56,'NO.777,Basavangudi','M',8865423234,'TM0003');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0012','Pankaj',36,'NO.888,Electronic City','M',7543210981,'TM0012');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0013','Savitri',72,'NO.490,Hanumanthanagar','F',8423190666,'TM0016');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0014','Ramesh',49,'NO.161,Kathriguppe','M',9972505431,'TM0009');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0015','Uday',39,'NO.611,JPNagar','M',7771188899,'TM0020');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0016','Krishna',75,'NO.555,Basavangudi','M',8454516767,'TM0015');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0017','Radha',29,'NO.300,Malleshwaram','F',9900990090,'TM0004');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0018','Rashmi',36,'NO.45,Hoskote','F',7846454340,'TM0008');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0019','Shiva',47,'NO.111,Shivajinagar','M',8234567890,'TM0002');
insert into consult_patients(app_no,name,age,address,sex,phone_no,tid)values('AP0020','Karthik',48,'NO.411,Magadi','M',9349034900,'TM0011');



/*TAKESCARE*/

insert into takescare(bed_no,nid)values('BD0002','NR0015');
insert into takescare(bed_no,nid)values('BD0012','NR0013');
insert into takescare(bed_no,nid)values('BD0001','NR0014');
insert into takescare(bed_no,nid)values('BD0020','NR0011');
insert into takescare(bed_no,nid)values('BD0007','NR0012');
insert into takescare(bed_no,nid)values('BD0019','NR0010');
insert into takescare(bed_no,nid)values('BD0018','NR0008');
insert into takescare(bed_no,nid)values('BD0006','NR0007');
insert into takescare(bed_no,nid)values('BD0003','NR0005');
insert into takescare(bed_no,nid)values('BD0008','NR0002');
insert into takescare(bed_no,nid)values('BD0013','NR0004');
insert into takescare(bed_no,nid)values('BD0004','NR0001');
insert into takescare(bed_no,nid)values('BD0005','NR0003');
insert into takescare(bed_no,nid)values('BD0009','NR0006');
insert into takescare(bed_no,nid)values('BD0010','NR0009');
insert into takescare(bed_no,nid)values('BD0014','NR0016');
insert into takescare(bed_no,nid)values('BD0011','NR0018');
insert into takescare(bed_no,nid)values('BD0015','NR0017');
insert into takescare(bed_no,nid)values('BD0016','NR0020');
insert into takescare(bed_no,nid)values('BD0017','NR0019');

/*MANAGE*/

insert into manage(acc_no,mid)values(0532013000,'MS0015');
insert into manage(acc_no,mid)values(0535678907,'MS0016');
insert into manage(acc_no,mid)values(0890456789,'MS0017');
insert into manage(acc_no,mid)values(0045678945,'MS0018');
insert into manage(acc_no,mid)values(0345679004,'MS0019');
insert into manage(acc_no,mid)values(0576768788,'MS0020');
insert into manage(acc_no,mid)values(0036666888,'MS0014');
insert into manage(acc_no,mid)values(0483739367,'MS0013');
insert into manage(acc_no,mid)values(0467892578,'MS0012');
insert into manage(acc_no,mid)values(0004565546,'MS0011');
insert into manage(acc_no,mid)values(0255479575,'MS0010');
insert into manage(acc_no,mid)values(0354774847,'MS0009');
insert into manage(acc_no,mid)values(0534634745,'MS0008');
insert into manage(acc_no,mid)values(0257887950,'MS0001');
insert into manage(acc_no,mid)values(0476849368,'MS0002');
insert into manage(acc_no,mid)values(0164798584,'MS0003');
insert into manage(acc_no,mid)values(0746383548,'MS0004');
insert into manage(acc_no,mid)values(0467282647,'MS0005');
insert into manage(acc_no,mid)values(0538464648,'MS0006');
insert into manage(acc_no,mid)values(0634847484,'MS0007');

/*DPERFORMST*/
insert into dperformst(did,tid)values('DC0005','TM0015');
insert into dperformst(did,tid)values('DC0006','TM0014');
insert into dperformst(did,tid)values('DC0007','TM0013');
insert into dperformst(did,tid)values('DC0009','TM0012');
insert into dperformst(did,tid)values('DC0008','TM0011');
insert into dperformst(did,tid)values('DC0010','TM0020');
insert into dperformst(did,tid)values('DC0020','TM0019');
insert into dperformst(did,tid)values('DC0018','TM0018');
insert into dperformst(did,tid)values('DC0019','TM0017');
insert into dperformst(did,tid)values('DC0016','TM0016');
insert into dperformst(did,tid)values('DC0017','TM0005');
insert into dperformst(did,tid)values('DC0003','TM0004');
insert into dperformst(did,tid)values('DC0004','TM0003');
insert into dperformst(did,tid)values('DC0001','TM0002');
insert into dperformst(did,tid)values('DC0002','TM0001');
insert into dperformst(did,tid)values('DC0011','TM0010');
insert into dperformst(did,tid)values('DC0013','TM0009');
insert into dperformst(did,tid)values('DC0012','TM0008');
insert into dperformst(did,tid)values('DC0014','TM0007');
insert into dperformst(did,tid)values('DC0015','TM0006');

/*REQUIREMENT*/

insert into requirement(tid,code)values('TM0005','FC0015');
insert into requirement(tid,code)values('TM0004','FC0014');
insert into requirement(tid,code)values('TM0002','FC0013');
insert into requirement(tid,code)values('TM0001','FC0012');
insert into requirement(tid,code)values('TM0003','FC0011');
insert into requirement(tid,code)values('TM0020','FC0005');
insert into requirement(tid,code)values('TM0018','FC0004');
insert into requirement(tid,code)values('TM0016','FC0003');
insert into requirement(tid,code)values('TM0017','FC0002');
insert into requirement(tid,code)values('TM0019','FC0001');
insert into requirement(tid,code)values('TM0006','FC0020');
insert into requirement(tid,code)values('TM0007','FC0019');
insert into requirement(tid,code)values('TM0008','FC0018');
insert into requirement(tid,code)values('TM0009','FC0017');
insert into requirement(tid,code)values('TM0010','FC0016');
insert into requirement(tid,code)values('TM0015','FC0006');
insert into requirement(tid,code)values('TM0014','FC0007');
insert into requirement(tid,code)values('TM0013','FC0008');
insert into requirement(tid,code)values('TM0012','FC0009');
insert into requirement(tid,code)values('TM0011','FC0010');

/*PUNDERGOEST*/
insert into pundergoest(tid,bed_no,opdate)values('TM0005','BD0015','01/02/2015');
insert into pundergoest(tid,bed_no,opdate)values('TM0004','BD0014','03/08/2016');
insert into pundergoest(tid,bed_no,opdate)values('TM0002','BD0013','07/02/2016');
insert into pundergoest(tid,bed_no,opdate)values('TM0001','BD0012','11/12/2014');
insert into pundergoest(tid,bed_no,opdate)values('TM0003','BD0011','19/08/2017');
insert into pundergoest(tid,bed_no,opdate)values('TM0020','BD0005','07/06/2017');
insert into pundergoest(tid,bed_no,opdate)values('TM0018','BD0004','10/03/2016');
insert into pundergoest(tid,bed_no,opdate)values('TM0016','BD0003','13/02/2015');
insert into pundergoest(tid,bed_no,opdate)values('TM0017','BD0002','21/02/2016');
insert into pundergoest(tid,bed_no,opdate)values('TM0019','BD0001','28/07/2016');
insert into pundergoest(tid,bed_no,opdate)values('TM0006','BD0020','31/01/2015');
insert into pundergoest(tid,bed_no,opdate)values('TM0007','BD0019','21/10/2015');
insert into pundergoest(tid,bed_no,opdate)values('TM0008','BD0018','11/02/2017');
insert into pundergoest(tid,bed_no,opdate)values('TM0009','BD0017','01/07/2015');
insert into pundergoest(tid,bed_no,opdate)values('TM0010','BD0016','28/04/2015');
insert into pundergoest(tid,bed_no,opdate)values('TM0015','BD0006','01/02/2016');
insert into pundergoest(tid,bed_no,opdate)values('TM0014','BD0007','25/04/2014');
insert into pundergoest(tid,bed_no,opdate)values('TM0013','BD0008','08/08/2014');
insert into pundergoest(tid,bed_no,opdate)values('TM0012','BD0009','11/03/2015');
insert into pundergoest(tid,bed_no,opdate)values('TM0011','BD0010','16/07/2017');

/*WORKS_IN*/

insert into works_in(hid,block_no)values('HS0005','B1');
insert into works_in(hid,block_no)values('HS0004','A1');
insert into works_in(hid,block_no)values('HS0002','C1');
insert into works_in(hid,block_no)values('HS0001','A2');
insert into works_in(hid,block_no)values('HS0003','A3');
insert into works_in(hid,block_no)values('HS0020','B1');
insert into works_in(hid,block_no)values('HS0018','B1');
insert into works_in(hid,block_no)values('HS0016','A1');
insert into works_in(hid,block_no)values('HS0017','A2');
insert into works_in(hid,block_no)values('HS0019','A3');
insert into works_in(hid,block_no)values('HS0006','B1');
insert into works_in(hid,block_no)values('HS0007','B1');
insert into works_in(hid,block_no)values('HS0008','B1');
insert into works_in(hid,block_no)values('HS0009','C1');
insert into works_in(hid,block_no)values('HS0010','C1');
insert into works_in(hid,block_no)values('HS0015','A1');
insert into works_in(hid,block_no)values('HS0014','A2');
insert into works_in(hid,block_no)values('HS0013','A3');
insert into works_in(hid,block_no)values('HS0012','B1');
insert into works_in(hid,block_no)values('HS0011','C1');

/*CPUNDERGOEST*/

insert into cpundergoest(app_no,tid)values('AP0005','TM0015');
insert into cpundergoest(app_no,tid)values('AP0004','TM0014');
insert into cpundergoest(app_no,tid)values('AP0003','TM0013');
insert into cpundergoest(app_no,tid)values('AP0002','TM0012');
insert into cpundergoest(app_no,tid)values('AP0001','TM0011');
insert into cpundergoest(app_no,tid)values('AP0020','TM0005');
insert into cpundergoest(app_no,tid)values('AP0019','TM0004');
insert into cpundergoest(app_no,tid)values('AP0018','TM0003');
insert into cpundergoest(app_no,tid)values('AP0017','TM0002');
insert into cpundergoest(app_no,tid)values('AP0016','TM0001');
insert into cpundergoest(app_no,tid)values('AP0006','TM0020');
insert into cpundergoest(app_no,tid)values('AP0007','TM0019');
insert into cpundergoest(app_no,tid)values('AP0008','TM0018');
insert into cpundergoest(app_no,tid)values('AP0009','TM0017');
insert into cpundergoest(app_no,tid)values('AP0010','TM0016');
insert into cpundergoest(app_no,tid)values('AP0011','TM0006');
insert into cpundergoest(app_no,tid)values('AP0012','TM0007');
insert into cpundergoest(app_no,tid)values('AP0013','TM0008');
insert into cpundergoest(app_no,tid)values('AP0014','TM0009');
insert into cpundergoest(app_no,tid)values('AP0015','TM0010');
