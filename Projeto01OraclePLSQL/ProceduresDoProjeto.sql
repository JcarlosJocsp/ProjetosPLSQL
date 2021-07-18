


/*PROCEDURE DE CADASTRO DE CLIENTES*/
CREATE OR REPLACE PROCEDURE SP_CAD_CLI
(P_CPF_CLI   IN CAD_CLI_02.CPF_CLI      %TYPE,
 P_NOME_CLI  IN CAD_CLI_02.NOME_CLI     %TYPE)
IS 
BEGIN
 INSERT INTO CAD_CLI_02 VALUES (SEQ_CLI.NEXTVAL,P_CPF_CLI,INITCAP(P_NOME_CLI));
COMMIT;
DBMS_OUTPUT.PUT_LINE(' CLIENTE CADASTRADO COM SUCESSO !!!');
END;



BEGIN
  SP_CAD_CLI (P_CPF_CLI  => &DIGITE_CPF_CLI,
              P_NOME_CLI => '&DIGITE_NOME_CLI');
END;
              
           

/*PROCEDURE DE CADASTRO DE PRODUTOS*/
CREATE OR REPLACE PROCEDURE SP_COD_PRO 
(P_NOME_PRODUTO IN  PRODUTO.NOME_PRODUTO %TYPE,
 P_PRECO_PRO    IN  PRODUTO.PRECO_PRO    %TYPE)
IS 
BEGIN 
 INSERT INTO PRODUTO VALUES (SEQ_PRO.NEXTVAL,INITCAP(P_NOME_PRODUTO), P_PRECO_PRO);
COMMIT;
 DBMS_OUTPUT.PUT_LINE(' PRODUTO CADASTRADO COM SUCESSO !!!');
END;



BEGIN 
 SP_COD_PRO (P_NOME_PRODUTO  => '&DIGITE_NOME_PRO',
             P_PRECO_PRO     => &DIGITE_PRECO_PRO);
END;




/*PROCEDURE DE CADASTRO DE LOJISTA*/
CREATE OR REPLACE PROCEDURE SP_LOJISTA 
(P_NOME_LOJI IN LOJISTA.NOME_LOJISTA %TYPE)
IS 
BEGIN 
 INSERT INTO LOJISTA VALUES (SEQ_LOJI.NEXTVAL,INITCAP(P_NOME_LOJI));
COMMIT;
DBMS_OUTPUT.PUT_LINE(' LOJISTA CADASTRADO COM SUCESSO !!!');
END;



BEGIN 
 SP_LOJISTA (P_NOME_LOJI  => '&DIGITE_NOME_LOJISTAO');       
END;



