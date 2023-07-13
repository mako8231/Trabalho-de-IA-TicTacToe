BotaoHard = Botao:extend()

function BotaoHard.new(self, x, y, sprite_normal, sprite_hover, icon, scale) 
	BotaoHard.super.new(self, x, y, sprite_normal, sprite_hover, icon, scale)
end 


function BotaoHard.mousePressed(self, button)
	if button == 1 and self.hover then 
		print("Alterando a dificuldade para DIFÍCIL ")
		limpar_grade()
		em_jogo = true 
		modo_jogo = 1 
		dificuldade = 999 
	end 
end

return BotaoHard