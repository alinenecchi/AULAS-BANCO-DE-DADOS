CREATE OR REPLACE FUNCTION fn_geramultas_exemplo(pcnh character,	pvelapurada numeric)
RETURNS character varying
   
AS $$ 
declare
-- Coloque aqui as variáveis
_VelCalculada 	integer 	:= 0;
_msg  			varchar(80) := 'Sem Multa !!!!';
_aplicaMulta	char(01)	:= 'N';
_pontoi  		ex_multa.pontos%type;
_valori 		decimal(5,2);
_nome			varchar(20);
_total			integer:=0;
begin -- Escreva aqui

-- Testar se o motorista existe, mediante CNH enviado como parametro, buscando seu nome
-- Usando PERFORM para o descarte do RESULSET
PERFORM  nome  FROM ex_motorista WHERE CNH = pCNH;
IF NOT FOUND THEN 
    RAISE EXCEPTION 'ERRO AO PROCURAR O MOTORISTA % NA TABELA EX_MOTORISTA', pCNH;
ELSE 
    SELECT nome INTO _nome FROM EX_MOTORISTA WHERE CNH = pCNH;
END IF;

-- 1º o cálculo da velocidade calculada
_VelCalculada := pVelApurada * 0.90 ;

-- 2º teste os intervalos para ver se o motorista tem multa e se tiver --    insere na tabela ex_multa
--Se a velocidade calculada estiver entre 80.01 e 110 então o motorista deve ser multado em 120,00 e receber 20 pontos
--e a velocidade calculada estiver entre 110.01 e 140 então o motorista deve ser multado em 350 e receber 40 pontos
--Se a velocidade calculada estiver acima de 140 então o motorista deve ser multado em 680 e receber 60 pontos
if (_VelCalculada >= 80.01 and _VelCalculada <= 110) then
	-- aplica multa
	_aplicaMulta:= 'S';
	_valori		:= 120;
	_pontoi		:= 20;
elsif 
   (_VelCalculada >= 110.01 and _VelCalculada <= 140) then
	-- aplica multa
	_aplicaMulta:= 'S';
	_valori		:= 350;
	_pontoi		:= 40;
elsif 
   (_VelCalculada > 140) then
	-- aplica multa
	_aplicaMulta:= 'S';
	_valori		:= 680;
	_pontoi		:= 60;
end if;

if 	(_aplicaMulta= 'S') then
	insert into ex_multa (cnh,velocidadeApurada,velocidadeCalculada,pontos,valor)
	values (pCNH, pVelApurada, _VelCalculada, _pontoi, _valori );

	-- 3º busque o nome do motorista –
	-- feito
	
	-- 4º some o total de pontos do motorista
	_total:= (select sum(pontos) from ex_multa where cnh = pCNH);
	--ou
	--select sum(total) into _total from ex_multa where cnh = pCNH;
	
	_msg := 'O motorista '|| _nome ||'  soma ' || _total ||' pontos em multas !!';

end if;	

-- 5º retorne a mensagem 
return _msg;
end;
$$ language 'plpgsql'


select * from fn_geramultas_exemplo ('123AC',880)

insert into ex_motorista values ('123AD', 'Séfora');



CREATE OR REPLACE FUNCTION fn_atualizamultas_exemplo(pcnh character)
RETURNS character varying
   
AS $$ 
declare
-- Coloque aqui as variáveis
_msg  			varchar(120) := 'Atualização foi Concluída com Sucesso !!!!';
_nome			varchar(20);
_totalMultas	decimal(9,2):=0.00;
begin -- Escreva aqui

-- Testar se o motorista existe, mediante CNH enviado como parametro, buscando seu nome
-- Usando PERFORM para o descarte do RESULSET
PERFORM  nome  FROM ex_motorista WHERE CNH = pCNH;
IF NOT FOUND THEN 
    RAISE EXCEPTION 'ERRO AO PROCURAR O MOTORISTA % NA TABELA EX_MOTORISTA', pCNH;
ELSE 
    SELECT nome INTO _nome FROM EX_MOTORISTA WHERE CNH = pCNH;
END IF;


-- Somando as Multas de um motorista (valor)
-- A função COALESCE testa se um valor está NULO, se sim, joga o valor atribuído, no caso abaixo, zero.
_totalMultas := (select coalesce(sum(valor), 0) from ex_multa where cnh=pCNH);
--ou
--select coalesce(sum(valor), 0) into _totalMultas  from ex_multa where cnh=pCNH;


-- Atualizar a coluna totalmultas do motorista em questão
update ex_motorista set totalmultas = _totalMultas where cnh=pCNH;

 _msg:= 'Olá ' || _nome || ', sua ' || _msg;
return _msg ;
end;
$$ language 'plpgsql'


select  coalesce ( sum(valor), 0 ) as totalmultas from ex_multa b
where b.cnh = '123AB' 

select * from fn_atualizamultas_exemplo('123AB')

select * from fn_atualizamultas_exemplo('123AG')


select * from ex_motorista
select * from ex_multa


















