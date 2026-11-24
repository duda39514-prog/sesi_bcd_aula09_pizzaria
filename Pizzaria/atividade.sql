
USE pizzaria;

DROP PROCEDURE IF EXISTS atulizaValorPedido;

DELIMITER $

CREATE PROCEDURE atulizaValorPedido(id INT)
BEGIN
    UPDATE pedidos
    SET valor = (
        SELECT SUM(valor * quantidade)
        FROM itens_pedido
        WHERE pedido_id = id
    )
    WHERE pedido_id = id;
END $

DELIMITER ;



DROP PROCEDURE IF EXISTS pedidoDeUmItem;

DELIMITER $

CREATE PROCEDURE pedidoDeUmItem(
    cli_id INT,
    piz_id INT,
    qtd INT
)
BEGIN
    DECLARE idPedido INT;

    INSERT INTO pedidos VALUES
    (DEFAULT, cli_id, CURDATE(), NOW(), NULL);

    SET idPedido = LAST_INSERT_ID();

    INSERT INTO itens_pedido VALUES
    (
        idPedido,
        piz_id,
        qtd,
        (SELECT valor FROM pizzas WHERE pizza_id = piz_id)
    );

    CALL atulizaValorPedido(idPedido);

END $

DELIMITER ;

1) Thamires de Campos Luz

CALL pedidoDeUmItem(96, 41, 1);


2) Everton José de Souza

CALL pedidoDeUmItem(41, 39, 2);


3)Silvia Roberta de Jesus Garcia

CALL pedidoDeUmItem(93, 11, 1);

CALL pedidoDeUmItem(93, 14, 2);


SELECT * FROM pedidos
ORDER BY pedido_id DESC;

SELECT * FROM itens_pedido
ORDER BY pedido_id DESC;
