--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


local GAMEMODE_DEATHMATCH = 0
local GAMEMODE_MONSTER_RACING = 6
local GAMEMODE_FIELD = 7
local GAMEMODE_DUALMATCH = 8
local GAMEMODE_SINGLEMATCH = 9


local String_Lucky_1 = PreCreateString_2341	--GetSStringInfo(LAN_LUCKY_FIGHTER_SUCCESS)			-- ��Ű ������ ����! 
local String_Lucky_2 = PreCreateString_2343	--GetSStringInfo(LAN_LUCKY_FIGHTER_ATTAINMENT)			-- %d��° ��Ű �����Ͱ� �Ǽ̽��ϴ� 
local String_Lucky_3 = PreCreateString_2340	--GetSStringInfo(LAN_LUCKY_FIGHTER_REWARD)				-- "%s"�� ���޵˴ϴ� 
local String_Lucky_4 = PreCreateString_2342	--GetSStringInfo(LAN_LUCKY_FIGHTER_FAIL)				-- ��Ű ������ ����! 
local String_Lucky_5 = PreCreateString_2344	--GetSStringInfo(LAN_LUCKY_FIGHTER_COUNT_NOTIFY)		-- ����� ��Ű ī��Ʈ�� %d �Դϴ� 
local String_Lucky_6 = PreCreateString_2345	--GetSStringInfo(LAN_LUCKY_FIGHTER_CHALLENGE_AGAIN)	-- �ٽ� ������ ������!

local tMyRankPos	= { ["protectErr"]=0, 1100, 460, 2000 }
local tMyRankDescX	= { ["protectErr"]=0, 0, 193, 386, 579, 0, 193, 386, 579 }
local tMyRankDescY	= { ["protectErr"]=0, 157, 157, 157, 157, 274, 274, 274, 274 }

-- �ε��� 0�� ��ȭ��ġ, 1�� �߰���ġ, 2�� ������ġ

-- ���� ���
local tRedWins		= { ["err"]=0, [0]=-690, 180, 1920 }
local tBlueWins		= { ["err"]=0, [0]=-783, 140, 1920 }
local tDrawGame		= { ["err"]=0, [0]=-870,  90, 1920 }
local tYouWin		= { ["err"]=0, [0]=-594, 230, 1920 }
local tYouLose		= { ["err"]=0, [0]=-835, 150, 1920 }
local tYouWin_R		= { ["err"]=0, [0]=-582, 220, 1920 }
local tYouLose_R	= { ["err"]=0, [0]=-730, 160, 1920 }
local tYouWin_B		= { ["err"]=0, [0]=-582, 220, 1920 }
local tYouLose_B	= { ["err"]=0, [0]=-730, 160, 1920 }
local tResultTemp	= { ["err"]=0, [0]=0, 0, 0 }

-- ��� �̼�
local tMission			= { ["err"]=0, [0]=-1000, 20, -1000 }
local tMission_Result	= { ["err"]=0, [0]=1030, 0, -1000 }
local g_missionEffect	= 0
local g_koRateTime = 0

-- �Ʒ��� ���¹�
local tStateBarX	= { ["err"]=0, [0]=66}
local tStateBarY	= { ["err"]=0, [0]=768+85, 620, 768+85+500 }

local tLevelupY	= { ["err"]=0, [0]=600, 150 }
local g_levelupEffect_Star	= 0
local g_levelupAlpha		= 350
local g_incEffect = 0
local g_resultSound = true


-- �����̵� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_stampArcadeTicket")
mywindow:setWideType(6);
mywindow:setPosition(734, 404)
mywindow:setSize(256, 256)
mywindow:setVisible(false)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:addController("arcadeTicketController", "ArcadeTicketEffect", "xscale", "Elastic_EaseOut", 1, 300, 9, true, true, 10)
mywindow:addController("arcadeTicketController", "ArcadeTicketEffect", "yscale", "Elastic_EaseOut", 1, 300, 9, true, true, 10)
mywindow:setAlign(8)
root:addChildWindow(mywindow)
local bArcadeTicketEffectOnce = true
local g_ArcadeTicketSound = true
local g_ArcadeTicketSoundTime = 0


-- ���� ������ ������ ����������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_stampRewardItem")
mywindow:setWideType(6);
mywindow:setPosition(734, 224)
mywindow:setSize(256, 256)
mywindow:setVisible(false)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:addController("RewardItemController", "RewardItemEffect", "xscale", "Elastic_EaseOut", 1, 300, 9, true, true, 10)
mywindow:addController("RewardItemController", "RewardItemEffect", "yscale", "Elastic_EaseOut", 1, 300, 9, true, true, 10)
mywindow:setAlign(8)
root:addChildWindow(mywindow)
local bRewardItemEffectOnce = true
local g_RewardItemSound = true
local g_RewardItemSoundTime = 0


-- 
local TexXTable = {['err']=0, [0]=0, 517}
local AlphaTable = {['err']=0, [0]=255,0,0,255, 0,255,255,0}
for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_luckyCountTextBack"..i)
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
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_luckyCountItemBack"..i)
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


local g_newMRRecord = false
local g_newMRRecordEffect = 0
local g_newMRRank = 0
local g_newMRMin = 0
local g_newMRSec = 0
local g_newMRMilliSec = 0
local g_newMRKillCount = 0
local g_tnewMRTime = { ["err"]=0, [0]=822, 838, 854, 870, 886, 902, 918, 934, 950, 966 }
function SetNewMRRecord(rank, min, sec, milliSec, killCount)
	g_newMRRecord = true
	g_newMRRank = rank
	g_newMRMin = min
	g_newMRSec = sec
	g_newMRMilliSec = milliSec
	g_newMRKillCount = killCount
end


--------------------------------------------------------------------

-- ó�� 4�ʰ��� Ŭ����� �� �ɸ��͸� �����ش�

--------------------------------------------------------------------
local PLAYMODE = 0
function WndGameResult_RenderResult(deltaTime, drawState, bTeam, myTeam, myResult,
			missionSuccess, mission0_result, mission1_result, mission0_desc, mission1_desc,
			myName, myStyle, myPoint, myCash,
			totalPoint, gainedExp, addGainedExp, addGainedPoint,				-- ���� ����Ʈ, ���� ����ġ, ���� +����ġ
			myLevel, currentExp, levelTable, increaseExp, 						-- ���� ����, ���� ����ġ, ����ġ ���̺�, ���� ����ġ
			leftPercent, rightPercent, bMyLevelup, ladder,						-- ���� ����ġ �ۼ�Ʈ, ��������ġ �ۼ�Ʈ, ���� ������ ����, �������
			_oldPreDPoint, _oldAfterDPoint1, _oldAfterDPoint2,					-- ���� KO�� �Ҽ��� �� 2�ڸ�, ���� KO�� �Ҽ��� �� 2�ڸ�
			_curPreDPoint, _curAfterDPoint1, _curAfterDPoint2, _bIncrease,		-- ���� KO�� �Ҽ��� �� 2�ڸ�, ���� KO�� �Ҽ��� �� 2�ڸ�, KO�� �����ߴ���
			currentUserNum, bPerfectGame, playMode,	myKill, missionExp,			-- ����������, ����Ʈ ��������, �÷��̸��, ���� ų��, �̼��߰�����ġ
			missionZen, myRank, promotion, attribute)							-- �̼��߰�ZEN, ���Ƿ�ŷ, ����, ĳ���� �Ӽ�

	bTeam = 1
	----------------------------------------------------
		
	-- ���� ��� �׸���
	
	----------------------------------------------------
	if bTeam == 1 then
		if		myTeam == 0 and myResult == 0 then	for i=0, 2 do tResultTemp[i] = tYouWin_R[i]	 end	-- ���� ����� �̱�
		elseif	myTeam == 0 and myResult == 1 then	for i=0, 2 do tResultTemp[i] = tYouLose_R[i] end	-- ���� ����� ��
		elseif	myTeam == 0 and myResult == 2 then	for i=0, 2 do tResultTemp[i] = tDrawGame[i]  end	-- ���� ����� ���
		elseif	myTeam == 1 and myResult == 0 then	for i=0, 2 do tResultTemp[i] = tYouWin_B[i]  end	-- ���� ���� �̱�
		elseif	myTeam == 1 and myResult == 1 then	for i=0, 2 do tResultTemp[i] = tYouLose_B[i] end	-- ���� ���� ��
		elseif	myTeam == 1 and myResult == 2 then	for i=0, 2 do tResultTemp[i] = tDrawGame[i]  end	-- ���� ���� ���
		end
	else
		if		myResult == 0 then	for i=0, 2 do tResultTemp[i] = tYouWin[i] end		-- ���� ��
		elseif	myResult == 1 then	for i=0, 2 do tResultTemp[i] = tYouLose[i] end		-- ���� ����
		elseif	myResult == 2 then	for i=0, 2 do tResultTemp[i] = tDrawGame[i] end		-- ���� ���
		end	
	end

	tResultTemp[0] = tResultTemp[0] + (deltaTime*3)
	if drawState == 0 then	
		if tResultTemp[0] >= tResultTemp[1] then
			tResultTemp[0] = tResultTemp[1]
		end
	else
		if bPerfectGame == 1 then
			tResultTemp[0] = 1100
		else		
			if tResultTemp[0] >= tResultTemp[1] then
				tResultTemp[0] = tResultTemp[1]
			end
		end
	end
	
	
	-- ���� ���(0�̸� ������ ��, 1�̸� ����� ��, 2�̸� ���º�)
	if bTeam == 1 then
	
		-- WIN
		if myResult == 0 then
		
			if g_resultSound then
				g_resultSound = false
				PlaySound('sound/System/System_Win.wav')
			end
		
			-- ���� �������϶�(������ �¸�)
			if myTeam == 0 then
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 588, 105, 0, 670, WIDETYPE_6)
			
			-- ���� ������϶�(����� �¸�)
			else
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 588, 105, 0, 557, WIDETYPE_6)				
			end
		
		-- LOSE
		elseif myResult == 1 then
		
			if g_resultSound then
				g_resultSound = false
				PlaySound('sound/System/System_Lose.wav')
			end
			
			-- ���� �������϶�(������ �й�)
			if myTeam == 0 then
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 329, 107, 0, 670, WIDETYPE_6)
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0]+320, 18, 404, 107, 600, 670, WIDETYPE_6)
				
			-- ���� ������϶�(����� �й�)
			else
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 329, 107, 0, 557, WIDETYPE_6)
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0]+320, 18, 404, 107, 600, 557, WIDETYPE_6)				
			end
		
		-- DRAW
		elseif myResult == 2 then
		
			drawer:drawTexture("UIData/ResultNewImage_1.tga", tResultTemp[0], 18, 860, 107, 0, 526, WIDETYPE_6)		
		
		end
		
	-- ������ ���(0�̸� Win, 1�̸� Lose, 2�̸� ���º�)
	else
		if myResult == 0 then
			if g_resultSound then
				g_resultSound = false
				PlaySound('sound/System/System_Win.wav')
			end
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 588, 105, 0, 670, WIDETYPE_6)
			
		elseif myResult == 1 then
			if g_resultSound then
				g_resultSound = false
				PlaySound('sound/System/System_Lose.wav')
			end
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 329, 107, 0, 557, WIDETYPE_6)
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0]+320, 18, 404, 107, 600, 557, WIDETYPE_6)
			
		elseif myResult == 2 then
			drawer:drawTexture("UIData/ResultNewImage_1.tga", tResultTemp[0], 18, 860, 107, 0, 526, WIDETYPE_6)
		end
	end
	
	
	if bTeam == 1 then	
		if		myTeam == 0 and myResult == 0 then	for i=0, 2 do tYouWin_R[i]	= tResultTemp[i] end	-- ���� ����� �̱�
		elseif	myTeam == 0 and myResult == 1 then	for i=0, 2 do tYouLose_R[i]	= tResultTemp[i] end	-- ���� ����� ��
		elseif	myTeam == 0 and myResult == 2 then	for i=0, 2 do tDrawGame[i]	= tResultTemp[i] end	-- ���� ����� ���
		elseif	myTeam == 1 and myResult == 0 then	for i=0, 2 do tYouWin_B[i]	= tResultTemp[i] end	-- ���� ���� �̱�
		elseif	myTeam == 1 and myResult == 1 then	for i=0, 2 do tYouLose_B[i]	= tResultTemp[i] end	-- ���� ���� ��
		elseif	myTeam == 1 and myResult == 2 then	for i=0, 2 do tDrawGame[i]	= tResultTemp[i] end	-- ���� ���� ���
		end
	else
		if		myResult == 0 then	for i=0, 2 do tYouWin[i]   = tResultTemp[i] end
		elseif	myResult == 1 then	for i=0, 2 do tYouLose[i]  = tResultTemp[i] end
		elseif	myResult == 2 then	for i=0, 2 do tDrawGame[i] = tResultTemp[i] end
		end
	end
	
	
	----------------------------------------------------
	
	-- ���� ���� �׸���
	
	----------------------------------------------------
	if drawState == 0 then
		tStateBarY[0] = tStateBarY[0] - deltaTime/2
		if tStateBarY[0] <= tStateBarY[1] then
			tStateBarY[0] = tStateBarY[1]
		end	
	else
		tStateBarY[0] = tStateBarY[0] + deltaTime/2
		if tStateBarY[0] > tStateBarY[2] then
			tStateBarY[0] = tStateBarY[2]
		end
	end
	
	
	-- �Ʒ��� ���¹�
	drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0], tStateBarY[0], 892, 121, 4, 896, WIDETYPE_6)
	
	-- ���¹� ��� ��
	drawer:drawTexture("UIData/ResultNewImage_1.tga", tStateBarX[0]+350, tStateBarY[0]+36, 266, 1, 0, 282, WIDETYPE_6)
		
	-- ����
	drawer:setTextColor(255,205,86,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText("Lv." .. myLevel, tStateBarX[0]+92, tStateBarY[0]+19, WIDETYPE_6)
	
	-- ����
	drawer:drawTexture("UIData/numberUi001.tga", tStateBarX[0]+243, tStateBarY[0]+44, 47, 21, 113, 600+21*ladder, WIDETYPE_6)
			
	-- �̸�
	drawer:setTextColor(97,230,255,255)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(myName))
	drawer:drawText(myName, (tStateBarX[0]+106)-nameSize/2, tStateBarY[0]+50, WIDETYPE_6)
		
	-- ��Ÿ��
	drawer:drawTexture("UIData/Skill_up2.tga", (tStateBarX[0]+235), tStateBarY[0]+3,  89, 35,  tAttributeImgTexXTable[myStyle][attribute], tAttributeImgTexYTable[myStyle][attribute], WIDETYPE_6)
	drawer:drawTexture("UIData/Skill_up2.tga", (tStateBarX[0]+235), tStateBarY[0]+3,  89, 35,  promotionImgTexXTable[myStyle], promotionImgTexYTable[promotion], WIDETYPE_6)	
	
	-- ���� ����Ʈ
	local szMyPoint = CommatoMoneyStr(myPoint)
	local r,g,b = GetGranColor(tonumber(myPoint))
	drawer:setTextColor(r,g,b,255)
	local pointSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, szMyPoint)
	--drawer:drawText(szMyPoint, tStateBarX[0]+122-pointSize/2, tStateBarY[0]+46)
	
	
	-- ���� ĳ��
	local szMyCash = CommatoMoneyStr(myCash)
	r,g,b = GetGranColor(tonumber(myCash))
	drawer:setTextColor(r,g,b,255)
	local cashSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, szMyCash)
	--drawer:drawText(szMyCash, tStateBarX[0]+280-cashSize/2, tStateBarY[0]+46)
	

	-- ���� ����ġ ����
	drawer:setTextColor(255,198,0,255)
	local percent_a = 0
	if levelTable > 0 then
		percent_a = increaseExp*100/levelTable
	end
	drawer:drawText(percent_a .. " %", tStateBarX[0]+837, tStateBarY[0]+89, WIDETYPE_6)


	-- ����ġ ������
	drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+59, tStateBarY[0]+79, rightPercent, 33, 62, 818, WIDETYPE_6)
	
	
	-- �����ϴ� ����ġ ��ġ 3����
	g_incEffect = g_incEffect + deltaTime
	g_incEffect = g_incEffect % 150
	if g_incEffect > 75 then
		drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+59+leftPercent, tStateBarY[0]+79, rightPercent-leftPercent, 33, 62+leftPercent, 851, WIDETYPE_6)
	end
	
	
	-- ����ġ ���±���
	drawer:setTextColor(255,255,255,255)
	local currentExpText = increaseExp .. " / " ..  levelTable
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, (tStateBarX[0]+454)-currentExpSize/2, tStateBarY[0]+89, WIDETYPE_6)
	
	
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	
	local _left, _right
	local _left1, _right1
	
	if PLAYMODE == GAMEMODE_DEATHMATCH then
		if IsKoreanLanguage() == false then
		
			-- KO�� ���� �̹���
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+628, tStateBarY[0]+8, 251, 59, 773, 231, WIDETYPE_6)
		
			-- ���� KO��
			local OLDX = 660
			if _oldPreDPoint == 100 then
				OLDX = 666
			end
			_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _oldPreDPoint, 2, tStateBarX[0]+OLDX, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/numberUi001.tga", tStateBarX[0]+OLDX+16, tStateBarY[0]+43, 9, 18, 869, 109, WIDETYPE_6)	-- .
			_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _oldAfterDPoint1, 1, tStateBarX[0]+OLDX+26, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
			_left1, _right1 = DrawEachNumberWide("UIData/numberUi001.tga", _oldAfterDPoint2, 1, _right+14, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/numberUi001.tga", _right1+16, tStateBarY[0]+43, 21, 19, 879, 108, WIDETYPE_6)	-- %
			
			
			-- ���� KO��	
			local CURX = 790
			if _curPreDPoint == 100 then
				CURX = 794
			end
			if _bIncrease == 1 then
				g_koRateTime = g_koRateTime + deltaTime
				g_koRateTime = g_koRateTime % 400
				if g_koRateTime < 200 then
					_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _curPreDPoint, 2, tStateBarX[0]+CURX, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
					drawer:drawTexture("UIData/numberUi001.tga", tStateBarX[0]+CURX+16, tStateBarY[0]+43, 9, 18, 869, 109, WIDETYPE_6)	-- .
					_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _curAfterDPoint1, 1, tStateBarX[0]+CURX+26, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
					_left1, _right1 = DrawEachNumberWide("UIData/numberUi001.tga", _curAfterDPoint2, 1, _right+14, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
					drawer:drawTexture("UIData/numberUi001.tga", _right1+16, tStateBarY[0]+43, 21, 19, 879, 108, WIDETYPE_6)	-- %
				end
			else
				_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _curPreDPoint, 2, tStateBarX[0]+CURX, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
				drawer:drawTexture("UIData/numberUi001.tga", tStateBarX[0]+CURX+16, tStateBarY[0]+43, 9, 18, 869, 109, WIDETYPE_6)	-- .
				_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _curAfterDPoint1, 1, tStateBarX[0]+CURX+26, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
				_left1, _right1 = DrawEachNumberWide("UIData/numberUi001.tga", _curAfterDPoint2, 1, _right+14, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
				drawer:drawTexture("UIData/numberUi001.tga", _right1+16, tStateBarY[0]+43, 21, 19, 879, 108, WIDETYPE_6)	-- %
			end
		end
	end
	
	
	
	-- ����ġ(���ʽ�), �׶�(���ʽ�) ����
	drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+342, tStateBarY[0]+4, 111, 28, 800, 191, WIDETYPE_6)	-- ����ġ(���ʽ�)
	drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+346, tStateBarY[0]+38, 96, 28, 928, 191, WIDETYPE_6)	-- �׶�(���ʽ�)
	
	
	-- ����ġ(���ʽ�) ����
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", gainedExp, 2, tStateBarX[0]+510, tStateBarY[0]+7, 286, 751, 16, 26, 27, WIDETYPE_6)	-- ����ġ
	drawer:drawTexture("UIData/dungeonmsg.tga", _right+16, tStateBarY[0]+8, 13, 25, 240, 673, WIDETYPE_6)	-- (
--	drawer:drawTexture("UIData/dungeonmsg.tga", _right+24, tStateBarY[0]+9, 20, 25, 553, 673)	-- +
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", addGainedExp, 1, tStateBarX[0]+538, tStateBarY[0]+7, 286, 672, 16, 26, 27, WIDETYPE_6)	-- +����ġ
	drawer:drawTexture("UIData/dungeonmsg.tga", _right+16, tStateBarY[0]+8, 13, 25, 262, 673, WIDETYPE_6)	-- )
	
	-- �׶�(���ʽ�) ����
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", totalPoint, 2, tStateBarX[0]+510, tStateBarY[0]+40, 286, 751, 16, 26, 27, WIDETYPE_6)	-- ����Ʈ
	if tonumber(totalPoint) < 0 then	-- -�ϰ�� �̹����� �ٿ��ش�.
		drawer:drawTexture("UIData/dungeonmsg.tga", _left-16, tStateBarY[0]+41, 16, 25, 605, 752, WIDETYPE_6)	-- -
	end
	drawer:drawTexture("UIData/dungeonmsg.tga", _right+16, tStateBarY[0]+41, 13, 25, 240, 673, WIDETYPE_6)	-- (
--	drawer:drawTexture("UIData/dungeonmsg.tga", _right+24, tStateBarY[0]+41, 20, 25, 553, 673)	-- +
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", addGainedPoint, 1, tStateBarX[0]+538, tStateBarY[0]+40, 286, 672, 16, 26, 27, WIDETYPE_6)	-- +����Ʈ
	drawer:drawTexture("UIData/dungeonmsg.tga", _right+16, tStateBarY[0]+41, 13, 25, 262, 673, WIDETYPE_6)	-- )
	
	
	-- ������ ����
	if bMyLevelup == 1 then
		tLevelupY[0] = tLevelupY[0] - 3
		if tLevelupY[0] <= tLevelupY[1] then
			tLevelupY[0] = tLevelupY[1]
			g_levelupAlpha = 0
		else
			g_levelupAlpha = g_levelupAlpha - 3
			if g_levelupAlpha > 255 then
				g_levelupAlpha = 255
			elseif g_levelupAlpha <= 0 then
				g_levelupAlpha = 0
			end
			
			g_levelupEffect_Star = g_levelupEffect_Star + deltaTime
			g_levelupEffect_Star = g_levelupEffect_Star % 100
						
			if g_levelupEffect_Star < 50 then
				-- ��
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 430, tLevelupY[0]-20, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 600, tLevelupY[0]-10, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 380, tLevelupY[0]+30, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 540, tLevelupY[0]+80, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
			end
			
			-- ������ ����
			drawer:drawTextureA("UIData/ResultNewImage_2.tga", 400, tLevelupY[0], 280, 85, 0, 0, g_levelupAlpha, WIDETYPE_6)
		end
	end	
end






----------------------------------------------------

-- ���� ���� â(����� 3�������� ������)

----------------------------------------------------
local MAX_BATTELREWARD_COUNT = 3
local tImageSequence = {["err"]=0, [0]=197, 304, 411, 518, 625, 732, 839}
local tRewardStartTime = {["err"]=0, }
local tRewardBoxTime = {["err"]=0, }

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_RewardboxParentWindow")
mywindow:setWideType(6)
mywindow:setPosition(10, 340)
mywindow:setSize(336, 197)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
root:addChildWindow(mywindow)

for i=0, MAX_BATTELREWARD_COUNT-1 do
	tRewardStartTime[i] = 0
	tRewardBoxTime[i] = 0
	
	-- �������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battelRewardBoxBack_"..i)
	mywindow:setPosition(0, 0)
	mywindow:setSize(336, 197)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setTexture("Enabled", "UIData/ResultNewImage_3.tga", 688, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setAlign(8)
	winMgr:getWindow("sj_RewardboxParentWindow"):addChildWindow(mywindow)

	-- ���� �ڽ�(�ִϸ��̼�)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battelRewardBox_"..i)
	mywindow:setTexture("Enabled", "UIData/ResultNewImage_3.tga", 810, 197)
	mywindow:setTexture("Disabled", "UIData/ResultNewImage_3.tga", 810, 197)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(63, 44)
	mywindow:setSize(215, 107)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RewardboxParentWindow"):addChildWindow(mywindow)

	-- ���� ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battelRewardItemImage_"..i)
	mywindow:setPosition(112, 45)
	mywindow:setSize(128, 128)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setAlign(8)
	mywindow:setUserString("count", 0)
	mywindow:setSubscribeEvent("EndRender", "EndRenderRewardCount")
	winMgr:getWindow("sj_RewardboxParentWindow"):addChildWindow(mywindow)

	-- ���� ���� �ؽ�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battelRewardItemText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setVisible(false)
	mywindow:setText("")
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 20)
	winMgr:getWindow("sj_battelRewardBox_"..i):addChildWindow(mywindow)
end

-- ���� �޴� ������ ���� �̹����� �����ֱ� ����
function EndRenderRewardCount(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() == true then
		local count  = tonumber(window:getUserString("count"))
		local parentWindow = window:getParent()
		local parentPos = parentWindow:getPosition()
		local position = window:getPosition()

		if count > 0 then
			local _left, _right = DrawEachNumberWide("UIData/match001.tga", count, 2, position.x.offset+144, position.y.offset+410, 822, 914, 16, 22, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/match001.tga", _left-15, position.y.offset+410, 16, 22, 804, 914, WIDETYPE_6)		-- +
		end
	end
end


function WndResult_ShowPvpRewardItem(deltaTime, drawState, maxRewardCount, i, rewardType, rewardCount, rewardFileName, rewardDesc)
	if drawState == 0 then
		if rewardFileName ~= "" then
		
			-- ��ġ ����(���η� �ִ� 3��)
			local LIMIT_X = 3
			local x = ((LIMIT_X-maxRewardCount) * 170) + (i*336)
			
			winMgr:getWindow("sj_battelRewardBoxBack_"..i):setVisible(true)
			winMgr:getWindow("sj_battelRewardBoxBack_"..i):setPosition(x, 0)
			if rewardType == 0 then
				winMgr:getWindow("sj_battelRewardBoxBack_"..i):setTexture("Enabled", "UIData/ResultNewImage_3.tga", 688, 0)
			elseif rewardType == 1 then
				winMgr:getWindow("sj_battelRewardBoxBack_"..i):setTexture("Enabled", "UIData/ResultNewImage_3.tga", 474, 827)
			else
				winMgr:getWindow("sj_battelRewardBoxBack_"..i):setTexture("Enabled", "UIData/ResultNewImage_3.tga", 688, 0)
			end
			
			winMgr:getWindow("sj_battelRewardBox_"..i):setVisible(true)
			winMgr:getWindow("sj_battelRewardBox_"..i):setPosition(x+63, 44)
			
			if tRewardStartTime[i] >= 0 then
				tRewardStartTime[i] = tRewardStartTime[i] + deltaTime
				if tRewardStartTime[i] >= 1500 then
					tRewardBoxTime[i] = tRewardBoxTime[i] + deltaTime
					local imageIndex = tRewardBoxTime[i] / 40
					if imageIndex <= #tImageSequence then
						winMgr:getWindow("sj_battelRewardBox_"..i):setTexture("Enabled", "UIData/ResultNewImage_3.tga", 810, tImageSequence[imageIndex])
						winMgr:getWindow("sj_battelRewardBox_"..i):setTexture("Disabled", "UIData/ResultNewImage_3.tga", 810, tImageSequence[imageIndex])
					else
						tRewardBoxTime[i] = 0
						tRewardStartTime[i] = -1

						winMgr:getWindow("sj_battelRewardItemImage_"..i):setVisible(true)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setTexture("Enabled", rewardFileName, 0, 0)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setPosition(x+113, 45)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setScaleWidth(200)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setScaleHeight(200)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setUserString("count", rewardCount)
						
						local textSize = GetStringSize(g_STRING_FONT_GULIM, 12, rewardItemDesc)
						winMgr:getWindow("sj_battelRewardItemText_"..i):setVisible(true)
						winMgr:getWindow("sj_battelRewardItemText_"..i):setPosition(45+textSize/2, 112)
						winMgr:getWindow("sj_battelRewardItemText_"..i):setText(rewardDesc)
					end
				end
			end
		end
	else
		winMgr:getWindow("sj_battelRewardBoxBack_"..i):setVisible(false)
		winMgr:getWindow("sj_battelRewardBox_"..i):setVisible(false)
		winMgr:getWindow("sj_battelRewardItemImage_"..i):setVisible(false)
		winMgr:getWindow("sj_battelRewardItemText_"..i):setVisible(false)
		winMgr:getWindow("sj_battelRewardItemText_"..i):setText("")
	end
end





-- EndRender
function WndGameResult_EndRender(bLuckyEvent, LuckyCount, LuckyRewardMoney, bEventOk,			-- ��Ű�̺�Ʈ �������п���, ��Űī��Ʈ, ��Ű�̺�Ʈ ����, ��Ű�̺�Ʈ ����������
								LuckyRewardItemName, LuckyRewardItemFileName)					-- ��Ű�̺�Ʈ���� �������̸�, ��Ű�̺�Ʈ���� �����������̸�
	-- ��Ű ī��Ʈ ǥ��	==================================
	if bEventOk == 1 then
		local posX = 72--32
		local posY = 392
		if bLuckyEvent == 1 then		-- ��Ű �̺�Ʈ�� ��÷�ƴ�
			if bLuckyCountEffectOnce then
				for i=0, 1 do
					winMgr:getWindow("sj_gameResult_luckyCountItemBack"..i):setPosition(posX, posY)
					winMgr:getWindow("sj_gameResult_luckyCountItemBack"..i):setVisible(true)
					winMgr:getWindow("sj_gameResult_luckyCountItemBack"..i):activeMotion("LuckyCountItemBackMotion")
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):setPosition(posX+68, posY)
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):setVisible(true)
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):activeMotion("LuckyCountTextBackMotion")
				end
				bLuckyCountEffectOnce = false
			end
			drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
			common_DrawOutlineText1(drawer, String_Lucky_1, posX+150, posY+14, 140,140,140,255, 97,230,240,255, WIDETYPE_6)
			local String = string.format(String_Lucky_2, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+90, posY+35, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			if LuckyRewardMoney > 0 then	-- �޴� �������� zen�̴�
				String = string.format(String_Lucky_3, CommatoMoneyStr(LuckyRewardMoney).." Zen")
				drawer:drawTextureSA("UIData/ItemUIData/item/Zen.tga", posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0, WIDETYPE_6)		
			else							-- �Ϲ� �������� �޴´�.
				String = string.format(String_Lucky_3, LuckyRewardItemName)
				drawer:drawTextureSA("UIData/ItemUIData/"..LuckyRewardItemFileName, posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0, WIDETYPE_6)		
			end		
			common_DrawOutlineText1(drawer, String, posX+90, posY+56, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
		else
			if bLuckyCountEffectOnce then
				for i=0, 1 do
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):setPosition(posX, posY)
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):setVisible(true)
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):activeMotion("LuckyCountTextBackMotion")
				end
				bLuckyCountEffectOnce = false
			end
			drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
			common_DrawOutlineText1(drawer, String_Lucky_4, posX+82, posY+14, 140,140,140,255, 240,30,40,255, WIDETYPE_6)
			local String = string.format(String_Lucky_5, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+16, posY+35, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			common_DrawOutlineText1(drawer, String_Lucky_6, posX+16, posY+55, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
		end
	end
	--==================================================
end


function WndGameResult_MyExtremePoint(drawState, extremeZen)

end





g_bInit	= false
tRankInfo = { ["protectErr"]=0 , 
				index		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				rank		= { ["protectErr"]=0, 1, 2, 3, 4, 5, 6, 7, 8 },
				enemyType	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				level		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				name		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				ko			= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				down		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				exp			= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				addExp		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				point		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				addPoint	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				levelUp		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				mission		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				disconnected= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				wherePCRoom	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				event		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				costume		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				ladder		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				buff_EXP	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				buff_ZEN	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				icafe		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				extreme_ZEN	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 }
			}


--------------------------------------------------------------------

-- ���� ����� �ʱ�ȭ�Ѵ�.(��ũ�� �°� ����)

--------------------------------------------------------------------
function WndGameResult_InitResultInfo(slot, enemyType, rank, level, name,
						ko, down, exp, addExp, point, addPoint, bLevelUp, bMission, disconnected, bWherePCRoom, bEvent, bCostume, ladder,
						buff_EXP, buff_ZEN, icafe, extreme_ZEN, gameMode)

	slot = slot + 1
	tRankInfo.index[slot]			= slot
	tRankInfo.rank[slot]			= rank
	tRankInfo.enemyType[slot]		= enemyType
	tRankInfo.level[slot]			= level
	tRankInfo.name[slot]			= name
	tRankInfo.ko[slot]				= ko
	tRankInfo.down[slot]			= down
	tRankInfo.exp[slot]				= exp
	tRankInfo.addExp[slot]			= addExp
	tRankInfo.point[slot]			= point
	tRankInfo.addPoint[slot]		= addPoint
	tRankInfo.levelUp[slot]			= bLevelUp
	tRankInfo.mission[slot]			= bMission
	tRankInfo.disconnected[slot]	= disconnected
	tRankInfo.wherePCRoom[slot]		= bWherePCRoom
	tRankInfo.event[slot]			= bEvent
	tRankInfo.costume[slot]			= bCostume
	tRankInfo.ladder[slot]			= ladder
	tRankInfo.buff_EXP[slot]		= buff_EXP
	tRankInfo.buff_ZEN[slot]		= buff_ZEN
	tRankInfo.icafe[slot]			= icafe
	tRankInfo.extreme_ZEN[slot]		= extreme_ZEN
	g_bInit	= true
end






-- mvp ����ȿ���� ����...
local MVP_IMAGE_POSX = 680
local MVP_IMAGE_POSY = 130
local g_mvpSoundEffect = true
local g_mvpStampEffect = true
local g_mvpEffectTime  = 0
local g_mvpTextAlpha   = 0
local g_mvpTextTime	   = 0
mvpwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGameResult_mvpImage")
mvpwindow:setWideType(6)
mvpwindow:setPosition(MVP_IMAGE_POSX, MVP_IMAGE_POSY)
mvpwindow:setSize(323, 155)
mvpwindow:setVisible(false)
mvpwindow:setTexture("Enabled", "UIData/ResultNewImage_2.tga", 324, 0)
mvpwindow:setProperty("BackgroundEnabled", "False")
mvpwindow:setProperty("FrameEnabled", "False")
root:addChildWindow(mvpwindow)


winMgr:getWindow("sj_wndGameResult_mvpImage"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
winMgr:getWindow("sj_wndGameResult_mvpImage"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
winMgr:getWindow("sj_wndGameResult_mvpImage"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
winMgr:getWindow("sj_wndGameResult_mvpImage"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
winMgr:getWindow("sj_wndGameResult_mvpImage"):setAlign(8)


g_effect		= false
descPosX		= 1030
MvpEffectTime	= 0
tLevelUpEffectTime	= { ["protectErr"]=0, 0, 0, 0, 0, 0, 0, 0, 0 }
tRankPosX			= { ["protectErr"]=0, 1230, 1430, 1630, 1830, 2030, 2230, 2430, 2630 }
tRankPosY			= { ["protectErr"]=0, 520, 550, 580, 610, 640, 670, 700, 730 }
tGoodDesc			= { ["protectErr"]=0, -850, 100 }
tBadDesc			= { ["protectErr"]=0, -750, 150 }
tMyRank				= { ["protectErr"]=0, -400, 50 }
tbuffExpTime		= { ["protectErr"]=0, 0, 0, 0, 0, 0, 0, 0, 0 }
tbuffZenTime		= { ["protectErr"]=0, 0, 0, 0, 0, 0, 0, 0, 0 }
tRankPosY_dual		= { ["protectErr"]=0, 505, 533, 563, 592, 629, 659, 688, 716 }

-- mvp���� �����̴� �ð�
local MOVETIME		= 200
local g_mvpMoveTime = MOVETIME
local g_totalBonusCalc = true
local g_totalBonusExp = 0
local g_totalBonusGran = 0
local g_mvpTwinkle = false
local g_mvpShine = -1030
local g_mvpShineSound = true
local g_mvpAddBonusStart = false
local g_extremeTime = 0

-- ����Ʈ ����
local g_perfectCount = 0
local g_perfectTime = 0
local g_perfectSound = true

-- ����
local g_continueWinTime = 0

tTime = { ["err"]=0, [0]=515, 550, 586, 622, 657, 693, 729, 766, 801, 836 }
--------------------------------------------------------------------

-- 2��° ��������� �����ش�

--------------------------------------------------------------------
function WndGameResult_DrawResult(deltaTime, drawState, mySlot, bTeam, userNum, myResult, myRank, mvp, mvpExp, mvpPoint, redKill, blueKill, 
			mvpName, currentUserNum, extremeMode, bPerfectGame, continueWinTeam, oldContinueWin, continueWin, continueWinReward, 
			redTeamSceneNumber, blueTeamSceneNumber, min, sec, milliSec, winTeam)

	if g_bInit == false then
		return
	end
	
	if drawState == 0 then
		return
	end
	
	bTeam = 1
	-- �����̵� �̿�� �Ⱥ��̰� �ϱ�
	winMgr:getWindow("sj_gameResult_stampArcadeTicket"):setVisible(false)
	
	-- ��� ������ �Ⱥ��̰� �ϱ�
	winMgr:getWindow("sj_gameResult_stampRewardItem"):setVisible(false)

	-- ���� ���ǥ��
	if bTeam == 1 then
		DrawEachNumberWide("UIData/numberUi001.tga", redKill, 2, 400, 180, 274, 521, 74, 66, 75, WIDETYPE_6)	-- ������ ų��
		drawer:drawTexture("UIData/GameNewImage.tga", 494, 192, 19, 46, 561, 512, WIDETYPE_6)				-- :
		DrawEachNumberWide("UIData/numberUi001.tga", blueKill, 1, 528, 180, 274, 455, 74, 66, 75, WIDETYPE_6)	-- ����� ų��
	end
	
	
	-- ���� ��ŷ �̹���
	if myRank > 0 then
		tMyRank[1] = tMyRank[1] + (deltaTime)
		if tMyRank[1] >= tMyRank[2] then
			tMyRank[1] = tMyRank[2]
			g_effect = true
		end
	end

	
	-- ���â ����
	local descPosY = 478
	local lastDescPosX = 80	
	descPosX = descPosX - (deltaTime*3)
	if descPosX <= lastDescPosX then
		descPosX = lastDescPosX
	end

	drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY-14, 1024, 295, 0, 729, WIDETYPE_6)
	
	if winTeam == 0 then
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+22, 1024, 124, 0, 481, WIDETYPE_6)
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+146, 1024, 124, 0, 605, WIDETYPE_6)
	else
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+22, 1024, 124, 0, 605, WIDETYPE_6)
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+146, 1024, 124, 0, 481, WIDETYPE_6)
	end


	-- �÷��̾��� ���â
	userNum = 8 -- ����ġ�� ���
	local lastPosX = 82
	for i=1, userNum do
		lastPosX = 104
		if tRankInfo.index[i] >= 0 then
			tRankPosX[i] = tRankPosX[i] - (deltaTime*2)
			if tRankPosX[i] <= lastPosX then
				tRankPosX[i] = lastPosX
			end
			
			-------------------------
			-- �ɸ���(����, �̸�)
			-------------------------
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			drawer:setTextColor(255,255,255,255)
			local levelText
			if tRankInfo.level[i] < 10 then
				levelText = "Lv. "
			else
				levelText = "Lv."
			end
			-- ����
			if tRankInfo.index[i] == mySlot+1 then
				common_DrawOutlineText1(drawer, levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			else
				drawer:drawText(levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY_dual[i]+7, WIDETYPE_6)
			end
			
			-- ����
			drawer:drawTexture("UIData/numberUi001.tga", tRankPosX[i]+98, tRankPosY_dual[i]-1, 47, 21, 113, 600+21*tRankInfo.ladder[i], WIDETYPE_6)
				
			-- �̸�
			local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.name[i]))
			if tRankInfo.index[i] == mySlot+1 then
				common_DrawOutlineText1(drawer, tRankInfo.name[i], tRankPosX[i]+238-nameSize/2, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			else
				drawer:drawText(tRankInfo.name[i], tRankPosX[i]+238-nameSize/2, tRankPosY_dual[i]+7, WIDETYPE_6)
			end
			
			-------------------------
			-- KO/DOWN, disconnected
			-------------------------
			-- KO(������ ����)
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.ko[i]))
			if tRankInfo.index[i] == mySlot+1 then
				common_DrawOutlineText1(drawer, tRankInfo.ko[i], tRankPosX[i]+356-size, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			else
				drawer:drawText(tRankInfo.ko[i], tRankPosX[i]+356-size, tRankPosY_dual[i]+7, WIDETYPE_6)
			end
			
			-- disconnected
			if tRankInfo.disconnected[i] == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", tRankPosX[i]+202, tRankPosY_dual[i]+4, 74, 14, 2, 190, WIDETYPE_6)
			end
		
			-------------------------
			-- ����(����ġ, ZEN)
			-------------------------
			if tRankInfo.buff_EXP[i] > 0 then
				tbuffExpTime[i] = tbuffExpTime[i] + deltaTime
				tbuffExpTime[i] = tbuffExpTime[i] % 400
				if tbuffExpTime[i] > 200 then
					drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY_dual[i]+9, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY_dual[i]+12, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
				end
			end
			
			if tRankInfo.buff_ZEN[i] > 0 then
				tbuffZenTime[i] = tbuffZenTime[i] + deltaTime
				tbuffZenTime[i] = tbuffZenTime[i] % 400
				if tbuffZenTime[i] > 200 then
					drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+618, tRankPosY_dual[i]+9, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+618, tRankPosY_dual[i]+12, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
				end
			end	
		
			-------------------------
			-- ����ġ
			-------------------------
			local _curExp = tRankInfo.exp[i]
			local _curExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, _curExp)
			local _addExp = "("..tRankInfo.addExp[i]..")"
			
			-------------------------
			-- ����Ʈ
			-------------------------
			local _curGran = tRankInfo.point[i]
			local _curGranSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, _curGran)
			local _addGran = "("..tRankInfo.addPoint[i]..")"
			
			
			if tRankInfo.index[i] == mySlot+1 then
				-- ����ġ
				common_DrawOutlineText1(drawer, _curExp, tRankPosX[i]+446-_curExpSize, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				common_DrawOutlineText1(drawer, _addExp, tRankPosX[i]+448, tRankPosY_dual[i]+7, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
				
				-- �׶�
				common_DrawOutlineText1(drawer, _curGran, tRankPosX[i]+564-_curGranSize, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				common_DrawOutlineText1(drawer, _addGran, tRankPosX[i]+566, tRankPosY_dual[i]+7, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
			else
				drawer:drawText(tRankInfo.exp[i], tRankPosX[i]+446-_curExpSize, tRankPosY_dual[i]+7, WIDETYPE_6)	-- ����ġ
				drawer:drawText(_curGran, tRankPosX[i]+564-_curGranSize, tRankPosY_dual[i]+7, WIDETYPE_6)		-- �׶�
				
				drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
				drawer:setTextColor(0,255,0,255)
				drawer:drawText(_addExp, tRankPosX[i]+448, tRankPosY_dual[i]+7, WIDETYPE_6)	-- ���ʽ� ����ġ				
				drawer:drawText(_addGran, tRankPosX[i]+566, tRankPosY_dual[i]+7, WIDETYPE_6)	-- ���ʽ� �׶�
			end
			
			local BONUS_X = 550
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			drawer:setTextColor(255,255,255,255)
			-------------------------
			-- ���ʽ�(�̼�, ������, PC��, �̺�Ʈ)
			-------------------------
			drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+85, tRankPosY_dual[i], 55, 24, 165, 415, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+140, tRankPosY_dual[i], 55, 24, 55, 415, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+195, tRankPosY_dual[i], 55, 24, 110, 415, WIDETYPE_6)
		--	drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+250, tRankPosY_dual[i], 55, 24, 0, 415, WIDETYPE_6) -- PC��
		--	drawer:drawTextureSA("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+146, tRankPosY_dual[i], 64, 45, 793, 235, 128, 128, 255, 0, 0) -- icafe

			-- �̼�
			if tRankInfo.mission[i] == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+85, tRankPosY_dual[i], 55, 24, 165, 391, WIDETYPE_6)
			end
			
			-- ������
			if tRankInfo.costume[i] == 1 or tRankInfo.buff_EXP[i] > 0 or tRankInfo.buff_ZEN[i] > 0 then
				drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+140, tRankPosY_dual[i], 55, 24, 55, 391, WIDETYPE_6)
			end
			
			-- �̺�Ʈ
			if tRankInfo.event[i] == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+195, tRankPosY_dual[i], 55, 24, 110, 391, WIDETYPE_6)
			end
		
			-- PC��
			--if tRankInfo.wherePCRoom[i] == 1 then
			--	drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+250, tRankPosY_dual[i], 55, 24, 0, 391, WIDETYPE_6)
			--end
			
			-- icafe
			if tRankInfo.icafe[i] == 1 then
				drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+260, tRankPosY_dual[i]+1, 64, 45, 729, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
				
			elseif tRankInfo.icafe[i] == 2 then
				drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+260, tRankPosY_dual[i]+1, 64, 45, 665, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
			end
			
			-------------------------------
			-- ���� �����ϱ� ���� �׵θ�
			-------------------------------
			if tRankInfo.index[i] == mySlot+1 then
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]-40, tRankPosY_dual[i]-4, 924, 32, 8, 515, WIDETYPE_6)
			end
		end
		
		if winTeam == 0 then
			-- win, lose
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+20, 152, 42, 234, 439, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+144, 152, 42, 385, 397, WIDETYPE_6)
		else
			-- win, lose
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+20, 152, 42, 234, 397, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+144, 152, 42, 385, 439, WIDETYPE_6)
		end
	end	
	
	-- ������
	for i=1, userNum do
		if tRankInfo.levelUp[i] == 1 then
			tLevelUpEffectTime[i] = tLevelUpEffectTime[i] + deltaTime
			tLevelUpEffectTime[i] = tLevelUpEffectTime[i] % 400
			
			if tLevelUpEffectTime[i] < 200 then
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+68, tRankPosY[i]-13, 40, 26, 975, 9, WIDETYPE_6)
			else
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+68, tRankPosY[i]-16, 40, 26, 975, 9, WIDETYPE_6)
			end
		end
	end
end









----------------------------------------------------

-- ä��

----------------------------------------------------
-- ä�� �������� ��
function WndGameResult_RootKeyDown(args)

	window = winMgr:getWindow("doChatting"):activate()
	
end
root:subscribeEvent("KeyDown", "WndGameResult_RootKeyDown")




-- ä�� �Է��� �������� ��
function OnTextAccepted(args)

	SendPublicChatMsg(winMgr:getWindow("doChatting"):getText())
	winMgr:getWindow("doChatting"):setText("")
	winMgr:getWindow("doChatting"):setVisible(false)
	
	winMgr:getWindow("sj_gameResult_inputChatWindow"):setVisible(false)
	
end




-- ä�� �Է�â
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_inputChatWindow")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 664, 396)
mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 664, 396)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(2);
mywindow:setPosition(5, 740)
mywindow:setSize(360, 22)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)



-- ä�� ����Ʈ �ڽ�
mywindow = winMgr:createWindow("TaharezLook/Editbox", "doChatting")
mywindow:setWideType(2);
mywindow:setPosition(10, 740)
mywindow:setSize(320, 24)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:activate()
mywindow:subscribeEvent("TextAccepted", "OnTextAccepted")
root:addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("doChatting")):setMaxTextLength(64)
CEGUI.toEditbox(winMgr:getWindow("doChatting")):subscribeEvent("EditboxFull", "OnEditBoxFull")

function OnEditBoxFull(args)
	PlaySound('sound/FullEdit.wav')
end


-- 15���� ä�� �ʱ�ȭ
local tShowText		 = { ["protectErr"]=0 }
local tShowTextColor = { ["protectErr"]=0 }
local tShowTextType = { ["protectErr"]=0 }

function WndGameResult_ClearChatting()

	for i=1, table.getn(tShowText) do
		table.remove(tShowText,  i)		-- ä�ó���
		table.remove(tShowTextColor, i)	-- ä�û���
		table.remove(tShowTextType, i)	-- ä�û���
		
	end
	
end



function WndGameResult_RenderChatting(bChat, hanMode)

	if IsKoreanLanguage() then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	else
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	end
	drawer:setTextColor(255, 255, 255, 255)
	
	if bChat then
		if hanMode then
			drawer:drawTexture("UIData/GameNewImage.tga", 345, 742, 16, 17, 404, 964, WIDETYPE_2);
		else
			drawer:drawTexture("UIData/GameNewImage.tga", 345, 742, 16, 17, 404, 981, WIDETYPE_2);
		end	
	end
	
	y = 286
	count = 0
		
	for i=1, table.getn(tShowText) do
		count = count + 1
		
		-- 1: �ڽ�(���)
		if tShowTextColor[i] == -1 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatMySelfFontData[3],ChatMySelfFontData[4],ChatMySelfFontData[5],255, WIDETYPE_2)
		
		-- 0: �ҹ�ä��(����)
		elseif tShowTextColor[i] == 0 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatWarnningFontData[3],ChatWarnningFontData[4],ChatWarnningFontData[5],255, WIDETYPE_2)
		
		-- 1:�Ϲ�ä��(���)
		elseif tShowTextColor[i] == 1 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatNormalFontData[3],ChatNormalFontData[4],ChatNormalFontData[5],255, WIDETYPE_2)
			
		-- 2:��Ƽä��(�Ķ���)
		elseif tShowTextColor[i] == 2 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatPartyFontData[3],ChatPartyFontData[4],ChatPartyFontData[5],255, WIDETYPE_2)
			
		-- 3:�ӼӸ�(���)
		elseif tShowTextColor[i] == 3 then
			local fontData = ChatWhisperFontData
			if tShowTextType[i] == 1 then
				fontData = SpecialZMFontData
			elseif tShowTextType[i] == 2 then
				fontData = SpecialSultanFontData
			end	
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, fontData[3],fontData[4],fontData[5],255, WIDETYPE_2)
			
		-- 4:��ä��(�Ķ���)
		elseif tShowTextColor[i] == 4 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatTeamFontData[3],ChatTeamFontData[4],ChatTeamFontData[5],255, WIDETYPE_2)
		
		-- 5:�ý���ä��(������)
		elseif tShowTextColor[i] == 5 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatSystemFontData[3],ChatSystemFontData[4],ChatSystemFontData[5],255, WIDETYPE_2)
		
		-- 6:�ý��� �޼���2(�ݻ�)
		elseif tShowTextColor[i] == 6 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatSystem2FontData[3],ChatSystem2FontData[4],ChatSystem2FontData[5],255, WIDETYPE_2)
		
		-- 7:��ä��(�������)
		elseif tShowTextColor[i] == 7 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatGangFontData[3],ChatGangFontData[4],ChatGangFontData[5],255, WIDETYPE_2)
		end

		y = y + 16
		if count >= 12 then
			return
		end
	end
	
end




-- ä�� ���̺� �Է�
-- ���� chatType (0: �ҹ�ä��(����), 1:�Ϲ�ä��(���), 2:��ä��(�Ķ���), 3:�ӼӸ�(���))
function WndGameResult_OnChatPublic(message, chatType, specialType)

	if table.getn(tShowText) >= 12 then
		table.remove(tShowText,  1)
		table.remove(tShowTextColor, 1)
		table.remove(tShowTextType, 1)
	end

	table.insert(tShowText, tostring(message))			-- ä�ó���
	table.insert(tShowTextColor, tonumber(chatType))	-- ä�û���
	table.insert(tShowTextType, tonumber(specialType))	-- ä��Ÿ��
	
end


-- ���ӽÿ� �����ִ� ä�������� ����
function SetBeforeGameChat(chat, chatColor)
	table.insert(tShowText, tostring(chat))				-- ä�ó���
	table.insert(tShowTextColor, tonumber(chatColor))	-- ä�û���
	table.insert(tShowTextType, tonumber(0))			-- 

end

function Result_ShowEmblemKey(LeftEmblem, RightEmblem)
	if LeftEmblem > 0 then 
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..LeftEmblem..".tga", 280 , 190, 32, 32, 0, 0, 400, 400, 255, 0, 0, WIDETYPE_6)
		--DebugStr('LeftEmblem:'..LeftEmblem)
	end
	
	if RightEmblem > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..RightEmblem..".tga", 690 , 190 , 32, 32, 0, 0, 400, 400, 255, 0, 0, WIDETYPE_6)
		--DebugStr('RightEmblem:'..RightEmblem)
	end
end