local Start = tick()

game:GetService("StarterGui"):SetCore("SendNotification",{ 
    Title = "v0.3.1",
    Text = "妲己吧缝合脚本", 
    Icon = "rbxassetid://105677776902677", 
    Duration = 2 
})

local ui = loadstring(game:HttpGet("https://pastebin.com/raw/3vQbADjh"))()
local win = ui:new("妲己吧脚本")

-- ... 你的其他脚本内容 ...
local UITab1 = win:Tab("『公告』",'7734068321')
local UITab2 = win:Tab("『通用』",'7734068321')
local UITab3 = win:Tab("『其它脚本』",'7734068321')
local UITab4 = win:Tab("『玩家』",'7734068321')
local UITab5 = win:Tab("『甩飞|黑洞』",'7734068321')

local about = UITab1:section("『公告』",true)

about:Label("你的注入器:"..identifyexecutor())
about:Label("当前服务器ID:".. game.GameId)
about:Label("你的用户名:".. game.Players.LocalPlayer.DisplayName)
about:Label("你的账号年龄:"..game.Players.LocalPlayer.AccountAge.."天")
about:Label("服务器名称:"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
about:Label("你的用户ID:"..game.Players.LocalPlayer.UserId)
about:Label("客户端ID:"..game:GetService("RbxAnalyticsService"):GetClientId())

local about = UITab1:section("『脚本信息』",true)

about:Label("妲己吧v0.3.1")
about:Label("这是缝合")
about:Label("更新内容：新增穿墙和透视！")
about:Label("deepseekNB")

local about = UITab2:section("『实用』",true)  -- 分类内功能分类
about:Toggle("无限跳","Toggle",false,function(Value)
        Jump = Value
        game.UserInputService.JumpRequest:Connect(function()
            if Jump then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end)
    
about:Slider("视野", "FieldOfView", Workspace.CurrentCamera.FieldOfView, 10, 180, false, function(FOV)
    spawn(function() 
        while task.wait() do 
            Workspace.CurrentCamera.FieldOfView = FOV
        end 
    end)
end)

about:Toggle("夜视","Toggle",false,function(Value)
if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end
end)

about:Toggle("穿墙","Toggle",false,function(Value)
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

about:Button("踏空行走",function() --（单点类）
    loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)

about:Button("飞行",function() --（单点类）
    loadstring(game:HttpGet('https://raw.githubusercontent.com/HoshinoAi1813/djbscript/refs/heads/main/FlyGuiV3'))()
end)

about:Button("蜘蛛侠（开启后无法关闭）",function() --（单点类）
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

local about = UITab3:section("『别人的脚本』",true)  -- 分类内功能分类

about:Button("XA Hub",function() --（单点类）
    loadstring(game:HttpGet("https://raw.gitcode.com/Xingtaiduan/Scripts/raw/main/Loader.lua"))()
end)

about:Button("皮脚本",function() --（单点类）
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

local about = UITab4:section("『透视』",true)
-- 简化版通用透视
about:Toggle("玩家透视","Toggle",false,function(Value)
    if Value then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "透视",
            Text = "玩家透视已开启",
            Icon = "rbxassetid://105677776902677",
            Duration = 2,
        })
        
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = player.Character
                highlight.Parent = player.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.FillTransparency = 0.7
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    else
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "透视",
            Text = "玩家透视已关闭",
            Icon = "rbxassetid://105677776902677",
            Duration = 2,
        })
        
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChildOfClass("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

local about = UITab5:section("『甩飞』",true)  -- 分类内功能分类

local about = UITab5:section("『黑洞』",true)
about:Button("黑洞英文",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-BLACK-HOLE-30646"))()
end)

-- 反挂机
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "欢迎使用妲己吧脚本",
    Text = "加载成功！",
    Icon = "rbxassetid://105677776902677",
    Duration = 2,
})
