ClubWarNPC = ClubWarNPC or {}

local imguiDebug = require("ImGuiDebug")

ClubWarNPC.participants = ClubWarNPC.participants or {} -- Table to store player names
ClubWarNPC.isInitReloaded = ClubWarNPC.isInitReloaded or false

local requiredPlayers = 3
local characterNameCount = 16
local displayClubName = ""


local function handleEscape()
    
    imguiDebug.RemoveEvent(ClubWarNPC.RegisterationMenu)

    VirtualImageSetVisible(false)
	TownNpcEscBtnClickEvent()
end

ClubWarNPC.RequestRegisterGangWarMenu = function()
    RequestRegisterGangWarMenu()
end

ClubWarNPC.RegisterationMenu = function()

    imgui.SetNextWindowSize(500, 600, "FirstUseEver")
    local visible, open = imgui.Begin("Register Gang War", true)
    if visible then
        imgui.Text("Guild Name: " .. tostring(displayClubName))
        imgui.Separator()
        imgui.Text("Participants:")

        -- Participant list
        for i = 1, requiredPlayers do
            local changed, value = imgui.InputText("Player " .. i, 
                ClubWarNPC.participants[i] or "",
                characterNameCount)
            if changed then
                ClubWarNPC.participants[i] = value
            end
        end

        -- Action buttons
        if imgui.Button("Register") then
            local isSuccess = RegisterGangWarPlayers(ClubWarNPC.participants)
            if not isSuccess then
                ShowNotifyOKMessage_Lua(GetSStringInfo(LAN_LUA_GANGWAR_REGISTERATION_FAILED))
            end
        end
        imgui.SameLine()
        if imgui.Button("Escape") then
            handleEscape()
        end

        imgui.End()
    end

    if not open then
        handleEscape()
    end
end


function MakeGangWarRegisterMenu(clubName)

    if CheckNpcModeforLua() then

        displayClubName = clubName

        -- Add the menu to ImGuiUpdate
        imguiDebug.AddEvent(ClubWarNPC.RegisterationMenu)

    end

end

function RejectRequestMenu()
    ShowNotifyOKMessage_Lua(GetSStringInfo(LAN_LUA_GANGWAR_REQUEST_FAILED_01))

    VirtualImageSetVisible(false)
	TownNpcEscBtnClickEvent()
end

function RegisterationResponse(responseEnum)
    if responseEnum == 1 then
        ShowNotifyOKMessage_Lua(GetSStringInfo(LAN_LUA_GANGWAR_REGISTERATION_SUCCESS))
    else
        ShowNotifyOKMessage_Lua(GetSStringInfo(LAN_LUA_GANGWAR_REGISTERATION_FAILED) .. " " .. GetSStringInfo(responseEnum))
    end
end

function SaveParticipants(participantsString)

    if participantsString == "" or participantsString == nil then
        return
    end

    ClubWarNPC.participants = {}

    for name in string.gmatch(participantsString, "([^,]+)") do
        local trimmedName = string.match(name, "^%s*(.-)%s*$") -- trim leading/trailing spaces
        table.insert(ClubWarNPC.participants, trimmedName)
        LOG("Added participant: '" .. trimmedName .. "'")
    end

    -- add the rest as empty strings
    for i = #ClubWarNPC.participants + 1, requiredPlayers do
        table.insert(ClubWarNPC.participants, "")
    end

end

if not ClubWarNPC.isInitReloaded then
    ClubWarNPC.isInitReloaded = true

    if ImGuiUpdate then
        ImGuiUpdate.AddReload("lua/ClubWarNpcExtension.lua")
    end
end


return ClubWarNPC