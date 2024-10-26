Blips = {}

---@type Blip
Blip = Class.new("Blip");

---@class Blip
---@field name string
---@field coords table
---@field sprite number
---@field color number
---@field scale number
---@field range boolean
---@field type string
---@field visible boolean
---@field jobs table
---@field route table
---@field id number
---@field Show fun(self: Blip)
---@field IsVisible fun(self: Blip): boolean
---@field SetVisible fun(self: Blip, visible: boolean)
---@field SetLabel fun(self: Blip)
---@field RemoveBlip fun(self: Blip)
---@field Constructor fun(self: Blip, name: string, data: table): BlipData
function Blip:Constructor(name, data)
    assert(name, "Blip name: (Expected string, got nil)");
    assert(data.coords, "Blip coords: (Expected table, got nil)");

    self.name = name
    self.coords = data.coords
    self.sprite = data.sprite
    self.color = data.color
    self.scale = data.scale or 1.0
    self.range = data.range or true
    self.type = data.type or "default"
    self.visible = false
    self.jobs = data.job or nil
    self.route = data.route or nil
    Blips[self.name] = self
    return self
end

function Blip:Show()
    self.id = AddBlipForCoord(self.coords.x, self.coords.y, self.coords.z);
    self:SetLabel();
    SetBlipSprite(self.id, self.sprite);
    SetBlipColour(self.id, self.color);
    SetBlipScale(self.id, self.scale);
    SetBlipAsShortRange(self.id, self.range);
    BeginTextCommandSetBlipName("BLIP"..self.name);
    AddTextComponentString(self.name);
    EndTextCommandSetBlipName(self.id);
    self:SetVisible(true);
end

function Blip:IsVisible()
    return self.visible;
end

---@param visible boolean
function Blip:SetVisible(visible)
    self.visible = visible;
end

function Blip:SetLabel()
    if self.type == "farm" then
        AddTextEntry('BLIP'..self.name, '~g~[Farm] ~c~-~s~ ~a~');
    elseif self.type == "service" then
        AddTextEntry('BLIP'..self.name, '~g~[Service]~c~:~s~ ~a~');
    elseif self.type == "default" then
        AddTextEntry('BLIP'..self.name, '~a~');
    end
end

function Blip:RemoveBlip()
    RemoveBlip(self.id);
end

function ShowAllBlips()
    for k, _ in pairs(Blips) do
        local isVisible = Blips[k]:IsVisible();
        if not isVisible then
            Blips[k]:Show();
        end
    end
end

Citizen.CreateThread(function()
    while ESX.Table.SizeOf(Blips) >= 1 do
        ShowAllBlips();
        Citizen.Wait(1000);
    end
end)