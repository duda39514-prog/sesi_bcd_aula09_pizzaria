Atividade 4
show tables;
SELECT COUNT(*) AS cliente FROM Clientes;
SELECT COUNT(*) AS pizza FROM Pizzas;
SELECT SUM(quantidade) FROM Itens_Pedido WHERE pedido_id = 3;
SELECT * from Clientes where cliente_id = 2;
SELECT Pizzas.nome FROM Itens_Pedido INNER JOIN Pizzas ON Itens_Pedido.pizza_id = Pizzas.pizza_id WHERE Itens_Pedido.pedido_id = 3;
ou SELECT nome FROM pizzas where pizza_id in (select pizza_id from itens_pedidos where pedido_id = 3);



insert into cliente(nome, cep, numero, complemento) values 
("Gaspar Oliveira", "13903-303", "21", null);
insert into Pizzas(nome, descricao, valor) values 
("A moda do chef", "Molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas",41.9);
insert into Pedidos(cliente_id, data, hora) values(27,DATE_SUB(curdate(),INTERVAL 10 DAY),"13:54:00");
insert into Itens_Pedido(pedido_id, pizza_id, quantidade, valor) values(27,42,2, (select valor from Pizzas where pizza_id = 42));
update Pedidos set valor=(select sum(quantidade * valor) from Itens_Pedido where pedido_id = 27) where pedido_id = 27;
UPDATE Itens_Pedido SET quantidade = 3 WHERE pedido_id = 27 AND pizza_id = 42;
INSERT INTO Itens_Pedido(pedido_id, pizza_id, quantidade, valor) VALUES (27, 22, 1, (SELECT valor FROM Pizzas WHERE pizza_id = 1));
UPDATE Pedidos SET valor = ( SELECT SUM(quantidade * valor) FROM Itens_Pedido WHERE pedido_id = 27 ) WHERE pedido_id = 27;