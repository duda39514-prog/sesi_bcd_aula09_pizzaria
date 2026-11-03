-- Relatório que mostra todos os pedidos e o nome de cada cliente
SELECT * FROM pedidos;
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;
-- Salvar a consulta como uma VIEW / Relatório
CREATE VIEW vw_pedidos1 AS
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;
-- Para ver o resultado
SELECT * FROM vw_pedidos1;


Desafios
CREATE VIEW vw_pedidos AS
SELECT p.pedido_id, c.nome AS cliente, pi.nome AS pizza, ip.quantidade, ip.valor AS preco_unitario FROM pedidos p INNER JOIN clientes c ON p.cliente_id = c.cliente_id INNER JOIN itens_pedido ip ON p.pedido_id = ip.pedido_id INNER JOIN pizzas pi ON ip.pizza_id = pi.pizza_id;

CREATE VIEW vw_pedidos_subtotal AS
SELECT p.pedido_id, c.nome AS cliente, pi.nome AS pizza, ip.quantidade, ip.valor AS preco_unitario, (ip.valor * ip.quantidade) AS subtotal FROM pedidos p INNER JOIN clientes c ON p.cliente_id = c.cliente_id INNER JOIN itens_pedido ip ON p.pedido_id = ip.pedido_id INNER JOIN pizzas pi ON ip.pizza_id = pi.pizza_id;

CREATE VIEW vw_total_pedidos AS
SELECT p.pedido_id, c.nome AS cliente, SUM(ip.valor * ip.quantidade) AS valor_total FROM pedidos p INNER JOIN clientes c ON p.cliente_id = c.cliente_id INNER JOIN itens_pedido ip ON p.pedido_id = ip.pedido_id GROUP BY p.pedido_id, c.nome;

CREATE VIEW vw_quantidade_pizzas_pedido AS
SELECT p.pedido_id, c.nome AS cliente, SUM(ip.quantidade) AS quantidade_pizzas FROM pedidos p INNER JOIN clientes c ON p.cliente_id = c.cliente_id INNER JOIN itens_pedido ip ON p.pedido_id = ip.pedido_id GROUP BY p.pedido_id, c.nome;