-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


local g_STRING_CHANGECLASS_1	= PreCreateString_1683	--GetSStringInfo(LAN_LUA_CHANGECLASS_1)	-- ���� �̼�!
local g_STRING_CHANGECLASS_2	= PreCreateString_1684	--GetSStringInfo(LAN_LUA_CHANGECLASS_2)	-- �������� ���� ��Ʈ�� KO ���Ѷ�!
local g_STRING_CHANGECLASS_3	= PreCreateString_1685	--GetSStringInfo(LAN_LUA_CHANGECLASS_3)	-- �����̼� ���۴��
local g_STRING_CHANGECLASS_4	= PreCreateString_1687	--GetSStringInfo(LAN_LUA_CHANGECLASS_4)	-- �����̼� �������
local g_STRING_CHANGECLASS_5	= PreCreateString_1688	--GetSStringInfo(LAN_LUA_CHANGECLASS_5)	-- �����̼� ���д��
local g_STRING_RANDYHEART_NAME	= PreCreateString_1372	--GetSStringInfo(LAN_LUA_WND_VILLAGE_4)	-- ���� ��Ʈ
local g_STRING_CHANGECLASS_6	= PreCreateString_1689	--GetSStringInfo(LAN_LUA_CHANGECLASS_6)	-- �����̼� �����Ұ���

----------------------------------------------------------------------

-- �����̼� ����

----------------------------------------------------------------------
function WndChangeClass_MissionDesc(className)
	drawer:drawTexture("UIData/Arcade_lobby.tga", 0, 10, 1024, 112, 0, 885, WIDETYPE_5)
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 26)
	drawer:setTextColor(255, 255, 255, 255)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 26, g_STRING_CHANGECLASS_1)
	drawer:drawText(g_STRING_CHANGECLASS_1, 512-size/2, 30, WIDETYPE_5)
	
	local missionName = className.." "..g_STRING_CHANGECLASS_2
	drawer:setFont(g_STRING_FONT_GULIMCHE, 18)
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 18, missionName)
	drawer:drawText(missionName, 512-size/2, 82, WIDETYPE_5)
end




----------------------------------------------------------------------

-- ĳ���� HP, SP�� ����

----------------------------------------------------------------------
local g_deltaTime = 0
function WndChangeClass_RenderCharacter
			( deltatime
			, myslot
            , myteam
			, slot
			, bone
			, team
			, friend
			, level
			, characterName
			, screenX
			, screenY
			, hp
			, sp
			, maxhp
			, maxsp
			, isPenalty
			, penaltyValue
			, revivalTime
			, transform
			, bDraw
			)
	
	if winMgr:getWindow('Btn_StartChangeClassBattle'):isVisible() then
		g_deltaTime = g_deltaTime + deltatime
	else
		g_deltaTime = 0
	end

	local BATTLE = 0		-- 0:����, 1:����, 2:���ͷ��̽�, 3:������, 4:������(������)
	local isPenalty = false	-- �����̵�� ���Ƽ�� ����
	local penaltyValue = 0	-- ���Ƽ ���� ����
	local showAllSP = 0		-- ��� ���� sp����(���Ӹ� ����)
	local showAllItem = 0	-- ��� ���� ������ ����(���Ӹ� ����)
	local _1stItemType = 0
	local _2ndItemType = 0
	local MONSTER_RACING = false
	local bArcadeEvent = 0
	local exceptE = 0
	Common_RenderCharacter(deltatime, myslot, myteam, slot, team, characterName, 
		screenX, screenY, hp, sp, maxhp, maxsp, friend, isPenalty, penaltyValue, 
		BATTLE, showAllSP, showAllItem, _1stItemType, _2ndItemType, MONSTER_RACING, bArcadeEvent, exceptE)
				
	-- �������� ���� �׸���
	if bDraw == 1 then
		if myslot == slot then
			local isGameOver = 0
			local lifeCount = 2
			local visibleHPSP = 0
			local bTournamentArcade = 0
			Common_RenderME(slot, bone, hp, sp, maxhp, maxsp, deltatime, 
				300, revivalTime, level, characterName, isGameOver, lifeCount, 1, transform, isPenalty, penaltyValue, bArcadeEvent, exceptE, visibleHPSP, bTournamentArcade)
		end
	end
end


--------------------------------------------------------------------

-- NPC ������ �׸���

--------------------------------------------------------------------
local g_npcLastHp		= 0
local g_npcLastHpTime	= 0
local g_npcLastSp		= 0
local g_npcLastSpTime	= 0
local g_npcEffect		= 0
local g_npcHpAccel		= 100
function WndChangeClass_RenderNpcInfo(deltatime, name, hp, maxhp, sp, maxsp, bDraw)

	if bDraw == 0 then
		return
	end
	
	if maxhp == 0 then
		return
	end
	if maxsp == 0 then
		maxsp = 3000
	end
		
	-- ���� ������ ����
	drawer:drawTexture("UIData/quest.tga", 5, 660, 1014, 103, 0, 0,WIDETYPE_7 )

	local WIDTH_HP  = 916
	local WIDTH_SP  = 260
		
	---------
	-- ��
	---------
	local RandyHeart_TexX = 541
	local RandyHeart_TexY = 294
	if hp <= 0 then
		drawer:drawTexture("UIData/characterNewImage.tga", 10, 665, 80, 93, RandyHeart_TexX+176, RandyHeart_TexY, WIDETYPE_7)
	else
		drawer:drawTexture("UIData/characterNewImage.tga", 10, 665, 80, 93, RandyHeart_TexX, RandyHeart_TexY, WIDETYPE_7)
	end
	
	
	
	---------
	-- �̸�
	---------
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	drawer:setTextColor(255, 255, 255, 255)
	drawer:drawText(name, 106, 680, WIDETYPE_7)
	
	
	---------
	-- hp
	---------
	g_npcLastHpTime	= g_npcLastHpTime + deltatime
	local change_hp	= g_npcLastHpTime / g_npcHpAccel
	g_npcLastHp		= g_npcLastHp - change_hp
	
	-- ���ӵ��� ����
	if g_npcHpAccel > 1 then
		g_npcHpAccel = g_npcHpAccel - 1
	end

	if g_npcLastHp < hp then
		g_npcLastHp		= hp
		g_npcLastHpTime = 0
		g_npcHpAccel	= 100
	end

	-- ��5���� ���鼭 0 <= hp < 6000, 6000 <= hp < 12000 �̷������� 5���� üũ�ؾ� �Ѵ�.
	-- remain+(divide-i)�� �ϰԵǸ� �׻� 0 ~ 6000������ ���� ������ �ȴ�
	local MAXHP	= 12000
	if maxhp < 12000 then
		MAXHP = maxhp
	end
	local remain1 = g_npcLastHp % MAXHP
	local remain2 = hp % MAXHP	
	local divide  = hp / MAXHP
	for i=0, 4 do
		if divide-i >= 0 then
			local changedHP = (remain1+(divide-i)*MAXHP) * WIDTH_HP / MAXHP
			local currentHP = (remain2+(divide-i)*MAXHP) * WIDTH_HP / MAXHP
			drawer:drawTexture("UIData/quest.tga", 98, 714, changedHP, 45, 0, 328+i*45, WIDETYPE_7)	-- ��ȭ�ϴ� hp
			drawer:drawTexture("UIData/quest.tga", 98, 714, currentHP, 45, 0, 103+i*45, WIDETYPE_7)	-- ���̴� hp
		end
	end

	
	---------
	-- SP
	---------
	--[[
	g_npcLastSpTime = g_npcLastSpTime + deltatime
	local change_sp	 = g_npcLastSpTime / 20

	g_npcLastSp = g_npcLastSp - change_sp	

	if g_npcLastSp < sp then
		g_npcLastSp = sp
		g_npcLastSpTime = 0
	end
	
	local changedSP	= g_npcLastSp * WIDTH_SP / maxsp
	local currentSP	= sp * WIDTH_SP / maxsp	
	drawer:drawTexture("UIData/quest.tga", 98, 746, changedSP, 12, 272, 558)	-- ��ȭ�ϴ� sp
	drawer:drawTexture("UIData/quest.tga", 98, 746, currentSP, 12, 0, 558)		-- ���̴� sp
	--]]
end



----------------------------------------------------------------------

-- ���� �̼ǿ��� ������ & �޺�

----------------------------------------------------------------------
function WndChangeClass_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
							teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
	Common_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
				teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
end





----------------------------------------------------------------------

-- ������ ���

----------------------------------------------------------------------
-- ����Ŀ�� 2D �̹��� �� ��系��â
tWndChangeClassWinName	= {['err'] = 0, 'WndChangeClass_speakermanImage', 'WndChangeClass_speakermanMentImage'}
tWndChangeClassTexName	= {['err'] = 0, 'UIData/jobchange3.tga', 'UIData/tutorial001.tga'}
tWndChangeClassSizeX	= {['err'] = 0,  550,   1024}
tWndChangeClassSizeY	= {['err'] = 0,  706,   229 }
tWndChangeClassPosY		= {['err'] = 0,   62,   541 }
for i=1, #tWndChangeClassWinName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWndChangeClassWinName[i])
	mywindow:setTexture("Enabled", tWndChangeClassTexName[i], 0, 0)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setWideType(7);
	mywindow:setSize(tWndChangeClassSizeX[i],tWndChangeClassSizeY[i])
	mywindow:setPosition(0, tWndChangeClassPosY[i])
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
end

-- ����Ŀ�� ��系��(0:����, 1:������, 2:���н�)
tWndChangeClassBtnEvent = {["err"]=0, [0]="Click_StartChangeClassBattle", "Click_ClearChangeClassBattle", "Click_FailedChangeClassBattle"}
tWndChangeClass1stMent  = {["err"]=0, [0]=g_STRING_CHANGECLASS_3, g_STRING_CHANGECLASS_4, g_STRING_CHANGECLASS_5}

mywindow = winMgr:createWindow("TaharezLook/StaticText", 'WndChangeClass_1stMent')
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setPosition(240, 47)
mywindow:setSize(700, 153);
mywindow:setAlign(0)
mywindow:setViewTextMode(2)
mywindow:setLineSpacing(15)
mywindow:clearTextExtends()
mywindow:setVisible(false)
mywindow:setProperty("Disabled", "true")
winMgr:getWindow('WndChangeClass_speakermanMentImage'):addChildWindow(mywindow);
winMgr:getWindow('WndChangeClass_speakermanMentImage'):subscribeEvent('EndRender', 'RenderSpeakermanName')

-- ���� �̼� ���� ���۹�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Btn_StartChangeClassBattle")
mywindow:setTexture("Normal", "UIData/tutorial001.tga", 896, 379)
mywindow:setTexture("Hover", "UIData/tutorial001.tga", 896, 468)
mywindow:setTexture("Pushed", "UIData/tutorial001.tga", 896, 557)
mywindow:setTexture("PushedOff", "UIData/tutorial001.tga", 896, 379)
mywindow:setSize(118, 75)
mywindow:setWideType(7);
mywindow:setPosition(870, 680)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- ���۽� 1��° ��系��
function WndChangeClass_SpeakToCharacter(speakIndex)
	winMgr:getWindow('WndChangeClass_speakermanImage'):setVisible(true)
	winMgr:getWindow('WndChangeClass_speakermanMentImage'):setVisible(true)
	winMgr:getWindow('WndChangeClass_1stMent'):setVisible(true)
	CEGUI.toGUISheet(winMgr:getWindow('WndChangeClass_1stMent')):setTextViewDelayTime(11)
	
	winMgr:getWindow('WndChangeClass_1stMent'):clearTextExtends()
	winMgr:getWindow('WndChangeClass_1stMent'):addTextExtends(tWndChangeClass1stMent[speakIndex], g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   1, 0,0,0,255)
	
	-- ��ư �̺�Ʈ�� ��Ȳ�� �°� �����Ѵ�.
	winMgr:getWindow('Btn_StartChangeClassBattle'):subscribeEvent("Clicked", tWndChangeClassBtnEvent[speakIndex])
	
	-- ��ư�� ȣ��� �Լ��� ��Ͻ�Ų��(c���� �����̽� ������ �Լ��� ȣ���ϱ� ����)
	WndChangeClass_SetFunctionName(tWndChangeClassBtnEvent[speakIndex])
end


-- ������� ������
function RenderSpeakermanName(args)
	local _drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
	_drawer:setFont(g_STRING_FONT_DODUMCHE, 20)
	common_DrawOutlineText2(_drawer, g_STRING_RANDYHEART_NAME..' :', 90, 47, 0,0,0,255, 255,255,0,255)
	
	local isTalkComplete = CEGUI.toGUISheet(winMgr:getWindow('WndChangeClass_1stMent')):isCompleteViewText();
	if isTalkComplete then
		winMgr:getWindow('Btn_StartChangeClassBattle'):setVisible(true)
		
		g_deltaTime = g_deltaTime % 1000
		if g_deltaTime <= 500 then
			winMgr:getWindow('Btn_StartChangeClassBattle'):setTexture("Normal", "UIData/tutorial001.tga", 896, 379)
		else
			winMgr:getWindow('Btn_StartChangeClassBattle'):setTexture("Normal", "UIData/tutorial001.tga", 742, 379)
		end
	end
end


function WndChangeClass_SpeakToEndToCharacter()
	winMgr:getWindow('WndChangeClass_speakermanImage'):setVisible(false)
	winMgr:getWindow('WndChangeClass_speakermanMentImage'):setVisible(false)
	winMgr:getWindow('Btn_StartChangeClassBattle'):setVisible(false)
end



------------------------------------------

-- ��ư �̺�Ʈ

------------------------------------------
-- ó�� ���۽� NPC���� ��ȭ�� ��ư ������ ���
function Click_StartChangeClassBattle()
	WndChangeClass_SpeakToEndToCharacter()
	WndChangeClass_StartBattle(true)	-- �����̼� ��Ʋ����
end

-- ���� �̼��� �����ؼ� NPC���� ��ȭ�� ��ư ������ ���
function Click_ClearChangeClassBattle()
	WndChangeClass_ExitVillage()		-- �������� ������.
end

-- ���� �̼��� �����ؼ� NPC���� ��ȭ�� ��ư ������ ���
function Click_FailedChangeClassBattle()
	WndChangeClass_ExitVillage()		-- �������� ������.
end



----------------------------------------------------------

-- READY �׸���

----------------------------------------------------------
local g_readySound = true
local tReadyDelta = { ["protectErr"]=0, -410 }
local tFightDelta = { ["protectErr"]=0, 0, 255 }
function WndChangeClass_RenderBattleReady(deltaTime)
	tReadyDelta[1] = tReadyDelta[1] + deltaTime*3
	
	if tReadyDelta[1] >= 720 then
		drawer:drawTexture("UIData/GameNewImage.tga", 310, 200, 403, 89, 599, 406, WIDETYPE_5)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", -410+tReadyDelta[1], 200, 403, 89, 599, 406, WIDETYPE_5)
	end
	
	-- ���� ����
	if g_readySound then
		g_readySound = false
		PlaySound('sound/System/System_READY.wav')
	end
	
	tFightDelta[1] = 0
	tFightDelta[2] = 255
end






----------------------------------------------------------

-- FIGHT �׸���

----------------------------------------------------------
local g_fightSound = true
function WndChangeClass_RenderBattleFight(deltaTime)
	tFightDelta[1] = tFightDelta[1] + deltaTime
	if tFightDelta[1] >= 400 then
		
		tFightDelta[2] = tFightDelta[2] - deltaTime/2
		if tFightDelta[2] <= 0 then
			tFightDelta[2] = 0
		end
	end
	
	-- ����Ʈ ����
	if g_fightSound then
		g_fightSound = false
		PlaySound('sound/System/System_FIGHT.wav')
	end
	
	drawer:drawTextureA("UIData/GameNewImage.tga", 290, 201, 425, 88, 599, 317, tFightDelta[2], WIDETYPE_5)
	tReadyDelta[1] = -410
end






----------------------------------------------------------

-- ���� �̼� ���� ����Ʈ(Clear)

----------------------------------------------------------
local t_ClearScaleX = { ["err"]=0, [0]=255*10, 255*10, 255*10, 255*10, 255*10, 255*10 }
local t_ClearScaleY = { ["err"]=0, [0]=255*10, 255*10, 255*10, 255*10, 255*10, 255*10 }
local t_ClearAlpha  = { ["err"]=0, [0]=0, 0, 0, 0, 0, 0 }
local t_ClearAngle  = { ["err"]=0, [0]=0, 0, 0, 0, 0, 0 }
local t_ClearEffect = { ["err"]=0, [0]=0, -1, -1, -1, -1, -1 }
local t_ClearTexX	= { ["err"]=0, [0]=5, 102, 198, 292, 387, 480 }
--local t_ClearSizeX	= { ["err"]=0, [0]=87, 82, 86, 86, 88, 74 }
local t_ClearSizeX	= { ["err"]=0, [0]=97, 96, 94, 95, 93, 74 }
local t_ClearPosX	= { ["err"]=0, [0]=289, 385, 480, 574, 668, 761 }
local g_ClearSound  = true
local g_nextEffect  = false	-- ���� or ������ ���� ����
local g_accumTime = 0
function Effect_ChangeClassBattleClear(deltaTime)

	for i=0, #t_ClearEffect do
		if t_ClearEffect[i] == 0 then
			
			if g_ClearSound then
				PlaySound("sound/Dungeon/Dungeon_Clear.wav")
				PlaySound('sound/System/System_Clear.wav')
				g_ClearSound = false
			end
		
			-- ó���� ũ�� ���� �۾�����, ȸ���ϰ�, ���İ� �����Ѵ�.
			t_ClearScaleX[i] = t_ClearScaleX[i] - (deltaTime*5)
			if t_ClearScaleX[i] <= 255 then
				t_ClearScaleX[i] = 255
				t_ClearEffect[i] = 1
			else
				if t_ClearScaleX[i] <= 255*8 then
					if i < 5 then
						t_ClearEffect[i+1] = 0
					end
				end
			end
			
			t_ClearScaleY[i] = t_ClearScaleY[i] - (deltaTime*5)
			if t_ClearScaleY[i] <= 255 then
				t_ClearScaleY[i] = 255
			end
			
			t_ClearAlpha[i] = t_ClearAlpha[i] + (deltaTime/2)
			if t_ClearAlpha[i] >= 255 then
				t_ClearAlpha[i] = 255
			end
			
			t_ClearAngle[i] = t_ClearAngle[i] + (deltaTime*8)
			if t_ClearAngle[i] >= 4000 then
				t_ClearAngle[i] = 4000				
			end			
			
			drawer:drawTextureWithScale_Angle_Offset("UIData/dungeonmsg.tga", t_ClearPosX[i], 343, t_ClearSizeX[i], 83, t_ClearTexX[i], 99,
																t_ClearScaleX[i], t_ClearScaleY[i], t_ClearAlpha[i], t_ClearAngle[i], 8,261,249, WIDETYPE_6)
			
		elseif t_ClearEffect[i] == 1 then
		
			drawer:drawTextureWithScale_Angle_Offset("UIData/dungeonmsg.tga", t_ClearPosX[i], 343, t_ClearSizeX[i], 83, t_ClearTexX[i], 99,
																255, 255, 255, 0, 8,261,249, WIDETYPE_6)
		end
	end
	
	
	local allClear = true
	for i=0, #t_ClearEffect do
		if t_ClearEffect[i] == 0 then
			allClear = false
			return
		end
	end
	
	-- CLEAR ���ڰ� �� �����Ŀ� ����â�� ����ش�.
	if allClear then
		g_accumTime = g_accumTime + deltaTime
		if g_accumTime >= 1300 then
			g_nextEffect = true
			
			--0426KSG����
			-- �̱��� ����â ����
			--if IsEngLanguage() then
			--	Click_Close_RewardWindow()
			--else
			--	WndChangeClass_ShowLastReward(true)
			--end
			WndChangeClass_ShowLastReward(true)

		end
	end

end


-- ���� ������ �ð�� ����â���� �Ѿ��.
local tPresentPromotion = {['err']=0, [0]=g_CLASS_STREET, g_CLASS_TAEKWONDO, g_CLASS_BOXING, g_CLASS_CAPOERA, g_CLASS_MUAYTHAI,
										  g_CLASS_RUSH, g_CLASS_JUDO, g_CLASS_PROWRESTLING, g_CLASS_HAPGIDO, g_CLASS_SAMBO, g_CLASS_S_SUMO, g_CLASS_R_SUMO}
local tSpeakermanTexX = {['err']=0, [0]=0, 0, 144, 432, 288,		0, 144, 0, 288, 432, 720}
local tSpeakermanTexY = {['err']=0, [0]=0, 0, 0, 0, 0,				244, 244, 244, 244, 244, 244}
local tClassNameTexX  = {['err']=0, [0]=537, 537, 537, 537, 537,	748, 748, 748, 748, 748, 537}
local tClassNameTexY  = {['err']=0, [0]=616, 616, 651, 723, 687, 	616, 651, 616, 687, 723, 795}

function WndChangeClass_EventRewardItemToClear(szChangeClassName, wantClassIndex, itemKind1, szItemName1, szItemPath1, styleIndex1, promotionIndex1, 
					itemKind2, szItemName2, szItemPath2, styleIndex2, promotionIndex2, itemKind3, szItemName3, szItemPath3, styleIndex3, promotionIndex3)
	
	local tItemKind  = {["err"]=0, itemKind1, itemKind2, itemKind3}
	local tItemName  = {["err"]=0, szItemName1, szItemName2, szItemName3}
	local tPathName  = {["err"]=0, szItemPath1, szItemPath2, szItemPath3}
	local tClassIndex = {["err"]=0, styleIndex1, styleIndex2, styleIndex3}	
	local tPromotionIndex = {["err"]=0, promotionIndex1, promotionIndex2, promotionIndex3}	
	local tItemPromotion = {["err"]=0, 0, 0}
	local tItemStyle	 = {["err"]=0, 0, 0}
	
	-- ����â ���̱�
	winMgr:getWindow("RewardBackImage"):setVisible(true)
	winMgr:getWindow("RewardBackImage"):clearControllerEvent("EventMotion1")
	winMgr:getWindow("RewardBackImage"):addController("EventMotion", "EventMotion1", "alpha", "Sine_EaseIn", 0, 255, 3, true, false, 10)
	winMgr:getWindow("RewardBackImage"):activeMotion("EventMotion1")
	
	
	-- ���� �������� ����
	local speakerImageX = 0
	local speakerImageY = 0
	local classNameX = 0
	local classNameY = 0
	for i=0, #tPresentPromotion do
		if wantClassIndex == tPresentPromotion[i] then
			if tPresentPromotion[i] == 12 or tPresentPromotion[i] == 13 then
				speakerImageX = tSpeakermanTexX[10]
				speakerImageY = tSpeakermanTexY[10]
				
				classNameX = tClassNameTexX[10]
				classNameY = tClassNameTexY[10]
			else
				speakerImageX = tSpeakermanTexX[i]
				speakerImageY = tSpeakermanTexY[i]
				
				classNameX = tClassNameTexX[i]
				classNameY = tClassNameTexY[i]
			end
			break
		end
	end
	
	-- 1. ���� ����Ŀ�� �̹���
	winMgr:getWindow("RewardSpeakermanImage"):setTexture("Enabled", "UIData/jobchange4.tga", speakerImageX, speakerImageY)
	
	
	-- 2. ���� Ŭ���� �̸�
	winMgr:getWindow("RewardClassNameImage"):setTexture("Enabled", "UIData/jobchange4.tga", classNameX, classNameY)
	

	for i=1, 3 do	
		if tItemName[i] == "" then
			winMgr:getWindow("RewardItemBackImage"..i):setEnabled(false)
			winMgr:getWindow("GetRewardSkillItem"..i):setVisible(false)
			winMgr:getWindow("GetRewardClassIcon"..i):setVisible(false)
		else
			-- 3. ���� ������ �ع���
			winMgr:getWindow("RewardItemBackImage"..i):setEnabled(true)
			
			-- 4. ���� ������ �̹���, ������
			if tItemKind[i] == 0 then		-- �ڽ���
				winMgr:getWindow("GetRewardSkillItem"..i):setVisible(true)
				winMgr:getWindow("GetRewardSkillItem"..i):setTexture("Enabled", tPathName[i], 0, 0)
				winMgr:getWindow("GetRewardSkillItem"..i):setPosition(10, 0)
				winMgr:getWindow("GetRewardSkillItem"..i):setSize(110, 110)
				
				winMgr:getWindow("GetRewardClassIcon"..i):setVisible(false)
				
			elseif tItemKind[i] == 1 then	-- �⺻��ų
				winMgr:getWindow("GetRewardSkillItem"..i):setVisible(true)
				winMgr:getWindow("GetRewardSkillItem"..i):setTexture("Enabled", tPathName[i], 0, 0)
			
			elseif tItemKind[i] == 6 then	-- ��ų ��ȯ��
				winMgr:getWindow("GetRewardSkillItem"..i):setVisible(true)
				winMgr:getWindow("GetRewardSkillItem"..i):setTexture("Enabled", tPathName[i], 0, 0)
				winMgr:getWindow("GetRewardSkillItem"..i):setPosition(6, 6)
				winMgr:getWindow("GetRewardSkillItem"..i):setSize(116, 99)
				
				winMgr:getWindow("GetRewardClassIcon"..i):setVisible(false)
				
			elseif tItemKind[i] == 20 then	-- ������
				winMgr:getWindow("GetRewardSkillItem"..i):setVisible(true)
				winMgr:getWindow("GetRewardSkillItem"..i):setPosition(14, 10)
				winMgr:getWindow("GetRewardSkillItem"..i):setTexture("Enabled", tPathName[i], 0, 0)
				
			elseif tItemKind[i] == 56 then	-- ������
				winMgr:getWindow("GetRewardSkillItem"..i):setVisible(true)
				winMgr:getWindow("GetRewardSkillItem"..i):setPosition(14, 10)
				winMgr:getWindow("GetRewardSkillItem"..i):setTexture("Enabled", tPathName[i], 0, 0)
				
			elseif tItemKind[i] == 63 then	-- ������
				winMgr:getWindow("GetRewardSkillItem"..i):setVisible(true)
				winMgr:getWindow("GetRewardSkillItem"..i):setPosition(14, 10)
				winMgr:getWindow("GetRewardSkillItem"..i):setTexture("Enabled", tPathName[i], 0, 0)
				
			else
				winMgr:getWindow("GetRewardSkillItem"..i):setVisible(true)
				winMgr:getWindow("GetRewardSkillItem"..i):setPosition(14, 10)
				winMgr:getWindow("GetRewardSkillItem"..i):setTexture("Enabled", tPathName[i], 0, 0)
			end
			
			if tItemKind[i] == 1 then
				-- 5. Ŭ���� ������ ���̱�
				winMgr:getWindow("GetRewardClassIcon"..i):setVisible(true)
				winMgr:getWindow("GetRewardClassIcon"..i):setTexture("Enabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[tClassIndex[i]][0], tAttributeImgTexYTable[tClassIndex[i]][0])
				winMgr:getWindow("GetRewardClassIcon"..i):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[tClassIndex[i]], promotionImgTexYTable[tPromotionIndex[i]])
			else
				winMgr:getWindow("GetRewardClassIcon"..i):setVisible(false)
			end
				
			if tItemKind[i] ~= 6 then
				-- 6. ���� ������ �̸�
				if tItemKind[i] == 63 then	-- ������
					winMgr:getWindow("RewardItemName"..i):clearTextExtends()
					
					local nameSize = GetStringSize(g_STRING_FONT_DODUMCHE, 10, tItemName[i])
					
					if nameSize > 17 then
						local itemname = SummaryString(g_STRING_FONT_DODUMCHE, 10, tItemName[i], 60)
						winMgr:getWindow("RewardItemName"..i):addTextExtends(itemname, g_STRING_FONT_DODUMCHE,10, 255,255,255,255, 0, 255,255,255,255)
					else
						winMgr:getWindow("RewardItemName"..i):addTextExtends(tItemName[i], g_STRING_FONT_DODUMCHE,10, 255,255,255,255, 0, 255,255,255,255)
					end
				else
					winMgr:getWindow("RewardItemName"..i):clearTextExtends()
					
					local nameSize = GetStringSize(g_STRING_FONT_DODUMCHE, 12, tItemName[i])
					
					if nameSize > 17 then
						local itemname = SummaryString(g_STRING_FONT_DODUMCHE, 12, tItemName[i], 60)
						winMgr:getWindow("RewardItemName"..i):addTextExtends(itemname, g_STRING_FONT_DODUMCHE,12, 255,255,255,255, 0, 255,255,255,255)
					else
						winMgr:getWindow("RewardItemName"..i):addTextExtends(tItemName[i], g_STRING_FONT_DODUMCHE,12, 255,255,255,255, 0, 255,255,255,255)
					end
				end
			end
		end	
	end
	
end




----------------------------------------------------------

-- ���� �̼� ���� ����Ʈ(Failed)

----------------------------------------------------------
local g_failedTime	= 0
local g_failedPos	= 0
local g_failedSound = true
function Effect_ChangeClassBattleFailed(deltaTime)
	g_failedTime = g_failedTime + deltaTime
	local alpha = g_failedTime/3
	if alpha >= 120 then
		alpha = 120
	end
	drawer:drawTextureA("UIData/OnDLGBackImage.tga", 0, 0, 1920, 1200, 0, 0, alpha)
	
	if 0 <= g_failedTime and g_failedTime <= 1500 then
		if g_failedSound then
			PlaySound("sound/Dungeon/Dungeon_Failed.wav")
			PlaySound("sound/System/System_Fail.wav")
			g_failedSound = false
		end
		g_failedPos = Effect_Bounce_EaseOut(g_failedTime, -300, 600, 1500)
	else
		-- ���� �ð��� ������ �絵�� �Ͻðڽ��ϱ�?
		g_nextEffect = true
		winMgr:getWindow("TryingAgainWindow"):setVisible(true)
	end	
	drawer:drawTexture("UIData/dungeonmsg.tga", 280, g_failedPos, 487, 83, 5, 202, WIDETYPE_6)
end




-------------------------------------------

-- ���� �̼� ����� ���� UI�� �����ش�.

-------------------------------------------
function WndChangeClass_BattleResult(deltaTime, battleResult)

	-- �������� ���
	if battleResult == 1 then
		if g_nextEffect == false then
			Effect_ChangeClassBattleClear(deltaTime)
		end
		
	-- �������� ���
	elseif battleResult == 2 then
		if g_nextEffect then
			WndChangeClass_TryingAgain(deltaTime)
		else
			Effect_ChangeClassBattleFailed(deltaTime)
		end
	end
end


--------------------------------------------------------------------

-- �̺�Ʈ �����˾�

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardBackImage")
mywindow:setTexture("Enabled", "UIData/jobchange4.tga", 0, 488)
mywindow:setTexture("Disabled", "UIData/jobchange4.tga", 0, 488)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(244, 216)
mywindow:setSize(537, 336)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- ���� ����Ŀ�� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardSpeakermanImage")
mywindow:setTexture("Enabled", "UIData/jobchange4.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/jobchange4.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 90)
mywindow:setSize(144, 244)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RewardBackImage"):addChildWindow(mywindow)


-- ���� Ŭ���� �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardClassNameImage")
mywindow:setTexture("Enabled", "UIData/jobchange4.tga", 537, 616)
mywindow:setTexture("Disabled", "UIData/jobchange4.tga", 537, 616)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(120, 33)
mywindow:setSize(210, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RewardBackImage"):addChildWindow(mywindow)


-----------------------------------------
-- �ִ� 3������ ������ �޴´�.
-----------------------------------------
local tRewardBackPosX = {['err']=0, 130, 262, 394}
for i=1, 3 do

	-- ���� �ع��� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemBackImage"..i)
	mywindow:setTexture("Enabled", "UIData/jobchange4.tga", 537, 488)
	mywindow:setTexture("Disabled", "UIData/jobchange4.tga", 665, 488)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(tRewardBackPosX[i], 116)
	mywindow:setSize(128, 128)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RewardBackImage"):addChildWindow(mywindow)
	
	-- ���� �޴� ������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GetRewardSkillItem"..i)
	mywindow:setTexture("Enabled", "UIData/jobchange4.tga", 0, 652)
	mywindow:setTexture("Disabled", "UIData/jobchange4.tga", 0, 652)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(105, 98)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RewardItemBackImage"..i):addChildWindow(mywindow)

	-- ���� �޴� Ŭ���� ������	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GetRewardClassIcon"..i)
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(44, 60)
	mywindow:setSize(89, 35)
	mywindow:setLayered(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("GetRewardSkillItem"..i):addChildWindow(mywindow)
	
	-- ������ �̸�
	mywindow = winMgr:createWindow('TaharezLook/StaticText', "RewardItemName"..i);
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(0, 110)
	mywindow:setSize(128, 30)
	mywindow:setZOrderingEnabled(true)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:clearTextExtends()
	winMgr:getWindow("RewardItemBackImage"..i):addChildWindow(mywindow)
	
end


-- ���� �˾�â �ݱ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "CloseBtn_RewardWindow");
mywindow:setTexture("Normal", "UIData/jobchange4.tga", 794, 488);
mywindow:setTexture("Hover", "UIData/jobchange4.tga", 829, 488);
mywindow:setTexture("Pushed", "UIData/jobchange4.tga", 864, 488);
mywindow:setTexture("PushedOff", "UIData/jobchange4.tga", 794, 488);
mywindow:setPosition(497, 33)
mywindow:setSize(35, 35)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "Click_Close_RewardWindow");
winMgr:getWindow("RewardBackImage"):addChildWindow(mywindow)


function Click_Close_RewardWindow()
	local CLEAR = 1
	WndChangeClass_SpeakToCharacter(CLEAR)
	winMgr:getWindow("RewardBackImage"):setVisible(false)
	WndChangeClass_InitCharacterPosition()
end




----------------------------------------------------

-- ���� �̼� ������ �絵��?

----------------------------------------------------
quitwindow = winMgr:createWindow("TaharezLook/StaticImage", "TryingAgainWindow")
quitwindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 0, 509)
quitwindow:setTexture("Disabled", "UIData/dungeonmsg.tga", 0, 509)
quitwindow:setProperty("FrameEnabled", "False")
quitwindow:setProperty("BackgroundEnabled", "False")
quitwindow:setWideType(6);
quitwindow:setPosition(0, 300)
quitwindow:setSize(1024, 157)
quitwindow:setAlpha(0)
quitwindow:setZOrderingEnabled(true)
quitwindow:setVisible(false)
root:addChildWindow(quitwindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TryingAgain_textImage")
mywindow:setTexture("Enabled", "UIData/quest.tga", 0, 760)
mywindow:setTexture("Disabled", "UIData/quest.tga", 0, 760)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(350, 18)
mywindow:setSize(335, 42)
mywindow:setAlpha(0)
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "OkBtn_TryingAgain")
mywindow:setTexture("Normal", "UIData/quest.tga", 644, 564)
mywindow:setTexture("Hover", "UIData/quest.tga", 439, 760)
mywindow:setTexture("Pushed", "UIData/quest.tga", 439, 825)
mywindow:setTexture("PushedOff", "UIData/quest.tga", 644, 564)
mywindow:setPosition(340, 80)
mywindow:setSize(153, 65)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "Click_OK_TryingAgain")
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "CancelBtn_TryingAgain")
mywindow:setTexture("Normal", "UIData/quest.tga", 842, 564)
mywindow:setTexture("Hover", "UIData/quest.tga", 439, 890)
mywindow:setTexture("Pushed", "UIData/quest.tga", 439, 955)
mywindow:setTexture("PushedOff", "UIData/quest.tga", 842, 564)
mywindow:setPosition(538, 80)
mywindow:setSize(153, 65)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "Click_CANCEL_TryingAgain")
quitwindow:addChildWindow(mywindow)


-- ����� ����Ͽ� ���ķ� ��Ÿ���� ��� ��ư �̹������� ������ ���� �̹����� �׸��� �ʴ´�;;
local g_tryingAgainAlpha = 0
function WndChangeClass_TryingAgain(deltaTime)
		
	g_tryingAgainAlpha = g_tryingAgainAlpha + deltaTime
	if g_tryingAgainAlpha >= 255 then
		g_tryingAgainAlpha = 255		
	end
	
	winMgr:getWindow("TryingAgainWindow"):setAlpha(g_tryingAgainAlpha)
	winMgr:getWindow("TryingAgain_textImage"):setAlpha(g_tryingAgainAlpha)
	winMgr:getWindow("OkBtn_TryingAgain"):setAlpha(g_tryingAgainAlpha)
	winMgr:getWindow("CancelBtn_TryingAgain"):setAlpha(g_tryingAgainAlpha)
end


-- ������ �絵�� OK�� �������
function Click_OK_TryingAgain()
	winMgr:getWindow('TryingAgainWindow'):setVisible(false)
	WndChangeClass_TryingAgainMisstion()
end

-- ������ �絵�� CANCEL�� �������
function Click_CANCEL_TryingAgain()
	local FAILED = 2
	WndChangeClass_SpeakToCharacter(FAILED)
	winMgr:getWindow("TryingAgainWindow"):setVisible(false)
	WndChangeClass_InitCharacterPosition()
end



----------------------------------------------------------------------

-- ESC �����̼� ����â

----------------------------------------------------------------------
function WndChangeClass_ABandonToChangeClass(bAbandon)
	if bAbandon == 1 then
		ShowCommonAlertOkCancelBoxWithFunction("", g_STRING_CHANGECLASS_6, "OK_ExitVillage", "CANCEL_ExitToVillage")
	else
		CANCEL_ExitToVillage()
	end
end


RegistEscEventInfo("CommonAlertAlphaImg", "CANCEL_ExitToVillage")
RegistEnterEventInfo("CommonAlertAlphaImg", "OK_ExitVillage")


-- �������� ������ OK
function OK_ExitVillage()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OK_ExitVillage" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	WndChangeClass_ExitVillage()
end

-- �������� ������ CANCEL
function CANCEL_ExitToVillage()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "CANCEL_ExitToVillage" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
end





