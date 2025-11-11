    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    
    local player = Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    local noclip = Value
    
    -- 穿墙功能
    if noclip then
        -- 启用穿墙
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "穿墙",
            Text = "穿墙已开启",
            Icon = "rbxassetid://105677776902677",
            Duration = 2,
        })
        
        -- 存储原始碰撞状态
        local originalCollide = {}
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                originalCollide[part] = part.CanCollide
                part.CanCollide = false
            end
        end
        
        -- 持续禁用碰撞的连接
        local noclipConnection
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclip then
                noclipConnection:Disconnect()
                return
            end
            
            if character and character.Parent then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
        -- 角色重生时重新应用
        local characterAddedConnection
        characterAddedConnection = player.CharacterAdded:Connect(function(newChar)
            character = newChar
            wait(1) -- 等待角色完全加载
            
            -- 重新应用穿墙效果
            if noclip then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
        -- 存储连接以便关闭时清理
        getgenv().NoclipData = getgenv().NoclipData or {}
        getgenv().NoclipData.Connection = noclipConnection
        getgenv().NoclipData.CharConnection = characterAddedConnection
        getgenv().NoclipData.OriginalCollide = originalCollide
        
    else
        -- 禁用穿墙
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "穿墙",
            Text = "穿墙已关闭",
            Icon = "rbxassetid://105677776902677",
            Duration = 2,
        })
        
        -- 恢复碰撞
        if character and character.Parent then
            local noclipData = getgenv().NoclipData or {}
            if noclipData.OriginalCollide then
                for part, canCollide in pairs(noclipData.OriginalCollide) do
                    if part and part.Parent then
                        part.CanCollide = canCollide
                    end
                end
            else
                -- 如果没有存储原始状态，默认恢复碰撞
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
        
        -- 断开连接
        local noclipData = getgenv().NoclipData or {}
        if noclipData.Connection then
            noclipData.Connection:Disconnect()
        end
        if noclipData.CharConnection then
            noclipData.CharConnection:Disconnect()
        end
        
        getgenv().NoclipData = nil
    end
end)