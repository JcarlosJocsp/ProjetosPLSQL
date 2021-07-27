


SET SERVEROUTPUT ON;


DECLARE 
 V_SQL_REGULAR    VARCHAR2(2000);
 V_SQL_BOM        VARCHAR2(2000);
 V_SQL_OTIMO      VARCHAR2(2000);
 V_SQL_EXCELENTE  VARCHAR2(2000);
 V_SQL_SEM_CLAS   VARCHAR2(2000);
BEGIN
EXECUTE IMMEDIATE 'CREATE TABLE TAB_BASE_DADOS AS
SELECT E.FIRST_NAME||'' ''||E.LAST_NAME AS NOME,
       TO_CHAR(SALARY,''L999999D99'')   AS SALARIO,
       ROUND(MONTHS_BETWEEN(SYSDATE,E.HIRE_DATE)/12) AS ANOS_TRAB,
       NVL(TO_CHAR(E.COMMISSION_PCT),''SEM COMISSAO'') AS COMISSAO,
CASE E.JOB_ID WHEN ''FI_ACCOUNT'' THEN ''TEM UM CARGO REGULAR''
              WHEN ''PU_CLERK''   THEN ''TEM UM CARGO BOM''
              WHEN ''SA_MAN''    THEN ''TEM UM CARGO OTIMO''
              WHEN ''SA_REP''     THEN ''TEM UM CARGO EXCELENTE''
        ELSE TO_CHAR(''CARGOS SEM CLASIFICACAO'')
         END AS CARGO_CLASIFICACAO,
     D.DEPARTMENT_NAME AS NOME_DEPT,
       DEPARTMENT_ID   AS DEPT_COD
 FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
USING(DEPARTMENT_ID )
 WHERE UPPER(SUBSTR(E.FIRST_NAME,1,1)) NOT IN (''J'',''S'')
   AND TO_CHAR(HIRE_DATE,''YYYY'') BETWEEN 2000 AND 2007
   AND ROUND(MONTHS_BETWEEN(SYSDATE,E.HIRE_DATE)/ 12) BETWEEN 5 AND 15
ORDER BY E.SALARY';

EXECUTE IMMEDIATE
'CREATE TABLE TAB_CARGO_REGULAR (NOME       VARCHAR2(200),
                                SALARIO    VARCHAR2(50),
                                ANOS_TRAB  INTEGER,
                                COMISSAO   VARCHAR2(50),
                                CARGO_CLASIFICACAO VARCHAR2(100),
                                NOME_DEPT  VARCHAR2(100),
                                DEPT_COD   INTEGER)';
                                

EXECUTE IMMEDIATE
'CREATE TABLE TAB_CARGO_BOM (NOME  VARCHAR2(200),
                            SALARIO VARCHAR2(50),
                            ANOS_TRAB INTEGER,
                            COMISSAO VARCHAR2(50),
                            CARGO_CLASIFICACAO VARCHAR2(100),
                            NOME_DEPT VARCHAR2(100),
                            DEPT_COD INTEGER)';                           
                                

EXECUTE IMMEDIATE                                
'CREATE TABLE TAB_CARGO_OTIMO (NOME VARCHAR2(200),
                               SALARIO VARCHAR2(50),
                               ANOS_TRAB INTEGER,
                               COMISSAO VARCHAR2(50),
                               CARGO_CLASIFICACAO VARCHAR2(100),
                               NOME_DEPT VARCHAR2(100),
                               DEPT_COD INTEGER)';                               


EXECUTE IMMEDIATE
'CREATE TABLE TAB_CARGO_EXCELENTE (NOME VARCHAR2(200),
                                  SALARIO VARCHAR2(50),
                                  ANOS_TRAB INTEGER,
                                  COMISSAO VARCHAR2(50),
                                  CARGO_CLASIFICACAO VARCHAR2(100),
                                  NOME_DEPT VARCHAR2(100),
                                  DEPT_COD INTEGER)';



EXECUTE IMMEDIATE
'CREATE TABLE TAB_CARGO_SEM_CLAS(NOME VARCHAR2(200),
                              SALARIO  VARCHAR2(50),
                            ANOS_TRAB  INTEGER,
                             COMISSAO  VARCHAR2(50),
                   CARGO_CLASIFICACAO  VARCHAR2(100),
                            NOME_DEPT  VARCHAR2(100),
                             DEPT_COD  INTEGER)';
              
                                
EXECUTE IMMEDIATE                                
'INSERT ALL 
  WHEN CARGO_CLASIFICACAO = ''TEM UM CARGO REGULAR'' THEN 
INTO TAB_CARGO_REGULAR VALUES(NOME,SALARIO,ANOS_TRAB,COMISSAO,CARGO_CLASIFICACAO,NOME_DEPT,DEPT_COD)
  WHEN CARGO_CLASIFICACAO = ''TAB_CARGO_BOM'' THEN 
INTO TAB_CARGO_BOM VALUES(NOME,SALARIO,ANOS_TRAB,COMISSAO,CARGO_CLASIFICACAO,NOME_DEPT,DEPT_COD) 
  WHEN CARGO_CLASIFICACAO = ''TEM UM CARGO OTIMO'' THEN 
INTO TAB_CARGO_OTIMO VALUES(NOME,SALARIO,ANOS_TRAB,COMISSAO,CARGO_CLASIFICACAO,NOME_DEPT,DEPT_COD)  
  WHEN CARGO_CLASIFICACAO = ''TEM UM CARGO EXCELENTE'' THEN 
INTO TAB_CARGO_EXCELENTE VALUES(NOME,SALARIO,ANOS_TRAB,COMISSAO,CARGO_CLASIFICACAO,NOME_DEPT,DEPT_COD)  
  WHEN CARGO_CLASIFICACAO = ''CARGOS SEM CLASIFICACAO'' THEN 
INTO TAB_CARGO_SEM_CLAS VALUES(NOME,SALARIO,ANOS_TRAB,COMISSAO,CARGO_CLASIFICACAO,NOME_DEPT,DEPT_COD)  
   SELECT NOME       AS NOME,
          SALARIO    AS SALARIO,
          ANOS_TRAB  AS ANOS_TRAB,
          COMISSAO   AS COMISSAO,
          CARGO_CLASIFICACAO AS CARGO_CLASIFICACAO,
          NOME_DEPT  AS NOME_DEPT,
          DEPT_COD   AS DEPT_COD
     FROM TAB_BASE_DADOS';

 COMMIT;
 
V_SQL_REGULAR := 'BEGIN
DBMS_OUTPUT.PUT_LINE(''  '');
DBMS_OUTPUT.PUT_LINE(''============ FUNCINARIOS QUE TEM O CARGO REGULAR ========='');
FOR I IN (SELECT NOME,SALARIO,ANOS_TRAB,
                 COMISSAO,CARGO_CLASIFICACAO,
                 NOME_DEPT,DEPT_COD 
            FROM TAB_CARGO_REGULAR) LOOP
DBMS_OUTPUT.PUT_LINE('' ========================================== '');
DBMS_OUTPUT.PUT_LINE(''NOME: ''||I.NOME);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''CARGO CLASIFICACAO: ''||I.CARGO_CLASIFICACAO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.NOME_DEPT);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
END LOOP;
 END;';

V_SQL_BOM := 'BEGIN
DBMS_OUTPUT.PUT_LINE(''  '');
DBMS_OUTPUT.PUT_LINE(''============ FUNCINARIOS QUE TEM O CARGO BOM ========='');
FOR I IN (SELECT NOME,SALARIO,ANOS_TRAB,
                 COMISSAO,CARGO_CLASIFICACAO,
                 NOME_DEPT,DEPT_COD 
            FROM TAB_CARGO_BOM) LOOP
DBMS_OUTPUT.PUT_LINE('' ========================================== '');
DBMS_OUTPUT.PUT_LINE(''NOME: ''||I.NOME);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''CARGO CLASIFICACAO: ''||I.CARGO_CLASIFICACAO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.NOME_DEPT);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
END LOOP;
 END;';
 
V_SQL_OTIMO := 'BEGIN
DBMS_OUTPUT.PUT_LINE(''  '');
DBMS_OUTPUT.PUT_LINE(''============ FUNCINARIOS QUE TEM O CARGO OTIMO ========='');
FOR I IN (SELECT NOME,SALARIO,ANOS_TRAB,
                 COMISSAO,CARGO_CLASIFICACAO,
                 NOME_DEPT,DEPT_COD 
            FROM TAB_CARGO_OTIMO) LOOP
DBMS_OUTPUT.PUT_LINE('' ========================================== '');
DBMS_OUTPUT.PUT_LINE(''NOME: ''||I.NOME);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''CARGO CLASIFICACAO: ''||I.CARGO_CLASIFICACAO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.NOME_DEPT);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
END LOOP;
 END;';

V_SQL_EXCELENTE := 'BEGIN
DBMS_OUTPUT.PUT_LINE(''  '');
DBMS_OUTPUT.PUT_LINE(''============ FUNCINARIOS QUE TEM O CARGO EXCELENTE ========='');
FOR I IN (SELECT NOME,SALARIO,ANOS_TRAB,
                 COMISSAO,CARGO_CLASIFICACAO,
                 NOME_DEPT,DEPT_COD 
            FROM  TAB_CARGO_EXCELENTE) LOOP
DBMS_OUTPUT.PUT_LINE('' ========================================== '');
DBMS_OUTPUT.PUT_LINE(''NOME: ''||I.NOME);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''CARGO CLASIFICACAO: ''||I.CARGO_CLASIFICACAO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.NOME_DEPT);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
END LOOP;
 END;';
 

V_SQL_SEM_CLAS := 'BEGIN
DBMS_OUTPUT.PUT_LINE(''  '');
DBMS_OUTPUT.PUT_LINE(''============ FUNCINARIOS QUE TEM O CARGO SEM CLASIFICACAO ========='');
FOR I IN (SELECT NOME,SALARIO,ANOS_TRAB,
                 COMISSAO,CARGO_CLASIFICACAO,
                 NOME_DEPT,DEPT_COD 
            FROM TAB_CARGO_SEM_CLAS) LOOP
DBMS_OUTPUT.PUT_LINE('' ========================================== '');
DBMS_OUTPUT.PUT_LINE(''NOME: ''||I.NOME);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''CARGO CLASIFICACAO: ''||I.CARGO_CLASIFICACAO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.NOME_DEPT);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
END LOOP;
 END;';
 
EXECUTE IMMEDIATE V_SQL_REGULAR;
EXECUTE IMMEDIATE V_SQL_BOM;
EXECUTE IMMEDIATE V_SQL_OTIMO;
EXECUTE IMMEDIATE V_SQL_EXCELENTE;
EXECUTE IMMEDIATE V_SQL_SEM_CLAS;

EXECUTE IMMEDIATE 'DROP TABLE TAB_BASE_DADOS PURGE';
EXECUTE IMMEDIATE 'DROP TABLE TAB_CARGO_REGULAR PURGE';
EXECUTE IMMEDIATE 'DROP TABLE TAB_CARGO_BOM PURGE';
EXECUTE IMMEDIATE 'DROP TABLE TAB_CARGO_OTIMO PURGE';
EXECUTE IMMEDIATE 'DROP TABLE TAB_CARGO_EXCELENTE PURGE';
EXECUTE IMMEDIATE 'DROP TABLE TAB_CARGO_SEM_CLAS PURGE';

END;




SELECT * FROM TAB_CARGO_REGULAR;

SELECT * FROM TAB_CARGO_BOM;

SELECT * FROM TAB_CARGO_OTIMO;

SELECT * FROM TAB_CARGO_EXCELENTE;
                                
SELECT * FROM TAB_CARGOS_SEM_CLAS;






