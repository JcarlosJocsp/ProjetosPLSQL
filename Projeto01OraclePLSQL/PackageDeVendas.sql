


/*CHAMANDO A PROCEDURE PARA FORA DA PACKAGE*/
CREATE OR REPLACE PACKAGE PKG_VOUCHER_DESC IS
 PROCEDURE SP_VENDAS (P_COD_LOJ     IN LOJISTA.COD_LOJ      %TYPE,
                      P_CPF_CLI     IN CAD_CLI_02.CPF_CLI   %TYPE,
                      P_COD_PRO     IN PRODUTO.COD_PRO      %TYPE,
                      P_COD_VAUCHER IN VAUCHER.COD_VAU      %TYPE);
 END PKG_VOUCHER_DESC;





/*PROCEDURE DE VENDAS*/
CREATE OR REPLACE PACKAGE BODY PKG_VOUCHER_DESC 
IS
PROCEDURE SP_VENDAS
(P_COD_LOJ     IN LOJISTA.COD_LOJ      %TYPE,
 P_CPF_CLI     IN CAD_CLI_02.CPF_CLI   %TYPE,
 P_COD_PRO     IN PRODUTO.COD_PRO      %TYPE,
 P_COD_VAUCHER IN VAUCHER.COD_VAU      %TYPE)
IS 
/*VARIAVEIS DO INSERTE*/
V_CAP_COD_LOJ   VARCHAR2(500);
V_CAP_CPF_CLI   VARCHAR2(500);
V_CAP_COD_PRO   VARCHAR2(500);
V_CAP_PRECO_PRO VARCHAR2(500);
V_COD_LOJ       INTEGER;
V_CPF_CLI       INTEGER;
V_COD_PRO       INTEGER;
V_PRECO_PRO     INTEGER;

/*VARIAVEIS DOS VAUCHERS*/
V_SQL_DESC_10 VARCHAR2(500);
V_SQL_DESC_20 VARCHAR2(500);
V_SQL_DESC_30 VARCHAR2(500);
V_SQL_DESC_40 VARCHAR2(500);
V_SQL_DESC_50 VARCHAR2(500);
V_DESC_10 NUMBER(8,2);
V_DESC_20 NUMBER(8,2);
V_DESC_30 NUMBER(8,2);
V_DESC_40 NUMBER(8,2);
V_DESC_50 NUMBER(8,2);


/*VARIAVEL DE ERRO*/
V_ERRO EXCEPTION;

BEGIN 
V_CAP_COD_LOJ := 'SELECT COD_LOJ FROM LOJISTA WHERE COD_LOJ = :P_COD_LOJ ';
V_CAP_CPF_CLI := 'SELECT CPF_CLI FROM CAD_CLI_02 WHERE CPF_CLI = :P_CPF_CLI';
V_CAP_COD_PRO := 'SELECT COD_PRO FROM PRODUTO WHERE COD_PRO = :P_COD_PRO';
V_CAP_PRECO_PRO := 'SELECT PRECO_PRO FROM PRODUTO WHERE COD_PRO = :P_COD_PRO';

EXECUTE IMMEDIATE V_CAP_COD_LOJ INTO V_COD_LOJ USING P_COD_LOJ ;
EXECUTE IMMEDIATE V_CAP_CPF_CLI INTO V_CPF_CLI USING P_CPF_CLI;
EXECUTE IMMEDIATE V_CAP_COD_PRO INTO V_COD_PRO USING P_COD_PRO;
EXECUTE IMMEDIATE V_CAP_PRECO_PRO INTO V_PRECO_PRO USING P_COD_PRO;

V_SQL_DESC_10 := 'SELECT PORCENTAGEM_DES FROM VAUCHER WHERE COD_VAU = ''NHZ3456KFSD''';
V_SQL_DESC_20 := 'SELECT PORCENTAGEM_DES FROM VAUCHER WHERE COD_VAU = ''FHJ9078TGSL''';
V_SQL_DESC_30 := 'SELECT PORCENTAGEM_DES FROM VAUCHER WHERE COD_VAU = ''QWH7856PMNG''';
V_SQL_DESC_40 := 'SELECT PORCENTAGEM_DES FROM VAUCHER WHERE COD_VAU = ''JKB4539FFEW''';
V_SQL_DESC_50 := 'SELECT PORCENTAGEM_DES FROM VAUCHER WHERE COD_VAU = ''LDR7856QPZF''';

EXECUTE IMMEDIATE V_SQL_DESC_10 INTO V_DESC_10;
EXECUTE IMMEDIATE V_SQL_DESC_20 INTO V_DESC_20;
EXECUTE IMMEDIATE V_SQL_DESC_30 INTO V_DESC_30;
EXECUTE IMMEDIATE V_SQL_DESC_40 INTO V_DESC_40;
EXECUTE IMMEDIATE V_SQL_DESC_50 INTO V_DESC_50;


  INSERT /*+append*/ INTO VENDAS VALUES (V_COD_LOJ,V_CPF_CLI,V_COD_PRO,V_PRECO_PRO,P_COD_VAUCHER);
COMMIT; 
  DBMS_OUTPUT.PUT_LINE(' VENDA FEITA COM SUCESSO !!! ');
  
 
/*INICIANDO MINHAS CONDICOES*/
 IF P_COD_VAUCHER = 'NHZ3456KFSD' THEN 
  UPDATE VENDAS 
     SET TOTAL_COMPRA = TOTAL_COMPRA - TOTAL_COMPRA * V_DESC_10
   WHERE COD_CLI = V_CPF_CLI;
 DBMS_OUTPUT.PUT_LINE(' DESCONTO DE 10% NA COMPRA');
COMMIT;

ELSIF P_COD_VAUCHER = 'FHJ9078TGSL' THEN
   UPDATE VENDAS 
     SET TOTAL_COMPRA = TOTAL_COMPRA - TOTAL_COMPRA * V_DESC_20
   WHERE COD_CLI = V_CPF_CLI;
 DBMS_OUTPUT.PUT_LINE(' DESCONTO DE 20% NA COMPRA');
COMMIT;

ELSIF P_COD_VAUCHER = 'QWH7856PMNG' THEN
   UPDATE VENDAS 
     SET TOTAL_COMPRA = TOTAL_COMPRA - TOTAL_COMPRA * V_DESC_30
   WHERE COD_CLI = V_CPF_CLI;
 DBMS_OUTPUT.PUT_LINE(' DESCONTO DE 30% NA COMPRA');
COMMIT;

ELSIF P_COD_VAUCHER = 'JKB4539FFEW' THEN
   UPDATE VENDAS 
     SET TOTAL_COMPRA = TOTAL_COMPRA - TOTAL_COMPRA * V_DESC_40
   WHERE COD_CLI = V_CPF_CLI;
 DBMS_OUTPUT.PUT_LINE(' DESCONTO DE 40% NA COMPRA');
COMMIT;

ELSIF P_COD_VAUCHER = 'LDR7856QPZF' THEN
   UPDATE VENDAS 
     SET TOTAL_COMPRA = TOTAL_COMPRA - TOTAL_COMPRA * V_DESC_50
   WHERE COD_CLI = V_CPF_CLI;
 DBMS_OUTPUT.PUT_LINE(' DESCONTO DE 50% NA COMPRA');
COMMIT;

ELSIF P_COD_VAUCHER != 'NHZ3456KFSD' 
      OR 
      P_COD_VAUCHER != 'FHJ9078TGSL'
      OR
      P_COD_VAUCHER != 'QWH7856PMNG'
      OR 
      P_COD_VAUCHER != 'JKB4539FFEW'
      OR 
      P_COD_VAUCHER != 'LDR7856QPZF' THEN 
RAISE V_ERRO;

ELSE
 DBMS_OUTPUT.PUT_LINE(' ESTE CLIENTE NÃO OBTEVE O VAUCHAR');
END IF;

 EXCEPTION WHEN DUP_VAL_ON_INDEX THEN 
   DBMS_OUTPUT.PUT_LINE('ERRO ID OU CPF IGUAIS');
 WHEN V_ERRO THEN 
RAISE_APPLICATION_ERROR(-20000, 'ERRO: CODIGO DO VAUCHER DIGITADO ERRADO, OU NAO CONSTA NA BASE DA DADOS');
 WHEN OTHERS THEN 
  DBMS_OUTPUT.PUT_LINE('ERRO INESPERADO ');
  DBMS_OUTPUT.PUT_LINE('VALORES DE ALGUMS PARAMETRO NAO ESTAO CORRETOS !!!');
END SP_VENDAS;
END PKG_VOUCHER_DESC;







/*CHAMADA DA PROCEDURE SP_VENDAS */
BEGIN 
  SP_VENDAS (P_COD_LOJ     => &DIGITE_COD_LOJISTA,
             P_CPF_CLI     => &DIGITE_CPF_DO_CLIENTE,
             P_COD_PRO     => &DIGITE_COD_PRO,
             
             P_COD_VAUCHER => '&DIGITE_CODIGO_VAUCHER');
END;  
  
  


