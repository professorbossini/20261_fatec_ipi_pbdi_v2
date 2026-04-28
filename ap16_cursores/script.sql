SELECT * FROM tb_top_youtubers;
DO $$
DECLARE
  cur_delete REFCURSOR;
  tupla RECORD;
BEGIN
  OPEN cur_delete SCROLL FOR
  SELECT * FROM tb_top_youtubers;
  LOOP
    FETCH cur_delete INTO tupla;
    EXIT WHEN NOT FOUND;
    IF tupla.video_count IS NULL THEN
      DELETE FROM tb_top_youtubers WHERE CURRENT OF cur_delete;
    END IF;
  END LOOP;

  LOOP
    FETCH BACKWARD FROM cur_delete INTO tupla;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE '%', tupla;
  END LOOP;

  CLOSE cur_delete;
END;
$$

--exibir os nomes dos youtubers que começaram a partir de 2010 e têm, pelo menos, 60 milhões de inscritos, usando um parâmetro nomeado e outro pela ordem

--fazer um cursor vinculado para exibir o nome de cada youtuber e seu número de inscrições
-- DO $$
-- DECLARE
-- 	--1. Declaração (vinculado ou bound)
-- 	cur_nomes_e_inscritos CURSOR FOR
-- 	SELECT youtuber, subscribers FROM tb_top_youtubers;
-- 	tupla RECORD;
-- 	resultado TEXT DEFAULT '';
-- BEGIN
-- 	--2. Abertura
-- 	OPEN cur_nomes_e_inscritos;
-- 	--façamos com while...
-- 	--3. Recuperação
-- 	FETCH cur_nomes_e_inscritos INTO tupla;
-- 	WHILE FOUND
-- 	LOOP
-- 		resultado := resultado || tupla.youtuber || ': ' || tupla.subscribers || ', ';
-- 		FETCH cur_nomes_e_inscritos INTO tupla;
-- 	END LOOP;
-- 	--4. Fechamento do cursor
-- 	CLOSE cur_nomes_e_inscritos;
-- 	RAISE NOTICE '%', resultado;
-- END;
-- $$

-- DO $$
-- DECLARE
-- 	--1. Declaração
-- 	cur_nomes_a_partir_de REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- 	v_ano INT := 2020;
-- 	v_nome_tabela VARCHAR(200) := 'tb_top_youtubers';
-- BEGIN
-- 	--2. Abertura
-- 	OPEN cur_nomes_a_partir_de FOR EXECUTE
-- 	format(
-- 		'
-- 			SELECT youtuber FROM %s
-- 			WHERE started >= $1
-- 		',
-- 		v_nome_tabela
-- 	)USING v_ano;
-- 	LOOP
-- 		--3. Recuperação de dados
-- 		FETCH cur_nomes_a_partir_de INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	--4. Fechamento do cursor
-- 	CLOSE cur_nomes_a_partir_de;
-- 	RAISE NOTICE 'Acabou...';
-- END;
-- $$

-- DO $$
-- DECLARE
--  --1. Declaração do cursor
--  --não vin
--  cur_nomes_youtubers REFCURSOR;
-- BEGIN

-- END;
-- $$
-- SELECT * FROM tb_top_youtubers;
-- CREATE TABLE tb_top_youtubers(
-- 	cod_top_youtubers SERIAL PRIMARY KEY,
-- 	rank INT,
-- 	youtuber VARCHAR(200),
-- 	subscribers INT,
-- 	video_views VARCHAR(200),
-- 	video_count INT,
-- 	category VARCHAR(200),
-- 	started INT
-- );