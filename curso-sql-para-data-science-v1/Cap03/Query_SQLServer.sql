create database dsa_cap03
go

use dsa_cap03
go

create table tb_dados_ca (
  classe VARCHAR(100) NULL,
  idade VARCHAR(45) NULL,
  menopausa VARCHAR(45) NULL,
  tamanho_tumor VARCHAR(45) NULL,
  inv_nodes VARCHAR(45) NULL,
  node_caps VARCHAR(3) NULL,
  deg_malig INT NULL,
  seio VARCHAR(5) NULL,
  quadrante VARCHAR(10) NULL,
  irradiando VARCHAR(3) NULL)
go

-- Carga massiva
select * from tb_dados_ca

begin transaction
bulk insert tb_dados_ca
from '\\VM-DELL\Users\VM_Dell\Downloads\breast-cancer.csv' 
with(
	format = 'csv',
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '0x0a'
)
go

select * from tb_dados_ca; -- 286 registros
select distinct classe from tb_dados_ca;
select distinct idade from tb_dados_ca;
select distinct menopausa from tb_dados_ca;
select distinct tamanho_tumor from tb_dados_ca;
select distinct inv_nodes from tb_dados_ca;
select distinct node_caps from tb_dados_ca;
select distinct deg_malig from tb_dados_ca;
select distinct seio from tb_dados_ca;
select distinct quadrante from tb_dados_ca;
select distinct irradiando from tb_dados_ca;
go

-- Nova Consulta com dados tratados.
select 
	case
		when classe = 'no-recurrence-events' then 0
        when classe = 'recurrence-events' then 1
	end as classe,
    idade,
    case
		when menopausa = 'premeno' then 1
        when menopausa = 'ge40' then 2
        else 3
	end as menopausa,
	case
		when tamanho_tumor = '0-4' then 'PP'
   		when tamanho_tumor = '5-9' then 'PP'
		when tamanho_tumor = '10-14' then 'P'
   		when tamanho_tumor = '15-19' then 'P'
		when tamanho_tumor = '20-24' then 'M'
        when tamanho_tumor = '25-29' then 'M'
        when tamanho_tumor = '30-34' then 'G'
		when tamanho_tumor = '35-39' then 'G'
		when tamanho_tumor = '40-44' then 'GG'
        when tamanho_tumor = '45-49' then 'GG'
        else 'Tratamento Urgente'
	end as tamanho_tumor,
   	-- inv_nodes,
    node_caps,
    deg_malig,
    case
		when seio = 'left' then 'E'
        when seio = 'right' then 'D'
	end as seio,
    -- quadrante,
    case
		when quadrante = 'central' then concat(inv_nodes, '-', 0)
        when quadrante = 'right_up' then concat(inv_nodes, '-', 1)
        when quadrante = 'left_up' then concat(inv_nodes, '-', 2)
        when quadrante = 'left_low' then concat(inv_nodes, '-', 3)
        when quadrante = 'right_low' then concat(inv_nodes, '-', 4)        
    end posicao_tumor,
    case
		when irradiando = 'no' then 0
        when irradiando = 'yes' then 1
    end irradiando
from tb_dados_ca
go

-- Criando tabela para inserir os dados tratados
create table tb_dados_ca_v2 (
  classe VARCHAR(100) NULL,
  idade VARCHAR(45) NULL,
  menopausa VARCHAR(45) NULL,
  tamanho_tumor VARCHAR(45) NULL,
  inv_nodes VARCHAR(45) NULL,
  node_caps VARCHAR(3) NULL,
  deg_malig INT NULL,
  seio VARCHAR(5) NULL,
  quadrante VARCHAR(10) NULL,
  irradiando VARCHAR(3) NULL)
go

-- Inserindo dados tratados na nova tabela
insert into tb_dados_ca_v2
select 
	case
		when classe = 'no-recurrence-events' then 0
        when classe = 'recurrence-events' then 1
	end as classe,
    idade,
    case
		when menopausa = 'premeno' then 1
        when menopausa = 'ge40' then 2
        else 3
	end as menopausa,
	case
		when tamanho_tumor = '0-4' then 'PP'
   		when tamanho_tumor = '5-9' then 'PP'
		when tamanho_tumor = '10-14' then 'P'
   		when tamanho_tumor = '15-19' then 'P'
		when tamanho_tumor = '20-24' then 'M'
        when tamanho_tumor = '25-29' then 'M'
        when tamanho_tumor = '30-34' then 'G'
		when tamanho_tumor = '35-39' then 'G'
		when tamanho_tumor = '40-44' then 'GG'
        when tamanho_tumor = '45-49' then 'GG'
        else 'Tratamento Urgente'
	end as tamanho_tumor,
   	inv_nodes,
    case
		when node_caps = 'no' then 0
        when node_caps = 'yes' then 1
        else 2
    end encapsulamento,
    deg_malig as grau_de_malignidade,
    case
		when seio = 'left' then 'E'
        when seio = 'right' then 'D'
	end as seio,
    case
		when quadrante = 'central' then concat(inv_nodes, '-', 0)
        when quadrante = 'right_up' then concat(inv_nodes, '-', 1)
        when quadrante = 'left_up' then concat(inv_nodes, '-', 2)
        when quadrante = 'left_low' then concat(inv_nodes, '-', 3)
        when quadrante = 'right_low' then concat(inv_nodes, '-', 4)        
    end posicao_tumor,
    case
		when irradiando = 'no' then 0
        when irradiando = 'yes' then 1
    end irradiando
from tb_dados_ca;
go

-- Consultando dados da nova tabela
select * from tb_dados_ca_v2
go
