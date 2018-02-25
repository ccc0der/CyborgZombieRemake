function Update(self)

self:GetController():SetState(Controller.MOVE_FAST , true)
if not (self:IsPlayerControlled() or self.AIMode == Actor.AIMODE_SENTRY) then
self:GetController():SetState(Controller.BODY_CROUCH , false)
self:GetController():SetState(Controller.MOVE_IDLE  , false)
end
if math.random(math.floor(math.abs(self.Health/2)) + 1) == 1 and not(self:IsDead()) and MovableMan:ValidMO(self) and MovableMan:IsActor(self)then
self.Health = self.Health + 1
end
if string.find(self.PresetName,"Regen") ~= nil and math.random(math.floor(math.abs(self.Health/2))+ 1) == 1 and not(self:IsDead()) and MovableMan:ValidMO(self) and MovableMan:IsActor(self)then
self.Health = self.Health + 1
end
end