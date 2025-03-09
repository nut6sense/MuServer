local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

-- Helper function & variable ////////////////////////////////////////////////////////////////////////////////
function getWindow(component, name)
	local newWindow = winMgr:getWindow(name)
	if newWindow == nil then
		newWindow = winMgr:createWindow(component, name)
	end
	return newWindow
end

g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY = GetCurrentResolution()
screenOffsetX = (1920 - g_GAME_WIN_SIZEX) / 2
screenOffsetY = (1080 - g_GAME_WIN_SIZEY) / 2


-- Main Element ////////////////////////////////////////////////////////////////////////////////
mainWindow = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_window")
mainWindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mainWindow:setPosition(0, 0)
mainWindow:setSize(g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY)
mainWindow:setVisible(true)
mainWindow:setEnabled(true)
mainWindow:setAlwaysOnTop(true)
mainWindow:setZOrderingEnabled(false)
root:addChildWindow(mainWindow)

panelWindow2 = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_panel")
panelWindow2:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
panelWindow2:setProperty("FrameEnabled", "false")
panelWindow2:setProperty("BackgroundEnabled", "false")
panelWindow2:setWideType(6)
panelWindow2:setPosition(590, 135)
panelWindow2:setSize(600, g_GAME_WIN_SIZEY)
panelWindow2:setZOrderingEnabled(false)
panelWindow2:setVisible(true)
panelWindow2:setSubscribeEvent("MouseWheel", "ExampleScrollbar_MouseWheelEvent")
mainWindow:addChildWindow(panelWindow2)

panelWindow = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_panel2")
panelWindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
panelWindow:setProperty("FrameEnabled", "false")
panelWindow:setProperty("BackgroundEnabled", "false")
panelWindow:setPosition(0, 0)
panelWindow:setSize(600, g_GAME_WIN_SIZEY)
panelWindow:setVisible(true)
panelWindow:setZOrderingEnabled(false)
panelWindow2:addChildWindow(panelWindow)


-- Set item nad re-calculate scroll size ////////////////////////////////////////////////////////////////////////////////
local tRewardItems = {}
local currentItemIndex = 1
local maxItemIndex = 0
local maxScrollY = 0
function ExampleScrollbar_SetRewardItem(j, item_name, item_file_name, item_quantity)
	if j == 1 then
		tRewardItems = {}
	end

	table.insert(tRewardItems, {
		item_name = item_name,
		item_file_name = item_file_name,
		item_quantity = item_quantity,
	});

	maxScrollY = (g_GAME_WIN_SIZEY / 2) - (120 * j)
	maxItemIndex = j
end

local tButtonRewardPosY = {['err']=237, [0]=237, 136, 34}
function ExampleScrollbar_RenderRewardItem()
	for j=1, #tRewardItems do
		local buttonIndex = j+currentItemIndex-1
		local rewardItem = tRewardItems[buttonIndex]

		local item_name = rewardItem.item_name
		local item_file_name = rewardItem.item_file_name
		local item_quantity = "x" .. tostring(rewardItem.item_quantity) .. " EA"

		-- local item_name = "Super Egg (1 days)"
		-- local item_file_name = "UIData/ItemUIData/bag"
		-- local item_quantity = "x2 EA"

		itemWindow = getWindow("TaharezLook/StaticImage", "rank_reward_item" .. j)
		itemWindow:setTexture("Enabled", "UIData/invisible.tga", 344, 101)
		itemWindow:setProperty("FrameEnabled", "True")
		itemWindow:setProperty("BackgroundEnabled", "True")
		itemWindow:setPosition(0, 120 * (j-1))
		itemWindow:setSize(344, 101)
		itemWindow:setVisible(true)
		panelWindow:addChildWindow(itemWindow)

        -- KROB
		buttonWindow = getWindow("TaharezLook/Button", "rank_reward_button" .. j)
		buttonWindow:setTexture("Normal", "UIData/rank_reward_texture.tga", 0, 136)
		buttonWindow:setTexture("Hover", "UIData/rank_reward_texture.tga", 345, 136)
		buttonWindow:setPosition(0, 0)
		buttonWindow:setSize(344, 101)
		buttonWindow:setEnabled(true)
		buttonWindow:setVisible(true)
		itemWindow:addChildWindow(buttonWindow)

		itemImageWindow = getWindow("TaharezLook/StaticImage", "rank_reward_image_bg" .. j)
		itemImageWindow:setTexture("Enabled", "UIData/rank_reward_texture.tga", 1, 339)
		itemImageWindow:setPosition(13, 31)
		itemImageWindow:setSize(55, 56)
		itemImageWindow:setVisible(true)
		buttonWindow:addChildWindow(itemImageWindow)

		mywindow = getWindow("TaharezLook/StaticText", "rank_reward_name" .. j)
		mywindow:setAlphaWithChild(0)
		mywindow:setPosition(78, 35)
		mywindow:setSize(0, 0)
		mywindow:clearTextExtends();
		mywindow:setViewTextMode(1);
		mywindow:addTextExtends(item_name, g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,    2, 0,0,0,255);	
		buttonWindow:addChildWindow(mywindow)

		mywindow = getWindow("TaharezLook/StaticText", "rank_reward_quantity" .. j)
		mywindow:setPosition(78, 55)
		mywindow:setSize(0, 0)
		mywindow:clearTextExtends();
		mywindow:setViewTextMode(1);
		mywindow:addTextExtends(item_quantity, g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,    2, 0,0,0,255);	
		buttonWindow:addChildWindow(mywindow)

        rewardWindow = getWindow("TaharezLook/RadioButton", "MyStorage_ItemList_Button_".. j)
        rewardWindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
        rewardWindow:setPosition(70 * 0, 0)
        rewardWindow:setSize(55, 55);
        rewardWindow:setVisible(true)
        itemImageWindow:addChildWindow(rewardWindow)

        mywindow = getWindow("TaharezLook/StaticImage", "ItemListContainer_Image_".. j)
        mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
        mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
        mywindow:setTexture("Enabled", "UIData/ItemUIData/" .. item_file_name, 0, 0)
        mywindow:setScaleWidth(140)
        mywindow:setScaleHeight(140)
        mywindow:setVisible(true)
        mywindow:setZOrderingEnabled(false)
        rewardWindow:addChildWindow(mywindow)
	end
end


-- Scrollbar ////////////////////////////////////////////////////////////////////////////////
scrollBar = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_scroll")
scrollBar:setTexture("Enabled", "UIData/rank_reward_texture.tga", 1009, 0)
scrollBar:setWideType(6)
scrollBar:setPosition(1024 - 79, 130)
scrollBar:setSize(15, 586)
scrollBar:setVisible(true)
scrollBar:setEnabled(true)
scrollBar:setZOrderingEnabled(false)
scrollBar:setUseEventController(false)
mainWindow:addChildWindow(scrollBar)

scrollPin = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_scroll_pin")
scrollPin:setTexture("Enabled", "UIData/rank_reward_texture.tga", 1000, 0)
scrollPin:setPosition(1024 + ((g_GAME_WIN_SIZEX - 1024) / 2) - 76, 133)
scrollPin:setSize(8, 137)
scrollPin:setVisible(true)
scrollPin:setEnabled(true)
scrollPin:setZOrderingEnabled(false)
scrollPin:setUseEventController(false)
mainWindow:addChildWindow(scrollPin)


-- Calculate scaling factors and map the value
function mapValue(value, srcMin, srcMax, dstMin, dstMax)
    local scale = (dstMax - dstMin) * value
    local result = (scale + (srcMax - 1)) / srcMax + dstMin
    return result
end

-- Event Handler ////////////////////////////////////////////////////////////////////////////////
scrollSpeed = 80
scrollPosition = -10
scrollBarPosition = 0
function ExampleScrollbar_MouseWheelEvent(args)
	local delta = CEGUI.toMouseEventArgs(args).wheelChange
    scrollPosition = scrollPosition + (delta * scrollSpeed)

    if scrollPosition > -1 then
        scrollPosition = -1
    end

    if scrollPosition < maxScrollY then
        scrollPosition = maxScrollY
    end

    local maxY = 445
    local newScrollY = mapValue(scrollPosition, 0, maxScrollY, 0, maxY)
    scrollBarPosition = 133 + newScrollY
end

currentScrollPosition = -1
currentScrollBarPosition = -1
function ExampleScrollbar_Render()
	currentScrollPosition = currentScrollPosition + ((scrollPosition - currentScrollPosition)/8)
	currentScrollBarPosition = currentScrollBarPosition + ((scrollBarPosition - currentScrollBarPosition)/8)

    if currentScrollPosition > -1 then
		currentScrollPosition = -1
	end

	panelWindow:setPosition(0, currentScrollPosition)
    scrollPin:setPosition(1024 + ((g_GAME_WIN_SIZEX - 1024) / 2) - 76, currentScrollBarPosition)
end