select * from ex_motorista
select * from ex_multa

CREATE OR REPLACE FUNCTION fn_geramultas(cCnh character, nVelapurada numeric)
RETURNS character varying
AS $$ 
DECLARE
-- Variáveis
_VelCalculada 	integer 	:= 0;
_msg  			varchar(80) := 'Motoristas não possui multas !!!!';
_aplicaMulta	char(01)	:= 'N';
_pontoI  		ex_multa.pontos%type;
_valorI			decimal(5,2);
_nome			varchar(20);
_total			integer:=0;

BEGIN
	--Utilizando exemplo que professsor passou em aula
	PERFORM  nome  FROM ex_motorista WHERE CNH = cCNH;
	IF NOT FOUND THEN 
		RAISE EXCEPTION 'ERRO AO PROCURAR O MOTORISTA % NA TABELA EX_MOTORISTA', cCNH;
	ELSE 
		SELECT nome INTO _nome FROM EX_MOTORISTA WHERE CNH = cCNH;
	END IF;

	_VelCalculada := nVelApurada * 0.90 ;

	--Se a velocidade calculada estiver entre 80.01 e 110 então o motorista deve ser multado em 120,00 e receber 20 pontos
	--e a velocidade calculada estiver entre 110.01 e 140 então o motorista deve ser multado em 350 e receber 40 pontos
	--Se a velocidade calculada estiver acima de 140 então o motorista deve ser multado em 680 e receber 60 pontos

	CASE 
		WHEN _VelCalculada >= 80.01 AND _VelCalculada <= 110.0 THEN
			-- aplica multa
			_aplicaMulta:= 'S';
			_valorI		:= 120;
			_pontoI		:= 20;
		WHEN
		   _VelCalculada >= 110.01 AND _VelCalculada <= 140.0 THEN
			-- aplica multa
			_aplicaMulta:= 'S';
			_valorI		:= 350;
			_pontoI		:= 40;
		WHEN 
		   _VelCalculada > 140.0 THEN
			-- aplica multa
			_aplicaMulta:= 'S';
			_valorI		:= 680;
			_pontoI		:= 60;
	END CASE;
	
	IF _aplicaMulta= 'S' THEN
		INSERT INTO ex_multa (cnh,velocidadeApurada,velocidadeCalculada,pontos,valor)
		VALUES (cCnh, nVelApurada, _VelCalculada, _pontoI, _valorI );

		_total:= (select sum(pontos) from ex_multa where cnh = cCNH);

		_msg := 'O motorista '|| _nome ||'  possui um total de ' || _total ||' pontos em multas !!';

	END IF;
	
	RETURN _msg;
	
END;
$$ language 'plpgsql'


-- SEGUNDA FUNÇÃO --

CREATE OR REPLACE FUNCTION fn_atualizamultas(cCnh character)
RETURNS character varying
   
AS $$ 
DECLARE
_msg  			varchar(120) := 'Atualização foi Concluída com Sucesso !!!!';
_nome			varchar(20);
_totalMultas	decimal(9,2):=0.00;

BEGIN 
	-- Usando PERFORM para o descarte do RESULSET
	PERFORM  nome  FROM ex_motorista WHERE CNH = cCNH;
	IF NOT FOUND THEN 
		RAISE EXCEPTION 'ERRO AO PROCURAR O MOTORISTA % NA TABELA EX_MOTORISTA', cCNH;
	ELSE 
		SELECT nome INTO _nome FROM EX_MOTORISTA WHERE CNH = cCNH;
	END IF;

	-- Somando as Multas de um motorista (valor)
	-- A função COALESCE testa se um valor está NULO, se sim, joga o valor atribuído, no caso abaixo, zero.
	_totalMultas := (select coalesce(sum(valor), 0) from ex_multa where cnh=cCNH);
	UPDATE ex_motorista SET totalmultas = _totalMultas WHERE cnh=cCNH;
	
	IF _totalMultas > 0.00 THEN
	-- Atualizar a coluna totalmultas do motorista em questão
		 _msg:= 'Olá ' || _nome || ', sua ' || _msg;
	ELSE 
		_msg := 'O motorista '|| _nome ||'  não possui multas !!';
	END IF;

	RETURN _msg ;
END;
$$ language 'plpgsql'


select * from fn_atualizamultas('123AA')
select * from fn_atualizamultas('123AB')
select * from fn_atualizamultas('123AC')
select * from fn_atualizamultas('123Ad')

select * from ex_motorista
select * from ex_multa

select * from fn_geramultas ('123AB',880);
insert into ex_motorista values ('123AC', 'Beatriz');

