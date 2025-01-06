local uis = game:GetService("UserInputService")

local replicatedStarge = game.ReplicatedStorage
local animationMobule = replicatedStarge.Modules.AnimationModule

local AnimationModule = require(animationMobule)

local hitEvent = game.ReplicatedStorage.HitEvent

local character = script.Parent
local humanoid = character.Humanoid
local player = game.Players.LocalPlayer

local Persona = "Character1" -- It will get it from somewhere idk now !

local lastTimeM1 = 0
local lastM1End = 0
local combo = 1

local canAir = true

local animationTable = AnimationModule["Character1"]

local function hitBox(size, cframe, ignore, char)
	local hitBox = Instance.new("Part", workspace.HItBoxes)
	hitBox.Anchored = true
	hitBox.CanCollide = false
	hitBox.CanQuery = false
	hitBox.Transparency = 0.6
	hitBox.Material = Enum.Material.ForceField
	hitBox.Name = "Hitbox"
	hitBox.Size = size
	hitBox.CFrame = cframe

	local connction
	connction = hitBox.Touched:Connect(function()
		connction:Disconnect()
	end)

	local lastTarget = nil

	for i, v in pairs(hitBox:GetTouchingParts()) do
		if v.Parent:FindFirstChild("Humanoid") and table.find(ignore, v.Parent) == nil then
			if lastTarget then
				if (lastTarget.Position - char.PrimaryPart.Position).Magnitude > (v.Position - char.PrimaryPart.Position) then
					lastTarget = v.Parent.PrimaryPart
					break
				end
			else
				lastTarget = v.Parent.PrimaryPart
				break
			end
		end
	end

	hitBox:Destroy()
	if lastTarget then
		return lastTarget.Parent
	else
		return nil
	end
end

uis.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 and tick() - lastTimeM1 > 0.3 and tick() - lastM1End > 0.7 then
		if tick() - lastTimeM1 > 0.7 then
			combo = 1
		end

		lastTimeM1 = tick()

		local animation = Instance.new("Animation", workspace.Fx)
		local air = nil
		
		if uis:IsKeyDown("Space") and combo == 2 and canAir then
			canAir = false
			animation.AnimationId = animationTable.AirAnimation.AirCombo1
			air = "UP"
			print("up")
		elseif uis:IsKeyDown("Space") and combo == 3 and not air then
			animation.AnimationId = animationTable.AirAnimation.AirCombo2
			air = "Down"
			print("down")
		else
			animation.AnimationId = animationTable["Combo" .. combo]
		end

		local load = humanoid:LoadAnimation(animation)
		load:Play()
		animation:Destroy()

		print("Compo Activaed: " .. combo)

		local hitTarget = hitBox(Vector3.new(4,6,4), character.PrimaryPart.CFrame * CFrame.new(0,0,-3), {character}, character)

		if hitTarget then
			local data = {
				["Target"] = hitTarget,
				["Character"] = character,
				["Combo"] = combo,
				["Air"] = air,
				["Action"] = "m1"
			}

			hitEvent:FireServer(data)
		end
		print(combo)
		if combo == 4 then
			combo = 1
			lastM1End = tick()
		else
			combo += 1
		end

		humanoid.WalkSpeed = 0
		wait(0.4)
		humanoid.WalkSpeed = 16

	end
end)