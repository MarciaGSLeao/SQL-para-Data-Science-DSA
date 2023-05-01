create database dsa_cap03;

use dsa_cap03;

create table tb_dados_ca (
  `classe` VARCHAR(100) NULL,
  `idade` VARCHAR(45) NULL,
  `menopausa` VARCHAR(45) NULL,
  `tamanho_tumor` VARCHAR(45) NULL,
  `inv_nodes` VARCHAR(45) NULL,
  `node_caps` VARCHAR(3) NULL,
  `deg_malig` INT NULL,
  `seio` VARCHAR(5) NULL,
  `quadrante` VARCHAR(10) NULL,
  `irradiando` VARCHAR(3) NULL);
  
# Carga massiva
# SHOW VARIABLES LIKE 'secure_file_priv'; -- Foi necessário alterar as configuração de segurança no arquivo de configuração my.cnf (C:\ProgramData\MySQL\MySQL Server 8.0)
SHOW VARIABLES LIKE 'local_infile';
set global local_infile=true;

load data infile 'C:/Marcia/CursosDSA/SQL para Data Science/cap03/breast-cancer.csv' 
into table tb_dados_ca
fields terminated by ','
lines terminated by '\n'
ignore 1 rows;

# Binarização da variável classe
select distinct classe from tb_dados_ca;

select 
	case 
		when classe = 'no-recurrence-events' then 0
		when classe = 'recurrence-events' then 1
	end as classe_bin,
    idade, menopausa, tamanho_tumor, inv_nodes, node_caps, deg_malig, seio, quadrante, irradiando
from tb_dados_ca;

# Binarização da variável irradiando
select distinct irradiando from tb_dados_ca;

select 
	case 
		when classe = 'no-recurrence-events' then 0
		when classe = 'recurrence-events' then 1
	end as classe_bin,
    idade, menopausa, tamanho_tumor, inv_nodes, node_caps, deg_malig, seio, quadrante,
    case
		when irradiando = 'no' then 0
        when irradiando = 'yes' then 1
	end as irradiando_bin
from tb_dados_ca;

# Binarização da variável node_caps
select distinct node_caps from tb_dados_ca;
select count(node_caps) from tb_dados_ca where node_caps = '?'; # 8 registros.

select 
	case 
		when classe = 'no-recurrence-events' then 0
		when classe = 'recurrence-events' then 1
	end as classe_bin,
    idade, menopausa, tamanho_tumor, inv_nodes, 
    case
		when node_caps = 'no' then 0
        when node_caps = 'yes' then 1
        else 2 -- Não foi possível binarizar a variável, pois havia valores ausentes.
    end as node_caps_label, 
    deg_malig, seio, quadrante,
    case
		when irradiando = 'no' then 0
        when irradiando = 'yes' then 1
	end as irradiando_bin
from tb_dados_ca;

# Categorização da variável seio (E/D)
select distinct seio from tb_dados_ca;

select 
	case 
		when classe = 'no-recurrence-events' then 0
		when classe = 'recurrence-events' then 1
	end as classe_bin,
    idade, menopausa, tamanho_tumor, inv_nodes, 
    case
		when node_caps = 'no' then 0
        when node_caps = 'yes' then 1
        else 2 -- Não foi possível binarizar a variável, pois havia valores ausentes.
    end as node_caps_label, 
    deg_malig, 
    case
		when seio = 'left' then 'E'
        when seio = 'right' then 'D'
	end as seio_label,
    quadrante,
    case
		when irradiando = 'no' then 0
        when irradiando = 'yes' then 1
	end as irradiando_bin
from tb_dados_ca;

# Categorização da variável tamanho_tumor (6 categorias)
select distinct tamanho_tumor from tb_dados_ca;

select 
	case 
		when classe = 'no-recurrence-events' then 0
		when classe = 'recurrence-events' then 1
	end as classe_bin,
    idade, menopausa, 
    case
		when tamanho_tumor = '0-4' or tamanho_tumor = '5-9' then 'PP'
        when tamanho_tumor = '10-14' or tamanho_tumor = '15-19' then 'P'
        when tamanho_tumor = '20-24' or tamanho_tumor = '25-29' then 'M'
        when tamanho_tumor = '30-34' or tamanho_tumor = '35-39' then 'G'
        when tamanho_tumor = '40-44' or tamanho_tumor = '45-49' then 'GG'
        else 'CRÍTICO'
    end as tamanho_tumor_label,
    inv_nodes, 
    case
		when node_caps = 'no' then 0
        when node_caps = 'yes' then 1
        else 2 -- Não foi possível binarizar a variável, pois havia valores ausentes.
    end as node_caps_label, 
    deg_malig, 
    case
		when seio = 'left' then 'E'
        when seio = 'right' then 'D'
	end as seio_label,
    quadrante,
    case
		when irradiando = 'no' then 0
        when irradiando = 'yes' then 1
	end as irradiando_bin
from tb_dados_ca;

# Label Encoding da variável quadrante (1, 2, 3, 4, 5)
select distinct quadrante from tb_dados_ca;

select 
	case 
		when classe = 'no-recurrence-events' then 0
		when classe = 'recurrence-events' then 1
	end as classe_bin,
    idade, menopausa, 
    case
		when tamanho_tumor = '0-4' or tamanho_tumor = '5-9' then 'PP'
        when tamanho_tumor = '10-14' or tamanho_tumor = '15-19' then 'P'
        when tamanho_tumor = '20-24' or tamanho_tumor = '25-29' then 'M'
        when tamanho_tumor = '30-34' or tamanho_tumor = '35-39' then 'G'
        when tamanho_tumor = '40-44' or tamanho_tumor = '45-49' then 'GG'
        else 'CRÍTICO'
    end as tamanho_tumor_label,
    inv_nodes, 
    case
		when node_caps = 'no' then 0
        when node_caps = 'yes' then 1
        else 2 -- Não foi possível binarizar a variável, pois havia valores ausentes.
    end as node_caps_label, 
    deg_malig, 
    case
		when seio = 'left' then 'E'
        when seio = 'right' then 'D'
	end as seio_label,
    case
		when quadrante = 'left_up' then 1
        when quadrante = 'right_up' then 2
        when quadrante = 'left_low' then 3
        when quadrante = 'right_low' then 4
        when quadrante = 'central' then 5
        else  0 # o valor 0 representa os valores ausente no dataset.
    end as quadrante_label,
    case
		when irradiando = 'no' then 0
        when irradiando = 'yes' then 1
	end as irradiando_bin
from tb_dados_ca;

# Crie um novo dataset a partir das transformações realizadas

create table cap03.tb_dados_ca_v1
as
select 
	case 
		when classe = 'no-recurrence-events' then 0
		when classe = 'recurrence-events' then 1
	end as classe_bin,
    idade, menopausa, 
    case
		when tamanho_tumor = '0-4' or tamanho_tumor = '5-9' then 'PP'
        when tamanho_tumor = '10-14' or tamanho_tumor = '15-19' then 'P'
        when tamanho_tumor = '20-24' or tamanho_tumor = '25-29' then 'M'
        when tamanho_tumor = '30-34' or tamanho_tumor = '35-39' then 'G'
        when tamanho_tumor = '40-44' or tamanho_tumor = '45-49' then 'GG'
        else 'CRÍTICO'
    end as tamanho_tumor_label,
    inv_nodes, 
    case
		when node_caps = 'no' then 0
        when node_caps = 'yes' then 1
        else 2 -- Não foi possível binarizar a variável, pois havia valores ausentes.
    end as node_caps_label, 
    deg_malig, 
    case
		when seio = 'left' then 'E'
        when seio = 'right' then 'D'
	end as seio_label,
    case
		when quadrante = 'left_up' then 1
        when quadrante = 'right_up' then 2
        when quadrante = 'left_low' then 3
        when quadrante = 'right_low' then 4
        when quadrante = 'central' then 5
        else  0 # o valor 0 representa os valores ausente no dataset.
    end as quadrante_label,
    case
		when irradiando = 'no' then 0
        when irradiando = 'yes' then 1
	end as irradiando_bin
from tb_dados_ca;
