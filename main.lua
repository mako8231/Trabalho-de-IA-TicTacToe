love.graphics.setDefaultFilter("nearest", "nearest")
	
Object = require("classic")
Celula = require("celula")
Botao = require("botao")

--botoes herdados 
BotaoReset = require("botao_reset")
BotaoPVP = require("botao_pvp")
BotaoIA = require("botao_ia")

jogadores = {'1', '2'}
--variaveis de controle
jogador_atual = 1 
jogador_anterior = jogador_atual 
modo_jogo = 0 
-- 0 => Player VS Player 
-- 1 => Player VS Computador 

--verificando se o jogo ainda está rodando 
em_jogo = true 

Grade = {
	{'0', '0', '0'},
	{'0', '0', '0'},
	{'0', '0', '0'}
}

Dimensao = {x=32 * 3, y=32 * 3}
Celulas = {}

--sprites de botão 
botao_normal = love.graphics.newImage("assets/botao_normal.png") 
botao_hover = love.graphics.newImage("assets/botao_hover.png")
--icones
icon_pvp = love.graphics.newImage("assets/pvp.png")
icon_reset = love.graphics.newImage("assets/reset.png")
icon_ai = love.graphics.newImage("assets/ai.png")

function limpar_grade()
 	for i=1, 3 do 
		for j=1, 3 do 
			Grade[i][j] = '0'
		end 
	end
end


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
	
function love.load()
	
	reset = BotaoReset(0, 320, botao_normal, botao_hover, icon_reset, 2)
	pvp = BotaoPVP(117, 320, botao_normal, botao_hover, icon_pvp, 2)
	ai = BotaoIA(230, 320, botao_normal, botao_hover, icon_ai, 2)


	offset = 10 
	for i=0, 2 do 
		for j=0, 2 do 
			Celulas[#Celulas + 1] = Celula((Dimensao.x + offset)*i, (Dimensao.y + offset) * j,  Dimensao.x, Dimensao.y, i+1, j+1, 3)
		end
	end 
	
	--botao_humano = Botao(20, 360, 100, 40, "Teste")

end 

function love.draw()
	--botao_humano:draw()
	reset:draw()
	pvp:draw()
	ai:draw()
	for _, celula in ipairs(Celulas) do 
		celula:draw()
	end 
end 

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

function love.mousepressed(x, y, button)
	for _, celula in ipairs(Celulas) do 
		celula:mousePressed(button)
	end	
	reset:mousePressed(button)
	pvp:mousePressed(button)
	ai:mousePressed(button)
end

