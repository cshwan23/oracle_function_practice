/*
 --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
 --system 계정과 동일한 권한을 가진 king 계정 생성
 --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    --system 계정으로 접속한 후 코딩 창에서 아래와 같은 명령으로 king 계정을 만들고
    -- 암호를 k123으로 한다.
    -- king 계정에 system 계정과 동일한 권한을 부여한다.
 --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    create use king identified by k123;
    grant connect,resource,dba to king;
 --mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
 */



/*
------------------------------------------------
drop sequence emp_sq;  --> <주의> emp_sq 가 없으면 삭제 대상이 없다는 에러 메시지 출력
drop sequence cus_sq;
------------------------------------------------
drop table salary_grade; --> <주의> salary_grade 가 없으면 삭제 대상이 없다는 에러 메시지 출력
drop table customer;
drop table employee;
drop table dept;
commit;
------------------------------------------------
*/
select * from user_users;

------------------------------------------------
-- employee 테이블에서 사용할 PK 번호를 제공하는 시퀀스(sequence) 생성하기 (일련 번호 자동 생성기)
-- 시퀀스는 객체의(sequence) 한 종류로서 자동 일련번호를 제공한다. 주로 pk 값을 뽑아준다.
-- 은행에서 번호표 생성기와 동일한 기능을 가진다.
------------------------------------------------
create sequence  emp_sq
    start with 1   -->(처음 시작값)
    increment by 1 -->(증가값)
    minvalue 1     -->(최소값)
    maxvalue 999;  -->(최대값)
------------------------------------------------
-- customer 테이블에서 사용할 PK 번호를 제공하는 시퀀스(sequence) 생성하기 (일련 번호 자동 생성기)
-- 시퀀스는 객체의(sequence) 한 종류로서 자동 일련번호를 제공한다. 주로 pk 값을 뽑아준다.
-- 은행에서 번호표 생성기와 동일한 기능을 가진다.
------------------------------------------------
create sequence  cus_sq
    start with 1   -->(처음 시작값)
    increment by 1 -->(증가값)
    minvalue 1     -->(최소값)
    maxvalue 999;  -->(최대값)





---------------------
--dept 테이블 만들기
---------------------
-- 테이블 이름은 dept
create table dept(
    -------------------------------------------------------
    --dep_no 컬럼명 선언 숫자 정수 2자리까지 저장되도록 설정
    -------------------------------------------------------
    dep_no number(2)
    -------------------------------------------------------
    --dep_name 컬럼명 선언하고 문자(한글10영어20)저장되도록 설정 ,비지마,중복마라
    -------------------------------------------------------
    ,dep_name varchar2(20)  not null unique
    -------------------------------------------------------
    -- loc 컬럼명 선언하고 문자(한글10영어20)저장되도록 설정, 비지마! 라는 제약조건 설정
    -------------------------------------------------------
    ,loc varchar2(20)  not null
    -------------------------------------------------------
    -- dep_no 칼럼에 primary key 라는 제약 조건 설정. primary key 는 비지마! 중복마!
    -- FK가 언젠가 참조할 수도 있어! 라는 제약 조건
    -- <주의> primary key 설정은 (관용적으로)컬럼명 오른쪽에 설정하지 않고 모든 컬럼명 선언한 이후 설정한다.
    -------------------------------------------------------
    ,primary key (dep_no)
);
commit;
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- dept 테이블에 행 단위로 데이터 입력하기
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-------------------------------------------------------
-- 1행 dep_no, dep_name, loc 칼럼명에 10, '총무부', '서울' 데이터 입력하기
-------------------------------------------------------
insert into dept(dep_no, dep_name, loc) values (10,'총무부','서울');
-------------------------------------------------------
-- 2행 dep_no, dep_name, loc 칼럼명에 20, '영업부', '부산' 데이터 입력하기
-------------------------------------------------------
insert into dept(dep_no, dep_name, loc) values (20,'영업부','부산');
-------------------------------------------------------
-- 3행 dep_no, dep_name, loc 칼럼명에 30, '전산부', '대전' 데이터 입력하기
-------------------------------------------------------
insert into dept(dep_no, dep_name, loc) values (30,'전산부','대전');
-------------------------------------------------------
-- 4행 dep_no, dep_name, loc 칼럼명에 40, '자재부', '광주' 데이터 입력하기
-------------------------------------------------------
insert into dept(dep_no, dep_name, loc) values (40,'자재부','광주');

/*
-------------------------------------------------------
<문제> 아래 insert 구문은 각각 성공하는가?
-------------------------------------------------------
insert into dept values (50, '홍보부', '광주');
// 성공(o)  컬럼명이 없으면 create 로 만들 때 나열했던 컬럼명이 그대로 나온다.
insert into dept values (50, '광주', '관리부');
// 성공(o)  다만 dep_name 컬럼에 광주가 들어간다.
insert into dept values ('광주', '마케팅부', 70);
// 실패(x)  '광주' 가 dep_no 칼럼에 들어갈 순 없다. 자료형이 맞지 않다.
*/


--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- dept 테이블의 모든 컬럼과 모든 행 검색하기
-- select 뒤에 * 는 모든 칼럼명을 ,콤마로 나열한 것과 동일하다.
-- 즉 * 는 dept_no, dept_name, loc 와 동일하다.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- select * from dept;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 여태까지 한 입력 또는 수정 또는 삭제 작업을 실제로 인정하기.
-- <주의> 입력 수정 삭제 작업은 가상작업이므로 commit 을 실행해야 실제 작업으로 인정한다.
--       만약 가상 작업을 취소하고 싶다면 rollback 하면 된다.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
commit;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- ● employee 테이블 생성하기
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
create table employee(
   -------------------------------------------------------
   -- emp_no 칼럼명 선언하고 숫자 정수 3까지 저장 되도록 설정
   -------------------------------------------------------
   emp_no number(3)  ,
   -------------------------------------------------------
   -- emp_name 칼럼명 선언하고 문자(한글 15자, 영어 30자)저장되도록 설정. 비지마! 라는 제약조건 설정
   -------------------------------------------------------
   emp_name  varchar2(30) not null ,
   -------------------------------------------------------
   -- dep_no 칼럼명 선언하고 숫자 정수 2까지 저장 되도록 설정
   -------------------------------------------------------
   dep_no  number(2) ,
   -------------------------------------------------------
   -- jikup 칼럼명 선언하고 문자(한글 5자, 영어 10자)저장되도록 설정. 비지마! 라는 제약조건 설정
   -------------------------------------------------------
   jikup varchar2(10) not null,

   -------------------------------------------------------
   -- salary 칼럼명 선언하고 숫자 정수 10까지 저장 되도록 설정
   -- 입력되지 않으면 defalt 값으로 0값이 들어가게 하는 제약 조건 설정. (default 제약조건)
   -- <주의> default 제약 조건이 설정되면 입력되지 않아도 디폴트 값이 입력되므로
   -- not null 제약조건을 자동으로 가진다.
   -------------------------------------------------------
   salary number(10) default 0,

   -------------------------------------------------------
   -- hire_date 칼럼명 선언하고 날짜가 저장되도록 설정
   -- 입력되지 않으면 default 값인 현재시스템 날짜가 입력되라는 제약조건
   -- <주의> sysdate 는 현재 시스템 날짜를 의미한다.
   -------------------------------------------------------
   hire_date date   default  sysdate,

   -------------------------------------------------------
   -- jumin_num 칼럼명 선언하고 문자(숫자문자 13자)저장되도록 설정. 비지마! 중복마!라는 제약조건 설정
   -- <주의>개발 과정에서 unique 라는 제약조건은 안 주는 게 몸에 좋다.
   --      테스트 데이터 입력 시 항상 다른데 이터를 입력하기 힘드니까.
   --      개발 후에 unique를 준다.( 항상 그런건 아니다.)
   -- char 는 모자라게 들어오면 공백이 들어간다.
   -- char 는 똑같은 길이로만 들어온다면 char 가 낫다. (부하가 적게 걸린다)
   -------------------------------------------------------
   jumin_num char(13) not null unique,
   -------------------------------------------------------
   -- phone_num 컬럼명 선언하고 문자(숫자문자15자) 저장 되도록 설정. 비지마! 라는 제약 조건 설정
   -------------------------------------------------------
   phone_num varchar2(15) not null,
   -------------------------------------------------------
   -- mgr_emp_no 컬럼명 선언하고 숫자(3자리) 저장 되도록 설정.
   -------------------------------------------------------
   mgr_emp_no number(3) ,
   -------------------------------------------------------
   -- emp_no 컬럼에 primary key 라는 제약조건 설정하기
   -------------------------------------------------------
   primary key(emp_no)  ,
   -------------------------------------------------------
   -- dep_no 컬럼에 foreign key 라는 제약조건 설정하기 dept 테이블에 dep_no 참조하기
   -------------------------------------------------------
   foreign key(dep_no) references dept(dep_no) ,

   -------------------------------------------------------
   -- mgr_emp_no 컬럼에 foreign key라는 제약 조건 설정하기 employee 테이블의 emp_no 컬럼명을 참조하기
   -- 이 제약 조건을 후에 잠시 무력화 시키기 위해 이름을 employee_mgr_emp_no_fk로 설정한다.
   -------------------------------------------------------
   constraint employee_mgr_emp_no_fk  foreign key(mgr_emp_no) references employee(emp_no)

);



-------------------------------------------------------
-- employee_mgr_emp_no_fk 라는 이름의 제약조건 끄기
-- 위 이름은 현재 employee 테이블에 mgr_emp_no 컬럼에 걸린 제약 조건이다.
-------------------------------------------------------
alter table employee disable constraint employee_mgr_emp_no_fk;
-- alter table employee disable constraint employee_mgr_emp_no_fk;

------------------------------------------------------------------------------------------------------------------------------------------
-- employee 테이블에 20행을 입력하기
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '홍길동', 10, '사장', 5000, to_date('1980-01-01','yyyy-mm-dd'), '7211271109410', '01099699515', null );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '한국남', 20, '부장', 3000, to_date('1988-11-01','yyyy-mm-dd'), '6002061841224', '01024948424', 1 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '이순신', 20, '과장', 3500, to_date('1989-03-01','yyyy-mm-dd'), '6209172010520', '01026352672', 2 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '이미라', 30, '대리', 2503, to_date('1983-04-01','yyyy-mm-dd'), '8409282070226', '01094215694', 17 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '이순라', 20, '사원', 1200, to_date('1990-05-01','yyyy-mm-dd'), '8401041483626', '01028585900', 3 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '공부만', 30, '과장', 4003, to_date('1995-05-01','yyyy-mm-dd'), '8402121563616', '01191338328', 17 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '놀기만', 20, '과장', 2300, to_date('1996-06-01','yyyy-mm-dd'), '8011221713914', '01029463523', 2 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '채송화', 30, '대리', 1703, to_date('1992-06-01','yyyy-mm-dd'), '8105271014112', '01047111052', 17 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '무궁화', 10, '사원', 1100, to_date('1984-08-01','yyyy-mm-dd'), '8303291319116', '01025672300', 12 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '공부해', 30, '사원', 1303, to_date('1988-11-01','yyyy-mm-dd'), '8410031281312', '01027073174', 4 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '류별나', 20, '과장', 1600, to_date('1989-12-01','yyyy-mm-dd'), '8409181463545', '01071628290', 2 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '류명한', 10, '대리', 1800, to_date('1990-10-01','yyyy-mm-dd'), '8207211661117', '01042072622', 20 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '무궁화', 10, '부장', 3000, to_date('1996-11-01','yyyy-mm-dd'), '8603231183011', '01098110955', 1 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '채시라', 20, '사원', 3400, to_date('1993-10-01','yyyy-mm-dd'), '8001172065410', '01044452437', 3 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '최진실', 10, '사원', 2000, to_date('1991-04-01','yyyy-mm-dd'), '8303101932611', '01027491145', 12 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '김유신', 30, '사원', 4000, to_date('1981-04-01','yyyy-mm-dd'), '7912031009014', '01098218448', 4 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '이성계', 30, '부장', 2803, to_date('1984-05-01','yyyy-mm-dd'), '8102261713921', '0165358075', 1 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '강감찬', 30, '사원', 1003, to_date('1986-07-01','yyyy-mm-dd'), '8203121977315', '01033583130', 4 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '임꺽정', 20, '사원', 2200, to_date('1988-04-01','yyyy-mm-dd'), '8701301040111', '01086253078', 7 );
------------------------------------------------------------------------------------------------------------------------------------------
insert into employee values( emp_sq.nextval, '깨똥이', 10, '과장', 4500, to_date('1990-05-01','yyyy-mm-dd'), '8811232452719', '01090084876', 13 );

--------------------------------------------------------------
-- employee_mgr_emp_no_fk 라는 이름의 제약조건 키기
-- 위 이름은 현재 employee 테이블에 mgr_emp_no 컬럼에 걸린 제약 조건이다.
--------------------------------------------------------------
alter table employee enable constraint employee_mgr_emp_no_fk;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- 여태까지 한 입력 또는 수정 또는 삭제 작업을 실제로 인정하기.
-- <주의> 입력 수정 삭제 작업은 가상작업이므로 commit 을 실행해야 실제 작업으로 인정한다.
--       만약 가상 작업을 취소하고 싶다면 rollback 하면 된다.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
--commit;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- select 테이블의 모든 컬럼과 모든 행 검색하기
-- select 뒤에 * 는 모든 칼럼명을 ,콤마로 나열한 것과 동일하다.
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- select * from employee;

--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-- ● customer 테이블 생성하기
--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
create table customer(

    cus_no number(3),
    cus_name varchar2(10) not null ,
    tel_num varchar2(15) ,
    jumin_num varchar2(13) not null unique ,
    emp_no number(3),
    ----------------------------------------------------
    primary key (cus_no) ,
    foreign key (emp_no) references employee(emp_no)
);
----------------------------------------------------
-- customer 테이블에 10행을 입력하기
----------------------------------------------------
insert into customer values (cus_sq.nextval, '류민이', '123-1234', '7001131537915', 3);
insert into customer values (cus_sq.nextval, '이강민', '343-1454', '7601031343915', 2);
insert into customer values (cus_sq.nextval, '이영희', '144-1655', '9301131534525', null);
insert into customer values (cus_sq.nextval, '김철이', '673-1674', '8002131535675', 4);
insert into customer values (cus_sq.nextval, '박류완', '123-1674', '9311201548975', 3);
insert into customer values (cus_sq.nextval, '서캔디', '673-1764', '9012231537578', null);
insert into customer values (cus_sq.nextval, '신똘이', '176-7677', '8901032346515', 7);
insert into customer values (cus_sq.nextval, '도최돌', '673-6744', '9812131836554', 9);
insert into customer values (cus_sq.nextval, '권홍이', '767-1234', '9811131357965', 13);
insert into customer values (cus_sq.nextval, '김안나', '767-1677', '7901132645647', 4);



create table salary_grade(
    sal_grade_no number(2),
    min_salary number(15) not null ,
    max_salary number(15) not null ,
    ----------------------------------------
    primary key (sal_grade_no)

);

insert into salary_grade values (1,8000,10000);
insert into salary_grade values (2,6000,7999);
insert into salary_grade values (3,4000,5999);
insert into salary_grade values (4,2000,3999);
insert into salary_grade values (5,1000,1999);

-- select * from salary_grade;

commit;

select * from dept;
select * from employee;
select * from customer;
select * from salary_grade;

select emp_no, emp_name,to_char(hire_date,'YYYY.MM.DD Q')||'/4분기' from employee;
select emp_no,
       emp_name,
       to_char(hire_date,'YYYY.MM.DD Q')||'/4분기'
       || to_char(hire_date,'DY','NLS_DATE_LANGUAGE = Korean')
from employee;

select emp_no, emp_name
     ,to_char(hire_date,'YYYY.MM.DD')||'('
    ||to_char(hire_date,'DY','NLS_DATE_LANGUAGE = Korean') ||')'
from employee;
select emp_no, emp_name,to_char(hire_date,'YYYY.MM') from employee;

----------------------
-- 직원번호, 직원명, 생알(년-월-일)
----------------------
select emp_no, emp_name, to_char(to_date('19'||substr(jumin_num,1, 6),'YYYYMMDD'),'YYYY-MM-DD')from employee;
----------------------
-- 직원번호, 직원명, 백일잔치일
----------------------
select emp_no, emp_name, to_char(to_date('19'||substr(jumin_num,1, 6),'YYYYMMDD')+100,'YYYY-MM-DD') from employee;
----------------------
--직원번호, 직원명, 근무일수
----------------------
select emp_no, emp_name, sysdate-hire_date from employee;
commit;
