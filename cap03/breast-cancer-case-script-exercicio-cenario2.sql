SELECT * FROM cap03.tb_dados_ca_v1;

# 1- Aplique label encoding à variável menopausa. - Ok!

# 2-[Desafio] Crie uma nova coluna chamada posicao_tumor concatenando as colunas inv_nodes e quadrante_label. - Ok!

# 3-[Desafio] Aplique One-Hot-Encoding à coluna deg_malig. - Ok!

# 4-Crie um novo dataset com todas as variáveis após as transformações anteriores - Ok!

select * from tb_dados_ca_v1;

select distinct menopausa from tb_dados_ca_v1;

select distinct deg_malig from tb_dados_ca_v1;

select
	classe_bin,
    idade,
    case
		when menopausa = 'premeno' then 0
        when menopausa = 'ge40' then 1
        when menopausa = 'lt40' then 2
	end as menopausa_label,
    tamanho_tumor_label,
    concat(inv_nodes, '-', quadrante_label) as inv_nodes_quadrante_label,
    node_caps_label,    
    case
		when deg_malig = 3 then 1
        else 0
	end as deg_malig_3_label,
        case
		when deg_malig = 2 then 1
        else 0
	end as deg_malig_2_label,
        case
		when deg_malig = 1 then 1
        else 0
	end as deg_malig_1_label,
    seio_label,
    irradiando_bin
from tb_dados_ca_v1;
