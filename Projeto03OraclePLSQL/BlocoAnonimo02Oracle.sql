

SET SERVEROUTPUT ON;


DECLARE 
 V_CRIA_VIEW  VARCHAR2(1000);
 V_QUARY_14   VARCHAR2(2000);
 V_QUARY_15   VARCHAR2(2000);
 V_QUARY_16   VARCHAR2(2000);
 V_QUARY_17   VARCHAR2(2000);
 V_QUARY_18   VARCHAR2(2000);
BEGIN

/*VARIAVEL QUE CRIA UMA VIEW PARA TER UMA BASE DE DADOS*/
V_CRIA_VIEW := 'CREATE OR REPLACE VIEW VW_SAL_BONUS_ANOS_TRAB AS 
                  SELECT E.EMPLOYEE_ID                  AS EMP_COD,
                         E.FIRST_NAME||'' ''||E.LAST_NAME AS NOME_FUNC,
                         E.SALARY                       AS SALARIO,
                         E.JOB_ID                       AS CARGO,
                         D.DEPARTMENT_NAME              AS DEPT_NOME,
                         DEPARTMENT_ID                  AS DEPT_COD,
                         ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) AS ANOS_TRAB,
                         NVL(TO_CHAR(COMMISSION_PCT), ''SEM COMISSAO'') AS COMISSAO
                    FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                   USING(DEPARTMENT_ID)
                   WHERE ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) BETWEEN 14 AND 18
              WITH READ ONLY 
                CONSTRAINT VW_BONUS_SAL_ANO';

EXECUTE IMMEDIATE V_CRIA_VIEW;
    



EXECUTE IMMEDIATE 'CREATE TABLE TAB_14_ANOS_TRAB(EMP_COD   INTEGER,
                                                 NOME_FUNC VARCHAR2(200),
                                                 SALARIO   NUMBER(8,2),
                                                 CARGO     VARCHAR2(50),
                                                 DEPT_NOME VARCHAR2(100),
                                                 DEPT_COD  INTEGER,
                                                 ANOS_TRAB INTEGER,
                                                 COMISSAO  VARCHAR2(100),
                                                 SAL_BONUS NUMBER(8,2))';
  


EXECUTE IMMEDIATE 'CREATE TABLE TAB_15_ANOS_TRAB(EMP_COD   INTEGER,
                                                 NOME_FUNC VARCHAR2(200),
                                                 SALARIO   NUMBER(8,2),
                                                 CARGO     VARCHAR2(50),
                                                 DEPT_NOME VARCHAR2(100),
                                                 DEPT_COD  INTEGER,
                                                 ANOS_TRAB INTEGER,
                                                 COMISSAO  VARCHAR2(100),
                                                 SAL_BONUS NUMBER(8,2))';



EXECUTE IMMEDIATE 'CREATE TABLE TAB_16_ANOS_TRAB(EMP_COD   INTEGER,
                                                 NOME_FUNC VARCHAR2(200),
                                                 SALARIO   NUMBER(8,2),
                                                 CARGO     VARCHAR2(50),
                                                 DEPT_NOME VARCHAR2(100),
                                                 DEPT_COD  INTEGER,
                                                 ANOS_TRAB INTEGER,
                                                COMISSAO  VARCHAR2(100),
                                                SAL_BONUS NUMBER(8,2))';




EXECUTE IMMEDIATE 'CREATE TABLE TAB_17_ANOS_TRAB(EMP_COD   INTEGER,
                                                 NOME_FUNC VARCHAR2(200),
                                                 SALARIO   NUMBER(8,2),
                                                 CARGO     VARCHAR2(50),
                                                 DEPT_NOME VARCHAR2(100),
                                                 DEPT_COD  INTEGER,
                                                 ANOS_TRAB INTEGER,
                                                COMISSAO  VARCHAR2(100),
                                                SAL_BONUS NUMBER(8,2))';




EXECUTE IMMEDIATE 'CREATE TABLE TAB_18_ANOS_TRAB(EMP_COD   INTEGER,
                                                 NOME_FUNC VARCHAR2(200),
                                                 SALARIO   NUMBER(8,2),
                                                 CARGO     VARCHAR2(50),
                                                 DEPT_NOME VARCHAR2(100),
                                                 DEPT_COD  INTEGER,
                                                 ANOS_TRAB INTEGER,
                                                 COMISSAO  VARCHAR2(100),
                                                 SAL_BONUS NUMBER(8,2))';
   
                


EXECUTE IMMEDIATE 'INSERT ALL 
 WHEN ANOS_TRAB = 14 THEN 
INTO TAB_14_ANOS_TRAB VALUES (EMP_COD,NOME_FUNC,SALARIO,CARGO,
                              DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS)
 WHEN ANOS_TRAB = 15 THEN 
INTO TAB_15_ANOS_TRAB VALUES (EMP_COD,NOME_FUNC,SALARIO,CARGO,
                              DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS)
 WHEN ANOS_TRAB = 16 THEN 
INTO TAB_16_ANOS_TRAB VALUES (EMP_COD,NOME_FUNC,SALARIO,CARGO,
                              DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS)
 WHEN ANOS_TRAB = 17 THEN 
INTO TAB_17_ANOS_TRAB VALUES (EMP_COD,NOME_FUNC,SALARIO,CARGO,
                              DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS)
 WHEN ANOS_TRAB = 18 THEN 
INTO TAB_18_ANOS_TRAB VALUES (EMP_COD,NOME_FUNC,SALARIO,CARGO,
                              DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS)
 SELECT EMP_COD    AS EMP_COD,
        NOME_FUNC  AS NOME_FUNC,
        SALARIO    AS SALARIO,
        CARGO      AS CARGO,
        DEPT_NOME  AS DEPT_NOME,
        DEPT_COD   AS DEPT_COD,
        ANOS_TRAB  AS ANOS_TRAB,
        COMISSAO   AS COMISSAO,
   CASE WHEN ANOS_TRAB = 14 THEN (SALARIO + 140)
        WHEN ANOS_TRAB = 15 THEN (SALARIO + 150)
        WHEN ANOS_TRAB = 16 THEN (SALARIO + 160)
        WHEN ANOS_TRAB = 17 THEN (SALARIO + 340)
        WHEN ANOS_TRAB = 18 THEN (SALARIO + 360)
     ELSE SALARIO
      END AS SAL_BONUS
   FROM VW_SAL_BONUS_ANOS_TRAB';
 
 
V_QUARY_14 := 'BEGIN
DBMS_OUTPUT.PUT_LINE('' '');
DBMS_OUTPUT.PUT_LINE(''========== TABELA DOS FUNCIONARIOS 14 ANOS DE FIRMA =========='');
 FOR I IN(SELECT EMP_COD,NOME_FUNC,SALARIO,CARGO,
               DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS
          FROM TAB_14_ANOS_TRAB) LOOP
DBMS_OUTPUT.PUT_LINE(''========================================================'');
DBMS_OUTPUT.PUT_LINE(''CODIGO DO EMPREGADO: ''||I.EMP_COD);
DBMS_OUTPUT.PUT_LINE(''NOME FUNCINARIO: ''||I.NOME_FUNC);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''CARGO: ''||I.CARGO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.DEPT_NOME);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''SALARIO BONUS: ''||I.SAL_BONUS);
 END LOOP;
END;';


V_QUARY_15 := 'BEGIN
DBMS_OUTPUT.PUT_LINE('' '');
DBMS_OUTPUT.PUT_LINE(''========== TABELA DOS FUNCIONARIOS 15 ANOS DE FIRMA =========='');
 FOR I IN(SELECT EMP_COD,NOME_FUNC,SALARIO,CARGO,
               DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS
          FROM TAB_15_ANOS_TRAB) LOOP
DBMS_OUTPUT.PUT_LINE(''========================================================'');
DBMS_OUTPUT.PUT_LINE(''CODIGO DO EMPREGADO: ''||I.EMP_COD);
DBMS_OUTPUT.PUT_LINE(''NOME FUNCINARIO: ''||I.NOME_FUNC);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''CARGO: ''||I.CARGO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.DEPT_NOME);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''SALARIO BONUS: ''||I.SAL_BONUS);
 END LOOP;
END;';


V_QUARY_16 := 
'BEGIN
DBMS_OUTPUT.PUT_LINE('' '');
DBMS_OUTPUT.PUT_LINE(''========== TABELA DOS FUNCIONARIOS 16 ANOS DE FIRMA =========='');
 FOR I IN(SELECT EMP_COD,NOME_FUNC,SALARIO,CARGO,
               DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS
          FROM TAB_16_ANOS_TRAB) LOOP
DBMS_OUTPUT.PUT_LINE(''========================================================'');
DBMS_OUTPUT.PUT_LINE(''CODIGO DO EMPREGADO: ''||I.EMP_COD);
DBMS_OUTPUT.PUT_LINE(''NOME FUNCINARIO: ''||I.NOME_FUNC);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''CARGO: ''||I.CARGO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.DEPT_NOME);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''SALARIO BONUS: ''||I.SAL_BONUS);
 END LOOP;
END;';


V_QUARY_17:= 'BEGIN
DBMS_OUTPUT.PUT_LINE('' '');
DBMS_OUTPUT.PUT_LINE(''========== TABELA DOS FUNCIONARIOS 17 ANOS DE FIRMA =========='');
 FOR I IN(SELECT EMP_COD,NOME_FUNC,SALARIO,CARGO,
               DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS
          FROM TAB_17_ANOS_TRAB) LOOP
DBMS_OUTPUT.PUT_LINE(''========================================================'');
DBMS_OUTPUT.PUT_LINE(''CODIGO DO EMPREGADO: ''||I.EMP_COD);
DBMS_OUTPUT.PUT_LINE(''NOME FUNCINARIO: ''||I.NOME_FUNC);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''CARGO: ''||I.CARGO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.DEPT_NOME);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''SALARIO BONUS: ''||I.SAL_BONUS);
 END LOOP;
END;';


V_QUARY_18 := 'BEGIN
DBMS_OUTPUT.PUT_LINE('' '');
DBMS_OUTPUT.PUT_LINE(''========== TABELA DOS FUNCIONARIOS 18 ANOS DE FIRMA =========='');
 FOR I IN(SELECT EMP_COD,NOME_FUNC,SALARIO,CARGO,
               DEPT_NOME,DEPT_COD,ANOS_TRAB,COMISSAO,SAL_BONUS
          FROM TAB_18_ANOS_TRAB) LOOP
DBMS_OUTPUT.PUT_LINE(''========================================================'');
DBMS_OUTPUT.PUT_LINE(''CODIGO DO EMPREGADO: ''||I.EMP_COD);
DBMS_OUTPUT.PUT_LINE(''NOME FUNCINARIO: ''||I.NOME_FUNC);
DBMS_OUTPUT.PUT_LINE(''SALARIO: ''||I.SALARIO);
DBMS_OUTPUT.PUT_LINE(''CARGO: ''||I.CARGO);
DBMS_OUTPUT.PUT_LINE(''NOME DEPARTAMENTO: ''||I.DEPT_NOME);
DBMS_OUTPUT.PUT_LINE(''CODIGO DEPARTAMENTO: ''||I.DEPT_COD);
DBMS_OUTPUT.PUT_LINE(''ANOS TRABALHADOS: ''||I.ANOS_TRAB);
DBMS_OUTPUT.PUT_LINE(''COMISSAO: ''||I.COMISSAO);
DBMS_OUTPUT.PUT_LINE(''SALARIO BONUS: ''||I.SAL_BONUS);
 END LOOP;
END;';

COMMIT;

EXECUTE IMMEDIATE V_QUARY_14;
EXECUTE IMMEDIATE V_QUARY_15;
EXECUTE IMMEDIATE V_QUARY_16;
EXECUTE IMMEDIATE V_QUARY_17;
EXECUTE IMMEDIATE V_QUARY_18;


EXECUTE IMMEDIATE 'DROP TABLE TAB_14_ANOS_TRAB PURGE';
EXECUTE IMMEDIATE 'DROP TABLE TAB_15_ANOS_TRAB PURGE';
EXECUTE IMMEDIATE 'DROP TABLE TAB_16_ANOS_TRAB PURGE';
EXECUTE IMMEDIATE 'DROP TABLE TAB_17_ANOS_TRAB PURGE';
EXECUTE IMMEDIATE 'DROP TABLE TAB_18_ANOS_TRAB PURGE';
EXECUTE IMMEDIATE 'DROP VIEW VW_SAL_BONUS_ANOS_TRAB';

END;





