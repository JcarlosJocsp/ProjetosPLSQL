

SET SERVEROUTPUT ON;


CREATE OR REPLACE FUNCTION F_CALCULADORA 
(P_NUMERO1   NUMBER,
 P_OPERACAO  VARCHAR2,
 P_NUMERO2   NUMBER)
RETURN NUMBER
IS 
TYPE CALCULADORA IS RECORD
(
V_CALCULO NUMBER
);

V_TYPE_CALC CALCULADORA;

BEGIN
  IF P_OPERACAO = 'SOMA' OR P_OPERACAO = '+' THEN
V_TYPE_CALC.V_CALCULO := P_NUMERO1 + P_NUMERO2;

ELSIF P_OPERACAO = 'SUBTRACAO' OR P_OPERACAO = '-' THEN
 V_TYPE_CALC.V_CALCULO := P_NUMERO1 - P_NUMERO2;

ELSIF P_OPERACAO = 'MULTIPLICACAO' OR P_OPERACAO = '*' THEN
 V_TYPE_CALC.V_CALCULO := P_NUMERO1 * P_NUMERO2;

ELSIF P_OPERACAO = 'DIVISAO' OR P_OPERACAO = '/' THEN
 V_TYPE_CALC.V_CALCULO := P_NUMERO1 / P_NUMERO2;

ELSIF P_OPERACAO = 'MOD' OR P_OPERACAO = 'RESTO DA DIVISAO' THEN
 V_TYPE_CALC.V_CALCULO := P_NUMERO1 - (P_NUMERO2 * FLOOR(P_NUMERO1/P_NUMERO2));
 END IF;
DBMS_OUTPUT.PUT_LINE('RESULTADO '||V_TYPE_CALC.V_CALCULO);
RETURN V_TYPE_CALC.V_CALCULO;

END;



/*CHAMANDO A FUNCAO 01*/
SELECT F_CALCULADORA(&DIGITE_UM_NUMERO,'&OPERACAO_ARITIMETICA',&DIGITE_SEG_NUMERO) AS RESULTADO
  FROM DUAL;




/*CHAMANDO A FUNCAO 02*/
DECLARE
   V_FUNCAO NUMBER;
BEGIN 
  V_FUNCAO := F_CALCULADORA(&DIGITE_UM_NUMERO,'&OPERACAO_ARITIMETICA',&DIGITE_SEG_NUMERO);
END;






  