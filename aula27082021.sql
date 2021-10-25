--aula 27/08/2021
--5 – Monte uma consulta para mostrar o nome do(s) analista(s) e o nome de seu respectivo
--curso, o(s) qual(is) nunca tive(ram) atividades realizadas com o programador o qual tenha
--em seu nome a palavra “Jefer”.
select * from programador
where progranador like '%Jefer%'

select * from atividadesanalise;
select * from analista;
select * from produto;

select distinct cod_prod from movimento;
--usando join 
select distinct nome from produto a, movimento b
where a.cod_prod = b.cod_prod;
 --usando clasula in
select nome from produto
where cod_prod in 
(select distinct cod_prod from movimento) -->>>>(3,2,1)

--usando clasula exists 
select nome from produto 
where exists (select * from movimento where produto.cod_prod = movimento.cod_prod)

--Mostre o nome dos produtos que nunca foram pedidos --não usar not
select nome from produto 
where not exists (select * from movimento where produto.cod_prod = movimento.cod_prod)

select nome from produto 
where cod_prod not in (select cod_prod from movimento) 

--erro 
select distinct * from produto a, movimento b
where a cod_prod != b cod_prod


--Union     = união       -> unir os valores dos dois conjusntos 
--Intersect = intersecção -> mostrar os valores que são comuns (join)
-- Except   = menos       -> subtrair os valores do primeiro conjunto pelo 2 conjunto (igualdade)
select cod_prod from produto --> (1,2,3,4)

select distinct cod_prod from movimento --(1,3,4)

select cod_prod from produto --> (1,2,3,4)
union
select distinct cod_prod from movimento --(1,3,4)

select cod_prod from produto --> (1,2,3,4)
union all
select distinct cod_prod from movimento --(1,3,4)

select cod_prod from produto --> (1,2,3,4)
intersect
select distinct cod_prod from movimento --(1,3,4)

select cod_prod from produto --> (1,2,3,4)
except
select distinct cod_prod from movimento --(1,3,4)

select cod_prod from produto --> (1,2,3,4)
except
select distinct cod_prod from movimento --(1,3,4)

--usando o nome
select nome from produto --> (Pinho, Minerva, omo, confort)
except
select distinct nome from movimento, produto --(minerva, omo, confort) todos movimentados 
where movimento.cod_prod = produto.cod_prod -- filtra o que não foi movimentado no caso aqui Pinho sol

--usando subqueries 
select * from pedido, (select nro_ped, sum(total_mov) as Total from movimento
					  group by nro_ped) ValorTotal
where pedido.nro_ped = ValorTotal.nro_ped