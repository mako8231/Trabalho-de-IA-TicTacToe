BotaoMedium = Botao:extend()

function BotaoMedium.new(self, x, y, sprite_normal, sprite_hover, icon, scale) 
	BotaoMedium.super.new(self, x, y, sprite_normal, sprite_hover, icon, scale)
end 


function BotaoMedium.mousePressed(self, button)
	if button == 1 and self.hover then 
		print("Alterando a dificuldade para MÉDIO ")
		limpar_grade()
		em_jogo = true 
		modo_jogo = 1 
		dificuldade = 5 
	end 
end

return BotaoMedium