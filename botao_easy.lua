BotaoEasy = Botao:extend()

function BotaoEasy.new(self, x, y, sprite_normal, sprite_hover, icon, scale) 
	BotaoEasy.super.new(self, x, y, sprite_normal, sprite_hover, icon, scale)
end 


function BotaoEasy.mousePressed(self, button)
	if button == 1 and self.hover then 
		print("Alterando a dificuldade para FÁCIL ")
		limpar_grade()
		em_jogo = true 
		modo_jogo = 1 
		dificuldade = 2 
	end 
end

return BotaoEasy