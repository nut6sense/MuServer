local stamina = stamina or {}

stamina.Border = {}
stamina.Border.x = 419
stamina.Border.y = 954
stamina.Border.width = 1012 - stamina.Border.x
stamina.Border.height = 984 - stamina.Border.y

stamina.Bar = {}
stamina.Bar.x = 431
stamina.Bar.y = 988
stamina.Bar.width = 1012 - stamina.Bar.x
stamina.Bar.height = 998 - stamina.Bar.y
-- offset to move staminarbar over to the border
stamina.Bar.localOffsetX = 0
stamina.Bar.localOffsetY = stamina.Bar.y - 974

stamina.BG = {}
stamina.BG.x = 431
stamina.BG.y = 1002
stamina.BG.width = 1012 - stamina.BG.x
stamina.BG.height = 1013 - stamina.BG.y
stamina.BG.localOffsetX = 440   -- from debugging
stamina.BG.localOffsetY = -11   -- from debugging

stamina.Text = {}
-- stamina.Text.localOffsetX = 534
-- stamina.Text.localOffsetY = -12
stamina.Text.stamina = {}
stamina.Text.stamina.localOffsetX = 525
stamina.Text.stamina.localOffsetY = -12

stamina.Text.maxStamina = {}
stamina.Text.maxStamina.localOffsetX = 550
stamina.Text.maxStamina.localOffsetY = -12

local winMgr = CEGUI.WindowManager:getSingleton()

local function RemoveIfExist(windowManager)

    windowManager:destroyWindow("maxion_staminaBG")
    windowManager:destroyWindow("maxion_staminabar")
    windowManager:destroyWindow("maxion_staminabarBorder")
    windowManager:destroyWindow("maxion_staminaText")
    windowManager:destroyWindow("maxion_maxStaminaText")

end

stamina.InitUI = function(windowManager, root)

    -- InitUI only run once so remove first is fine
    RemoveIfExist(windowManager)

    -- background
    local staminaBG = windowManager:createWindow("TaharezLook/StaticImage", "maxion_staminaBG")
    staminaBG:setTexture("Enabled", "UIData/mainbarchat.tga", stamina.BG.x, stamina.BG.y)
    staminaBG:setSize(stamina.BG.width, stamina.BG.height)
    staminaBG:setVisible(true)

    -- stamina bar
    local staminabar = windowManager:createWindow("TaharezLook/StaticImage", "maxion_staminabar")
    staminabar:setTexture("Enabled", "UIData/mainbarchat.tga", stamina.Bar.x, stamina.Bar.y)
    staminabar:setSize(stamina.Bar.width, stamina.Bar.height)
    staminabar:setVisible(true)

    -- border
    local staminaBorder = windowManager:createWindow("TaharezLook/StaticImage", "maxion_staminabarBorder")
    staminaBorder:setTexture("Enabled", "UIData/mainbarchat.tga", stamina.Border.x, stamina.Border.y)
    staminaBorder:setSize(stamina.Border.width, stamina.Border.height)
    staminaBorder:setVisible(true)
    
    -- Stamina Text
    local staminaText = windowManager:createWindow("TaharezLook/StaticText", "maxion_staminaText")
    staminaText:setAlwaysOnTop(true)
    staminaText:setZOrderingEnabled(true)
    staminaText:setViewTextMode(1)
    staminaText:setLineSpacing(2)
    staminaText:addTextExtends("TEST", g_STRING_FONT_GULIMCHE, 12,  255,0,0,255,    2,		0,0,0,255)
    staminaText:setVisible(true)
    staminaText:setAlign(3) -- align right

    local maxStaminaText = windowManager:createWindow("TaharezLook/StaticText", "maxion_maxStaminaText")
    maxStaminaText:setAlwaysOnTop(true)
    maxStaminaText:setZOrderingEnabled(true)
    maxStaminaText:setViewTextMode(1)
    maxStaminaText:setLineSpacing(2)
    maxStaminaText:addTextExtends("TEST", g_STRING_FONT_GULIMCHE, 12,  255,0,0,255,    2,		0,0,0,255)
    maxStaminaText:setVisible(true)


    staminaBG:addChildWindow(staminabar)
    staminaBG:addChildWindow(staminaBorder)
    staminaBG:addChildWindow(staminaText)
    staminaBG:addChildWindow(maxStaminaText)
    staminaBorder:setPosition(-12,-19)


    root:addChildWindow(staminaBG)
    staminaBG:setPosition(stamina.BG.localOffsetX,stamina.BG.localOffsetY)

    -- set stamina text position
    staminaText:setPosition(stamina.Text.stamina.localOffsetX,stamina.Text.stamina.localOffsetY)
    maxStaminaText:setPosition(stamina.Text.maxStamina.localOffsetX,stamina.Text.maxStamina.localOffsetY)

    -- cpp function
    RefreshCharacterStamina()
        
end



stamina.GetParentName = function()
    return "maxion_staminaBG"
end

stamina.SetVisible = function(value)
    
    local staminabar = winMgr:getWindow("maxion_staminaBG")
    if staminabar ~= nil then
        staminabar:setVisible(value)
    end

    local staminaText = winMgr:getWindow("maxion_staminaText")
    if staminaText ~= nil then
        staminaText:setVisible(value)
    end

    local maxStaminaText = winMgr:getWindow("maxion_maxStaminaText")
    if maxStaminaText ~= nil then
        maxStaminaText:setVisible(value)
    end

    local staminaBorder = winMgr:getWindow("maxion_staminabarBorder")
    if staminaBorder ~= nil then
        staminaBorder:setVisible(value)
    end

    local staminabar = winMgr:getWindow("maxion_staminabar")
    if staminabar ~= nil then
        staminabar:setVisible(value)
    end
    
end

stamina.Refresh = function(value,maxStamina) -- int

    local winMgr = CEGUI.WindowManager:getSingleton()

    -- Get the stamina bar window
    local staminabar = winMgr:getWindow("maxion_staminabar")
    if staminabar ~= nil then

        -- Calculate the new width based on the percentage
        local newWidth = GetProportionalValue(value,maxStamina,stamina.Bar.width)

        LOG("Change stamina bar to " .. newWidth)
        -- Set the new size of the stamina bar
        staminabar:setSize(newWidth, stamina.Bar.height)

    end

    LOG("Change stamina text to " .. value .. "/" .. maxStamina)

    local staminaText = winMgr:getWindow("maxion_staminaText")
    if staminaText ~= nil then
        staminaText:clearTextExtends()
        
        local textColor = {}

        if(value > maxStamina) then
            -- text color is green if current stamina is greater than max stamina
            textColor.r = 0
            textColor.g = 255
            textColor.b = 0
            textColor.a = 255
        else
            textColor.r = 255
            textColor.g = 255
            textColor.b = 255
            textColor.a = 255
        end
        
        staminaText:addTextExtends(tostring(value), g_STRING_FONT_GULIMCHE, 12,  textColor.r,textColor.g,textColor.b,textColor.a,    2,		0,0,0,255)
    end

    local maxStaminaText = winMgr:getWindow("maxion_maxStaminaText")
    if maxStaminaText ~= nil then
        maxStaminaText:clearTextExtends()
        maxStaminaText:addTextExtends( "/" .. tostring(maxStamina), g_STRING_FONT_GULIMCHE, 12,  255,255,255,255,    2,		0,0,0,255)
    end

end


function RefreshStamina(current,max)
    stamina.Refresh(current, max)
end

stamina.SetLocalPosition = function(x,y)
    local winMgr = CEGUI.WindowManager:getSingleton()
    local staminabar = winMgr:getWindow("maxion_staminaBG")
    if staminabar ~= nil then
        staminabar:setPosition(x,y)
    end
end

stamina.ResetPosition = function()
    stamina.SetLocalPosition(stamina.BG.localOffsetX,stamina.BG.localOffsetY)
end



return stamina