NPCExtension = NPCExtension or {}
NPCExtension.id = NPCExtension.id or {}
NPCExtension.isInit = NPCExtension.isInit or false

-- ClubWar NPC
local clubwarNPC = require("ClubWarNpcExtension")
NPCExtension.id[5] = {
    MENU = {
        {
            name = TOWN_NPC_GANGWAR_MENUNAME2,
            onClicked = clubwarNPC.RequestRegisterGangWarMenu
        }
    }
}


NPCExtension.clickedFuncs = NPCExtension.clickedFuncs or {}

local winMgr = CEGUI.WindowManager:getSingleton()

NPCExtension.Init = function()

    for npcIndex, item in pairs(NPCExtension.id) do

        for _,menuItem in ipairs(item.MENU) do

            local menuName = menuItem.name

            if menuName == nil then
                break
            end

            NPCExtension.clickedFuncs[npcIndex] = menuItem.onClicked

            local menuButton = winMgr:createWindow("TaharezLook/Button", menuName)
            menuButton:setTexture("Normal", "UIData/invisible.tga", 0, 0)
            menuButton:setTexture("Hover", "UIData/mainBG_Button001.tga", 281, 388)
            menuButton:setTexture("Pushed", "UIData/mainBG_Button001.tga", 281, 388)
            menuButton:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 281, 388)
            menuButton:setTexture("Disabled", "UIData/mainBG_Button001.tga", 281, 388)
            menuButton:setPosition(6,35)
            menuButton:setSize(252, 23)
            menuButton:setVisible(false)
            menuButton:setAlwaysOnTop(true)
            menuButton:setZOrderingEnabled(false)
            menuButton:setUserString("Index", tostring(npcIndex))
            menuButton:subscribeEvent("MouseButtonDown", "Button_Type_MouseDown")
            menuButton:subscribeEvent("MouseButtonUp", "Button_Type_MouseUp")
            menuButton:subscribeEvent("MouseLeave", "Button_Type_MouseLeave")
            menuButton:subscribeEvent("MouseEnter", "Button_Type_MouseEnter")
            menuButton:subscribeEvent("Clicked", "OnExtensionClicked")
            winMgr:getWindow("TownNPC_ServiceListBack"):addChildWindow(menuButton)


            local menuText = winMgr:createWindow("TaharezLook/StaticText", menuName.."_Text")
            menuText:setFont(g_STRING_FONT_DODUM, 13)
            menuText:setTextColor(255,198,30, 255)
            menuText:setText("asdsdad")
            menuText:setPosition(4, 4)
            menuText:setSize(207, 16)
            menuText:setEnabled(false)
            menuText:setAlwaysOnTop(true)
            menuText:setZOrderingEnabled(false)

            menuButton:addChildWindow(menuText)

        end
    end

end

NPCExtension.OnPlayerTalk = function(currentButtonIndex,npcIndex)

    local npc = NPCExtension.id[npcIndex]
    if npc == nil then
        return
    end

    for i,menuItem in ipairs(npc.MENU) do

        local menuName = menuItem.name

        local menuButton = winMgr:getWindow(menuName)
        if menuButton == nil then
            return
        end
    
        local menuText = winMgr:getWindow(menuName.."_Text")
        if menuText == nil then
            return
        end
    
    
        menuText:setText(GetSStringInfo(menuName))
	    menuButton:setVisible(true)
	    menuButton:setPosition(6, 35+((i + currentButtonIndex)*23))

    end

end

NPCExtension.GetExtraButtonsCount = function(npcIndex)

    local npc = NPCExtension.id[npcIndex]
    if npc == nil then
        return 0
    end

    return #npc.MENU
end

NPCExtension.HideButtons = function ()
    
    for _, npcMenu in pairs(NPCExtension.id) do
        for _, menuItem in pairs(npcMenu.MENU) do
            local menuName = menuItem.name
            local menuButton = winMgr:getWindow(menuName)
            if menuButton ~= nil then
                menuButton:setVisible(false)
            end
        end
    end

end

function OnExtensionClicked(args)

    local eventWindow = CEGUI.toWindowEventArgs(args).window
    local npcIndex = tonumber(eventWindow:getUserString("Index"))

    CloseNPCServiceListWindow()
	SelectedNpcFunction(npcIndex)
    
    winMgr:getWindow("TownNPC_ServiceListBack"):setVisible(false)
    if NPCExtension.clickedFuncs[npcIndex] then
        NPCExtension.clickedFuncs[npcIndex]()
    end

end

if not NPCExtension.isInit then
    NPCExtension.isInit = true

    if ImGuiUpdate then
        ImGuiUpdate.AddReload("lua/TownNPCFunctionExtension.lua")
    end
end


return NPCExtension
