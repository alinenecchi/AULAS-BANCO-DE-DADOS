--select * from pedido where cod_cli = 'cli';
--SELECT * FROM cliente where cidade = 'Porto Alegre';

--GRANT da permissão para um grupo ou usuario 
--grant all on cliente to gastao;
--grant select on cliente to gastao;
-- dml -- select

-- Moldagem
--select limite/5.50, cast (limite/5.50 as decimal(10,4)) from cliente;

-- Visoes - VIEWS
--select cod_cli, nome, cidade, uf, telefone, status 
--from cliente
--where cidade = 'Porto Alegre';

--create view v_cliente as 
--select cod_cli, nome, cidade, uf, telefone, status 
--from cliente
--where cidade = 'Porto Alegre';

--select * from analista;

--mostrar preço atual e com aumento de 10%
--select preco, (preco*10/100) + preco, preco*1.10 as "Aumento de 10% "

--select * from analista;
-- remover view 
-- DROP VIEW <nome da view>

--Aumento no preço dos produtos 
--Categoria amaciante 10%
--Categoria desinfetante 15%
--demais
--Select nome, preco, 
--case when categoria = 'amaciante' then CAST(preco*1.10 AS decimal(5,2))
	 --when  categoria ='desinfetante' then cast (preco*1.15 decimal(5,2))
	 --else  cast (preco * 1.20 decimal(5,2))
--end as "PRECO ALTERADO"
---from produto

--1 – Criar uma view com o nome de cursosanalista, que contém o nome do curso, nome do
--analista e salário do analista com um aumento de 10%.
create view cursosanalista as 
select curso, analista, salario*1.10 as "Aumento de sálario 10%"
from curso
left join analista on curso.codcurso= analista.codcurso

--2 – Montar uma consulta que mostra o nome do programador e a quantidade de dias de
--férias. Caso o programador tenha idade:
--select * from programador
Select progranador, idade,
case
	when  (idade between 20 and 24) then '18 dias'
	when  (idade between 25 and 35)  then '21 dias'
	when  (idade > 35)  then '25 dias'
end as "Férias"
from programador

--3 – Criar uma view com o nome de ativanalista, contendo o nome do analista e a
--quantidade de atividades de análise que ele realizou.
select * from atividadesanalise
select * from analista

create view ativanalista as 
select analista, codatividadeanalise
from analista 
left join 
(select codanalista count(*) 
 	as "Quantidade de analises realizadas" 
 	from atividadesanalise
 	group by codanalista) on analista.codanalista = atividadeanalise.codanalista

4 – Montar uma consulta para atualizar o salário dos analistas a partir da quantidade de
atividades de análise realizadas.
1 atividade 5%
2 atividades 10%
3 atividades ou mais 15%
5 – Monte uma consulta para mostrar o nome do(s) analista(s) e o nome de seu respectivo
curso, o(s) qual(is) nunca tive(ram) atividades realizadas com o programador o qual tenha
em seu nome a palavra “Jefer”.
select * from programador
where progranador like '%Jefer%'






