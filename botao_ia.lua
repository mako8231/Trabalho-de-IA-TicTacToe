BotaoIA = Botao:extend()

function BotaoIA.new(self, x, y, sprite_normal, sprite_hover, icon, scale) 
	BotaoIA.super.new(self, x, y, sprite_normal, sprite_hover, icon, scale)
end 


function BotaoIA.mousePressed(self, button)
	if button == 1 and self.hover then 
		print("Reiniciando o jogo e mudando para o modo Jogador X Computador: ")
		limpar_grade()
		em_jogo = true 
		modo_jogo = 1 
	end 
end

return BotaoIA