create or replace FUNCTION atualizarTotalPedido( cod_cli char(10))
returns void as 
$$
UPDATE v_totalped 
set total_movimento = 2
$$ LANGUAGE SQL

select * from cliente

create or replace function fn_exemploTipos(p_cod_cli char(10)) returns varchar(50) as
$$
declare
_cliente cliente%rowtype; -- registro do tipo cliente (possui todos as colunas da tabela cliente e irá armazenar uma linha
--_nome char(40);
_nome cliente.nome%type;
_cod_cli cliente.cod_cli%type;
_msg varchar(80);
begin
select nome into _nome from cliente where cod_cli = p_cod_cli;
raise notice '%', _nome;
select * into _cliente from cliente where cod_cli = p_cod_cli;
raise notice '%', 'Atribui um valor a variável do tipo type';
_cod_cli := 'c1';
if _cod_cli = _cliente.cod_cli then
  raise notice '%', 'Se cliente for igual a c3 listar o nome do cliente c1';
	_msg := 'Cliente já existe : ';
  select * into _cliente from cliente where cod_cli = _cod_cli;
end if;
return _msg || _cliente.nome;
end;
$$ language plpgsql;


------------------------------------------------------------------------------------------------------------


Create or Replace function fn_exemplo_parametros(in_a decimal(8,2), in_b decimal(8,2)) returns decimal(8,2)
AS $$
DECLARE
_result decimal(8,2);
BEGIN
_result := in_a / in_b;
return _result;
END;
$$ language PlpgSQL;

-------------------------------------------------------------

drop function fn_exemplo_parametros(in_a int, in_b int)

-----------------------------------------------------------

select fn_exemplo_parametros(10,3)

-------------------------------------------------------------------------------------------------------------
--tabelas para exercicio 

create table ex_motorista

(cnh char(5) primary key,

nome varchar(20) not null,

totalMultas decimal(9,2) );

 -----------------------------

create table ex_multa

(id serial primary key,

cnh char(5) references ex_motorista(cnh) not null,

velocidadeApurada decimal(5,2) not null,

velocidadeCalculada decimal(5,2),

pontos integer not null,

valor decimal(9,2) not null);

------------------------------------------------------------------
--pulando um motorista, por exemplo:

insert into ex_motorista values ('123AB', 'Carlo');

--------------------------------------------------------

Dicas de como fazer:

Segue abaixo algumas dicas para o 1 exercicio:

create or replace function fn_GeraMultas(pCNH char(5), pVelApurada DECIMAL(5,2))

returns varchar(50) as

$$ declare

-- Coloque aqui as variáveis

_VelCalculada integer := 0;

 

begin -- Escreva aqui

-- 1º o cálculo da velocidade calculada

-- 2º teste os intervalos para ver se o motorista tem multa e se tiver --    insere na tabela ex_multa

-- 3º busque o nome do motorista –

- 4º some o total de pontos do motorista

-- 5º retorne a mensagem 

end;

 

$$ language 'plpgsql';

 

-- Insira qtos motoristas desejar aqui, fora da função

insert into ex_motorista values ('123AB', 'Jose')

 

-- execute a função, por exemplo

select * from fn_GeraMultas('123AB', 100)

 

-- Aqui um exemplo de INSERT na tabela ex_multa, deve ser usado dentro

-- da função.

insert into ex_multa (cnh,velocidadeApurada,velocidadeCalculada,pontos,valor)

values (pCNH, pVelApurada, _VelCalculada, 20, 120 );
----------------------------------------------------------------------

--Exercício 01: Neste primeiro exercício, 
--iremos criar uma função em PlpgSQL, para que mediante os parâmetros enviados 
--(CNH e Velocidade Apurada) se possa testar se um motorista deverá receber ou não Multa.
--O resultado é a inserção (caso tenha multa) de um novo registro na tabela de ex_multa.
--parametros cnh e velocidade

..
--parte do exercicio 01

_VelCalculada := pVelApurada * 90/100;

if _VelCalculada >= 80.01 and _VelCalculada <= 110 then

 insert into ex_multa (cnh,velocidadeApurada,velocidadeCalculada,pontos,valor)

  values (pCNH, pVelApurada, _VelCalculada, 20, 120 );

end if;

if _VelCalculada >= 110.01 and _VelCalculada <= 140 then

 insert into ex_multa (cnh,velocidadeApurada,velocidadeCalculada,pontos,valor)

  values (pCNH, pVelApurada, _VelCalculada, 40, 350 );

end if;

if _VelCalculada > 140 then

 insert into ex_multa (cnh,velocidadeApurada,velocidadeCalculada,pontos,valor)

  values (pCNH, pVelApurada, _VelCalculada, 60, 680 );

end if;
 
--Conforme as tabelas descritas abaixo, escreva um procedimento que atenda ao solicitado:

--O procedimento deve receber dois valores por parâmetro CNH do motorista e velocidadeApurada do veículo por ele conduzido;

--O procedimento, caso seja necessário deverá gravar um registro na tabela ex_multa, bem como retornar um texto com a seguinte mensagem:


--'O motorista [nome] soma [X] pontos em multas ‘;

 

--O cálculo da pontuação do motorista é efetuado da seguinte forma:

-- Se a velocidade estiver entre 80.01 e 110 então o motorista deve ser multado em 120,00 e receber 20 pontos

--–Se a velocidade estiver entre 110.01 e 140 então o motorista deve ser multado em 350 e receber 40 pontos

--–Se a velocidade estiver acima de 140 então o motorista deve ser multado em 680 e receber 60 pontos

--•O sistema deve considerar somente 90% da velocidade apurada para o cálculo da multa.

--OBS1: Após o cálculo o sistema deve incluir a multa na tabela ex_multa (se o contribuinte foi multado)

 ------------------------------------------------------------------------------------------------------------------------------------

--Exercício 02: Escreva um outro procedimento que atualize o campo totalMultas da tabela ex_motorista a partir dos totais apurados para cada motorista autuado na tabela ex_multa.

--•OBS1: motorista sem multa deverão possuir valor 0.00 no campo total multa;

--•OBS2:cuidado para não duplicar valores na coluna totalMultas para os casos em que a rotina for disparada mais de uma vez.

