Botao = Object.extend(Object)

function Botao.new(self, x, y, sprite_normal, sprite_hover, icon, scale)
	self.scale = scale or 1 
	self.x = x 
	self.y = y 
	self.sprite_normal = sprite_normal
	self.sprite_hover = sprite_hover 
	self.current_sprite = self.sprite_normal 
	self.icon = icon 
	self.h = self.current_sprite:getHeight() * self.scale 
	self.w = self.current_sprite:getWidth() * self.scale 
	self.hover = false 	

end

function Botao.update(self, dt)
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

function Botao.draw(self)
	love.graphics.draw(self.current_sprite, self.x, self.y, 0, self.scale)
	love.graphics.draw(self.icon, self.x, self.y, 0, self.scale)
	
end  

function Botao.mousePressed(self, button)
	if button == 1 and self.hover then 
		print("Clicou")
	end 

end

return Botao 