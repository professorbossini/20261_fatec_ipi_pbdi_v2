DO $$
DECLARE
  valor INT := fn_valor_aleatorio_entre(1, 12);
  mensagem VARCHAR(200);
BEGIN
  RAISE NOTICE 'Valor gerado: %', valor;
  CASE valor
    WHEN 1, 3, 5, 7, 9 THEN
      mensagem := 'Ímpar';
    WHEN 2, 4, 6, 8, 10 THEN
      mensagem := 'Par';
    ELSE
      mensagem := 'Fora do intervalo';
  END CASE;
  RAISE NOTICE '%', mensagem;
END;
$$

-- DO $$
-- DECLARE
--   valor INT;
--   mensagem VARCHAR(200);
-- BEGIN
--   valor := fn_valor_aleatorio_entre(1, 12);
--   RAISE NOTICE 'O valor gerado é %', valor;
--   CASE valor
--     WHEN 1 THEN
--       mensagem := 'Ímpar';
--     WHEN 3 THEN
--       mensagem := 'Ímpar';
--     WHEN 5 THEN
--       mensagem := 'Ímpar';
--     WHEN 2 THEN
--       mensagem := 'Par';
--     WHEN 4 THEN
--       mensagem := 'Par';
--     WHEN 6 THEN
--       mensagem := 'Par';
--     ELSE
--       mensagem := 'Valor fora do intervalo';
--   END CASE;
--   RAISE NOTICE '%', mensagem;
-- END;
-- $$

-- DO $$
-- DECLARE
--   a INT := fn_valor_aleatorio_entre(0, 10);
--   b INT := fn_valor_aleatorio_entre(0, 10);
--   c INT := fn_valor_aleatorio_entre(0, 10);
--   delta NUMERIC(10, 2);
--   raizUm NUMERIC (10, 2);
--   raizDois NUMERIC(10, 2);
-- BEGIN
--   RAISE NOTICE 'Equação %x% + %x + % = 0', a, U&'\00B2',b, c;
--   IF a = 0 THEN
--     RAISE NOTICE 'Não é uma equação do segundo grau';
--   ELSE
--     -- calcular delta
--     delta := b ^ 2 - 4 * a * c;
--     RAISE NOTICE 'Valor de delta: %', delta;
--     --se delta for negativo, dizer que não tem raiz
--     --se delta for igual a zero, dizer que tem uma raiz e mostrar
--     --se delta for maior do que zero, dizer que tem duas raizes e mostrar ambas
--     IF delta < 0 THEN
--       RAISE NOTICE 'Nenhuma raiz';
--     ELSIF delta = 0 THEN
--       raizUm := (-b + |/delta) / (2 * a);
--       RAISE NOTICE 'Uma raiz: %', raizUm;
--     ELSE
--       raizUm := (-b + |/delta) / (2 * a);
--       raizDois := (-b - |/delta) / (2 * a);
--       RAISE NOTICE 'Duas raizes: % e %', raizUm, raizDois;
--     END IF;
--   END IF;
-- END;
-- $$

-- DO $$
-- DECLARE
--   valor INT := fn_valor_aleatorio_entre(1, 100);
-- BEGIN
--   RAISE NOTICE 'Valor gerado: %', valor;
--   IF valor % 2 = 0 THEN
--     RAISE NOTICE '% é par', valor;
--   ELSE
--     RAISE NOTICE '% é ímpar', valor;
--   END IF;
-- END;]

-- $$

-- DO $$
-- DECLARE
--   valor INT;
-- BEGIN
--   SELECT fn_valor_aleatorio_entre(1, 30) INTO valor;
--   RAISE NOTICE 'Valor gerado: %', valor;
--   IF valor BETWEEN 1 AND 20 THEN
--     RAISE NOTICE 'A metade do valor % é %', valor, valor / 2;
--   END IF;
-- END;
-- $$

-- DO $$
-- DECLARE
--  valor INT;
-- BEGIN
--   valor := fn_valor_aleatorio_entre(1, 30);
--   RAISE NOTICE 'Valor gerador: %', valor;
--   IF valor <= 20 THEN
--     RAISE NOTICE 'O valor % é menor do que 20', valor;
--   END IF;
-- END;
-- $$

-- SELECT fn_valor_aleatorio_entre(5, 17);

-- CREATE OR REPLACE FUNCTION fn_valor_aleatorio_entre
-- (lim_inferior INT, lim_superior INT)
-- RETURNS INT AS $$
-- BEGIN
--   RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
-- END;
-- $$ LANGUAGE plpgsql;


-- 1 10

-- FLOOR(RANDOM() * 10) + 1

-- 5 17
-- FLOOR(RANDOM() * (17 - 5) + 1) + 5