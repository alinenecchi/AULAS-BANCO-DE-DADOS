select nome, cod_cli from cliente_p

where not exists (

	
	select a.num_voo, a.data from execucao_voo a, passagem b
		where a.num_voo = b.num_voo
		and a.data = b.data 
		and b.num_voo = a.num_voo
		except
		select a.num_voo, b.data from voo a, execucao_voo b
		where a.num_voo = b.num_voo 
		and cidade_cheg = 'Rio de Janeiro'
		and b.data = '2002/09/20'
	
)
--trazer clientes que tenha feito pedidos 
select * from cliente 
where exists (
select * from pedido where cliente.cod_cli = pedido.cod_cli)

--b) Para cada vôo que o piloto Paulo tenha comandado, recuperar a cidade de partida e a data do vôo,
--bem como o número de passagens marcadas. Mostrar somente os vôos com menos de 500
--passagens.
select * from voo
select * from execucao_voo
select * from cliente_p
select * from passagem
select * from piloto 


select cidade_part, b.data, count(*) as "passagens marcadas"
from voo a , execucao_voo b, passagem c, piloto d
where a.num_voo = b.num_voo --JOIN ENTRE VOO E EXECUÇÃO 
and b.num_voo = c.num_voo	-- JOIN ENTRE EXECUCAO E PASSAGEM 
and b.data = c.data
and b.cod_piloto = d.cod_piloto --- JOIN ENTRE EXECUCAO E PILOTO 
and nome = 'Paulo'
group by cidade_part, b.data
having count(*) < 500


select cidade_part, b.data, n_lugares from voo a, execucao_voo b, piloto c, passagem d
where a.num_voo = b.num_voo
and b.cod_piloto = c.cod_piloto
and b.num_voo =  d.num_voo
and c.nome = 'Paulo'
and b.n_lugares < 500


select p.cod_cli, p.nro_ped, sum(total_mov) 
from pedido p, movimento m
where p.nro_ped = m.nro_ped
group by p.cod_cli, p.nro_ped

create view v_TotalPedido as
select p.nro_ped, sum(total_mov) as Total
from pedido p, movimento m
where p.nro_ped = m.nro_ped
group by p.nro_ped
select * from v_TotalPedido
--replace -------------------------------------------------------------------------------
create or replace view as v_TotalPedido as 
select nro_ped, sum(total_mov) as Total from movimento
group by nro_ped
-----------------------------------------------------------------------------------------
create or replace v_TotalPedido (pCod_cli char(10))
returns void as 
$$
--------CODIGO DE UPDATE 
$$ language SQL;

-------------------------------------------------------------------------------------------
select cidade_part, max(b.data)
from voo a , execucao_voo b, passagem c, piloto d
where a.num_voo = b.num_voo 
and b.num_voo = c.num_voo
and b.data = c.data
and b.cod_piloto = d.cod_piloto 
and nome = 'Paulo'
group by b.data, cidade_part


select * from voo
select * from execucao_voo
select * from passagem
select * from piloto

 select distinct max(b.data)  from voo a, execucao_voo b, piloto d
 where a.num_voo = b.num_voo 
 	and b.cod_piloto = d.cod_piloto 
	and nome = 'Paulo'
	group by cidade_part, b.data

select cidade_part
from voo a , execucao_voo b,  piloto d
where a.num_voo = b.num_voo
and b.cod_piloto = d.cod_piloto 
and nome = 'Paulo'



select * from voo
select * from execucao_voo
select * from passagem
select * from piloto
select * from cliente_p

select nome, cod_cli from cliente_p

where not exists (

	select a.num_voo, b.data from voo a, execucao_voo b, piloto c
		where a.num_voo = b.num_voo 
		and b.cod_piloto = c.cod_piloto
		and nome = 'Ronaldo'
		and cidade_part = 'Porto Alegre'
	except 
	select a.num_voo, a.data from execucao_voo a, passagem b
		where a.num_voo = b.num_voo
		and a.data = b.data 
	and b.cod_cli = cliente_p.cod_cli
		and cod_cli = cliente_p.cod_cli
		and cod_cli = 'c3')
		
		select distinct c.nome from cliente_p c, passagem p
where c.cod_cli = p.cod_cli and p.data = 2002-09-20 exists 
(select distinct a.num_voo from passagem p, voo a
	 	where p.num_voo = a.num_voo and exists
		 (select distinct cidade_cheg, from voo where cidade_cheg <> 'Rio de Janeiro' ) )
		
	
	