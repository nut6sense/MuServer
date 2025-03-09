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
local GAMEMODE_COINMATCH = 11


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
--local g_currentClubBattle = WndGameResult_IsClubBattle()

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
local lastDrawState = 0
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

	PLAYMODE = playMode
	
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
		
	-- �̼� ��� �׸��� (3����� ���̱�)
	
	----------------------------------------------------
	if PLAYMODE == GAMEMODE_DEATHMATCH then
		--[[
		if currentUserNum >= 3 then
			if drawState == 0 then
				tMission[0] = tMission[0] + deltaTime*2
				if tMission[0] >= tMission[1] then
					tMission[0] = tMission[1]
					
					tMission_Result[0] = tMission_Result[0] - (deltaTime*6)	
					if tMission_Result[0] <= tMission_Result[1] then
						tMission_Result[0] = tMission_Result[1]
					end
				end		
			else
				tMission[0] = tMission[0] - deltaTime
				if tMission[0] <= tMission[2] then
					tMission[0] = tMission[2]
				end
				
				tMission_Result[0] = tMission_Result[0] - deltaTime
				if tMission_Result[0] <= tMission_Result[2] then
					tMission_Result[0] = tMission_Result[2]
				end
			end
			
			drawer:setFont(g_STRING_FONT_DODUMCHE, 16)
			drawer:setTextColor(255, 255, 255, 255)
			
			local missionSuccessY	= 160
			local mission0_posY		= 220
			local mission1_posY		= 260
			
			-- �̼� ����
			common_DrawOutlineText1(drawer, mission0_desc, tMission[0]+80, mission0_posY, 0,0,0,255, 255,255,255,255, WIDETYPE_6)
			common_DrawOutlineText1(drawer, mission1_desc, tMission[0]+80, mission1_posY, 0,0,0,255, 255,255,255,255, WIDETYPE_6)
			
			-- �̼� ���
			if mission0_result == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", tMission[0], mission0_posY-12, 59, 38, 880, 182, WIDETYPE_6)	-- success
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tMission[0], mission0_posY-11, 59, 38, 880, 142, WIDETYPE_6)	-- miss
			end
			
			if mission1_result == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", tMission[0], mission1_posY-12, 59, 38, 880, 182, WIDETYPE_6)	-- success
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tMission[0], mission1_posY-11, 59, 38, 880, 142, WIDETYPE_6)	-- miss
			end
			
			
			-- �̼� ��������
			g_missionEffect = g_missionEffect + deltaTime
			g_missionEffect = g_missionEffect % 400
			drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0], missionSuccessY-19, 473, 69, 0, 852, WIDETYPE_6)
			if missionSuccess == 1 then
				if g_missionEffect < 200 then
					drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0]+100, missionSuccessY, 190, 27, 700, 738, WIDETYPE_6)	-- �̼� ����
				else
					drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0]+100, missionSuccessY, 190, 27, 700, 770, WIDETYPE_6)	-- �̼� ����
				end
			else
				if g_missionEffect < 200 then
					drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0]+100, missionSuccessY, 190, 27, 700, 802, WIDETYPE_6)	-- �̼� ����
				else
					drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0]+100, missionSuccessY, 190, 27, 700, 834, WIDETYPE_6)	-- �̼� ����
				end
			end
		end		
		--]]
	-- ���� ���̽�
	elseif PLAYMODE == GAMEMODE_MONSTER_RACING then
		--[[
		if drawState == 0 then
			tMission[0] = tMission[0] + deltaTime*2
			if tMission[0] >= tMission[1] then
				tMission[0] = tMission[1]
				
				tMission_Result[0] = tMission_Result[0] - (deltaTime*6)	
				if tMission_Result[0] <= tMission_Result[1] then
					tMission_Result[0] = tMission_Result[1]
				end
			end		
		else
			tMission[0] = tMission[0] - deltaTime
			if tMission[0] <= tMission[2] then
				tMission[0] = tMission[2]
			end
			
			tMission_Result[0] = tMission_Result[0] - deltaTime
			if tMission_Result[0] <= tMission_Result[2] then
				tMission_Result[0] = tMission_Result[2]
			end
		end
		--]]
		
		-- ���� ���� NEW RECORD
		if g_newMRRecord then
			g_newMRRecordEffect = g_newMRRecordEffect + deltaTime
			g_newMRRecordEffect = g_newMRRecordEffect % 200
			if g_newMRRecordEffect < 100 then
				drawer:drawTexture("UIData/ResultNewImage_3.tga", tMission[0]+50, 275, 206, 89, 0, 0, WIDETYPE_6)
			else
				drawer:drawTexture("UIData/ResultNewImage_3.tga", tMission[0]+50, 275, 206, 89, 206, 0, WIDETYPE_6)
			end
			
			local startPos1	= tMission[0]+70
			local startPos2	= tMission[0]+86
			local startPosY = 300
			
			-- ��ũ
			local m_ten = (g_newMRRank-1) / 10
			local m_one = (g_newMRRank-1) % 10			
			drawer:drawTexture("UIData/ResultNewImage_3.tga", startPos1-12, startPosY+13, 64, 33, m_one*64, 89+(m_ten*33), WIDETYPE_6)

			-- ų��
			local _l, _r = DrawEachNumberWide("UIData/match001.tga", g_newMRKillCount, 8, startPos1+100, startPosY+30, 822, 914, 16, 22, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/ResultNewImage_3.tga", _r+10, startPosY+26, 60, 33, 618, 0, WIDETYPE_6)
			
			-- minute
			drawer:drawTexture("UIData/match001.tga", startPos1+56, startPosY+4, 16, 22, g_tnewMRTime[g_newMRMin/10], 914, WIDETYPE_6)
			drawer:drawTexture("UIData/match001.tga", startPos2+56, startPosY+4, 16, 22, g_tnewMRTime[g_newMRMin%10], 914, WIDETYPE_6)
			
			-- :
			drawer:drawTexture("UIData/match001.tga", startPos2+70, startPosY+4, 16, 21, 982, 914, WIDETYPE_6)
			
			-- second
			drawer:drawTexture("UIData/match001.tga", startPos1+100, startPosY+4, 16, 22, g_tnewMRTime[g_newMRSec/10], 914, WIDETYPE_6)
			drawer:drawTexture("UIData/match001.tga", startPos2+100, startPosY+4, 16, 22, g_tnewMRTime[g_newMRSec%10], 914, WIDETYPE_6)
			
			-- :
			drawer:drawTexture("UIData/match001.tga", startPos2+23+92, startPosY+4, 16, 21, 982, 914, WIDETYPE_6)
			
			-- milli second
			drawer:drawTexture("UIData/match001.tga", startPos1+146, startPosY+4, 16, 22, g_tnewMRTime[g_newMRMilliSec/10], 914, WIDETYPE_6)
			drawer:drawTexture("UIData/match001.tga", startPos2+146, startPosY+4, 16, 22, g_tnewMRTime[g_newMRMilliSec%10], 914, WIDETYPE_6)

		end
		
		drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission[0]+50, 170, 206, 90, 777, 643, WIDETYPE_6)
		
		local _left, _right = DrawEachNumberWide("UIData/ResultNewImage_1.tga", myKill, 2, tMission[0]+190, 196, 833, 870, 17, 20, 17, WIDETYPE_6)
	--	drawer:drawTexture("UIData/ResultNewImage_1.tga", _left-16, 226, 17, 20, 799, 870)
		
		_left, _right = DrawEachNumberWide("UIData/match001.tga", missionExp, 2, tMission[0]+190, 216, 580, 499, 13, 19, 13, WIDETYPE_6)
	--	drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission[0]+50, 200, 206, 90, 777, 643)
		
		_left, _right = DrawEachNumberWide("UIData/match001.tga", missionZen, 2, tMission[0]+190, 235, 580, 480, 13, 19, 13, WIDETYPE_6)
	--	drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission[0]+50, 200, 206, 90, 777, 643)
	end
	
	
	if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
		-- ���� ��ŷ �̹���
		if myRank > 0 then
			if drawState == 0 then
				tMyRankPos[1] = tMyRankPos[1] - deltaTime
				if tMyRankPos[1] <= tMyRankPos[2] then
					tMyRankPos[1] = tMyRankPos[2]
				end			
			else
				tMyRankPos[1] = tMyRankPos[1] + (deltaTime*2)
				
				if tMyRankPos[1] >= tMyRankPos[3] then
					tMyRankPos[1] = tMyRankPos[3]
				end
			end
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tMyRankPos[1], 130, 193, 117, tMyRankDescX[myRank], tMyRankDescY[myRank], WIDETYPE_6)
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

-- �ͽ�Ʈ�� 1
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_extremeImage1")
mywindow:setTexture("Enabled", "UIData/ResultNewImage_1.tga", 585, 282)
mywindow:setTexture("Disabled", "UIData/ResultNewImage_1.tga", 585, 282)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(440, 500)
mywindow:setSize(202, 114)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:addController("motion", "extremeAlphaMotion1", "alpha", "Sine_EaseInOut", 255, 0, 5, true, true, 10)
mywindow:addController("motion", "extremeAlphaMotion1", "alpha", "Sine_EaseInOut", 0, 255, 5, true, true, 10)
root:addChildWindow(mywindow)

-- �ͽ�Ʈ�� 2
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_extremeImage2")
mywindow:setTexture("Enabled", "UIData/ResultNewImage_1.tga", 585, 396)
mywindow:setTexture("Disabled", "UIData/ResultNewImage_1.tga", 585, 396)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(440, 500)
mywindow:setSize(202, 114)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:addController("motion", "extremeAlphaMotion2", "alpha", "Sine_EaseInOut", 0, 255, 5, true, true, 10)
mywindow:addController("motion", "extremeAlphaMotion2", "alpha", "Sine_EaseInOut", 255, 0, 5, true, true, 10)
root:addChildWindow(mywindow)


function WndGameResult_MyExtremePoint(drawState, extremeZen)

	if drawState == 1 then
		winMgr:getWindow("sj_gameResult_extremeImage1"):setVisible(false)
		winMgr:getWindow("sj_gameResult_extremeImage2"):setVisible(false)
		return
	end

	-- �ͽ�Ʈ�� ��� �����
	if extremeZen ~= 0 then
		winMgr:getWindow("sj_gameResult_extremeImage1"):setVisible(true)
		winMgr:getWindow("sj_gameResult_extremeImage1"):activeMotion("extremeAlphaMotion1")
		winMgr:getWindow("sj_gameResult_extremeImage2"):setVisible(true)
		winMgr:getWindow("sj_gameResult_extremeImage2"):activeMotion("extremeAlphaMotion2")
	
		if extremeZen > 0 then
			_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", extremeZen, 2, 560, 572, 848, 0, 16, 22, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/numberUi001.tga", _left-15, 572, 16, 22, 832, 0, WIDETYPE_6)		-- +
		
		elseif extremeZen < 0 then
			_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", extremeZen, 2, 560, 572, 848, 22, 16, 22, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/numberUi001.tga", _left-16, 574, 16, 22, 832, 22, WIDETYPE_6)	-- -
		end
	else
		winMgr:getWindow("sj_gameResult_extremeImage1"):setVisible(false)
		winMgr:getWindow("sj_gameResult_extremeImage2"):setVisible(false)
	end
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
				extreme_ZEN	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				mmZp		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				mmLevel		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 }
			}


--------------------------------------------------------------------

-- ���� ����� �ʱ�ȭ�Ѵ�.(��ũ�� �°� ����) ��ź����

--------------------------------------------------------------------
function WndGameResult_InitBombResultInfo(slot, enemyType, rank, level, name,
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

--------------------------------------------------------------------

-- ���� ����� �ʱ�ȭ�Ѵ�.(��ũ�� �°� ����)

--------------------------------------------------------------------
function WndGameResult_InitResultInfo(slot, enemyType, rank, level, name,
						ko, down, exp, addExp, point, addPoint, bLevelUp, bMission, disconnected, bWherePCRoom, bEvent, bCostume, ladder,
						buff_EXP, buff_ZEN, icafe, extreme_ZEN, gameMode)
	
	if gameMode == GAMEMODE_DUALMATCH or gameMode == GAMEMODE_SINGLEMATCH then
		
		-- �����, �ϴ��� ����� �ε����� �����Ѵ�.
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
	else
	
		-- ��ũ���� �����Ѵ�.
		tRankInfo.index[rank]			= slot
		tRankInfo.rank[rank]			= rank
		tRankInfo.enemyType[rank]		= enemyType
		tRankInfo.level[rank]			= level
		tRankInfo.name[rank]			= name
		tRankInfo.ko[rank]				= ko
		tRankInfo.down[rank]			= down
		tRankInfo.exp[rank]				= exp
		tRankInfo.addExp[rank]			= addExp
		tRankInfo.point[rank]			= point
		tRankInfo.addPoint[rank]		= addPoint
		tRankInfo.levelUp[rank]			= bLevelUp
		tRankInfo.mission[rank]			= bMission
		tRankInfo.disconnected[rank]	= disconnected
		tRankInfo.wherePCRoom[rank]		= bWherePCRoom
		tRankInfo.event[rank]			= bEvent
		tRankInfo.costume[rank]			= bCostume
		tRankInfo.ladder[rank]			= ladder
		tRankInfo.buff_EXP[rank]		= buff_EXP
		tRankInfo.buff_ZEN[rank]		= buff_ZEN
		tRankInfo.icafe[rank]			= icafe
		tRankInfo.extreme_ZEN[rank]		= extreme_ZEN
		g_bInit	= true
	end	
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
	
	-- �����̵� �̿�� �Ⱥ��̰� �ϱ�
	winMgr:getWindow("sj_gameResult_stampArcadeTicket"):setVisible(false)
	
	-- ��� ������ �Ⱥ��̰� �ϱ�
	winMgr:getWindow("sj_gameResult_stampRewardItem"):setVisible(false)

	-- ���� ���ǥ��
	if bTeam == 1 then
		if PLAYMODE == GAMEMODE_MONSTER_RACING then
			local _left, _right = DrawEachNumberWide("UIData/numberUi001.tga", redTeamSceneNumber, 2, 440, 150, 270, 393, 26, 26, 27, WIDETYPE_6)	-- ������ ����
			drawer:drawTexture("UIData/numberUi001.tga", _left-114, 150, 101, 23, 270, 369, WIDETYPE_6)	-- ROUND
			
			DrawEachNumberWide("UIData/numberUi001.tga", blueTeamSceneNumber, 1, 650, 150, 270, 393, 26, 26, 27, WIDETYPE_6)	-- ����� ����
			drawer:drawTexture("UIData/numberUi001.tga", 540, 150, 101, 23, 270, 369, WIDETYPE_6)		-- ROUND
		end
		
		DrawEachNumberWide("UIData/numberUi001.tga", redKill, 2, 400, 180, 274, 521, 74, 66, 75, WIDETYPE_6)	-- ������ ų��
		drawer:drawTexture("UIData/GameNewImage.tga", 494, 192, 19, 46, 561, 512, WIDETYPE_6)				-- :
		DrawEachNumberWide("UIData/numberUi001.tga", blueKill, 1, 528, 180, 274, 455, 74, 66, 75, WIDETYPE_6)	-- ����� ų��
	end
	
	-- ���� ���̽� �ð�ǥ��
	if PLAYMODE == GAMEMODE_MONSTER_RACING then

		local startPos1	= 80
		local startPos2	= 102
		local startPosY = 310

		-- ���� �׸���
		drawer:drawTexture("UIData/ResultNewImage_3.tga", startPos1-6, startPosY-35, 206, 89, 412, 0, WIDETYPE_6)
		
		-- minute
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos1, startPosY+4, 38, 26, tTime[min/10], 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2, startPosY+4, 38, 26, tTime[min%10], 192, WIDETYPE_6)
		
		-- ' �� :
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23, startPosY+4, 16, 26, 891, 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30, startPosY+4, 16, 26, 870, 192, WIDETYPE_6)
		
		
		-- second
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+65, startPosY+4, 38, 26, tTime[sec/10], 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+65, startPosY+4, 38, 26, tTime[sec%10], 192, WIDETYPE_6)
		
		-- ' �� .
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23+65, startPosY+4, 16, 26, 891, 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30+65, startPosY+17, 16, 13, 870, 205, WIDETYPE_6)
		
		
		-- milli second
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+130, startPosY+4, 38, 26, tTime[milliSec/10], 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+130, startPosY+4, 38, 26, tTime[milliSec%10], 192, WIDETYPE_6)
		
		-- "
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+24+130, startPosY+4, 16, 26, 911, 192, WIDETYPE_6)
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
	
	if PLAYMODE == GAMEMODE_DUALMATCH or PLAYMODE == GAMEMODE_SINGLEMATCH then
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY-14, 1024, 295, 0, 729, WIDETYPE_6)
		
		if winTeam == 0 then
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+22, 1024, 124, 0, 481, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+146, 1024, 124, 0, 605, WIDETYPE_6)
		else
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+22, 1024, 124, 0, 605, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+146, 1024, 124, 0, 481, WIDETYPE_6)
		end
	else
		drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX-4, descPosY, 929, 280, 0, 0, WIDETYPE_6)	
		if PLAYMODE == GAMEMODE_COINMATCH then
		
			drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX-4+ 291, descPosY + 7, 99, 33, 925, 0, WIDETYPE_6)		
		
		
		end
		
	end
		
	if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
		-- �ͽ�Ʈ�� �ð�
		if extremeMode == BATTLETYPE_EXTREME then
			drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX+656, descPosY+9, 78, 22, 699, 711, WIDETYPE_6)
			g_extremeTime = g_extremeTime + deltaTime
			g_extremeTime = g_extremeTime % 200
		end
		
		-- ����Ʈ �Ҳ�ȿ��
		if bPerfectGame == 1 then
			if g_perfectSound then
				g_perfectSound = false
				PlaySound("sound/System/System_Perfect.wav")
			end
			drawer:drawTexture("UIData/Perfect.tga", 200, 20, 622, 101, 0, g_perfectCount*101, WIDETYPE_6)
			drawer:drawTexture("UIData/Perfect.tga", 310, 126, 294, 75, 622, g_perfectCount*75, WIDETYPE_6)
			g_perfectTime = g_perfectTime + deltaTime
			if g_perfectTime >= 100 then
				g_perfectCount = g_perfectCount + 1
				if g_perfectCount >= 9 then
					g_perfectCount = 0
				end
			end
		end
	end
	
	-- �����̳� ���°��ĳ�;;
	if continueWin >= 2 or oldContinueWin >= 2 then
		
		-- ���¹��� �̹���
		g_continueWinTime = g_continueWinTime + deltaTime
		g_continueWinTime = g_continueWinTime % 200
		if g_continueWinTime < 100 then
			drawer:drawTexture("UIData/match001.tga", descPosX+444, 434, 453, 39, 257, 768, WIDETYPE_6)
		else
			drawer:drawTexture("UIData/match001.tga", descPosX+444, 434, 453, 39, 257, 865, WIDETYPE_6)
		end
		
		-- ���������
		if continueWinTeam == 0 then
			drawer:drawTexture("UIData/match001.tga", descPosX+455, 444, 60, 19, 789, 941, WIDETYPE_6)
		elseif continueWinTeam == 1 then
			drawer:drawTexture("UIData/match001.tga", descPosX+455, 444, 60, 19, 849, 941, WIDETYPE_6)
		end
		
		-- ������̳�
		if continueWin > oldContinueWin then
			DrawEachNumberWide("UIData/match001.tga", continueWin, 2, descPosX+618, 442, 822, 914, 15, 22, 16, WIDETYPE_6)		-- ���
			drawer:drawTexture("UIData/match001.tga", descPosX+633, 438, 130, 29, 580, 807, WIDETYPE_6)	-- ������
		
		-- ��°��ĳ�
		elseif continueWin < oldContinueWin then
			DrawEachNumberWide("UIData/match001.tga", oldContinueWin, 2, descPosX+618, 442, 822, 914, 15, 22, 16, WIDETYPE_6)	-- ���
			drawer:drawTexture("UIData/match001.tga", descPosX+633, 438, 130, 29, 580, 836, WIDETYPE_6)	-- ���°���
		end
		
		-- ���º���
		drawer:drawTexture("UIData/match001.tga", descPosX+794, 442, 16, 22, 806, 914, WIDETYPE_6)	-- +
		DrawEachNumberWide("UIData/match001.tga", continueWinReward, 1, descPosX+808, 442, 822, 914, 15, 22, 16, WIDETYPE_6)		
	end
	
	-- �÷��̾��� ���â
	if PLAYMODE == GAMEMODE_DUALMATCH or PLAYMODE == GAMEMODE_SINGLEMATCH then
		userNum = 8 -- ����ġ�� ���
	end
	local lastPosX = 82
	for i=1, userNum do
		if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
			if tRankInfo.rank[i] >= 0 then
				tRankPosX[i] = tRankPosX[i] - (deltaTime*2)
				if tRankPosX[i] <= lastPosX then
					tRankPosX[i] = lastPosX
				end
			
				-------------------------
				-- ����
				-------------------------
				if bTeam == 0 then
					drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i], tRankPosY[tRankInfo.rank[i]]-2, 924, 26, 9, 422, WIDETYPE_6)
				else
					if tRankInfo.enemyType[i] == 0 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i], tRankPosY[tRankInfo.rank[i]]-2, 924, 24, 9, 453, WIDETYPE_6)
					else
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i], tRankPosY[tRankInfo.rank[i]]-2, 924, 24, 9, 484, WIDETYPE_6)
					end
				end
				
				-------------------------
				-- ����
				-------------------------
				DrawEachNumberWide("UIData/numberUi001.tga", i-1, 1, tRankPosX[i]+10, tRankPosY[tRankInfo.rank[i]]-1, 307, 110, 23, 23, 23, WIDETYPE_6)
		
				-------------------------
				-- �ɸ���(����, ����), �ѱ��� ����
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
				if tRankInfo.index[i] == mySlot then
					common_DrawOutlineText1(drawer, levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				else
					drawer:drawText(levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
				end
				
				-- ����
				drawer:drawTexture("UIData/numberUi001.tga", tRankPosX[i]+118, tRankPosY[tRankInfo.rank[i]]-1, 47, 21, 113, 600+21*tRankInfo.ladder[i], WIDETYPE_6)
				
				-- �̸�
				local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.name[i]))
				if tRankInfo.index[i] == mySlot then
					common_DrawOutlineText1(drawer, tRankInfo.name[i], tRankPosX[i]+222-nameSize/2, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				else
					drawer:drawText(tRankInfo.name[i], tRankPosX[i]+222-nameSize/2, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
				end
				
				-------------------------
				-- KO/DOWN, disconnected
				-------------------------
				
				if PLAYMODE == GAMEMODE_COINMATCH then
		
		
					-- KO(������ ����)
					local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.ko[i]))
					if tRankInfo.index[i] == mySlot then
						common_DrawOutlineText1(drawer, tRankInfo.ko[i], tRankPosX[i]+326-size+ 20, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					else
						drawer:drawText(tRankInfo.ko[i], tRankPosX[i]+326-size, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
					end
					
				
					
		
		
				else
				
					-- KO(������ ����)
					local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.ko[i]))
					if tRankInfo.index[i] == mySlot then
						common_DrawOutlineText1(drawer, tRankInfo.ko[i], tRankPosX[i]+326-size, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					else
						drawer:drawText(tRankInfo.ko[i], tRankPosX[i]+326-size, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
					end
					
					-- DOWN(���� ����)
					if tRankInfo.index[i] == mySlot then
						common_DrawOutlineText1(drawer, tRankInfo.down[i], tRankPosX[i]+356, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					else
						drawer:drawText(tRankInfo.down[i], tRankPosX[i]+356, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
					end
					
					
				
				end
		
			
				
				-- disconnected
				if tRankInfo.disconnected[i] == 1 then
					drawer:drawTexture("UIData/GameNewImage.tga", tRankPosX[i]+302, tRankPosY[tRankInfo.rank[i]]+2, 74, 14, 2, 190, WIDETYPE_6)
				end


				-- MVP �߰� ���ʽ��� +�Ѵ�.
				if g_totalBonusCalc then
					g_totalBonusCalc = false
					
					if mvp > 0 then
						g_totalBonusExp  = tRankInfo.addExp[mvp]+mvpExp
						g_totalBonusGran = tRankInfo.addPoint[mvp]+mvpPoint
					end
				end
				
				if g_mvpAddBonusStart then
					if mvp > 0 then
						tRankInfo.addExp[mvp] = tRankInfo.addExp[mvp] + 1
						if tRankInfo.addExp[mvp] >= g_totalBonusExp then
							tRankInfo.addExp[mvp] = g_totalBonusExp
						end
						
						tRankInfo.addPoint[mvp] = tRankInfo.addPoint[mvp] + 1
						if tRankInfo.addPoint[mvp] >= g_totalBonusGran then
							tRankInfo.addPoint[mvp] = g_totalBonusGran
						end
					end
				end				
			
				-------------------------
				-- ����(����ġ, ZEN)
				-------------------------
				if tRankInfo.buff_EXP[i] > 0 then
					tbuffExpTime[i] = tbuffExpTime[i] + deltaTime
					tbuffExpTime[i] = tbuffExpTime[i] % 400
					if tbuffExpTime[i] > 200 then
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY[tRankInfo.rank[i]]+9, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					else
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY[tRankInfo.rank[i]]+12, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					end
				end
				
				if tRankInfo.buff_ZEN[i] > 0 then
					tbuffZenTime[i] = tbuffZenTime[i] + deltaTime
					tbuffZenTime[i] = tbuffZenTime[i] % 400
					if tbuffZenTime[i] > 200 then
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+622, tRankPosY[tRankInfo.rank[i]]+9, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					else
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+622, tRankPosY[tRankInfo.rank[i]]+12, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
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
				
				
				if tRankInfo.index[i] == mySlot then
					-- ����ġ
					common_DrawOutlineText1(drawer, _curExp, tRankPosX[i]+446-_curExpSize, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					common_DrawOutlineText1(drawer, _addExp, tRankPosX[i]+448, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
					
					-- �׶�
					common_DrawOutlineText1(drawer, _curGran, tRankPosX[i]+564-_curGranSize, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					common_DrawOutlineText1(drawer, _addGran, tRankPosX[i]+566, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
				else
					drawer:drawText(tRankInfo.exp[i], tRankPosX[i]+446-_curExpSize, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)	-- ����ġ
					drawer:drawText(_curGran, tRankPosX[i]+564-_curGranSize, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)		-- �׶�
					
					drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
					drawer:setTextColor(0,255,0,255)
					drawer:drawText(_addExp, tRankPosX[i]+448, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)	-- ���ʽ� ����ġ				
					drawer:drawText(_addGran, tRankPosX[i]+566, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)	-- ���ʽ� �׶�
				end
			
			
				local BONUS_X = 646
				drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
				drawer:setTextColor(255,255,255,255)
				-------------------------
				-- ���ʽ�(�̼�, ������, PC��, �̺�Ʈ)
				-------------------------
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+120, tRankPosY[tRankInfo.rank[i]]-3, 45, 27, 795, 83, WIDETYPE_6)
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+158, tRankPosY[tRankInfo.rank[i]]-3, 52, 27, 840, 83, WIDETYPE_6)
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+200, tRankPosY[tRankInfo.rank[i]]-3, 48, 27, 976, 83, WIDETYPE_6)
			--	drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+107, tRankPosY[tRankInfo.rank[i]]-3, 84, 27, 892, 83) -- PC��
			--	drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+146, tRankPosY[tRankInfo.rank[i]]-2, 64, 45, 793, 235, 128, 128, 255, 0, 0) -- icafe
				
				-- ���� ���̽��� ���
				if PLAYMODE == GAMEMODE_MONSTER_RACING then
					drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+68, tRankPosY[tRankInfo.rank[i]]-4, 55, 26, 909, 57, WIDETYPE_6)
				end 
				
				if IsKoreanLanguage() then
					-- �̼�
					if tRankInfo.mission[i] == 1 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+118, tRankPosY[tRankInfo.rank[i]]-4, 45, 27, 795, 56, WIDETYPE_6)
					end
					
					-- ������
					if tRankInfo.costume[i] == 1 or tRankInfo.buff_EXP[i] > 0 or tRankInfo.buff_ZEN[i] > 0 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+156, tRankPosY[tRankInfo.rank[i]]-4, 52, 27, 840, 56, WIDETYPE_6)
					end
					
					-- �̺�Ʈ
					if tRankInfo.event[i] == 1 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+198, tRankPosY[tRankInfo.rank[i]]-4, 48, 27, 976, 56, WIDETYPE_6)
					end
				else
						-- �̼�
					if tRankInfo.mission[i] == 1 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+120, tRankPosY[tRankInfo.rank[i]]-4, 45, 27, 795, 56, WIDETYPE_6)
					end
					
					-- ������
					if tRankInfo.costume[i] == 1 or tRankInfo.buff_EXP[i] > 0 or tRankInfo.buff_ZEN[i] > 0 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+158, tRankPosY[tRankInfo.rank[i]]-4, 52, 27, 840, 56, WIDETYPE_6)
					end
					
					-- �̺�Ʈ
					if tRankInfo.event[i] == 1 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+200, tRankPosY[tRankInfo.rank[i]]-4, 48, 27, 976, 56, WIDETYPE_6)
					end
				end
				
				-- PC��
				--if tRankInfo.wherePCRoom[i] == 1 then
				--	drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+107, tRankPosY[tRankInfo.rank[i]]-4, 84, 27, 892, 56)
				--end
				
				-- icafe
				if tRankInfo.icafe[i] == 1 then
					drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+242, tRankPosY[tRankInfo.rank[i]]-2, 64, 45, 729, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
					
				elseif tRankInfo.icafe[i] == 2 then
					drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+242, tRankPosY[tRankInfo.rank[i]]-2, 64, 45, 665, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
				end	


				-- �ͽ�Ʈ�� ����� ���
				drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
				if extremeMode == BATTLETYPE_EXTREME then
					if g_extremeTime < 100 then
						if tRankInfo.extreme_ZEN[i] > 0 then
							_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", tRankInfo.extreme_ZEN[i], 8, tRankPosX[i]+680, tRankPosY[tRankInfo.rank[i]]+2, 28, 666, 12, 15, 14, WIDETYPE_6)
							drawer:drawTexture("UIData/dungeonmsg.tga", _left-15, tRankPosY[tRankInfo.rank[i]]+3, 14, 15, 0, 666, WIDETYPE_6)	-- +
							
						elseif tRankInfo.extreme_ZEN[i] < 0 then
							_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", tRankInfo.extreme_ZEN[i], 8, tRankPosX[i]+680, tRankPosY[tRankInfo.rank[i]]+2, 28, 681, 12, 15, 14, WIDETYPE_6)
							drawer:drawTexture("UIData/dungeonmsg.tga", _left-15, tRankPosY[tRankInfo.rank[i]]+2, 14, 15, 14, 681, WIDETYPE_6)	-- -
						end
					else
						if tRankInfo.extreme_ZEN[i] > 0 then
							_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", tRankInfo.extreme_ZEN[i], 8, tRankPosX[i]+680, tRankPosY[tRankInfo.rank[i]]+2, 28, 696, 12, 15, 14, WIDETYPE_6)
							drawer:drawTexture("UIData/dungeonmsg.tga", _left-15, tRankPosY[tRankInfo.rank[i]]+3, 14, 15, 0, 696, WIDETYPE_6)	-- +
							
						elseif tRankInfo.extreme_ZEN[i] < 0 then
							_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", tRankInfo.extreme_ZEN[i], 8, tRankPosX[i]+680, tRankPosY[tRankInfo.rank[i]]+2, 28, 681, 12, 15, 14, WIDETYPE_6)
							drawer:drawTexture("UIData/dungeonmsg.tga", _left-15, tRankPosY[tRankInfo.rank[i]]+2, 14, 15, 14, 681, WIDETYPE_6)	-- -
						end
					end
				end
								
				-------------------------------
				-- ���� �����ϱ� ���� �׵θ�
				-------------------------------
				if tRankInfo.index[i] == mySlot then
					drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i], tRankPosY[myRank]-6, 924, 32, 8, 515, WIDETYPE_6)
				end
				
			end
		else
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
			
			if PLAYMODE == GAMEMODE_DUALMATCH or PLAYMODE == GAMEMODE_SINGLEMATCH then
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
		end
	end
		
	if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
	
		if g_effect then	
			-- MVP�� 5����� ����ȴ�.
			local MVPCOUNT = 5
			if IsKoreanLanguage() then
				if GetIsAutoMatch() == 1 then
					MVPCOUNT = 4
				end
			end
			if currentUserNum >= MVPCOUNT then
				if mvp > 0 then
					if g_mvpSoundEffect then
						PlaySound("sound/GameResult_MVP.wav")
						g_mvpSoundEffect = false
					end
					
					if g_mvpStampEffect then
						winMgr:getWindow("sj_wndGameResult_mvpImage"):setVisible(true)
						winMgr:getWindow("sj_wndGameResult_mvpImage"):activeMotion("StampEffect")

						g_mvpEffectTime = g_mvpEffectTime + deltaTime
						if g_mvpEffectTime >= 800 then
							g_mvpEffectTime  = 0
							g_mvpStampEffect = false
						end
					else

						-- ������ ū MVP �ع���
						winMgr:getWindow("sj_wndGameResult_mvpImage"):setVisible(false)
						drawer:drawTexture("UIData/ResultNewImage_2.tga", MVP_IMAGE_POSX, MVP_IMAGE_POSY, 323, 155, 324, 0, WIDETYPE_6)
						
						-- ������ ū MVP �ɸ��� �̸�
						g_mvpTextTime = g_mvpTextTime + deltaTime
						g_mvpTextAlpha = g_mvpTextTime * 255 / 100
						if g_mvpTextAlpha >= 255 then
							g_mvpTextAlpha = 255
						end
						
						-- mvp���ʽ� ���� �����̱�
						local nMvpMoveX = 0
						local nMvpMoveY = 0
						if g_mvpTextTime >= 2000 then
							
							g_mvpMoveTime = g_mvpMoveTime - deltaTime/2
							if g_mvpMoveTime <= 0 then
								g_mvpMoveTime = 0
							end
							
							if g_mvpMoveTime > 0 then
								nMvpMoveX = (((tRankPosX[mvp] - 64)*(MOVETIME-g_mvpMoveTime))/MOVETIME) + (((MVP_IMAGE_POSX+170)*g_mvpMoveTime)/MOVETIME)
								nMvpMoveY = (((tRankPosY[mvp] - 14)*(MOVETIME-g_mvpMoveTime))/MOVETIME) + (((MVP_IMAGE_POSY+30)*g_mvpMoveTime)/MOVETIME)
							
							elseif g_mvpMoveTime == 0 then
								nMvpMoveX = tRankPosX[mvp] - 64
								nMvpMoveY = tRankPosY[mvp] - 14
								g_mvpTwinkle = true
							end
						else
							nMvpMoveX = MVP_IMAGE_POSX+170
							nMvpMoveY = MVP_IMAGE_POSY+30
						end
						
						
						-- MVP �̸�
						drawer:setFont(g_STRING_FONT_GULIMCHE, 16)
						drawer:setTextColor(0,0,0,255)
						local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 16, mvpName)
						common_DrawOutlineText1(drawer, mvpName, (MVP_IMAGE_POSX+210)-nameSize/2, MVP_IMAGE_POSY+68, 0,0,0,g_mvpTextAlpha, 97,230,255,g_mvpTextAlpha, WIDETYPE_6)
						
						
						-- MVP ���ʽ�(����ġ, �׶�)
						drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
						drawer:setTextColor(255,255,255,255)
						common_DrawOutlineText1(drawer, "+"..mvpExp, (MVP_IMAGE_POSX+176), MVP_IMAGE_POSY+95, 0,0,0,g_mvpTextAlpha, 0,255,0,g_mvpTextAlpha, WIDETYPE_6)
						common_DrawOutlineText1(drawer, "+"..mvpPoint, (MVP_IMAGE_POSX+252), MVP_IMAGE_POSY+95, 0,0,0,g_mvpTextAlpha, 0,255,0,g_mvpTextAlpha, WIDETYPE_6)

						-- ���� mvp �����Ÿ���
						if g_mvpTwinkle then
							MvpEffectTime = MvpEffectTime + deltaTime
							MvpEffectTime = MvpEffectTime % 600
							if MvpEffectTime < 300 then
								drawer:drawTexture("UIData/ResultNewImage_2.tga", nMvpMoveX, nMvpMoveY, 78, 49, 888, 0, WIDETYPE_6)
							end
							
							-- MVP ������ ��
							g_mvpShine = g_mvpShine + deltaTime*2
							if g_mvpShine >= 1900 then
								g_mvpShine = 1900
								g_mvpAddBonusStart = true
							end
							
							-- ����
							if g_mvpShineSound then
								g_mvpShineSound = false
								PlaySound('sound/LevelUP01.WAV')
							end
							drawer:drawTexture("UIData/ResultNewImage_1.tga", g_mvpShine, tRankPosY[mvp]-9, 1024, 48, 0, 958, WIDETYPE_6)
							
						else
							drawer:drawTexture("UIData/ResultNewImage_2.tga", nMvpMoveX, nMvpMoveY, 78, 49, 888, 0, WIDETYPE_6)
						end
					end
				end
			end
		end
	end
	
	
	-- ������
	if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
		for i=1, userNum do
			if tRankInfo.levelUp[i] == 1 then
				tLevelUpEffectTime[i] = tLevelUpEffectTime[i] + deltaTime
				tLevelUpEffectTime[i] = tLevelUpEffectTime[i] % 400
				
				if IsKoreanLanguage() then
					if tLevelUpEffectTime[i] < 200 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+60, tRankPosY[tRankInfo.rank[i]]-3, 40, 26, 975, 9, WIDETYPE_6)
					else
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+60, tRankPosY[tRankInfo.rank[i]]-6, 40, 26, 975, 9, WIDETYPE_6)
					end
				else
					if tLevelUpEffectTime[i] < 200 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+80, tRankPosY[tRankInfo.rank[i]]-3, 40, 26, 975, 9, WIDETYPE_6)
					else
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+80, tRankPosY[tRankInfo.rank[i]]-6, 40, 26, 975, 9, WIDETYPE_6)
					end
				end
			end
		end
	else
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
end



--------------------------------------------------------------------

-- 2��° ��������� �����ش�( ��ź����)

--------------------------------------------------------------------
function WndGameResult_DrawBombResult(deltaTime, drawState, mySlot, bTeam, userNum, myResult, myRank, mvp, mvpExp, mvpPoint, redKill, blueKill, 
			mvpName, currentUserNum, extremeMode, bPerfectGame, continueWinTeam, oldContinueWin, continueWin, continueWinReward, 
			redTeamSceneNumber, blueTeamSceneNumber, min, sec, milliSec, winTeam,  bombRedPoint, bombBluePoint, playType)
	
	if g_bInit == false then
		return
	end
	
	if drawState == 0 then
		return
	end
	
	if playType == 3 then  -- ��ź��
		redKill = bombRedPoint
		blueKill = bombBluePoint
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

	drawer:drawTexture("UIData/bumbmode_result.tga", descPosX-81, descPosY-14, 1024, 294, 0, 729, WIDETYPE_6)
	
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
				common_DrawOutlineText1(drawer, tRankInfo.name[i], tRankPosX[i]+273-nameSize/2, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			else
				drawer:drawText(tRankInfo.name[i], tRankPosX[i]+273-nameSize/2, tRankPosY_dual[i]+7, WIDETYPE_6)
			end
			
			-------------------------
			-- KO/DOWN, disconnected
			-------------------------
			-- KO(������ ����)
			--[[
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.ko[i]))
			if tRankInfo.index[i] == mySlot+1 then
				common_DrawOutlineText1(drawer, tRankInfo.ko[i], tRankPosX[i]+356-size, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			else
				drawer:drawText(tRankInfo.ko[i], tRankPosX[i]+356-size, tRankPosY_dual[i]+7, WIDETYPE_6)
			end
			--]]
			-- disconnected
			if tRankInfo.disconnected[i] == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", tRankPosX[i]+222, tRankPosY_dual[i]+4, 74, 14, 2, 190, WIDETYPE_6)
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

end


--------------------------------------------------------------------
-- Rungsimun @ GameInside - Go MatchMaking Button
--------------------------------------------------------------------
function WndGameResult_InitMatchMakingInfo(slot, zp, level)
	--slot = slot + 1
	tRankInfo.mmZp[slot]			= zp
	tRankInfo.mmLevel[slot]			= level
end

function WndGameResult_RenderMatchMaking(zp, oldZp, newZP, level)
	if lastDrawState == 1 then
		return
	end

	adder = ""
	if zp >= 0 then
		adder = "+"
	end

	local String1 = string.format("%s", adder .. CommatoMoneyStr(zp))
	local String2 = string.format("%s -> %s", CommatoMoneyStr(oldZp), CommatoMoneyStr(newZP))
	local String3 = string.format("%d", level+1)

	if zp >= 0 then
		drawer:drawTexture("UIData/MatchMakingGameResult.tga", 797, 532, 160, 77, 1, 111, WIDETYPE_6)
		drawer:drawTexture("UIData/MatchMakingGameResult.tga", 840, 532, 24, 24, 55, 1, WIDETYPE_6)
	elseif zp < 0 then
		drawer:drawTexture("UIData/MatchMakingGameResult.tga", 797, 532, 160, 77, 1, 32, WIDETYPE_6)
		drawer:drawTexture("UIData/MatchMakingGameResult.tga", 840, 532, 24, 24, 30, 1, WIDETYPE_6)
	end

	drawRank(math.fmod(level, 36), 797+10, 532+12, 240)
-- 782  15
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	drawer:setTextColor(0,0,0,255)
	drawer:drawText(String1, 900, 584, WIDETYPE_6)
	-- drawer:drawText(String2, 880, 424, WIDETYPE_6)
	-- drawer:drawText(String3, 880, 448, WIDETYPE_6)

	if zp >= 0 then
		drawer:setTextColor(0,255,0,255)
	else
		drawer:setTextColor(255,0,0,255)
	end
	drawer:drawText(String1, 900-1, 584-1, WIDETYPE_6)

	drawer:setFont(g_STRING_FONT_GULIMCHE, 18)
	drawer:setTextColor(255, 206, 81, 255)
	drawer:drawText(String3, 930, 557, WIDETYPE_6)
	-- drawer:drawText(String2, 880-2, 424-2, WIDETYPE_6)
	-- drawer:drawText(String3, 880-2, 448-2, WIDETYPE_6)
end

function WndGameResult_DrawMatchMakingResult(deltaTime, slot, userNum)
	drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX+632, 478+7, 130, 32, 0, 300, WIDETYPE_6)
	-- drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX+632+80, y+478+7, 0, 300, 130, 32, WIDETYPE_6)

	for i=1, userNum do
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		adder = ""
		if tRankInfo.mmZp[i] >= 0 then
			adder = "+"
			drawer:setTextColor(0,255,0,255)
		else
			drawer:setTextColor(255,0,0,255)
		end
		-- drawer:setTextColor(255,255,255,255)
		local sx = GetStringSize(g_STRING_FONT_GULIMCHE, 12, adder .. tostring(tRankInfo.mmZp[i]))
		drawer:drawText(adder .. tostring(tRankInfo.mmZp[i]), tRankPosX[i]+775-80 - (sx / 2), tRankPosY[i]+5, WIDETYPE_6)
		-- drawer:drawText(tRankInfo.mmZp[i], descPosX+768 - (sx / 2), tRankPosY[i]+5, WIDETYPE_6)
	end
end

-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_matchmaking_zp")
-- mywindow:setTexture("Enabled", "UIData/ResultNewImage_1.tga", 0, 300)
-- mywindow:setTexture("Disabled", "UIData/ResultNewImage_1.tga", 0, 300)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(2);
-- mywindow:setPosition(632+80, 478+7)
-- mywindow:setSize(130, 32)
-- mywindow:setVisible(false)
-- mywindow:setAlwaysOnTop(true)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)