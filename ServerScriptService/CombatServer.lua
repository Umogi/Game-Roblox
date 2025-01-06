local hitEvent = game.ReplicatedStorage.HitEvent

hitEvent.OnServerEvent:Connect(function(client, data)
	if data.Action == "m1" then
		data.Target.Humanoid:TakeDamage(4)
		if data.Air == "Up" then
			local bp = Instance.new("BodyPosition")
			bp.Position = data.Character.Primary.Position + Vector3.new(0,30,0)
			bp.P = 1200
			bp.MaxForce = Vector3.new(99999, 99999, 99999)
			bp.D = 200
			bp.Name = "Position"
			bp.Parent = data.Character.PrimaryPart
			game.Debris:AddItem(bp,1)
			
			local bp = Instance.new("BodyPosition")
			bp.Position = data.Target.Primary.Position + Vector3.new(0,30,0)
			bp.P = 1200
			bp.MaxForce = Vector3.new(99999, 99999, 99999)
			bp.D = 200
			bp.Name = "Position"
			bp.Parent = data.Target.PrimaryPart
			game.Debris:AddItem(bp,1)
			print("up")
		elseif data.Air == "Down" then
			for i, v in pairs(data.Target.PrimaryPart:GetChildren()) do
				if v:IsA("BodyMover") then
					v:Destroy()
				end
			end
			local bv = Instance.new("BodyVelocity", data.Target.PrimaryPart)
			bv.Velocity = (data.Character.PrimaryPart.CFrame.LookVector * 1 - Vector3.new(0,2,0)) * 25
			bv.MaxForce = Vector3.new(99999,99999,99999)
			bv.Name = "Velocity"
			game.Debris:AddItem(bv, 0.2)
			print("down")
		elseif data.Combo == 4 then
			local bv = Instance.new("BodyVelocity", data.Character.PrimaryPart)
			bv.Velocity = data.Character.PrimaryPart.CFrame.LookVector * 10
			bv.MaxForce = Vector3.new(99999,99999,99999)
			bv.Name = "Velocity"
			game.Debris:AddItem(bv, 0.2)
			local bv = Instance.new("BodyVelocity", data.Target.PrimaryPart)
			bv.Velocity = data.Target.PrimaryPart.CFrame.LookVector * 75
			bv.MaxForce = Vector3.new(99999,99999,99999)
			bv.Name = "Velocity"
			game.Debris:AddItem(bv, 0.2)
		else
			print("i am in 2")
			local bv = Instance.new("BodyVelocity", data.Character.PrimaryPart)
			bv.Velocity = data.Character.PrimaryPart.CFrame.LookVector * 10
			bv.MaxForce = Vector3.new(99999,99999,99999)
			bv.Name = "Velocity"
			game.Debris:AddItem(bv, 0.2)
			local bv = Instance.new("BodyVelocity", data.Target.PrimaryPart)
			bv.Velocity = data.Target.PrimaryPart.CFrame.LookVector * 10
			bv.MaxForce = Vector3.new(99999,99999,99999)
			bv.Name = "Velocity"
			game.Debris:AddItem(bv, 0.2)
		end
	end
end)