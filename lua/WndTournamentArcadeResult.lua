-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()



local g_QUESTRESULT_1 = PreCreateString_1355	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_1)	-- ü�轺ų�� �����ؾ� ����� �� �ִ� \n��ų�� �̸� ü���ϰ� ���ִ� ������\n�Դϴ�.
local g_QUESTRESULT_2 = PreCreateString_1356	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_2)	-- ���� �������� ���� �м��뿷�� �ִ�\n�����̵���� ��Ű���� ������ �ָ�\n���� �����۵�� ��ȯ�� �����մϴ�.
local g_QUESTRESULT_4 = PreCreateString_1358	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_4)	-- �����Կ��� Ȯ���ϼ���.
local g_QUESTRESULT_5 = PreCreateString_1359	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_5)	-- ���� �������� ���� �м��뿷�� �ִ�\n�����̵� ���� ��Ű���� ������ �ָ�\n���� �����۵�� ��ȯ�� �����մϴ�.
local g_QUESTRESULT_6 = PreCreateString_1357	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_3)	-- Ŭ����
local g_QUESTRESULT_7 = PreCreateString_2341	--GetSStringInfo(LAN_LUCKY_FIGHTER_SUCCESS)			-- ��Ű ������ ����! 
local g_QUESTRESULT_8 = PreCreateString_2343	--GetSStringInfo(LAN_LUCKY_FIGHTER_ATTAINMENT)			-- %d��° ��Ű �����Ͱ� �Ǽ̽��ϴ� 
local g_QUESTRESULT_9 = PreCreateString_2340	--GetSStringInfo(LAN_LUCKY_FIGHTER_REWARD)				-- "%s"�� ���޵˴ϴ� 
local g_QUESTRESULT_10= PreCreateString_2342	--GetSStringInfo(LAN_LUCKY_FIGHTER_FAIL)				-- ��Ű ������ ����! 
local g_QUESTRESULT_11= PreCreateString_2344	--GetSStringInfo(LAN_LUCKY_FIGHTER_COUNT_NOTIFY)		-- ����� ��Ű ī��Ʈ�� %d �Դϴ� 
local g_QUESTRESULT_12= 
PreCreateString_2345	--GetSStringInfo(LAN_LUCKY_FIGHTER_CHALLENGE_AGAIN)	-- �ٽ� ������ ������!

------------------------------------------------------------

-- ��� �̹���

------------------------------------------------------------
local g_characterInfoWindowsPosY = 636
function WndQuestResult_RenderBackImage()
	drawer:drawTexture("UIData/ResultNewImage_2.tga", 66, g_characterInfoWindowsPosY, 892, 121, 4, 896, WIDETYPE_6 )			-- �ɸ��� ����â
	--drawer:drawTexture("UIData/ResultNewImage_2.tga", 235, g_characterInfoWindowsPosY+40, 100, 22, 245, 935)	-- ĳ���ڸ��� ������ �ֱ����� �޹��
	--drawer:drawTexture("UIData/DungeonResult.tga", 240, g_characterInfoWindowsPosY+41, 70, 22, 430, 549)		-- ĳ���ڸ��� ����
	drawer:drawTexture("UIData/DungeonResult.tga", 470, g_characterInfoWindowsPosY+6, 440, 23, 426, 525, WIDETYPE_6 )		-- ����(ȹ������)
end




-- ��Ű ī��Ʈ â ����
local TexXTable = {['err']=0, [0]=0, 517}
local AlphaTable = {['err']=0, [0]=255,0,0,255, 0,255,255,0}
for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questResult_luckyCountTextBack"..i)
	mywindow:setTexture("Disabled", "UIData/event001.tga", TexXTable[i], 938)
	mywindow:setWideType(6);
	mywindow:setPosition(0, 0)
	mywindow:setSize(361, 86)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:addController("LuckyCountController", "LuckyCountTextBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i], AlphaTable[4*i+1], 2, true, true, 10)
	mywindow:addController("LuckyCountController", "LuckyCountTextBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i+2], AlphaTable[4*i+3], 2, true, true, 10)
	root:addChildWindow(mywindow)
end

TexXTable = {['err']=0, [0]=431, 878}
for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questResult_luckyCountItemBack"..i)
	mywindow:setTexture("Disabled", "UIData/event001.tga", TexXTable[i], 938)
	mywindow:setWideType(6);
	mywindow:setPosition(0, 0)
	mywindow:setSize(86, 86)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:addController("LuckyCountController", "LuckyCountItemBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i], AlphaTable[4*i+1], 2, true, true, 10)
	mywindow:addController("LuckyCountController", "LuckyCountItemBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i+2], AlphaTable[4*i+3], 2, true, true, 10)
	root:addChildWindow(mywindow)
end
local bLuckyCountEffectOnce = true
local bLuckyCountEffectVisible = true


	
	
	
------------------------------------------------------------

-- �ɸ��� ���� �׸���

------------------------------------------------------------
tResultTime = { ["err"]=0, [0]=515, 550, 586, 622, 657, 693, 729, 766, 801, 836 }
local g_increaseExp = 0
local g_levelTable  = 0
local g_successShow = false
local g_buffExpTime = 0
local g_buffZenTime = 0

function WndQuestResult_RenderCharacterInfo(level, name, style, exp, expPercent, increaseExp, levelTable, gran, bSuccess, ladder, currentCoin,
											buff_EXP, buff_ZEN, icafe_EXP, icafe_ZEN, deltaTime, resultState, promotion, attribute)

	g_increaseExp = increaseExp
	g_levelTable  = levelTable
	
	local infoY = g_characterInfoWindowsPosY+17
	
	-- ����	
	drawer:setTextColor(255,205,86,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText("Lv." .. level, 150, infoY+4, WIDETYPE_6)
	
	-- ����
	drawer:drawTexture("UIData/numberUi001.tga", 320, infoY+25, 47, 21, 113, 600+21*ladder, WIDETYPE_6)
	
	-- �̸�
	drawer:setTextColor(97,230,255,255)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(name))
	drawer:drawText(name, 190-nameSize/2, infoY+32, WIDETYPE_6)
	
	-- ��Ÿ��	
	drawer:drawTexture("UIData/Skill_up2.tga", 316, infoY-14,  89, 35,  tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute], WIDETYPE_6)
	drawer:drawTexture("UIData/Skill_up2.tga", 316, infoY-14,  89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[promotion], WIDETYPE_6)
	
	-- ����ġ %����
	local percent = 0
	if g_levelTable > 0 then
		percent = increaseExp*100/levelTable
	end
	drawer:setTextColor(0,0,0,255)
	drawer:drawText(percent .. " %", 904, infoY+72, WIDETYPE_6)
		
	-- ����ġ ������
	drawer:drawTexture("UIData/ResultNewImage_2.tga", 124, infoY+62, expPercent, 33, 62, 818, WIDETYPE_6)
		
	-- ����ġ ���±���
	drawer:setTextColor(255,255,255,255)
	local currentExpText = increaseExp .. "  /  " ..  levelTable
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, 520-currentExpSize/2, infoY+72, WIDETYPE_6)
		
	-- �׶�
	local szMyGran = CommatoMoneyStr(gran)
	r,g,b = GetGranColor(tonumber(gran))
	drawer:setTextColor(r,g,b,255)	
	local granSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, szMyGran)
	--drawer:drawText(szMyGran, 180-granSize/2, infoY+29)
	
	-- ����
	drawer:setTextColor(255,255,255,255)
	local coinSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, currentCoin)
	--drawer:drawText(currentCoin, 344-coinSize/2, infoY+29)
	
	-- ����
	
	if resultState < 6 then
		if buff_EXP > 0 then
			g_buffExpTime = g_buffExpTime + deltaTime
			g_buffExpTime = g_buffExpTime % 400
			if g_buffExpTime > 200 then
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 774, 645+9, 32, 32, 320, 788, 200, 200, 255, 0, 8, 100, 0, WIDETYPE_6)
			else
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 774, 645+12, 32, 32, 320, 788, 200, 200, 255, 0, 8, 100, 0, WIDETYPE_6)
			end
		end
		
		if buff_ZEN > 0 then
			g_buffZenTime = g_buffZenTime + deltaTime
			g_buffZenTime = g_buffZenTime % 400
			if g_buffZenTime > 200 then
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 922, 645+9, 32, 32, 352, 788, 200, 200, 255, 0, 8, 100, 0, WIDETYPE_6)
			else
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 922, 645+12, 32, 32, 352, 788, 200, 200, 255, 0, 8, 100, 0, WIDETYPE_6)
			end
		end
		
		
		-- I-CAFE
		if icafe_EXP > 0 then
		end
		
		if icafe_ZEN > 0 then
		end		
	end	
end


-- EndRender
function WndQuestResult_EndRender(bLuckyEvent, LuckyCount, LuckyRewardMoney, bEventOk,			-- ��Ű�̺�Ʈ �������п���, ��Űī��Ʈ, ��Ű�̺�Ʈ ����, ��Ű�̺�Ʈ ����������
								LuckyRewardItemName, LuckyRewardItemFileName)								-- ��Ű�̺�Ʈ���� �������̸�, ��Ű�̺�Ʈ���� �����������̸�
	-- ��Ű ī��Ʈ ǥ��	==================================
	if bEventOk == 1 then
		local posY = 550
		if bLuckyEvent == 1 then		-- ��Ű �̺�Ʈ�� ��÷�ƴ�
			local posX = 15--32	
			if bLuckyCountEffectOnce then
				for i=0, 1 do
					winMgr:getWindow("sj_questResult_luckyCountItemBack"..i):setPosition(posX, posY)
					winMgr:getWindow("sj_questResult_luckyCountItemBack"..i):setVisible(true)
					winMgr:getWindow("sj_questResult_luckyCountItemBack"..i):activeMotion("LuckyCountItemBackMotion")
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setPosition(posX+68, posY)
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setVisible(true)
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):activeMotion("LuckyCountTextBackMotion")
				end
				bLuckyCountEffectOnce = false
			end
			drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
			common_DrawOutlineText1(drawer, g_QUESTRESULT_7, posX+140, posY+14, 140,140,140,255, 97,230,240,255, WIDETYPE_6)
			local String = string.format(g_QUESTRESULT_8, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+90, posY+35, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			if LuckyRewardMoney > 0 then	-- �޴� �������� zen�̴�
				String = string.format(g_QUESTRESULT_9, CommatoMoneyStr(LuckyRewardMoney).." Zen")
				drawer:drawTextureSA("UIData/ItemUIData/item/Zen.tga", posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0, WIDETYPE_6)		
			else							-- �Ϲ� �������� �޴´�.
				String = string.format(g_QUESTRESULT_9, LuckyRewardItemName)
				drawer:drawTextureSA("UIData/ItemUIData/"..LuckyRewardItemFileName, posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0, WIDETYPE_6)		
			end		
			common_DrawOutlineText1(drawer, String, posX+90, posY+56, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
		else
			local posX = 65--32
			if bLuckyCountEffectOnce then
				for i=0, 1 do
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setPosition(posX, posY)
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setVisible(true)
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):activeMotion("LuckyCountTextBackMotion")
				end
				bLuckyCountEffectOnce = false
			end	
			drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
			common_DrawOutlineText1(drawer, g_QUESTRESULT_10, posX+72, posY+14, 140,140,140,255, 240,30,40,255, WIDETYPE_6)
			local String = string.format(g_QUESTRESULT_11, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+16, posY+35, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			common_DrawOutlineText1(drawer, g_QUESTRESULT_12, posX+16, posY+55, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
		end
	end
	--==================================================	
end

-- ��Ű ī��Ʈ �̺�Ʈ â�� �����.
function WndQuestResult_LuckyCountHide()
	if bLuckyCountEffectVisible then
		for i=0, 1 do
			winMgr:getWindow("sj_questResult_luckyCountItemBack"..i):setVisible(false)
			winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setVisible(false)
		end
		bLuckyCountEffectVisible = false
	end
end




------------------------------------------------------------

-- 1. ���׸���(����, ���ʽ�, ����â)

------------------------------------------------------------
local g_dungeonResultX = 200

local g_backImageTime	= 0
local g_backImagePosX	= 1500
local g_backImagePosY	= 30
local g_backImageFlag	= 0
local g_backImageSound  = true
local g_resultStage		= 0
function WndQuestResult_Show1stBackImage(bSuccess, deltaTime, min, sec, milliSec)

	if deltaTime < 0 then
		return
	end
	
	g_backImageTime = g_backImageTime + deltaTime
	
	local show = 0
	if g_backImageTime >= 1500 then
		if g_backImageSound then
			PlaySound("sound/Dungeon/Dungeon_Result_Window.wav")
			g_backImageSound = false
		end
		g_backImagePosX, g_backImageFlag, show = Effect_Circular_EaseOut(g_backImageTime-1500, 1300, -1100, 300, 417, g_backImageFlag)
	end
	
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX, g_backImagePosY, 542, 594, 482, 0, WIDETYPE_6)
	
	if show == 1 then
		IncreaseStateCount()
		
	-- ��ũ���������� �ð��� �����ɰ�� �Ѿ�� �Ѵ�.
	elseif g_backImageTime >= 2000 then
		g_backImagePosX = 417
		IncreaseStateCount()
	end
end



local tResultTime_Large = { ["err"]=0, [0]=716, 744, 772, 800, 828, 856, 884, 912, 940, 968 }
function CalcTimeForLarge(time, startPos1, startPos2, timePosY)

	if time <= 0 then
		return
	end
	
	local min = (time / 1000) / 60;
	local sec = (time / 1000) % 60;
	local milliSec = (time % 1000) / 10;
	
	-- minute
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1, timePosY, 28, 37, tResultTime_Large[min/10], 757, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2, timePosY, 28, 37, tResultTime_Large[min%10], 757, WIDETYPE_6)
	
	-- :
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+23, timePosY, 28, 37, 632, 757, WIDETYPE_6)
	
	-- second
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1+72, timePosY, 28, 37, tResultTime_Large[sec/10], 757, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+72, timePosY, 28, 37, tResultTime_Large[sec%10], 757, WIDETYPE_6)
	
	-- :
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+23+72, timePosY, 28, 37, 632, 757, WIDETYPE_6)
	
	-- milli second
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1+140, timePosY, 28, 37, tResultTime_Large[milliSec/10], 757, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+140, timePosY, 28, 37, tResultTime_Large[milliSec%10], 757, WIDETYPE_6)
end

local tResultTime_Small = { ["err"]=0, [0]=324, 344, 364, 384, 404, 424, 444, 464, 484, 504 }
function CalcTimeForSmall(time, startPos1, startPos2, timePosY)
	
	if time <= 0 then
		return
	end
	
	local min = (time / 1000) / 60;
	local sec = (time / 1000) % 60;
	local milliSec = (time % 1000) / 10;
	
	-- minute
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1, timePosY, 20, 27, tResultTime_Small[min/10], 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2, timePosY, 20, 27, tResultTime_Small[min%10], 419, WIDETYPE_6)
	
	-- :
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+16, timePosY, 20, 27, 284, 419, WIDETYPE_6)
	
	-- second
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1+54, timePosY, 20, 27, tResultTime_Small[sec/10], 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+54, timePosY, 20, 27, tResultTime_Small[sec%10], 419, WIDETYPE_6)
	
	-- :
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+16+54, timePosY, 20, 27, 284, 419, WIDETYPE_6)
	
	-- milli second
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1+104, timePosY, 20, 27, tResultTime_Small[milliSec/10], 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+104, timePosY, 20, 27, tResultTime_Small[milliSec%10], 419, WIDETYPE_6)
end


------------------------------------------------------------

-- 2. ���� ���� �׸���

------------------------------------------------------------
function WndQuestResult_TAInfo(todayStage, todayRank, todayTime, myBestStage, myBestRank, myBestTime,
							rankName1, rankName2, rankName3, rankName4, rankName5,
							rankStage1, rankStage2, rankStage3, rankStage4, rankStage5,
							rankTime1, rankTime2, rankTime3, rankTime4, rankTime5)
	
	-- ���׸���(����, ���ʽ�, ����â)
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX, g_backImagePosY, 542, 594, 482, 0, WIDETYPE_6)
	
	-- ��������
	g_resultStage = todayStage
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX-380, g_backImagePosY+4, 256, 55, 768, 655, WIDETYPE_6)
	DrawEachNumberWide("UIData/Tournament001.tga", g_resultStage, 1, g_backImagePosX-120, g_backImagePosY, 484, 594, 54, 61, 54, WIDETYPE_6)
	
	------------------
	-- ���� ���ھ�
	------------------
	local startPos1	= 240
	local startPos2	= startPos1 + 26
	local timePosY	= g_backImagePosY+90
	DrawEachNumberWide("UIData/numberUi001.tga", todayStage, 8, g_backImagePosX+80, g_backImagePosY+90, 716, 757, 28, 37, 28, WIDETYPE_6)		-- ��������
--	DrawEachNumber("UIData/numberUi001.tga", todayRank, 8, g_backImagePosX+179, g_backImagePosY+90, 716, 757, 28, 37, 28)		-- ��ũ	
	CalcTimeForLarge(todayTime, startPos1, startPos2, timePosY)
	
	
	------------------
	-- ���� �ְ� ���ھ�
	------------------
	DrawEachNumberWide("UIData/numberUi001.tga", myBestStage, 8, g_backImagePosX+80, g_backImagePosY+236,  716, 757, 28, 37, 28, WIDETYPE_6)	-- ��������
--	DrawEachNumber("UIData/numberUi001.tga", myBestRank, 8, g_backImagePosX+179, g_backImagePosY+236, 716, 757, 28, 37, 28)		-- ��ũ

	timePosY = g_backImagePosY+236
	CalcTimeForLarge(myBestTime, startPos1, startPos2, timePosY)
	
	
	------------------
	-- 1 ~ 5�� ��Ŀ ���ھ�
	------------------
	local RANK1_Y = 396
	local RANK2_Y = 436
	local RANK3_Y = 476
	local RANK4_Y = 516
	local RANK5_Y = 556
	local RANK_X = 23
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK1_Y, 20, 27, 344, 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK2_Y, 20, 27, 364, 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK3_Y, 20, 27, 384, 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK4_Y, 20, 27, 404, 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK5_Y, 20, 27, 424, 419, WIDETYPE_6)
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 20)
	drawer:setTextColor(255,255,255,255)
	
	RANK_X = 70
	if rankTime1 > 0 then	drawer:drawText(rankName1, g_backImagePosX+RANK_X, RANK1_Y+3, WIDETYPE_6)	end
	if rankTime2 > 0 then	drawer:drawText(rankName2, g_backImagePosX+RANK_X, RANK2_Y+3, WIDETYPE_6)	end
	if rankTime3 > 0 then	drawer:drawText(rankName3, g_backImagePosX+RANK_X, RANK3_Y+3, WIDETYPE_6)	end
	if rankTime4 > 0 then	drawer:drawText(rankName4, g_backImagePosX+RANK_X, RANK4_Y+3, WIDETYPE_6)	end
	if rankTime5 > 0 then	drawer:drawText(rankName5, g_backImagePosX+RANK_X, RANK5_Y+3, WIDETYPE_6)	end
	
	RANK_X = 290
	if rankTime1 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage1, 1, g_backImagePosX+RANK_X, RANK1_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	if rankTime2 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage2, 1, g_backImagePosX+RANK_X, RANK2_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	if rankTime3 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage3, 1, g_backImagePosX+RANK_X, RANK3_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	if rankTime4 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage4, 1, g_backImagePosX+RANK_X, RANK4_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	if rankTime5 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage5, 1, g_backImagePosX+RANK_X, RANK5_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	
	startPos1	= 360
	startPos2	= startPos1 + 18
	if rankTime1 > 0 then	CalcTimeForSmall(rankTime1, startPos1, startPos2, RANK1_Y)	end
	if rankTime2 > 0 then	CalcTimeForSmall(rankTime2, startPos1, startPos2, RANK2_Y)	end
	if rankTime3 > 0 then	CalcTimeForSmall(rankTime3, startPos1, startPos2, RANK3_Y)	end
	if rankTime4 > 0 then	CalcTimeForSmall(rankTime4, startPos1, startPos2, RANK4_Y)	end
	if rankTime5 > 0 then	CalcTimeForSmall(rankTime5, startPos1, startPos2, RANK5_Y)	end
end




------------------------------------------------------------

-- 3. ��� �׸���

------------------------------------------------------------
function WndQuestResult_ShowGradeEffect(deltaTime, grade, isHiddenMode)
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX, g_backImagePosY, 542, 594, 482, 0, WIDETYPE_6)
	
	-- ��������
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX-260, g_backImagePosY+6, 256, 55, 768, 655, WIDETYPE_6)
	DrawEachNumberWide("UIData/Tournament001.tga", g_resultStage, 1, g_backImagePosX-380, g_backImagePosY, 484, 594, 54, 61, 54, WIDETYPE_6)
end






------------------------------------------------------------

-- 4. ����, ����ġ, ����Ʈ �׸���

------------------------------------------------------------
local g_totalScore	= 0
local g_gainExp		= 0
local g_gainPoint	= 0
local g_gainCoin	= 0
local g_currentLife	= 0
function WndQuestResult_ShowTotalScore(deltaTime, totalScore, gainExp, gainPoint, gainCoin, currentLife)

	-- ������ ���� ������ �����Ѵ�.
	g_totalScore	= totalScore
	g_gainExp		= gainExp
	g_gainPoint		= gainPoint
	g_gainCoin		= gainCoin
	g_currentLife	= currentLife

	local _infoY = g_characterInfoWindowsPosY + 38
	local _left, _right
	

	-- ����ġ
	if gainExp <= 0 then
		gainExp = 0
	end
	DrawEachNumberWide("UIData/dungeonmsg.tga", gainExp, 2, 818, _infoY-1, 286, 751, 16, 26, 27, WIDETYPE_6)		-- ����ġ
	drawer:drawTexture("UIData/dungeonmsg.tga", 838, _infoY, 19, 26, 582, 751, WIDETYPE_6)	-- /
	
	
	-- �׶�
	if gainPoint <= 0 then
		gainPoint = 0
	end
	DrawEachNumberWide("UIData/dungeonmsg.tga", gainPoint, 1, 860, _infoY-1, 286, 751, 16, 26, 27, WIDETYPE_6)		-- �׶�
	
	
	-- ȹ�� ����
	if gainCoin <= 0 then
		gainCoin = 0
	end
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", gainCoin, 8, 695, _infoY+3, 727, 675, 20, 22, 27, WIDETYPE_6)	-- ����
	drawer:drawTexture("UIData/dungeonmsg.tga", _left-45, _infoY-8, 33, 41, 643, 670, WIDETYPE_6)	-- ���� �̹���
	drawer:drawTexture("UIData/dungeonmsg.tga", _left-20, _infoY+4, 27, 22, 700, 675, WIDETYPE_6)	-- x
	
	
	-- ���� ������
	if currentLife <= 0 then
		currentLife = 0
	end
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", currentLife, 8, 522, _infoY+3, 727, 675, 20, 22, 27, WIDETYPE_6)-- ������
	drawer:drawTexture("UIData/quest.tga", _left-60, _infoY-11, 62, 38, 77, 898, WIDETYPE_6)	-- ������ �̹���
	
end





------------------------------------------------------------

-- 5. ���ʽ� �׸���

------------------------------------------------------------
-- ���� ����
local tEableBonus = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tExpValue	  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tBonusValue = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tExpPosX	  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tExpPosY	  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tBonusEffectScaleX = { ["err"]=0, [0]=255, 255, 255, 255, 255 }
local tBonusEffectScaleY = { ["err"]=0, [0]=255, 255, 255, 255, 255 }
local tBonusEffectAlpha	 = { ["err"]=0, [0]=255, 255, 255, 255, 255 }

function WndQuestResult_IsVisibleBonusData(index, bVisible)
	tEableBonus[index] = bVisible
end

function WndQuestResult_ShowIncreaseBonus(deltaTime,
						exp0, exp1, exp2, exp3, exp4, bonus0, bonus1, bonus2, bonus3, bonus4, addExp, addPoint, icafe)

	-- 4. ����, ����ġ, ����Ʈ �׸���
	WndQuestResult_ShowTotalScore(deltaTime, g_totalScore, addExp, addPoint, g_gainCoin, g_currentLife)
end







------------------------------------------------------------

-- 6. ���� ����ġ, ����Ʈ�� +�ȴ�

------------------------------------------------------------
local g_bLevelup			= false
local tLevelupY				= { ["protectErr"]=0, [0]=450, 150 }
local g_levelupEffect_Star	= 0
local g_levelupAlpha		= 350

function WndQuestResult_ShowLevelupEffect()
	g_bLevelup = true
end



function WndQuestResult_AddMyExpAndPoint(deltaTime, gainExp, gainPoint, bUpEffect)

	g_gainExp	= gainExp
	g_gainPoint = gainPoint
	
	-- 5. ���ʽ� �׸���
	WndQuestResult_ShowIncreaseBonus(deltaTime,
						tExpValue[0], tExpValue[1], tExpValue[2], tExpValue[3], tExpValue[4], 
						tBonusValue[0], tBonusValue[1], tBonusValue[2], tBonusValue[3], tBonusValue[4], gainExp, gainPoint)
						

	-- ������ ����
	if g_bLevelup then
		tLevelupY[0] = tLevelupY[0] - 1
		if tLevelupY[0] <= tLevelupY[1] then
			tLevelupY[0] = tLevelupY[1]
			g_levelupAlpha = 0
		else
			g_levelupAlpha = g_levelupAlpha - 1
			if g_levelupAlpha > 255 then
				g_levelupAlpha = 255
			elseif g_levelupAlpha <= 0 then
				g_levelupAlpha = 0
			end
			
			g_levelupEffect_Star = g_levelupEffect_Star + deltaTime
			g_levelupEffect_Star = g_levelupEffect_Star % 100
						
			if g_levelupEffect_Star < 50 then
				-- ��
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 100, tLevelupY[0]-20, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 270, tLevelupY[0]-10, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga",  50, tLevelupY[0]+30, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 210, tLevelupY[0]+80, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
			end
			
			-- ������ ����
			drawer:drawTextureA("UIData/ResultNewImage_2.tga", 70, tLevelupY[0], 280, 85, 0, 0, g_levelupAlpha, WIDETYPE_6)
		end
	end	
end




local g_incEffect = 0
local g_leftPercent = 0
local g_rightPercent = 0
local g_bSuccess = false
function WndQuestResult_ShowIncreaseExpEffect(deltaTime, bSuccess, leftPercent, rightPercent)
	
	g_bSuccess		= bSuccess
	g_leftPercent	= leftPercent
	g_rightPercent	= rightPercent
	
--	if bSuccess == 0 then
--		return
--	end
	
	g_incEffect = g_incEffect + deltaTime
	g_incEffect = g_incEffect % 150
	
	
	if g_incEffect > 75 then
		drawer:drawTexture("UIData/ResultNewImage_2.tga", 124+leftPercent, g_characterInfoWindowsPosY+79, rightPercent-leftPercent, 33, 62+leftPercent, 851, WIDETYPE_6)
	end


	-- ����ġ ���±���
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:setTextColor(255,255,255,255)
	local currentExpText = g_increaseExp .. "  /  " ..  g_levelTable
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, 520-currentExpSize/2, g_characterInfoWindowsPosY+89, WIDETYPE_6)
		
end


local BUTTON_NORMAL = 0		-- �⺻ �ڽ�
local BUTTON_CLICK  = 1		-- �ڽ� Ŭ������ ��
local BUTTON_SELECT = 2		-- �ڽ��� ���õǾ��� ��
g_currentSelectBoxCount = 0
g_enableSelectBoxCount = 8
local g_onceSet = false
local tSelectBtnClick = {["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0}
local tSelectBtnTime  = {["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0}
local tSelectBtnPosX  = {["err"]=0, 60, 290, 520, 750, 60, 290, 520, 750}
local tSelectBtnPosY  = {["err"]=0, 480, 480, 480, 480, 600, 600, 600, 600}
for i=1, 8 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_TA_SelectBox_"..i)
	mywindow:setTexture("Enabled", "UIData/Tournament001.tga", 213, 0)
	mywindow:setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setWideType(6);
	mywindow:setPosition(tSelectBtnPosX[i], tSelectBtnPosY[i])
	mywindow:setSize(215, 107)
	mywindow:setUserString("boxIndex", tostring(i))
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_RewardInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_RewardInfo")
	mywindow:subscribeEvent("MouseButtonDown", "OnMMouseButtonDown_RewardInfo")
	root:addChildWindow(mywindow)
end

-- �ڽ� hover
function OnMouseEnter_RewardInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window ~= nil then
		local szBoxIndex = CEGUI.toWindowEventArgs(args).window:getUserString("boxIndex")
		if szBoxIndex ~= "" then
			local boxIndex = tonumber(szBoxIndex)
			if tSelectBtnClick[boxIndex] == BUTTON_NORMAL then
				window:setTexture("Enabled", "UIData/Tournament001.tga", 213, 107)
				window:setTexture("Disabled", "UIData/Tournament001.tga", 213, 107)
			end
		end
	end
end

-- �ڽ� ��������
function OnMouseLeave_RewardInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window ~= nil then
		local szBoxIndex = CEGUI.toWindowEventArgs(args).window:getUserString("boxIndex")
		if szBoxIndex ~= "" then
			local boxIndex = tonumber(szBoxIndex)
			if tSelectBtnClick[boxIndex] == BUTTON_NORMAL then
				window:setTexture("Enabled", "UIData/Tournament001.tga", 213, 0)
				window:setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
			end
		end
	end
end

-- �ڽ� ����
function OnMMouseButtonDown_RewardInfo(args)
	local szBoxIndex = CEGUI.toWindowEventArgs(args).window:getUserString("boxIndex")
	if szBoxIndex ~= "" then
		local boxIndex = tonumber(szBoxIndex)
		
		if g_currentSelectBoxCount < g_enableSelectBoxCount then
			g_currentSelectBoxCount = g_currentSelectBoxCount + 1
			
			if tSelectBtnClick[boxIndex] == BUTTON_NORMAL then
				tSelectBtnClick[boxIndex] = BUTTON_CLICK
				tSelectBtnTime[boxIndex] = 0
				
				SelectedRewardBox(boxIndex)
				SetCurrentEnableCount(g_currentSelectBoxCount)
				
				if g_currentSelectBoxCount == g_enableSelectBoxCount then
					for i=1, 8 do
						if tSelectBtnClick[i] == BUTTON_NORMAL then
							tSelectBtnClick[i] = BUTTON_SELECT
							winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
						end
					end
				end
			end
		end
	end
end



-- �ڽ� ���ð��� ���þ��ؼ� ���������� ���õɶ� ȣ��
function ClickedSelectRewardBtn_toC(boxIndex)

	if g_currentSelectBoxCount < g_enableSelectBoxCount then
		g_currentSelectBoxCount = g_currentSelectBoxCount + 1
		
		if tSelectBtnClick[boxIndex] == BUTTON_NORMAL then
			tSelectBtnClick[boxIndex] = BUTTON_CLICK
			tSelectBtnTime[boxIndex] = 0
		
			SetCurrentEnableCount(g_currentSelectBoxCount)
			
			if g_currentSelectBoxCount == g_enableSelectBoxCount then
				for i=1, 8 do
					if tSelectBtnClick[i] == BUTTON_NORMAL then
						tSelectBtnClick[i] = BUTTON_SELECT
						winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
					end
				end
			end
		end
	end
end



local tImageSequence = {["err"]=0, [0]=273, 380, 487, 594, 701, 808, 915}
local g_SelectBoxUIPosY = -200
function WndQuestResult_FadeOutOldInfo(deltaTime, remainTime, todayStage, enableCount)
		
	if g_characterInfoWindowsPosY <= 1200 then
		g_characterInfoWindowsPosY = g_characterInfoWindowsPosY + deltaTime
	end
	
	-- 2��° �ڽ����� ���϶�
	if g_backImagePosX >= -2000 then
		g_backImagePosX = g_backImagePosX - (deltaTime*3)
		
		-- ��ʸ�Ʈ �����̵� �������� �ʹ� 1���� ����
		if g_onceSet == false then
			g_onceSet = true
			
			-- 1���� ������ �ȵɰ�� ��� 
			if enableCount <= 0 then
				for i=1, 8 do
					tSelectBtnClick[i] = BUTTON_SELECT
					winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
					winMgr:getWindow("sj_TA_SelectBox_"..i):setVisible(true)
				end
			else
				
				for i=1, 8 do
					tSelectBtnClick[i] = BUTTON_NORMAL
					winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
					winMgr:getWindow("sj_TA_SelectBox_"..i):setVisible(true)
				end
			end
			
			g_enableSelectBoxCount = enableCount
		end
	end
	
	-- ��ʸ�Ʈ �����̵� �ڽ� �ִϸ��̼�
	for i=1, 8 do
		if tSelectBtnClick[i] == BUTTON_CLICK then
			tSelectBtnTime[i] = tSelectBtnTime[i] + deltaTime
			local imageIndex = tSelectBtnTime[i] / 30
			if imageIndex <= #tImageSequence then
				winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Enabled", "UIData/Tournament001.tga", 0, tImageSequence[imageIndex])
				winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 0, tImageSequence[imageIndex])
			else
				tSelectBtnClick[i] = BUTTON_SELECT
				tSelectBtnTime[i] = 0
			end			
		end
	end
	
	WndQuestResult_AddMyExpAndPoint(deltaTime, g_gainExp, g_gainPoint, 1)
	WndQuestResult_ShowIncreaseExpEffect(deltaTime, g_bSuccess, g_leftPercent, g_rightPercent)
	
	-- ���ο� ������ ��Ÿ����.	
	if g_SelectBoxUIPosY <= 60 then
		g_SelectBoxUIPosY = g_SelectBoxUIPosY + deltaTime
	end
	
	-- �����ð�
	if remainTime > 0 then
		DrawEachNumberWide("UIData/DungeonResult.tga", remainTime-1, 8, 850, 44, 385, 605, 126, 153, 126, WIDETYPE_6)
	end
	
	-- ��������
	drawer:drawTexture("UIData/Tournament001.tga", 512-200, g_SelectBoxUIPosY+5, 256, 55, 768, 655, WIDETYPE_6)
	DrawEachNumberWide("UIData/Tournament001.tga", todayStage, 1, 512+100, g_SelectBoxUIPosY, 484, 594, 54, 61, 54, WIDETYPE_6)
	
	-- ���� ������ �ڽ� ����
	drawer:drawTexture("UIData/Tournament001.tga", 318, 250, 388, 45, 636, 749, WIDETYPE_6)
	DrawEachNumberWide("UIData/numberUi001.tga", g_enableSelectBoxCount, 8, 480, 300, 134, 140, 89, 85, 89, WIDETYPE_6)
end


-- ����޴� ����
function WndQuestResult_RewardInfo(deltaTime, positionIndex, rewardType, rewardCount, rewardFileName, rewardItemName)

	if 1 > positionIndex and positionIndex > #tSelectBtnPosY then
		return
	end
	
	if tSelectBtnClick[positionIndex] ~= BUTTON_SELECT then
		return
	end
	
	
	local posY = tSelectBtnPosY[positionIndex]
	local alpha = 255
		
	if rewardCount > 0 then
		
		if rewardFileName ~= "" then
			-- ������ �̹���
			if rewardType == 1 then
				-- ����
				drawer:drawTextureSA(rewardFileName, tSelectBtnPosX[positionIndex]+76, posY+8, 98, 91, 490, 842, 160, 160, 255, 0, 0, WIDETYPE_6)
			else		
				drawer:drawTextureSA(rewardFileName, tSelectBtnPosX[positionIndex]+76, posY+12, 128, 128, 0, 0, 140, 140, alpha, 0, 0, WIDETYPE_6)
			end
		end
	        
		-- ������ ����
		drawer:setTextColor(255,255,255,255)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		drawer:drawText("x "..rewardCount, tSelectBtnPosX[positionIndex]+146, posY+32, WIDETYPE_6)
	
		-- ������ �̸�
		if rewardItemName ~= "" then
			drawer:setTextColor(97,230,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, rewardItemName)
			drawer:drawText(rewardItemName, tSelectBtnPosX[positionIndex]+108-size/2, posY+77, WIDETYPE_6)
		end
	else
		if rewardFileName ~= "" then
			drawer:drawTextureSA("UIData/quest1.tga", tSelectBtnPosX[positionIndex]+4, posY+5, 235, 97, 729, 535, 222, 252, alpha, 0, 0, WIDETYPE_6)	-- ������ �� á�ٴ� �̹���
		end
	end	
end
