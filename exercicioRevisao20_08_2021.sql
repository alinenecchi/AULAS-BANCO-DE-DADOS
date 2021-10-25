--1) Recuperar os nomes de produtos solicitados em pelo menos um pedido
select * from produto;
select * from pedido;
select * from movimento;

select distinct nome 
from produto, pedido, movimento
where produto.cod_prod = movimento.cod_prod 
and movimento.nro_ped = pedido.nro_ped 
and qtde > 1;

select distinct nome 
from movimento
inner join produto on (movimento.cod_prod = produto.cod_prod )
inner join pedido on (movimento.nro_ped = pedido.nro_ped)
where qtde > 1;

--2) Recuperar o nome e telefone de clientes que solicitaram pelo menos um produto de nome Confort
select cliente.nome, cliente.telefone 
from cliente 
inner join pedido on ( cliente.cod_cli = pedido.cod_cli )
inner join movimento on (pedido.nro_ped = movimento.nro_ped)
inner join produto on (movimento.cod_prod = produto.cod_prod)
where produto.nome = 'Confort' 
and qtde > 1;

select distinct cliente.nome, cliente.telefone 
from cliente, produto, pedido, movimento
where cliente.cod_cli = pedido.cod_cli 
and   pedido.nro_ped = movimento.nro_ped 
and movimento.cod_prod = produto.cod_prod 
and produto.nome = 'Confort' 
and qtde > 1;

--3) Selecionar código e nome de clientes cujos nomes contenham Ltda

select nome, cod_cli 
from cliente
where rtrim(nome) 
like '%Ltda%';

select cliente.nome, cliente.cod_cli 
from cliente
where(nome) LIKE '%Ltda%'
order by nome, cod_cli

--4) Recuperar o nome de cada produto e o seu preço em dólares

select nome as "Nome", preco as "Preço",preco*5.38 as "Preço em Dólar",
round(cast(preco*5.38 as numeric),2),'Dólares'
from produto;

--5) Recuperar o nome de cada produto e o seu preço em dólares. 
--Ordenar a consulta em ordem decrescente de preço

select preco as "Preço",preco*5.38 as "Preço em Dólar",nome as "Nome",
round(cast(preco*5.38 as numeric),2),'Dólares'
from produto
ORDER BY preco ASC;

select preco as "Preço",preco*5.38 as "Preço em Dólar",nome as "Nome",
round(cast(preco*5.38 as numeric),2),'Dólares'
from produto
ORDER BY nome ASC;