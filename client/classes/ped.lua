---@type Ped
Ped = Class.new("Ped");

---@class Ped
---@field type number
---@field model string
---@field coords vector3
---@field heading number
---@field networked boolean
---@field CreatePed function(pedType: number, model: string, coords: vector3, heading: number, networked: boolean): ped
---@field FreezePed function
---@field SetCoords function(newCoords: vector3)
---@field SetPedGod function
---@field SetPedHealth function(health: number)
---@field SetPedArmour function(ped: ped, armour: number)
---@field SetPedNotScared function(toggle: boolean)
---@field GetCoords function: vector3
---@field GetPed function: ped
---@field DeletePed function
---@field Constructor function(self: Ped, data: table): PedData
function Ped:Constructor(data)
    Application:Initialized("Ped");
end

---@param pedType number
---@param model string
---@param coords vector3
---@param heading? number
---@param networked? boolean
---@return ped
function Ped:CreatePed(pedType, model, coords, heading, networked)
    self.type = pedType or 0;
    self.model = model or "a_m_m_skater_01";
    self.coords = coords or vector3(0, 0, 0);
    self.heading = heading or 0.0;
    self.networked = networked or true;

    RequestModel(self.model);

    while not HasModelLoaded(self.model) do
        Citizen.Wait(0);
    end

    self.ped = CreatePed(self.type, self.model, self.coords.x, self.coords.y, self.coords.z, self.heading, self.networked, false);
    return self.ped;
end

function Ped:FreezePed()
    self.frozen = true;
    FreezeEntityPosition(self.ped, true);
end

function Ped:SetCoords(newCoords)
    self.coords = newCoords
    SetEntityCoords(self.ped, newCoords);
end

function Ped:SetPedGod()
    self.invicible = true;
    SetEntityInvincible(self.ped, true);
end

function Ped:SetPedHealth(health)
    self.health = health;
    SetEntityHealth(self.ped, health);
end

---@param ped Ped
function Ped:SetPedArmour(ped, armour)
    self.armour = armour;
    SetPedArmour(self.ped, armour);
end

---@param toggle boolean
function Ped:SetPedNotScared(toggle)
    self.scared = toggle
    SetBlockingOfNonTemporaryEvents(self.ped, toggle);
    SetCanAttackFriendly(self.ped, toggle, toggle);
end

function Ped:GetCoords()
    return self.coords;
end

function Ped:GetPed()
    return self.ped;
end

function Ped:DeletePed()
    DeleteEntity(self.ped);
end

exports("Ped", function()
    return Ped;
end);