


CREATE OR REPLACE PROCEDURE sp_calcular_troco(
  OUT troco INT,
  IN valor_a_pagar INT,
  IN valor_total INT  
) LANGUAGE plpgsql
AS $$
BEGIN
  troco := valor_a_pagar - valor_total;  
END;
$$


-- DO $$
-- BEGIN
--   CALL sp_fechar_pedido(200, 1);
-- END;
-- $$

-- SELECT * FROM tb_pedido;

--fechar pedido
--informar valor a pagar em modo IN
--e codigo do pedido em modo IN
--chamar a proc para verificar o valor total do pedido
--se o valor que chegou via parâmetro for suficiente, fechar
--caso contrário, dizer que não é suficiente
-- CREATE OR REPLACE PROCEDURE sp_fechar_pedido(
--   IN valor_a_pagar INT,
--   IN cod_pedido INT
-- ) LANGUAGE plpgsql
-- AS $$
-- DECLARE
--   valor_total INT;
-- BEGIN
--   CALL sp_calcular_valor_de_um_pedido(cod_pedido, valor_total);
--   IF valor_a_pagar < valor_total THEN
--     RAISE 'R$% insuficiente para pagar a conta de R$%', valor_a_pagar, valor_total;
--   ELSE
--     UPDATE tb_pedido p SET
--     data_modificacao = CURRENT_TIMESTAMP,
--     status = 'fechado'
--     WHERE p.cod_pedido = $2;
--   END IF;
-- END;
-- $$




--calcular valor de um pedido, ou seja, somar o valor de todos os seus itens
--disponibilizar o valor total numa variável em modo OUT
--o parâmetro que chega em modo IN é o código do pedido

DO $$
DECLARE
  valor_total INT;
BEGIN
  CALL sp_calcular_valor_de_um_pedido(1, valor_total);
  RAISE NOTICE 'Total do pedido %: R$%', 1, valor_total;
END;
$$

CREATE OR REPLACE PROCEDURE sp_calcular_valor_de_um_pedido(
  IN p_cod_pedido INT,
  OUT valor_total INT
) LANGUAGE plpgsql
AS $$
BEGIN
  SELECT SUM(valor) FROM
  tb_pedido p
  INNER JOIN tb_item_pedido ip ON
  p.cod_pedido = ip.cod_pedido
  INNER JOIN tb_item i ON
  i.cod_item = ip.cod_item
  WHERE p.cod_pedido = $1
  INTO $2;
END;
$$

SELECT * FROM tb_item;

CALL sp_adicionar_item_a_pedido(3, 1);
-- SELECT * FROM tb_item_pedido;
-- SELECT * FROM tb_pedido;

-- CREATE OR REPLACE PROCEDURE sp_adicionar_item_a_pedido(
--   IN cod_item INT,
--   IN cod_pedido INT
-- ) LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   INSERT INTO tb_item_pedido
--     (cod_item, cod_pedido)
--   VALUES
--     ($1, $2);
--   UPDATE tb_pedido p 
--   SET data_modificacao = CURRENT_TIMESTAMP
--   WHERE p.cod_pedido = $2;
-- END;
-- $$
-- Active: 1778585004725@@127.0.0.1@5432@20261_fatec_ipi_pbdi_rodrigo
--escrever um proc que adiciona um item a um pedido
--ele deve associar o item ao pedido e atualizar a data de modificação
--parâmetros: cod_item e o cod_pedido

-- SELECT * FROM tb_pedido;

-- DO $$
-- DECLARE
--   cod_pedido INT;
--   cod_cliente INT;
-- BEGIN
--   SELECT c.cod_cliente FROM tb_cliente c
--   WHERE nome LIKE 'João da Silva' INTO cod_cliente;
--   CALL sp_criar_pedido(cod_pedido, cod_cliente);
--   RAISE NOTICE 'Código de pedido gerado: %', cod_pedido;
-- END;
-- $$

-- CREATE OR REPLACE PROCEDURE sp_criar_pedido(
--   OUT cod_pedido INT,
--   IN cod_cliente INT
-- ) LANGUAGE PLPGSQL
-- AS $$
-- BEGIN
--   INSERT INTO tb_pedido(cod_cliente) VALUES(cod_cliente);
--   --pegar o código de pedido gerado e guardar na variável cod_pedido
--   SELECT LASTVAL() INTO cod_pedido;
-- END;
-- $$

-- CALL sp_cadastrar_cliente('João da Silva');
-- CALL sp_cadastrar_cliente('Maria Santos');

-- CREATE OR REPLACE PROCEDURE sp_cadastrar_cliente(
--   IN nome VARCHAR(200),
--   IN codigo INT DEFAULT NULL
-- ) LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   --se o código for null, cadastrar apenas nome, gerando automático
--   IF codigo IS NULL THEN
--     INSERT INTO tb_cliente(nome) VALUES(nome);
--   --caso contrário, cadastrar com o código recebido
--   ELSE
--     INSERT INTO tb_cliente(cod_cliente, nome) VALUES(codigo, nome);
--   END IF;
-- END;
-- $$

-- CREATE TABLE tb_item_pedido(
--   --surrogate key
--   cod_item_pedido SERIAL PRIMARY KEY,
--   cod_item INT,
--   cod_pedido INT,
--   CONSTRAINT fk_item
--     FOREIGN KEY (cod_item) REFERENCES tb_item (cod_item),
--   CONSTRAINT fk_pedido
--     FOREIGN KEY (cod_pedido) REFERENCES tb_pedido (cod_pedido)
-- );
-- INSERT INTO tb_item
-- (descricao, valor, cod_tipo)
-- VALUES
-- ('Refrigerante', 10, 1),
-- ('Suco', 8, 1),
-- ('Hambúrguer', 55, 2),
-- ('Batata Frita', 15, 2),
-- ('Nuggets', 5, 2);

-- CREATE TABLE tb_item(
--   cod_item SERIAL PRIMARY KEY,
--   descricao VARCHAR(200) NOT NULL,
--   valor NUMERIC(10, 2) NOT NULL,
--   cod_tipo INT NOT NULL,
--   CONSTRAINT fk_tipo_item FOREIGN KEY (cod_tipo) REFERENCES
--   tb_tipo(cod_tipo)
-- );

-- CREATE TABLE tb_tipo(
--   cod_tipo SERIAL PRIMARY KEY,
--   descricao VARCHAR(200) NOT NULL
-- );
-- INSERT INTO tb_tipo
-- (descricao)
-- VALUES
-- ('Bebida'),
-- ('Comida');
-- SELECT * FROM tb_tipo;

-- CREATE TABLE tb_pedido(
--   cod_pedido SERIAL PRIMARY KEY,
--   data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   status VARCHAR DEFAULT 'aberto',
--   cod_cliente INT NOT NULL,
--   CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES tb_cliente(cod_cliente)
-- );

-- CREATE TABLE tb_cliente(
--   cod_cliente SERIAL PRIMARY KEY,
--   nome VARCHAR(200) NOT NULL
-- );

-- CREATE OR REPLACE PROCEDURE sp_calcula_media(
--   VARIADIC valores INT []
-- ) LANGUAGE PLPGSQL
-- AS $$
-- DECLARE
--   media NUMERIC(10, 2) := 0;
--   valor INT;
-- BEGIN
--   FOREACH valor IN ARRAY valores LOOP
--     media := media + valor;
--   END LOOP;
--   RAISE NOTICE 'A média é %', media / array_length(valores, 1);
-- END;
-- $$

-- CALL sp_calcula_media(1);
-- CALL sp_calcula_media(1, 2);
-- CALL sp_calcula_media(1, 2, 3, 4, 5, 6);


-- DO $$
-- DECLARE
--   valor1 INT := 2;
--   valor2 INT := 3;
-- BEGIN
--   CALL sp_acha_maior(valor1, valor2);
--   RAISE NOTICE '% é o maior', valor1;
-- END;
-- $$

-- DROP PROCEDURE IF EXISTS sp_acha_maior;
-- CREATE OR REPLACE PROCEDURE sp_acha_maior(
--   INOUT valor1 INT,
--   IN valor2 INT
-- )LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   IF valor2 > valor1 THEN
--     valor1 := valor2;
--   END IF;
-- END;
-- $$

-- DO $$
-- DECLARE
--   resultado INT;
-- BEGIN
--   CALL sp_acha_maior(resultado, 2, 3);
--   RAISE NOTICE '% é o maior', resultado;
-- END;
-- $$

-- DROP PROCEDURE IF EXISTS sp_acha_maior;
-- CREATE OR REPLACE PROCEDURE sp_acha_maior(
--   OUT resultado INT,
--   IN valor1 INT,
--   IN valor2 INT
-- ) LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   CASE
--     WHEN valor1 > valor2 THEN
--       $1 := valor1;
--     ELSE
--       resultado := valor2;
--   END CASE;
-- END;
-- $$

-- CALL sp_acha_maior(2, 3);

-- CREATE OR REPLACE PROCEDURE sp_acha_maior(
--   IN valor1 INT,
--   valor2 INT  
-- ) LANGUAGE plpgsql
-- AS $$
-- BEGIN
--  IF valor1 > valor2 THEN
--   RAISE NOTICE '% é o maior', valor1;
--  ELSE
--   RAISE NOTICE '% é o maior', $2;
--  END IF;
-- END;


-- CALL sp_ola_usuario('Pedro');

-- CREATE OR REPLACE PROCEDURE sp_ola_usuario(nome VARCHAR(200))
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RAISE NOTICE 'Olá, %', nome;
--   --também vale assim
--   RAISE NOTICE 'Olá, %', $1;
-- END;
-- $$

-- CALL sp_ola_procedures();

-- CREATE OR REPLACE PROCEDURE sp_ola_procedures()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RAISE NOTICE 'Olá, procedures';
-- END;
-- $$