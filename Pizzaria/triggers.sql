USE Pizzaria;

DROP TRIGGER IF EXISTS trg_atualiza_valor_pedido;

DELIMITER $$

CREATE TRIGGER trg_atualiza_valor_pedido
AFTER INSERT ON Itens_Pedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos
    SET valor = (
        SELECT COALESCE(SUM(quantidade * valor), 0)
        FROM Itens_Pedido
        WHERE pedido_id = NEW.pedido_id
    )
    WHERE pedido_id = NEW.pedido_id;
END$$

DELIMITER ;

1) Claudiane Mendes Trigueiro Silva:

INSERT INTO Pedidos (cliente_id, data, hora)
SELECT cliente_id, CURDATE(), CURTIME()
FROM Clientes
WHERE nome = 'Claudiane Mendes Trigueiro Silva';

SET @pedido_claudiane = LAST_INSERT_ID();

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
SELECT @pedido_claudiane, p.pizza_id, itens.quantidade, p.valor
FROM Pizzas AS p
JOIN (
    SELECT 'Aliche' AS nome, 2 AS quantidade
    UNION ALL
    SELECT 'Firense', 1
) AS itens ON itens.nome = p.nome;

2) Diogo Matos da Silva:

INSERT INTO Pedidos (cliente_id, data, hora)
SELECT cliente_id, CURDATE(), CURTIME()
FROM Clientes
WHERE nome = 'Diogo Matos da Silva';

SET @pedido_diogo = LAST_INSERT_ID();

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
SELECT @pedido_diogo, p.pizza_id, itens.quantidade, p.valor
FROM Pizzas AS p
JOIN (
    SELECT 'Toscana' AS nome, 2 AS quantidade
    UNION ALL
    SELECT 'Grega', 1
) AS itens ON itens.nome = p.nome;

3) Eder Almeida Batista de Oliveira:

INSERT INTO Pedidos (cliente_id, data, hora)
SELECT cliente_id, CURDATE(), CURTIME()
FROM Clientes
WHERE nome = 'Eder Almeida Batista de Oliveira';

SET @pedido_eder = LAST_INSERT_ID();

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
SELECT @pedido_eder, p.pizza_id, itens.quantidade, p.valor
FROM Pizzas AS p
JOIN (
    SELECT 'Canadense' AS nome, 1 AS quantidade
    UNION ALL
    SELECT 'Margherita', 2
) AS itens ON itens.nome = p.nome;


SELECT
    pe.pedido_id,
    c.nome AS cliente,
    pe.valor AS valor_atualizado_pelo_gatilho,
    SUM(ip.quantidade * ip.valor) AS valor_calculado_dos_itens,
    CASE
        WHEN pe.valor = SUM(ip.quantidade * ip.valor) THEN 'CORRETO'
        ELSE 'DIVERGENTE'
    END AS conferencia
FROM Pedidos AS pe
JOIN Clientes AS c ON c.cliente_id = pe.cliente_id
JOIN Itens_Pedido AS ip ON ip.pedido_id = pe.pedido_id
WHERE pe.pedido_id IN (
    @pedido_claudiane,
    @pedido_diogo,
    @pedido_eder
)
GROUP BY pe.pedido_id, c.nome, pe.valor
ORDER BY pe.pedido_id;

