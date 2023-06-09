BotaoReset = Botao:extend()

function BotaoReset.new(self, x, y, sprite_normal, sprite_hover, icon, scale) 
	BotaoReset.super.new(self, x, y, sprite_normal, sprite_hover, icon, scale)
end 


function BotaoReset.mousePressed(self, button)
	if button == 1 and self.hover then 
		print("Reiniciando o jogo: ")
		limpar_grade()
		em_jogo = true 
	end 
end

return BotaoReset