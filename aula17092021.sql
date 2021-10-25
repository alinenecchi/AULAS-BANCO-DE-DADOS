select * from pedido;
$$ LANGUAGE SQL; 
---------------FAZER A FUNÇÃO AQUI DENTRO
$$
$$ LANGUAGE SQL
----------------------

SELECT * FROM movimento
UPDATE movimento set qtde = 150
where nro_ped = 'ped' and cod_prod = 3

SELECT * FROM movimento
UPDATE movimento set qtde = (select max(qtde) from movimento)
where nro_ped = 'ped' and cod_prod = 3

--update pedido set total_ped = .....
where ;....

--criar view
select p.cod_cli, p.nro_ped, sum(total_mov) 
from pedido p, movimento m
where p.nro_ped = m.nro_ped
group by p.cod_cli, p.nro_ped
--abaixo criar a função 

create or replace atualizarTotalPedido(char(10))
return void as 
$$
---update

--Recuperar os nomes de clientes que não voaram para o Rio de janeiro no dia 20/09/02
select * from voo
select * from execucao_voo
select * from cliente_p
select * from passagem

select distinct c.nome from cliente_p c, passagem p
where c.cod_cli = p.cod_cli and p.data = 2002-09-20 exists 
(select distinct a.num_voo from passagem p, voo a
	 	where p.num_voo = a.num_voo and exists
		 (select distinct cidade_cheg, from voo where cidade_cheg <> 'Rio de Janeiro' ) )
 	


-- mostrar clientes que nunca fizeram pedidos 
select * from cliente
where cod_cli not in
(select cod_cli from pedido)


--Exercício 01:
--Conforme as tabelas já mapeadas, cliente, produto, pedido e movimento, crie dois objetos
--abaixo relacionados, para atender ao solicitado:
--• 1ª) Monte uma visão chamada de v_TotalPedido, no qual retorne o total, em valores,
--de pedidos feitos, por cliente e pedido. Para isso deve ser lida a coluna total_mov da
--tabela de movimento.

select * from movimento

create view v_TotalPedido as
select p.cod_cli, p.nro_ped, sum(total_mov)
from pedido p, movimento m
where p.nro_ped = m.nro_ped
group by p.cod_cli, p.nro_ped

--ou 

create view v_TotalPedido as
select p.nro_ped, sum(total_mov) as Total
from pedido p, movimento m
where p.nro_ped = m.nro_ped
group by p.nro_ped


-- renomeando a coluna Total pedido
create or replace view v_TotalPedido as
select p.cod_cli, p.nro_ped, sum(total_mov) as Total_Movimento 
from pedido p, movimento m
where p.nro_ped = m.nro_ped
group by p.cod_cli, p.nro_ped

--teste view
select * from v_TotalPedido

--• 2º) Monte um procedimento chamado de atualizarTotalPedido (função de escrita) no
--qual receba como parâmetro, o código do cliente, tipo char(10), e atualize os pedidos
--(coluna total_ped) apenas do respectivo cliente enviado como parâmetro.

create or replace atualizarTotalPedido(char(10))
return void as 
$$
$$ LANGUAGE SQL



