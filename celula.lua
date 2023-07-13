Celula = Object.extend(Object)
require("ia")

function Celula.new(self, x, y, w, h, i, j, scale)
	--carregar as imagens 
	self.sprite_normal = love.graphics.newImage("assets/celula.png")
	self.sprite_hover = love.graphics.newImage("assets/celula_hover.png")
	self.X = love.graphics.newImage("assets/X.png")
	self.O = love.graphics.newImage("assets/O.png")
	self.current_sprite = self.sprite_normal
	self.scale = scale or 1 
	self.x = x
	self.y = y
	self.w = self.sprite_normal:getWidth() * self.scale  
	self.h = self.sprite_normal:getHeight() * self.scale 
	self.estado = 0 
	self.hover = false
	self.i = i 
	self.j = j
	--estado 0 => nada 
	--estado 1 => X
	--estado 2 => O
	print("Celula criada: ".. self.x.." ".. self.y)
end 

function Celula.update(self, dt)
	local mouse_pos_x, mouse_pos_y  = love.mouse.getPosition()
	
	if mouse_pos_x >= self.x and mouse_pos_x <= self.w + self.x 
	   and mouse_pos_y >= self.y and mouse_pos_y <= self.h + self.y then
	   	self.current_sprite = self.sprite_hover 
		self.hover = true 
	else 
		self.current_sprite = self.sprite_normal  
		self.hover = false 
	end 
end 

function Celula.draw(self)
	love.graphics.draw(self.current_sprite, self.x, self.y, 0, self.scale, self.scale)
	--puxar as informações da grade: 
	self.estado = Grade[self.i][self.j] 
	--desenhar na tela o item
	if self.estado == '1' then 
		love.graphics.draw(self.X, self.x, self.y, 0, self.scale, self.scale)
	elseif self.estado == '2' then  
		love.graphics.draw(self.O, self.x, self.y, 0, self.scale, self.scale)
	
	end 
end

function Celula.mousePressed(self, button)
	if button == 1 and self.hover and self.estado == '0' and em_jogo then 
		print("Jogador "..jogador_atual.. " clicou na posição: ".. self.i .. ", ".. self.j.. " do tabuleiro")
		--altera o estado da mesa 
		--muda o valor da tabela 
		--print(self.i, self.j)
		if modo_jogo == 0 then 
			Grade[self.i][self.j] = jogadores[jogador_atual] 
			checar_tabuleiro()
			jogador_atual = jogador_atual + 1
			if jogador_atual > 2 then 
				jogador_atual = 1 
			end 
		else 
			--inserir o jogo do player 
			Grade[self.i][self.j] = '1' 
			print("Checando tabuleiro...")
			checar_tabuleiro()
			jogador_atual = 2
			--logica de atualização da IA 
			if contar_pecas_livres(Grade) > 0 and em_jogo then
				print("Turno do computador: ")
				local jogada = melhor_jogada(Grade, dificuldade)
				print("Computador jogou na posição ".. jogada.i.. ", "..jogada.j)
				Grade[jogada.i][jogada.j] = '2'
				print("Checando tabuleiro...")
				checar_tabuleiro()
				jogador_atual = 1	
			end 
 		end 
	end 
end 

return Celula 