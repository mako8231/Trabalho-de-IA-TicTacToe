# Trabalho de Inteligência Artificial: 

Um trabalho para a disciplina de Inteligência Artificial. Se tratando do jogo da velha (ou tic tac toe) onde usa-se o algoritmo de busca competitiva (Minimax) para o computador. 

## Instalação: 

### Linux e Windows 
O jogo depende do framework lua [love2d](https://love2d.org/), que é totalmente gratuito e de código aberto, apenas siga as instruções no site oficial. 

Após a instalação do framework, clone o repositório:
```bash
git clone https://github.com/masao8231/Trabalho-de-IA-TicTacToe.git 
```
então, simplesmente execute o projeto inserindo no terminal dentro da pasta onde o repositório foi baixado: 
``love Trabalho-de-IA-TicTacToe``
caso esteja no Windows e deseja ver o log do jogo, abra no seguinte comando: 
``lovec Trabalho-de-IA-TicTacToe``

![Screenshot do Jogo](https://raw.githubusercontent.com/masao8231/Trabalho-de-IA-TicTacToe/main/assets/cap_1.png)

## Como funciona:

O jogo possui dois modos de jogabilidade:
- Jogador X Jogador 
- Máquina X Jogador 

### Jogador VS Jogador 

No primeiro modo, o primeiro jogador que assumir o primeiro movimento ficará com o **X**, enquanto o segundo ficará com o **O**. Assim como o clássico jogo da velha. O jogador que conseguir criar uma fila dos mesmos símbolos tanto na vertical, horizontal e diagonal, é o vencedor. 

### Jogador VS Máquina
No seguinte modo, a máquina jogará depois do movimento do jogador, em outras palavras, ela sempre será o **O**. Para conseguir decidir qual será o seu próximo movimento, foi usado um algoritmo de Inteligência Artificial chamado de MiniMax:

```lua 
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
``` 
O algoritmo minimax se baseia em fazer uma busca entre a árvore de estados, procurando a melhor possibilidade, para "atribuir um valor", foi estabelecido um critério da seguinte forma: 

- -1 condição da vitória do jogador 
-  0 empate 
-  1 vitória da máquina 

```lua
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


```

