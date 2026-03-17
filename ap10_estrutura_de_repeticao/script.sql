DO $$
BEGIN
  RAISE NOTICE 'De 1 a 10, de um em um';
  FOR i IN 1..10 LOOP
    RAISE NOTICE '%', i;
  END LOOP;

  RAISE NOTICE 'E agora...?';
  FOR i IN 10..1 LOOP
    RAISE NOTICE '%', i;
  END LOOP;

  RAISE NOTICE 'De 10 a 1, de um em um';
  FOR i IN REVERSE 10..1 LOOP
    RAISE NOTICE '%', i;
  END LOOP;

  RAISE NOTICE 'De 1 a 50, de dois em dois';
  FOR i IN 1..50 BY 2 LOOP
    RAISE NOTICE '%', i;
  END LOOP;

END;
$$

-- DO $$
-- DECLARE
--   nota INT;
--   media NUMERIC(10, 2) := 0;
--   contador INT := 0;
-- BEGIN
--   SELECT fn_valor_aleatorio_entre(0, 11) - 1 INTO nota;
  
--   WHILE nota >= 0 LOOP
--     RAISE NOTICE 'Nota desse aluno: %', nota;
--     media := media + nota;
--     contador := contador + 1;
--     SELECT fn_valor_aleatorio_entre(0, 11) - 1 INTO nota;
--   END LOOP;
--   IF contador > 0 THEN
--     RAISE NOTICE 'Média: %', media / contador;
--   ELSE
--     RAISE NOTICE 'Nenhuma nota gerada';
--   END IF;
-- END;
-- $$

-- DO $$
-- DECLARE
--   i INT;
--   j INT;
-- BEGIN
--   i := 0;
--   <<externo>>
--   LOOP
--     i := i + 1;
--     EXIT WHEN i > 10;
--     j := 1;
--     <<interno>>
--     LOOP
--       RAISE NOTICE '% %', i, j;
--       j := j + 1;
--       EXIT WHEN j > 10;
--       CONTINUE externo WHEN j > 5;
--     END LOOP;
--   END LOOP;
-- END;
-- $$

-- contar até 100, ignorando múltiplos de 7 e de 11
-- DO $$
-- DECLARE
--   contador INT := 0;
-- BEGIN
--   LOOP
--     contador := contador + 1;
--     EXIT WHEN contador > 100;
    
--     IF contador % 7 = 0 THEN
--       CONTINUE;
--     END IF;

--     CONTINUE WHEN contador % 11 = 0;

--     RAISE NOTICE '%', contador;
--   END LOOP;
-- END;
-- $$

-- DO $$
-- DECLARE
--   contador INT := 1;
-- BEGIN
--   LOOP
--     RAISE NOTICE '%', contador;
--     contador := contador + 1;
--     EXIT WHEN contador > 10;
--   END LOOP;
-- END;
-- $$

-- DO $$
-- DECLARE
--   contador INT := 1;
-- BEGIN
--   LOOP
--     RAISE NOTICE '%', contador;
--     contador := contador + 1; -- não tem contador++;
--     IF contador > 10 THEN
--       EXIT;
--     END IF;
--   END LOOP;
-- END;
-- $$


-- DO $$
-- BEGIN
--   LOOP
--     RAISE NOTICE 'Teste loop simples...';
--   END LOOP;
-- END;
-- $$