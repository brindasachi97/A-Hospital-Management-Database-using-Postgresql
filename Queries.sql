/*Display total number of beds occupied in a particular building*/
select no_beds-bed_avail as beds_occupied from building;

/*Name of all treatments performed on a particular date = '2016-08-03'*/
select treatment from treatment t ,Pundergoest pt where pt.tid = t.tid and opdate = '2016-08-03';

/*List of all patients treated by consulting doctors*/
select p.name from patients p ,doctors d where p.did = d.did and d.consult='Y';

/*Names of all consulting doctors who are available on  'Thursday to Sunday,11AM to 2PM' and specialization='Gynaecology'*/
select name from doctors where avail='Thursday to Sunday,11AM to 2PM' and consult='Y' and specialization='Gynaecology';

/*Stock available and price per unit of the item required for the treatment 'Antiretroviral Therapy'*/ 
select p.stock , p.price_per_unit from pharmacy p , treatment t where p.pcode=t.spcode and t.treatment='Antiretroviral Therapy'; 

/*Names and id of all housekeeping_staff who work in block_no='B1'*/
select h.hid , h.name from housekeeping_staff h , works_in w where h.hid = w.hid and w.block_no='B1';

/*The number of patients who are above the age 30 and have diabetes*/
select count(*) from consult_patients cp , treatment t where t.tid=cp.tid and cp.age>30 and t.disease='Diabetes';

/*Number of patients in each block at the particular instance*/
select block_no , count(*) as Patients_Count from patients group by block_no;

/*Patients having more than 2 accounts*/
select bed_no,count(*)  from accounts group by bed_no having count(*)>=2;

insert into accounts(acc_no,payment,bed_no)values(0545363000,'OnlinePayment','BD0006');

/*delete the row having payment='DebitCard' and bed_no='BD0006'*/
delete from accounts where payment='DebitCard' and bed_no='BD0006';

/*Number of consulting patients with age<30 and are being treated for treatment 'Diabetes'*/
select count(*) from consult_patients c , treatment t where t.tid=c.tid and c.age<30 and t.disease='Diabetes';

/* Name of managers who manage accounts of patient whose bed_no 'BD0017'*/
select m.name from managerial_staff m,accounts a,manage m1 where  a.bed_no='BD0017' and a.acc_no=m1.acc_no and m1.mid=m.mid and m.cader='Accounting' ;

/*List of all nurses and the doctors they work for*/
create view doc_nurse as select n.nid,d.did from nurses n,doctors d where d.did=n.did;

/*List of all patients and amounts paid*/
create view amt_paid as select p.name,a.amount from patients p,accounts a where p.bed_no=a.bed_no;

/*List of all treatments and all the facilities required*/
create view treatment_done as select t.treatment,f.name from treatment t,requirement r,facilities f where 
r.tid=t.tid and r.code=f.code ;

/* Alter table housekeeping_staff to add new column */
alter table housekeeping_staff add column salary integer;
alter table housekeeping_staff alter column salary set default 40000; 

/*Name of highest paid doctor treating for treatment      */
 select name from doctors where salary=(select max(salary)from doctors) and did in(select d.did from doctors d,dperformst t where d.did=t.did);
 
 /*Details of housekeeping staff working more than one block*/
 insert into works_in(hid,block_no)values('HS0011','C3');
select name from housekeeping_staff where hid in (select hid from works_in group by hid having count(hid)>1);

insert into dperformst(did,tid)values('DC0005','TM0010');
insert into dperformst(did,tid)values('DC0005','TM0002');
insert into dperformst(did,tid)values('DC0005','TM0020');
insert into dperformst(did,tid)values('DC0005','TM0008');
insert into dperformst(did,tid)values('DC0005','TM0001');

/* If the treatments performed by a doctor is greater than 5 then increment salary by 10% */
update  doctors set salary=1.1*(salary) where did in (select did from dperformst group by did having count(tid)>5)

/*Patient treated by a doctor of particular specialization for the treatment*/
select bed_no,t.tid from pundergoest u , dperformst t where t.tid=u.tid and did in(select did from doctors where specialization='Gynaecology'); 

/*medicine name used for particular patient*/
select spcode from treatment t , pundergoest u where t.tid = u.tid and bed_no='BD0016' and t.tid='TM0010';
