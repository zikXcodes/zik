-- Steal an Egg Script dengan Wind UI Library

        if not flying or not rootPart.Parent then return end
        
        local direction = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + (camera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - (camera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction = direction - Vector3.new(0, 1, 0)
        end
        
        if direction.Magnitude > 0 then
            direction = direction.Unit
        end
        
        bodyVelocity.Velocity = direction * flySpeed
        bodyGyro.CFrame = camera.CFrame
    end)
end


function stopFlying()
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
    end
    if bodyGyro then
        bodyGyro:Destroy()
    end
end


-- Cleanup saat player meninggal
player.CharacterAdded:Connect(function()
    wait(0.1)
    if flying then
        stopFlying()
    end
end)


print("✓ Steal an Egg Script Loaded!")
print("✓ Wind UI GUI Siap Digunakan!")

m
