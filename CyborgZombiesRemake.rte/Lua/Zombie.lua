function Create(self)
self.ntwitch = false
self.shouldnotbedoingthis =( GreyGooDefense and tostring(ActivityMan:GetActivity()) == tostring(GreyGooDefense))
end

function Update(self)
self:GetController():SetState(Controller.MOVE_FAST , true)
if not (self:IsPlayerControlled() or self.AIMode == Actor.AIMODE_SENTRY) then
self:GetController():SetState(Controller.BODY_CROUCH , false)
self:GetController():SetState(Controller.MOVE_IDLE  , false)
if self.shouldnotbedoingthis then
if GreyGooDefense.movarea:IsInside(self.Pos) then
self:GetController():SetState(Controller.MOVE_LEFT, false)
self:GetController():SetState(Controller.MOVE_RIGHT, true)
else
if self:GetController():IsState(Controller.MOVE_LEFT) then
self.ntwitch = true
elseif not self.ntwitch then
self:GetController():SetState(Controller.MOVE_RIGHT, true)
else
self.ntwitch = false
end
end
end
end
if math.random(math.floor(math.abs(self.Health/2)) + 1) == 1 and not(self:IsDead()) and MovableMan:ValidMO(self) and MovableMan:IsActor(self) then
self.Health = self.Health + 1
end
if string.find(self.PresetName,"Regen") ~= nil and math.random(math.floor(math.abs(self.Health/2)) + 1) == 1 and not(self:IsDead()) and MovableMan:ValidMO(self) and MovableMan:IsActor(self) then
self.Health = self.Health + 1
end
curdist = 50
self.targ = nil
if cyborgzombieon ~= true then
local part = CreateAEmitter("cyborgzombie Controller");
part.Pos = self.Pos
MovableMan:AddMO(part);
cyborgzombielist = {}
end
	if not(self.infected) then
		for actor in MovableMan.Actors do
		if not(actor:IsInGroup("Undead")) and actor.ClassName ~= "ADoor" and actor:IsDead() == false and actor.Health > 0 then
		dist = SceneMan:ShortestDistance(actor.Pos,self.Pos,true).Magnitude
			if dist < curdist then
			curdist = dist
			self.targ = actor
			end
		end
		end
		if self.targ ~= nil then
		table.insert(cyborgzombielist,self.targ)
		if self.targ.Health < 101 then
		self.targ.Health = 99
		end
		self.infected = true
		self.targ:FlashWhite(1000)
		end
	end
	if math.random(128) == 1 then
	self.infected = false
	end
if MovableMan:ValidMO(self) and MovableMan:IsActor(self) and self:IsDead()then
if not(ActivityMan:GetActivity():ActivityOver() or FrameMan:IsResettingRTE()) then
for actor in MovableMan.Actors do
if not(actor:IsInGroup("Undead")) and actor.ClassName ~= "ADoor" and actor:IsDead() == false and actor.Health > 0 then
dist = SceneMan:ShortestDistance(actor.Pos,self.Pos,true).Magnitude
if dist < 75 and not (self.shouldnotbedoingthis and actor.PresetName == "Gold Drill") then
table.insert(cyborgzombielist,actor)
if actor.Health < 101 then
actor.Health = 99
end
actor:FlashWhite(1000)
end
end
end
end
self:GibThis()
end
end

