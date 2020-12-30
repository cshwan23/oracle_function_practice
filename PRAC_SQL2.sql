--mmmmmmmmmmmmmmmmmmmmmmmmm
-- 숫자를 다양한 문자형태로 만들기
--mmmmmmmmmmmmmmmmmmmmmmmmm
---------------------------------------
-- Q1. 1234를 001234로 만들기
---------------------------------------
    -- 1234의 앞을 0으로 채우면서 6자리로 만들기
---------------------------------------
select
    to_char(1234,'099999')
from dual;


---------------------------------------
-- Q2. 123456789를 123,456,789 로 만들기
--     1234를 1,234로 만들기
---------------------------------------
-- 천단위로 콤마를 집어넣기
---------------------------------------
select
    to_char(123456789,'999,999,999'),
    to_char(1234,'999,999')
from dual;

---------------------------------------
-- Q3. 1234를 1234.00으로 만들기
---------------------------------------
-- 소수점 자리수를 확보해보기
---------------------------------------
select
    to_char(1234,'99999.99')
from dual;


---------------------------------------
-- Q4. 0.234 를 .234로 만들기
---------------------------------------
-- 정수자리에 0이라면 그 0을 지워버리기
---------------------------------------
select
    to_char(0.234, '999.999')
from dual;

---------------------------------------
-- Q5. .2345를 0.2345로 만들기
---------------------------------------
-- 정수자리에 숫자가 없다면, 정수 첫째 자리에 0하나 집어넣기
---------------------------------------
select
    to_char(.2345, '9990.9999')
from dual;


---------------------------------------
-- Q6. 0.5를 000.50으로 만들기
---------------------------------------
select
    to_char(0.5,'099.99')
from dual;


---------------------------------------
-- Q7. 맨앞에 $ , ₩ 넣기 (천단위콤마, 소수2째자리까지 0으로 넣기)
---------------------------------------
select
    to_char(12345678,'$999,999,999.00'),
    to_char(12345678,'L999,999,999.00')
from DUAL;

---------------------------------------
-- Q8. 숫자문자를 숫자로 만들기
---------------------------------------
select
to_number('12345.9')
from DUAL;

---------------------------------------
-- Q9. 콤마있는 숫자패턴을 빼버리고 숫자로만 구성하기
---------------------------------------
select
    to_number('1,234,567.8','999,999,999.9')
from DUAL;


--mmmmmmmmmmmmmmmmmmmmmmmmm
-- 기타 함수 ( decode, case )
--mmmmmmmmmmmmmmmmmmmmmmmmm

---------------------------------------
-- Q10. employee- 직원번호/명/성별 출력하기
---------------------------------------
select
    emp_no "직원번호"
    ,EMP_NAME "직원명"
    ,decode(substr(JUMIN_NUM,7,1),'1','남','3','남','여') "성별"
from EMPLOYEE;

select
    emp_no
    ,EMP_NAME
    ,   case substr(JUMIN_NUM,7,1)
        when '1' then '남'
        when '3' then '남'
        else '여'
        end
from EMPLOYEE;


---------------------------------------
-- Q11. employee-table 직원번호/명/<월급등급>출력하기
---------------------------------------
select
    emp_no "직원번호"
    ,EMP_NAME "직원명"
    ,
        case
            when SALARY>=5000 then 'A'
            when SALARY>=4000 and SALARY<5000 then 'B'
            when SALARY>=3000 and SALARY<4000 then 'C'
            when SALARY>=2000 and SALARY<3000 then 'D'
            else 'F'

        end "월급등급"
from EMPLOYEE;


--mmmmmmmmmmmmmmmmmmmmmmmmm
-- 통계 관련 함수
--mmmmmmmmmmmmmmmmmmmmmmmmm

---------------------------------------
-- Q12. employee-table 최소연봉/최대연봉/평균연봉/연봉총합/총인원수 출력하기
---------------------------------------

select

    min(SALARY), max(SALARY), avg(SALARY), sum(SALARY), count(emp_no)
from EMPLOYEE;



---------------------------------------
-- Q13. employee-table 소속부서 총 개수 출력하기
---------------------------------------
select
    count(distinct DEP_NO)
from EMPLOYEE;

---------------------------------------
-- Q14.  담당직원이 있는 고객수 출력하기
---------------------------------------
select
    count(EMP_NO)
from CUSTOMER;

---------------------------------------
-- Q15. 고객을 담당하는 직원수 출력하기
---------------------------------------
select
    count(distinct EMP_NO)
from CUSTOMER;

---------------------------------------
-- Q16. employee-table 직번,직명,입사분기 출력
---------------------------------------
select
    EMP_NO,
    EMP_NAME,
       to_char(HIRE_DATE,'Q')||'/4분기'
from EMPLOYEE;


---------------------------------------
-- Q17. employee-table 직번,직명,근무년차 출력
---------------------------------------
select
    EMP_NO,
    EMP_NAME,
       floor((extract(year from sysdate)-
       extract(year from HIRE_DATE))+1)||''||'년차'

from EMPLOYEE;
select
EMP_NO,
       EMP_NAME,
       ceil((sysdate - HIRE_DATE)/365)||'년차'
from EMPLOYEE;


---------------------------------------
-- Q18. customer-table 고객번호,고객명, 담당직원번호 출력(없으면 '없음'으로)
---------------------------------------
select

CUS_NO,
       CUS_NAME,
       nvl(EMP_NO||'','없음')

from CUSTOMER;
-- 없으면 null이면 이라는 함수
-- nvl(실행문1 ,실행문2) => 실행문2은 없으면실행 실행문1는 있으면 실행



---------------------------------------
-- Q19. customer-table 고객번호,고객명, 담당직원존재여부출력(없으면 '없음'있으면'있음')
---------------------------------------

select

CUS_NO,
       CUS_NAME,
       decode(EMP_NO,null,'없음','있음')

from CUSTOMER;


select

CUS_NO,
       CUS_NAME,
       case
            when EMP_NO is null then '없음'
            else '있음'
        end

from CUSTOMER;

select

CUS_NO,
       CUS_NAME,
       nvl2(emp_no,'있음','없음')
from CUSTOMER;


---------------------------------------
-- Q20. employee-table 직번호,직명, 나이, 연령대 검색
---------------------------------------
select


EMP_NO,
       EMP_NAME,
        extract(year from sysdate)-
       to_number(decode(substr(JUMIN_NUM,7,1),'1','19','2','19','20')||
       substr(JUMIN_NUM,1,2))+1
,
        floor((extract(year from sysdate)-
       to_number(decode(substr(JUMIN_NUM,7,1),'1','19','2','19','20')||
       substr(JUMIN_NUM,1,2))+1)*0.1)*10||''||'대'

from EMPLOYEE;


---------------------------------------
-- Q21. employee-table 직급순서대로 정렬하여 모든 칼럼을보이게 하라
---------------------------------------
select * from EMPLOYEE order by
decode(jikup,'사장',1,'부장',2,'과장',3,'대리',4,'사원',5) asc;


---------------------------------------
-- Q22. employee-table 직급순서대로 정렬하여 모든 칼럼을보이게 하라
        -- 직급같다면 나이가 많은사람이 위로
--------------------------------------
select * from EMPLOYEE order by
decode(jikup,'사장',1,'부장',2,'과장',3,'대리',4,'사원',5) asc
,         extract(year from sysdate)-
       to_number(decode(substr(JUMIN_NUM,7,1),'1','19','2','19','20')||
       substr(JUMIN_NUM,1,2))+1 desc;

---------------------------------------
-- Q23. employee-table 직급순서대로 정렬하여 모든 칼럼을보이게 하라
        -- 직급 같다면 먼저 태어난 사람이 위로가게
--------------------------------------
select * from EMPLOYEE order by
decode(jikup,'사장',1,'부장',2,'과장',3,'대리',4,'사원',5) asc
,   decode(substr(JUMIN_NUM,7,1),'1',19,'2',19,20)||
       substr(JUMIN_NUM,1,6) ;

---------------------------------------
-- Q24. employee-table 수요일에 태어난 직원 검색
--------------------------------------
select * from EMPLOYEE where
to_char(to_date(decode(substr(JUMIN_NUM,7,1),'1','19','2','19','20')||
       substr(JUMIN_NUM,1,6),'YYYYMMDD'),'D')=4
