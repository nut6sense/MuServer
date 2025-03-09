local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
local drawer2	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

function drawRank(index, x, y, scale)
    px = 0
    py = 0
    if index == -1 then
        px = 0
        py = 0
    elseif index == 35 then
        px = 240
        py = 0
    else
        px = math.fmod(index, 5) * 60
        py = (math.floor(index / 5)+1) * 60
    end 
    drawer:drawTextureSA("UIData/MatchMakingRanking.tga", x, y, 60, 60, px, py, scale, scale, 255, 0, 0, 6)
end

function setRankBadgeIcon(rankLevel, x, y, px, py)
    -- Set the rank icon based on the rankName  
    if rankLevel == 1 then   --"Rookie"
        drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y, 200, 200, px + 20, py + 5, 50, 55, 255, 0, 0, 0)
        
    elseif rankLevel == 2  then --"Bronze"
        drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y, 200, 200, px + 20, py + 200, 50, 55, 255, 0, 0, 0)
        
    elseif rankLevel == 3 then -- "Iron"
        drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y, 200, 200, px + 20, py + 400, 50, 55, 255, 0, 0, 0)
        
    elseif rankLevel == 4  then -- "Silver"
        drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y, 200, 200, px + 20, py + 600, 50, 55, 255, 0, 0, 0)
        
    elseif rankLevel == 5 then -- "Gold"
        drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y - 10, 200, 200, px + 20, py + 800, 50, 55, 255, 0, 0, 0)
        
    elseif rankLevel == 6  then -- "Platinum"
        drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y - 10, 200, 200, px + 20, py + 1000, 50, 55, 255, 0, 0, 0)
        
    elseif rankLevel == 7 then --"Diamond"
        drawer2:drawTextureSA("UIData/Raking_Badge.png", x + 5, y - 5, 200, 200, px + 20, py + 1250, 50, 55, 255, 0, 0, 0)
        
    elseif rankLevel == 8 then -- "Master"
        drawer2:drawTextureSA("UIData/Raking_Badge.png", x + 5, y - 5, 200, 230, px + 20, py + 1475, 50, 55, 255, 0, 0, 0)
        
    elseif rankLevel == 9 then -- "GrandMaster"
        drawer2:drawTextureSA("UIData/Raking_Badge.png", x - 5, y - 10, 220, 240, px + 20, py + 1700, 50, 55, 255, 0, 0, 0)
        
    else
        print("Unknown rank: ??? ")
    end
end


function drawRank2(index, x, y, scale)
    px = 0
    py = 0
    if index == -1 then
        px = 0
        py = 0
    elseif index == 35 then
        px = 240
        py = 0
    else
        px = math.fmod(index, 5) * 60
        py = (math.floor(index / 5)+1) * 60
    end 
    -- drawer:drawTextureSA("UIData/MatchMakingRanking.tga", x, y, 60, 60, px, py, scale, scale, 255, 0, 0, 0)
    -- Maxion
    -- Dragon Attemp 1#            Path                canvas spritescale    spritePos   ScalePic  Color   
    -- drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y, 200, 200, px + 20, py + 5, 50, 55, 255, 0, 0, 0)  -- Unrank
    -- drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y, 200, 200, px + 20, py + 200, 50, 55, 255, 0, 0, 0)  -- Bronze
    -- drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y, 200, 200, px + 20, py + 400, 50, 55, 255, 0, 0, 0)  -- Iron
    -- drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y, 200, 200, px + 20, py + 600, 50, 55, 255, 0, 0, 0)  -- Sliver
    -- drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y - 10, 200, 200, px + 20, py + 800, 50, 55, 255, 0, 0, 0)  -- Gold
    -- drawer2:drawTextureSA("UIData/Raking_Badge.png", x, y - 10, 200, 200, px + 20, py + 1000, 50, 55, 255, 0, 0, 0)  -- Platinum
    -- drawer2:drawTextureSA("UIData/Raking_Badge.png", x + 5, y - 5, 200, 200, px + 20, py + 1250, 50, 55, 255, 0, 0, 0)  -- Diamond
    -- drawer2:drawTextureSA("UIData/Raking_Badge.png", x + 5, y - 5, 200, 230, px + 20, py + 1475, 50, 55, 255, 0, 0, 0)  -- Master
    -- drawer2:drawTextureSA("UIData/Raking_Badge.png", x - 5, y - 10, 220, 240, px + 20, py + 1700, 50, 55, 255, 0, 0, 0)  -- GrandMaster

    -- #2 Change it into function 
    setRankBadgeIcon(1, x, y, px, py)
end


function drawRankWindow(window, index, x, y, scale)
    if window == '' then
        return
    end

    px = 0
    py = 0
    if index == -1 then
        px = 0
        py = 0
    elseif index == 35 then
        px = 240
        py = 0
    else
        px = math.fmod(index, 5) * 60
        py = (math.floor(index / 5)+1) * 60
    end 

    window:setTexture("Enabled", "UIData/MatchMakingRanking.tga", px, py)
	window:setProperty("FrameEnabled", "False")
	window:setProperty("BackgroundEnabled", "False")
	window:setPosition(x, y)
	window:setSize(60, 60)
    window:setScaleWidth(scale)
	window:setScaleHeight(scale)
    window:setZOrderingEnabled(false)
	window:setEnabled(true)
	window:setVisible(true)
    return window
    -- drawer:drawTextureSA("UIData/MatchMakingRanking.tga", x, y, 60, 60, px, py, scale, scale, 255, 0, 0)
end