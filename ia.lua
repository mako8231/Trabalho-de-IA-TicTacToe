
--grade = {
--	{'1', '0', '0'},
--	{'0', '0', '0'},
--	{'0', '0', '0'}
--}

--Checar a condição de vitória de cada jogador 
function avaliar_estado(grade, simbolo_desejado)
	-- verificar as diagonais da esquerda para a direita
	local contador = 0

	for i=1, 3 do 
		contador = 0 
		for j=1, 3 do 
			if Grade[j][i] == simbolo_desejado then 
				contador = contador + 1 
			end 
			if contador == 3 then
				return true 
			end 
		end 
	end

	contador = 0 

	for i=1, 3 do 
	    if grade[i][i] == simbolo_desejado then 
	        contador = contador + 1 
	    end 
	end

	if contador == 3 then 
	    return true 
	end 


	-- verificar as diagonais da direita para a esquerda  
	contador = 0
	for i=1, 3 do 
	    if grade[4-i][i] == simbolo_desejado then 
	        contador = contador + 1 
	    end 
	end

	if contador == 3 then 
	    return true 
	end 

	return false  -- Nenhuma condição de vitória foi atendidend 
end 

function contar_pecas_livres(_grade)
	local contador = 0
	for i=1, 3 do 
		for j=1, 3 do
			if _grade[i][j] == '0' then 
				contador = contador + 1 
			end
		end 
	end 
	return contador 
end


function imprimir_grade(_grade)
	print("=============") 
	for i=1, 3 do		
		print(_grade[i][1], _grade[i][2], _grade[i][3])
	end
	print("=============")
end 

function copiar_grade(_grade)
	local copia = {
		{'0', '0', '0'},
		{'0', '0', '0'},
		{'0', '0', '0'}
	}

	for i=1, 3 do 
		for j=1, 3 do 
			copia[i][j] = _grade[i][j]
		end 
	end 

	return copia
end 

function minimax(_grade, simbolo, nivel)
	if contar_pecas_livres(_grade) == 0 then 
		--se o jogador 1 ganhar, -1 
		--se o jogador 2 ganhar, 1 
		--se empatar, 0 
		return 0 
	end 	
	if avaliar_estado(_grade, '2') then
	    return 1 
	end 
	if avaliar_estado(_grade, '1') then
	 	return -1
	end 


	for i=1, 3 do
		for j=1, 3 do 
			local copia_grade = {}
			--checar espaço vazio 
			if _grade[i][j] == '0' then 
				copia_grade = copiar_grade(_grade)
				copia_grade[i][j] = simbolo
				if nivel % 2 == 0 then 
				    -- maximizar a IA
				    local melhor_pontuacao = -10000
				    return math.max(melhor_pontuacao, minimax(copia_grade, '2', nivel+1))
				else 
					local melhor_pontuacao = 10000
				    return math.min(melhor_pontuacao, minimax(copia_grade, '1', nivel+1))		
				end
			end
		end 
	end 
end 

function melhor_jogada(_grade)
	local ia = '2'
	local melhor_pontuacao = -999999
	local jogada = {i=0, j=0}
	--Percorrer todo o tabuleiro 
	for i=1, 3 do 
		for j=1, 3 do 
			--verificar se há uma vaga no tabuleiro 
			if _grade[i][j] == '0' then 
				_grade[i][j] = ia 
				--copiar a grade
				local copia_grade = copiar_grade(_grade)
				local pontos = minimax(copia_grade, ia, 1)
				print(pontos)
				_grade[i][j] = '0'
				imprimir_grade(_grade)
		
				if pontos > melhor_pontuacao then 
					melhor_pontuacao = pontos
					jogada.i = i 
					jogada.j = j 
				end 
			end 
		end 
	end
	return jogada  
end 

