--AULA 02 20/08/2021 BANCO II

select * from cliente;
-- quantos clientes tem cadastrados
select count(*) from cliente;

--quantos clientes estão cadastrados por cidade
select cidade, status, count(*), sum(limite)
from cliente
group by cidade, status;

select cidade, count(*), sum(limite), max(limite),min(limite),avg(limite)
from cliente
group by cidade;


-- filtrar somente os que tem telefone cadastrado
select cidade, count(*), sum(limite)
from cliente
where telefone is not null
group by cidade, status;

-- adicionando qualificação perante o reultado , acontece depois do qhere filtra o resultado que o group by gerou
select cidade, count(*), sum(limite)
from cliente
where telefone is not null
group by cidade
having count(*) >= 2;

select count(*) from cliente
where telefone is not null and limite >1200;

select * from cliente
where telefone is not null and limite >1200;

select * from pedido 

select cidade, count(*), sum(limite)

from cliente
where telefone is not null
group by cidade, status;

--Joins
select nro_ped, p.cod_cli, cli.cod_cli,nome 
from pedido p , cliente cli 
where  cli.cod_cli = p.cod_cli;

--outra forma 
--inner -> o que tem nas duas tabelas 
select * from pedido p
inner join cliente cli on (cli.cod_cli = p.cod_cli);

select * from pedido p
left join cliente cli on (cli.cod_cli = p.cod_cli);

select * from cliente ;

select * from cliente p
left join cliente cli on (cli.cod_cli = p.cod_cli);

select * from cliente p
inner join cliente cli on (cli.cod_cli = p.cod_cli);

select * from cliente p
right join cliente cli on (cli.cod_cli = p.cod_cli);

select * from cliente p
FULL OUTER join cliente cli on (cli.cod_cli = p.cod_cli);

--inner join com 3 tabelas 
select p.nro_ped, cli.cod_cli, cli.nome, m.cod_prod, prod.nome from pedido p
inner join cliente cli on (cli.cod_cli = p.cod_cli)
inner join movimento m on (p.nro_ped = p.nro_ped)
inner join produto prod on (m.cod_prod = prod.cod_prod)
where cidade ='Porto Alegre'

-- Criando uma consulta Self-join
Create table funcionarios 
	(cod_func integer not null,
	nome_func varchar(35) not null,
	cod_gerente integer);
select * from funcionarios;
--Inserindo dados 
insert into funcionarios (cod_func, nome_func, cod_gerente) values (1, 'Lucas', null);
insert into funcionarios (cod_func, nome_func, cod_gerente) values (2, 'Gabriel', 1);
insert into funcionarios (cod_func, nome_func, cod_gerente) values (3, 'Ester', 1);
insert into funcionarios (cod_func, nome_func, cod_gerente) values (4, 'Kai', null);

-- Alteração 
update funcionarios set cod_gerente = 4 where cod_func = 1;

-- mostre o nome do funcionario e de seu chefe
select f.nome_func as "Funcionários", c.nome_func as "Gerente" from funcionarios f,funcionarios c
where 	f.cod_gerente is not null and 
		f.cod_gerente = c.cod_func; -- junção(selfe) de funcionario f com funcionario c

select f.nome_func as "Funcionários", c.nome_func as "Gerente" from funcionarios f,funcionarios c
where f.cod_gerente = c.cod_func; -- junção(selfe) de funcionario f com funcionario c

select f.nome_func as "Funcionários", c.nome_func as "Gerente" 
from funcionarios f
left join funcionarios c on (f.cod_gerente = c.cod_func); 

select f.nome_func as "Funcionários", c.nome_func as "Gerente" 
from funcionarios f
inner join funcionarios c on (f.cod_gerente = c.cod_func); 

select f.nome_func as "Funcionários", c.nome_func as "Gerente" 
from funcionarios f
FULL OUTER join funcionarios c on (f.cod_gerente = c.cod_func);

select f.nome_func as "Funcionários", c.nome_func as "Gerente" 
from funcionarios f
right join funcionarios c on (f.cod_gerente = c.cod_func); 
			
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

select cod_cli from cliente 
except
select cod_cli from pedido

select cod_cli 
from cliente
where cod_cli 
not in 
	(select cod_cli from pedido);

select  cod_cli 
from cliente 
where not exists 
	(select cod_cli from pedido where cliente.cod_cli = pedido.cod_cli);






