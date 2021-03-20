select * from tab;
drop table admin;
drop table manager;
drop table debitcard;
drop table requests;
drop table beneficiarydetail;
drop table customerAccount;
drop table branch;
drop table userDetails;
drop table transactions;

drop sequence user_seq;
drop sequence request_sequence;
drop sequence trans_sequence;
purge recyclebin;


CREATE SEQUENCE user_seq
MINVALUE 1000
START WITH 1000
INCREMENT BY 1
CACHE 10;

CREATE TABLE UserDetails (
    user_id NUMBER(6),
    name varchar(24) NOT NULL,
    mobile_no VARCHAR2(10) NOT NULL,
    gender VARCHAR2(10) NOT NULL,
    mail_id varchar(48) NOT NULL,
    street_add varchar(24),
    city varchar(16),
    state varchar(16),
    aadhar varchar(12),
    pan varchar(10),
    PRIMARY KEY (user_id),
    CHECK( gender IN ('male','female','trans') )
);

insert into UserDetails values(user_seq.nextval,'Dummy Admin','1134567890','trans', 'dummy.admin@wipro.com','Electronic City','Bengaluru','Karnataka','123423555678','dummy12345');

insert into UserDetails values(user_seq.nextval,'Rishav Admin','1234567890','male', 'rishav.kumar7@wipro.com','Brookfield','Bengaluru','Karnataka','123423455678','abcdef1234');

insert into UserDetails values(user_seq.nextval,'Vinayak Admin','8266941599','male', 'vinayak.saini@wipro.com','Brookfield','Bengaluru','Karnataka','123423455677','abcdef1235');

insert into UserDetails values(user_seq.nextval,'Praveen Admin','1234567892','male', 'praveen@wipro.com','Whitefield','Bengaluru','Karnataka','123423415677','abcgef1235');

insert into UserDetails values(user_seq.nextval,'Tanmay Manager','1234567490','male', 'tanmay@wipro.com','Samta colony','Raipur','Chhattisgarh','223423455678','gbcdef1234');

insert into UserDetails values(user_seq.nextval,'Somya Manager','1234557490','female', 'somya@wipro.com','Kamla Nagar','Agra','Uttar Pradesh','223423555678','agraef1234');

insert into UserDetails values(user_seq.nextval,'Aishwarya Manager','9826160457','female', 'aish@bollywood.com','South Mumbai','Mumbai','Maharashtra','548550008000','aishab1234');

insert into UserDetails values(user_seq.nextval,'Abhishek Manager','9826160455','male', 'abhi@bollywood.com','South Mumbai','Mumbai','Maharashtra','548550008001','aishaa1234');


commit;




CREATE TABLE Admin (
    user_id NUMBER(6) PRIMARY KEY,
    password varchar(30),
    FOREIGN KEY (user_id) REFERENCES UserDetails(user_id)
);


insert into Admin values(1001,'xyz1');
insert into Admin values(1002,'xyz2');
insert into Admin values(1003,'xyz3');
insert into Admin values(1004,'xyz4');
commit;



CREATE TABLE Manager(
    user_id NUMBER(6) PRIMARY KEY NOT NULL,
    password varchar(30),
    FOREIGN KEY (user_id) REFERENCES UserDetails(user_id)
);


insert into manager values(1005,'abc5');
insert into manager values(1006,'abc6');
insert into manager values(1007,'abc7');
insert into manager values(1008,'abc8');
commit;




create table Branch(branchname varchar2(48), ifsccode varchar2(11) NOT NULL PRIMARY KEY, streetadd varchar2(48), city varchar2(16), state varchar2(16), manageruserid number(6));


insert into Branch values('HDFC, 183 Sri Sai Harshatowers','HDFC0004182','Opp Forum Value Mall','Bangalore' ,'Karnataka',1005);

insert into Branch values('HDFC, SKYLINE ICON WHITEFIELD MAIN ROAD','HDFC0002377','NEAR HOPE FARM CIRCLE','Bangalore' ,'Karnataka',1006);

insert into Branch values('Axis Bank,OPP NEW BUS STAND','UTIB0000139','JEEVAN BIMA MARG PANDRI','BILASPUR','CHHATTISGARH',1007);

insert into Branch values('Axis Bank, Wilson Garden','UTIB0003961','12th cross, wilson garden','Bengaluru','Karnataka',1008);

insert into Branch(branchname, ifsccode , streetadd , city , state) values('Axis Bank, Begur','UTIB0003960','Ground floor p.no. 30, kodichikanahalli road','Bengaluru','Karnataka');
commit;





create table customerAccount
	(user_id number(6) primary key,
	accountnum number(10) unique,
	customizedusername varchar2(10),
	ifsccode varchar2(11),
	profilepassword varchar2(16),
        transactionpassword varchar2(16),
	internetbankingstatus varchar2(7),
	accounttype varchar2(7),
	balance number(10,2),
	dateopened date,
	    FOREIGN KEY (user_id)
	    REFERENCES userdetails (user_id));


insert into UserDetails values(2000, 'Rishav KUMAR','1234567890','male', 'rishav.kumar7@wipro.com','Brookfield','Bengaluru','Karnataka','123423455678','abcdef1234');

insert into customerAccount values (2000,911010001,'oddrishav','HDFC0004182','kumar','rishav','enabled','savings',9999999.45, date '2012-04-09');


insert into UserDetails values(2001, 'Naveen Roy','8224825222','male', 'naveen.roy@blackdiamond.in','Industrial sector','Bilaspur','Chhattisgarh','122285239654','zxcvb85236');

insert into customerAccount(user_id, accountnum, ifsccode ,internetbankingstatus ,accounttype ,balance ,dateopened) values (2001,911010002,'UTIB0000139','disable','savings',1000000.70, date '1976-05-15');


insert into UserDetails values(2002, 'Vinayak Saini','8266941599','male', 'vinayak.saini@wipro.com','Whitefield','Bengaluru','Karnataka','122435239654','zx5vb85236');

insert into customerAccount(user_id, accountnum, ifsccode ,internetbankingstatus ,accounttype ,balance ,dateopened) values (2002,911010003,'HDFC0004182','disable','savings',10034300.70, date '1996-04-16');


insert into UserDetails values(2003, 'Dolly Ahluwalia','9266941599','female', 'dolly@jspl.com','Punjipatra','Raigarh','Chhattisgarh','122435239954','dolly85236');

insert into customerAccount(user_id, accountnum, ifsccode ,internetbankingstatus ,accounttype ,balance ,dateopened) values (2003,911010004,'HDFC0002377','disable','savings',19034300.70, date '1996-08-13');
commit;





CREATE SEQUENCE request_sequence
MINVALUE 100
START WITH 100
INCREMENT BY 1
CACHE 20;

create table Requests
	(requestid number(6) primary key,
	requestdate date,
	ifsccode varchar2(11),
	userid varchar2(6),
	status varchar2(8),
	remarks varchar(24),
	    FOREIGN KEY (ifsccode)
	    REFERENCES branch (ifsccode));

insert into requests values(request_sequence.nextval, date '2019-04-09', 'HDFC0004182', 2000, 'approved','Priority Customer');

insert into requests values(request_sequence.nextval, date '2019-08-14', 'UTIB0000139', 2001, 'pending','no remarks');

insert into requests values(request_sequence.nextval, date '2019-04-16', 'HDFC0004182', 2002, 'approved','Priority Cust. Roommate');

insert into requests values(request_sequence.nextval, date '2019-09-16', 'HDFC0002377', 2003, 'rejected','Account is Freezed');
commit;






create table debitcard
	(accountnum number(10),
	cardno number(16) primary key,
	validmonth number(2),
	validyear number(2),
	cvv number(3),
	pin number(4),
	status varchar2(10),
	constraint fk_debit
		foreign key (accountnum)
		references customeraccount (accountnum));

insert into debitcard values (911010001,4691980012345623,10,28,129,1234,'enabled');
insert into debitcard values (911010002,4160211585234586,03,27,445,2345,'enabled');
insert into debitcard values (911010003,4691980012345624,10,28,169,3456,'enabled');
insert into debitcard values (911010004,4160211585234585,03,27,485,4567,'enabled');
commit;




create table beneficiarydetail
	(user_id number(6),
	beneficiaryaccountnum number(10),
	beneficiaryname varchar2(24),
	beneficiarybank varchar2(12),
	ifsccode varchar(11),
		foreign key (user_id)
		references customeraccount(user_id));


insert into beneficiarydetail values(2000, 911010003,'Dolly Ahluwalia','withinbank','HDFC0002377');
insert into beneficiarydetail values(2000, 911010002,'Vinayak Flatmate','withinbank','HDFC0004182');
insert into beneficiarydetail values(2000, 911090001,'My Other Bank Friend','otherbank','OTHER000123');
commit;



CREATE SEQUENCE trans_sequence
MINVALUE 100
START WITH 100
INCREMENT BY 1
CACHE 6;


create table transactions
	(
	trasactionid number(6) primary key,
	chronicle date,
	modeofpayment varchar2(8),
	debitfrom number(10),
	creditto number(10),
	amount number(10,2),
	status varchar2(7),
	remarkscustomer varchar(24),
	remarksSystem varchar(24)
);
	

insert into transactions values (trans_sequence.nextval, date '2019-11-25', 'UPI',911010001, 911010002, 49.45, 'success','For Laxmi Chit Fund', 'Customer is Cool' );
insert into transactions values (trans_sequence.nextval, date '2019-11-25', 'UPI',911010002, 911010001, 50.45, 'success','For Dummy credit', 'Customer is king' );
insert into transactions values (trans_sequence.nextval, date '2019-11-25', 'UPI',911010001, 911010002, 499.45, 'success','For dummy debit', 'Cust. is testing trans.' );
commit;

purge recyclebin;
select * from tab;
