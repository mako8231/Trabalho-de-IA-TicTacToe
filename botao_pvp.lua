BotaoPVP = Botao:extend()

function BotaoPVP.new(self, x, y, sprite_normal, sprite_hover, icon, scale) 
	BotaoPVP.super.new(self, x, y, sprite_normal, sprite_hover, icon, scale)
end 


function BotaoPVP.mousePressed(self, button)
	if button == 1 and self.hover then 
		print("Reiniciando o jogo e mudando para o modo Jogador X Jogador: ")
		limpar_grade()
		em_jogo = true 
		modo_jogo = 0 
	end 
end

return BotaoPVP