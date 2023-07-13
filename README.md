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

### Estrutura base do jogo: 
O jogo é definido dentro da estrutura de love2D. Como pode-se observar no código main.lua:

```lua
--tirar o antialiasing para preservar os pixels 
love.graphics.setDefaultFilter("nearest", "nearest")
	
Object = require("classic")
Celula = require("celula")
Botao = require("botao")

--botoes herdados 
--Orientação a objetos 
BotaoReset = require("botao_reset")
BotaoPVP = require("botao_pvp")
BotaoIA = require("botao_ia")

--X = 1 
--O = 2 
jogadores = {'1', '2'}
--variaveis de controle
jogador_atual = 1 
jogador_anterior = jogador_atual 
modo_jogo = 0 
-- 0 => Player VS Player 
-- 1 => Player VS Computador 

--verificando se o jogo ainda está rodando 
em_jogo = true 

--Grade do jogo da velha 
Grade = {
	{'0', '0', '0'},
	{'0', '0', '0'},
	{'0', '0', '0'}
}

--Dimensão do tamanho do sprite (com escala 3 já que é pixel art e naturalmente é pequeno)
Dimensao = {x=32 * 3, y=32 * 3}
Celulas = {}

--sprites de botão 
botao_normal = love.graphics.newImage("assets/botao_normal.png") 
botao_hover = love.graphics.newImage("assets/botao_hover.png")
--icones
icon_pvp = love.graphics.newImage("assets/pvp.png")
icon_reset = love.graphics.newImage("assets/reset.png")
icon_ai = love.graphics.newImage("assets/ai.png")

--Limpar a grade do jogo da velha, deixando os espaços vazios 
function limpar_grade()
 	for i=1, 3 do 
		for j=1, 3 do 
			Grade[i][j] = '0'
		end 
	end
end

--Verificar se há um jogador vencedor, verificação de estados 
function checar_tabuleiro()
	--verificando as linhas
	local contador = 0
	for i=1, 3 do 
		contador = 0
		for j=1, 3 do 
			if Grade[i][j] == jogadores[jogador_atual] then 
				contador = contador + 1 
			end 
			if contador == 3 then 
				print(jogador_atual.. " Venceu.")
				em_jogo = false 
				return 
			end 
		end 
	end

	--verificando as colunas 
	for i=1, 3 do 
		contador = 0
		for j=1, 3 do 
			if Grade[j][i] == jogadores[jogador_atual] then 
				contador = contador + 1 
			end 
			if contador == 3 then 
				print(jogador_atual.. " Venceu.")
				em_jogo = false 
				return 
			end 
		end 
	end
	--verificar as diagonais da esquerda para direita  
	contador = 0
	for i=1, 3 do 
		if Grade[i][i] == jogadores[jogador_atual] then 
			contador = contador + 1 
		end 
	end

	if contador == 3 then 
		print(jogador_atual.. " Venceu.")
		em_jogo = false 
		return 
	end 

	contador = 0
	--verificar as diagonais da direita para a esquerda  
	for i=1, 3 do 
		if Grade[4-i][i] == jogadores[jogador_atual] then 
			contador = contador + 1 
		end 
	end

	if contador == 3 then 
		print(jogador_atual.. " Venceu.")
		em_jogo = false 
		return 
	end  
end 	
	
--carregando as classes dentro do código base 
function love.load()
	--Botão de reiniciar o jogo 
	reset = BotaoReset(0, 320, botao_normal, botao_hover, icon_reset, 2)
	--botão Jogador VS Jogador 
	pvp = BotaoPVP(117, 320, botao_normal, botao_hover, icon_pvp, 2)
	--Botão para a IA 
	ai = BotaoIA(230, 320, botao_normal, botao_hover, icon_ai, 2)

	--Deslocamento em pixels das células dentro da imagem 
	offset = 10 
	for i=0, 2 do 
		for j=0, 2 do 
			Celulas[#Celulas + 1] = Celula((Dimensao.x + offset)*j, (Dimensao.y + offset) * i,  Dimensao.x, Dimensao.y, i+1, j+1, 3)
		end
	end 
	
	--botao_humano = Botao(20, 360, 100, 40, "Teste")

end 

--Desenhar os objetos na tela 
function love.draw()
	--botao_humano:draw()
	reset:draw()
	pvp:draw()
	ai:draw()
	for _, celula in ipairs(Celulas) do 
		celula:draw()
	end 
end 

--Autalizando a lógica do jogo 
function love.update(dt)
	--botao_humano:update(dt)
	--checar se o jogador anterior foi alterado 
	reset:update(dt)
	pvp:update(dt)
	ai:update(dt)

	for _, celula in ipairs(Celulas) do 
		celula:update(dt)
	end
end 

--Evento de clique no mouse 
function love.mousepressed(x, y, button)
	for _, celula in ipairs(Celulas) do 
		celula:mousePressed(button)
	end	
	reset:mousePressed(button)
	pvp:mousePressed(button)
	ai:mousePressed(button)
end

```

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

É armazenado uma cópia do tabuleiro com as possibilidades de jogadas e após isso, expandido recursivamente. 
