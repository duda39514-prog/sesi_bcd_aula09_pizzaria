use pizzaria;

drop function if exists moeda;

create function moeda(v float) returns text
return concat("R$ ",v);

select moeda(4.9);

drop function if exists moeda;

select *, moeda(valor) from itens_pedido;
select pedido_id, pizza_id, quantidade, moeda(valor) from itens_pedido

create view vw_itens as
select pedido_id,
       pizza_id,
       quantidade,
       moeda(valor) as valor, 
       moeda(valor * quantidade) as subtotal
    from * itens_pedido

select vw_itens

delimiter //
create function moeda(v float) returns text
begin
    declare x varchar(20);
    set x = format(v,2,'de_DE');
    return concat("R$ ",x);
end//
delimiter ;