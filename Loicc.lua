repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer
local plr = game.Players.LocalPlayer
repeat wait() until plr.Character
repeat wait() until plr.Character:FindFirstChild("HumanoidRootPart")
repeat wait() until plr.Character:FindFirstChild("Humanoid")
repeat wait() until workspace:FindFirstChild("__THINGS")
local StoppedTp

if not getgenv().Tasks then 
    getgenv().Tasks = {}
    Tasks.__index = Tasks
    
    function Tasks.new(name,func)
        local obj = {
            Name = name,
            Function = func
        }
        setmetatable(obj, Tasks)
        return obj
    end
    
    function Tasks:Stop() 
        if not self:IsRunning() then return end
        if self.Thread then 
            task.cancel(self.Thread)
        end
        if self.ForceStoped then 
            self.ForceStoped()
        end
    end
    function Tasks:Start() 
        if self:IsRunning() then return end
        self.Thread = task.spawn(self.Function)
        return self
    end
    
    function Tasks:IsRunning() 
        if not self.Thread then return false end
        return coroutine.status(self.Thread) ~= "dead"
    end
end

if not getgenv().ListTask then 
    getgenv().ListTask = {}
end

local TaskHandler = {}

function TaskHandler:AddTask(Name, func)
    ListTask[Name] = Tasks.new(name,func)
    return ListTask[Name]
end

function TaskHandler:StopTask(Name)
    if not ListTask[Name] then return end
    ListTask[Name]:Stop()
end

function TaskHandler:CancelAll()
    for k, v in pairs(ListTask) do
        v:Stop()
    end
end
TaskHandler:CancelAll()

table.clear(getgenv().ListTask)
getgenv().ListTask = {}


function TP(pos) 
    pcall(function() 
        if not game.Workspace:FindFirstChild("Map") then 
            local NearestTeleport = GetNearestTeleport()
            if NearestTeleport then 
                if plr:DistanceFromCharacter(NearestTeleport.Teleports.Leave.Position) < 1000 then 
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(NearestTeleport.Teleports.Leave.Position)
                    wait(3)
                end
            end
        end
        plr.Character.HumanoidRootPart.CFrame = pos
    end)
end

function TPNormal(pos) 
    pcall(function() 
        plr.Character.HumanoidRootPart.CFrame = pos
    end)
end

function Tap() 
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Instancing_InvokeCustomFromClient"):InvokeServer("AdvancedFishing","Clicked")
end 
local RandomX = math.random(-20,20)
local RandomY = math.random(-20,20)

function ThaCan(pos) 
    if not pos then 
        pos = Vector3.new(tonumber(tostring(1448 + RandomX).."."..plr.UserId), 61.625038146972656, tonumber(tostring(-4409 + RandomY).."."..plr.UserId))
    end
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Click"):FireServer(Ray.new(Vector3.new(1378.8731689453125, 75.38618469238281, -4397.716796875), Vector3.new(0.8105669021606445, -0.5571429133415222, -0.18048004806041718)))
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Instancing_FireCustomFromClient"):FireServer("AdvancedFishing","RequestReel")
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Instancing_FireCustomFromClient"):FireServer("AdvancedFishing","RequestCast",pos)
end
function IsFishingGuiEnabled() 
    local s,e = pcall(function() 
        return game:GetService("Players").LocalPlayer.PlayerGui._INSTANCES.FishingGame
    end)
    if not s then return false end
    
    return e.Enabled
end

function IsPlayerFishing() 
    local s,e = pcall(function() 
        if plr.Character.Model.Rod:FindFirstChild("FishingLine") then 
            return plr.Character.Model.Rod:FindFirstChild("FishingLine")
        end
        return false
    end)
    if not s then return false end
    return e
end
getgenv().Time = 1.1
function CheckThaCan() 
    local Line = IsPlayerFishing()
    if not Line:FindFirstChild("Value") then 
        Instance.new("NumberValue",Line).Value = tick()
    else
        if Line then 
            for k,v in game.ReplicatedStorage.__DIRECTORY.FishingRods:GetChildren() do 
                if v:FindFirstChild("Model") and v:IsA("ModuleScript") and v.Model:FindFirstChild("Rod") then 
                    if Line.Parent.MeshId == v.Model.Rod.MeshId then
                        if tick() - Line.Value.Value > require(v).MinFishingTime * getgenv().Time then 
                            return true
                        else
                            return false
                        end
                        break
                    end
                end
            end
        end
    end
    
end


local plr = game.Players.LocalPlayer
function GetPlayerRobber() 
    local s,e = pcall(function() 
        for k,v in workspace.__THINGS.__INSTANCE_CONTAINER.Active.AdvancedFishing.Bobbers:GetChildren() do 
            if v:FindFirstChild("Bobber") then 
                local Number = tonumber("1448."..plr.UserId)
                if math.abs(v.Bobber.Position.X - tonumber(tostring(1448 + RandomX).."."..plr.UserId)) < 0.001 or  math.abs(v.Bobber.Position.z - tonumber(tostring(-4409 + RandomY).."."..plr.UserId)) < 0.001 then 
                    return v.Bobber
                end
            end
        end
    end)
    if not s then return false end
    return e
end
function GetNearestTeleport() 
    local s,e = pcall(function() 
        local NearestTeleport
        for k,v in workspace.__THINGS.Instances:GetChildren() do 
            if v:FindFirstChild("Teleports") then 
                if v.Teleports:FindFirstChild("Leave") then 
                    if not NearestTeleport then 
                        NearestTeleport = v
                    end
                    if plr:DistanceFromCharacter(v.Teleports.Leave.Position) < plr:DistanceFromCharacter(NearestTeleport.Teleports.Leave.Position) then 
                        NearestTeleport = v
                    end
                end
            end
        end
        return NearestTeleport
    end)

    if not s then return nil end
    return e
end

function IsPlayerInMapCauCa() 
    if game.Workspace:FindFirstChild("Map") then return false end
    
    local s,e = pcall(function() 
        if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("AdvancedFishing") then 
            if plr:DistanceFromCharacter(Vector3.new(1381.8416748046875, 64.95339965820312, -4451.9794921875)) < 500 then 
                return true
            end
        end
    end)

    if not s then return false end
    return e
end


TaskHandler:AddTask("CauCa",function() 
    while wait() do
        if not StoppedTp then 
            if not IsPlayerInMapCauCa() then 
                if not game.Workspace:FindFirstChild("Map") then 
                    local NearestTeleport = GetNearestTeleport()
                    if NearestTeleport then 
                        if plr:DistanceFromCharacter(NearestTeleport.Teleports.Leave.Position) < 1000 then 
                            plr.Character.HumanoidRootPart.CFrame = CFrame.new(NearestTeleport.Teleports.Leave.Position)
                            wait(3)
                        end
                    end
                else
                    if workspace.__THINGS.Instances:FindFirstChild("AdvancedFishing") then 
                        if workspace.__THINGS.Instances.AdvancedFishing:FindFirstChild("Teleports") and workspace.__THINGS.Instances.AdvancedFishing.Teleports:FindFirstChild("Enter") then 
                            plr.Character.HumanoidRootPart.CFrame = CFrame.new(workspace.__THINGS.Instances.AdvancedFishing.Teleports.Enter.Position)
                            wait(3)
                        end
                    end
                end
            else
                if IsFishingGuiEnabled() then 
                    task.spawn(Tap)
                    task.spawn(Tap)
                    wait()
                else
                    if not IsPlayerFishing() then 
                        ThaCan()
                        pcall(function() 
                            plr.Character.Model.Rod:WaitForChild("FishingLine",2)
                        end)
                        getgenv().Start = tick()
                    else
                        local Robber = GetPlayerRobber()
                        if Robber then
                            if Robber:FindFirstChild("ReadyToCheck") then
                                if math.abs((Robber.CFrame.Y - math.floor(Robber.CFrame.Y)) - 0.625) > 0.1 then 
                                    ThaCan()
                                    --if getgenv().Start then print(tick() - getgenv().Start) end
                                end
                            else
                                if math.abs((Robber.CFrame.Y - math.floor(Robber.CFrame.Y)) - 0.625) < 0.03 then 
                                    Instance.new("BoolValue",Robber).Name = "ReadyToCheck"
                                end
                            end
                        else
                            pcall(function() 
                                if not plr.Character.Model.Rod.FishingLine:FindFirstChild("Value") then 
                                    Instance.new("NumberValue",plr.Character.Model.Rod.FishingLine).Value = tick()
                                end
                                if tick() - plr.Character.Model.Rod.FishingLine.Value.Value > 4 then 
                                    ThaCan()
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
end):Start()

local MerchantInfo = {
    RegularMerchant = {
        Position = CFrame.new(372.11248779296875, 16.306806564331055, 551.4596557617188)
    },
    AdvancedMerchant = {
        Position = CFrame.new(808.6577758789062, 16.58210563659668, 1548.416748046875)
    },
    GardenMerchant = {
        Position = CFrame.new(258.5284729003906, 16.566850662231445, 2067.40087890625)
    }
}
local ListMerchant = {}

for k,v in MerchantInfo do 
    table.insert(ListMerchant,k)
end

ListMerchant = {
    RegularMerchant = true,
    AdvancedMerchant = true,
    GardenMerchant = true
}


local MerchantsTable 



game:GetService("ReplicatedStorage"):WaitForChild("Network").Merchant_Updated.OnClientEvent:Connect(function(...)
    MerchantsTable = ...
end)
local MerchantUtil = require(game.ReplicatedStorage.Library.Util.MerchantUtil)
local SaveModule = require(game.ReplicatedStorage.Library.Client.Save)
TaskHandler:AddTask("Merchant",function() 
    while wait(1) do --AdvancedMerchant.Offers["1"].PriceData.data
        if MerchantsTable and type(MerchantsTable) == "table" then 
            for k,v in ListMerchant do
                local MerchantName = k
                if v and MerchantsTable[k] and MerchantsTable[k].Offers then 
                    for k,v in MerchantsTable[k].Offers do 
                        if v.Stock and v.Stock > 0 then 
                            pcall(function() 
                                local PlayerExp = SaveModule.GetSaves()[plr].MerchantExperience[MerchantName] or 1
                                local PlayerRespect = MerchantUtil.RespectLevelFromExperience(PlayerExp)
                                if PlayerRespect >= v.Respect then 
                                    if plr.leaderstats["\240\159\146\142 Diamonds"].Value >= v.PriceData.data._am then 
                                        if plr:DistanceFromCharacter(MerchantInfo[MerchantName].Position.p) > 100 then 
                                            StoppedTp = true
                                            TP(MerchantInfo[MerchantName].Position)
                                            wait(1)
                                        end
                                        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Merchant_RequestPurchase"):InvokeServer(MerchantName,tonumber(k))
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        elseif MerchantsTable == nil then
            for k,v in ListMerchant do
                local MerchantName = k
                if v then 
                    if plr:DistanceFromCharacter(MerchantInfo[MerchantName].Position.p) > 100 then 
                        StoppedTp = true
                        TP(MerchantInfo[MerchantName].Position)
                        wait(1)
                    end
                    local Break 
                    for i = 1,6 do 
                        if game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Merchant_RequestPurchase"):InvokeServer(MerchantName,i) then Break = true break end
