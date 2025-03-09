
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

local NPC_FUNCTION_COMMUNICATION	= 0	-- ��ȭ�ϱ�
local NPC_FUNCTION_STORE			= 1	-- ����
local NPC_FUNCTION_PARTY			= 2	-- ��Ƽ
local NPC_FUNCTION_CHALLENGEMISSION	= 3 -- ç�����̼�
local NPC_FUNCTION_SLOT_MACHINE		= 4	-- ORB ���Ըӽ�
local NPC_FUNCTION_COSTUME_CRAFTING	= 5	-- �ڽ�Ƭ ����
local NPC_FUNCTION_CHANGE_CLASS		= 6 -- ����
local NPC_FUNCTION_CLUB				= 7	-- Ŭ�� ���Ǿ�
local NPC_FUNCTION_RANK				= 8	-- ��ŷ
local NPC_FUNCTION_ARCADE_PORTAL	= 9	-- �����̵�
local NPC_FUNCTION_FIGHT_PORTAL		= 10-- ����
local NPC_FUNCTION_TRAINING_PORTAL	= 11-- ������
local NPC_FUNCTION_CLUB_WAR			= 12-- ������
local NPC_FUNCTION_STORAGE			= 13-- ������
local NPC_FUNCTION_COSTUME_UPGRADE		= 14-- �ڽ�Ƭ ���׷��̵�
local NPC_FUNCTION_RESOLVE				= 15-- ����
local NPC_FUNCTION_CHARACTER_ATTRIBUTE	= 16-- ĳ���ͼӼ��ο�
local NPC_FUNCTION_SKILL_ATTRIBUTE		= 17-- ��ų�Ӽ��ο�
local NPC_FUNCTION_PROPOSE_FRIEND		= 18
local NPC_FUNCTION_QUEST				= 19
local NPC_FUNCTION_MAIL					= 20
local NPC_FUNCTION_SKILL_UPGRADE		= 21
local NPC_FUNCTION_TOUR_REQUEST			= 22
local NPC_FUNCTION_ORB_UPGRADE		    = 23
local NPC_FUNCTION_ORB_EQUIP			= 24
local NPC_FUNCTION_MAKE_COSTUME_AVATAR	= 25
local NPC_FUNCTION_CHECK_EVENT			= 26
local NPC_FUNCTION_DECO_CHANGE			= 27
local NPC_FUNCTION_RPSGAME				= 28
local NPC_FUNCTION_DICEPLAY				= 29
local NPC_FUNCTION_GEUPGRADE			= 30

local NPC_FUNCTION_MAX					= 31-- �ƽ� 


bTownNpcMode = false


-- ���忣�Ǿ��� ���� �̹����� �������� ����� ���� �̹���.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownNPC_VirtualImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
mywindow:setPosition(0,0)
mywindow:setSize(1,1)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-----------------------------------------
-- NPC Ŭ���� ó�� �˾�
-----------------------------------------
-- ����
-----------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownNPC_ServiceListBack")
mywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 281, 72)
mywindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 281, 72)
mywindow:setPosition(70, 70)
mywindow:setSize(264, 316)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- NPC �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TownNPC_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(235, 5)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "TownNpcEscBtnClickEvent")
winMgr:getWindow("TownNPC_ServiceListBack"):addChildWindow(mywindow)

--RegistEscEventInfo("TownNPC_ServiceListBack", "CloseNPCServiceListWindow")

-- ������ �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownNPC_ServiceTitle")
mywindow:setPosition(0, 9)
mywindow:setSize(264, 18)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownNPC_ServiceListBack"):addChildWindow(mywindow)

-- ��ȭ�ϱ�, ����, ��Ƽ, ç�����̼�, ���Ըӽ�, �ڽ�Ƭ ����, ����
local tButtonTypeNameTable = {['err']=0, [0]="Button_Type_Communication", "Button_Type_Shop", "Button_Type_Party", "Button_Type_ChallengeMission"
									, "Button_Type_SlotMachine", "Button_Type_Costume_Crafting", "Button_Type_ChangeClass"
									, "Button_Type_Club", "Button_Type_Rank", "Button_Type_Arcade", "Button_Type_Fight", "Button_Type_Training"
									, "Button_Type_ClubWar", "Button_Type_Storage", "Button_Type_CostumeUpgrade"
									, "Button_Type_Resolve", "Button_Type_CharacterAttribute", "Button_Type_SkillAttribute"
									, "Button_Type_Propose_Friend", "Button_Type_Quest", "Button_Type_Mail", "Button_Type_Skill_Upgrade", "Button_Type_Team_Tour"
									, "Button_Type_Upgrade_Orb", "Button_Type_Equip_Orb" 
									, "Button_Type_Make_Costume_Avatar"
									, "Button_Type_Check_Event"
									, "Button_Type_DecoChange" 
									, "Button_Type_RPSgame", "Button_Type_Diceplay"
									, "Button_Type_GEUpgrade" }
									
local tButtonNameTable = {['err']=0, [0] = PreCreateString_2385, PreCreateString_2386, PreCreateString_2387
									, PreCreateString_2388, PreCreateString_2389, PreCreateString_2390, PreCreateString_1041
									, PreCreateString_1730, PreCreateString_1041, PreCreateString_1041, PreCreateString_1041, PreCreateString_1041
									, PreCreateString_2458, PreCreateString_2637, PreCreateString_2672
									, PreCreateString_2671, PreCreateString_2740, PreCreateString_2741
									, PreCreateString_2723, PreCreateString_2853, PreCreateString_3017, PreCreateString_3416, PreCreateString_3514
									, PreCreateString_3538, PreCreateString_3539 
									, PreCreateString_3568 
									, PreCreateString_3598 
									, PreCreateString_4339 
									, PreCreateString_4491, PreCreateString_4518
									, PreCreateString_4601}
									
--local tButtonTypeEventTable = {['err']=0, [0] = "ShowTownNpcTelling", "OpenArcadeShop", "ShowPartyWindow", "", "", "", ""}

local npcFunctionExtension = require("TownNPCFunctionExtension")

for i=0, #tButtonTypeNameTable do
	-- ��ư
	mywindow = winMgr:createWindow("TaharezLook/Button", tButtonTypeNameTable[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", 281, 388)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", 281, 388)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 281, 388)
	mywindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 281, 388)
	mywindow:setPosition(6,35)
	mywindow:setSize(252, 23)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", tostring(i))
	mywindow:subscribeEvent("MouseButtonDown", "Button_Type_MouseDown")
	mywindow:subscribeEvent("MouseButtonUp", "Button_Type_MouseUp")
	mywindow:subscribeEvent("MouseLeave", "Button_Type_MouseLeave")
	mywindow:subscribeEvent("MouseEnter", "Button_Type_MouseEnter")
	mywindow:subscribeEvent("Clicked", "Button_Type_ClickEvent")--tButtonTypeEventTable[i])
	winMgr:getWindow("TownNPC_ServiceListBack"):addChildWindow(mywindow)	
	
	-- �ؽ�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tButtonTypeNameTable[i].."_Text")
	mywindow:setFont(g_STRING_FONT_DODUM, 13)
	mywindow:setTextColor(255,198,30, 255)
	mywindow:setText("asdsdad")
	mywindow:setPosition(4, 4)
	mywindow:setSize(207, 16)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tButtonTypeNameTable[i]):addChildWindow(mywindow)

end

npcFunctionExtension.Init()

-- ���Ǿ� ���� ����� �����ش�.
function ShowNPCServiceListWindow(nickName)
	winMgr:getWindow("TownNPC_ServiceListBack"):setVisible(true)
	if nickName ~= "" then
		winMgr:getWindow("TownNPC_ServiceTitle"):setTextExtends(nickName, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
	end
	
end


-- ���Ǿ� ���� ����� �ݾ��ش�.
function CloseNPCServiceListWindow()
	winMgr:getWindow("TownNPC_ServiceListBack"):setVisible(false)
end


-- �����츦 �����ش�.
function HideButtonToType()
	for i=0, #tButtonTypeNameTable do
		winMgr:getWindow(tButtonTypeNameTable[i]):setVisible(false)
	end
	FadeInStart(510)
	npcFunctionExtension.HideButtons()
end

-- ���Ǿ������� �ٸ� ��ġ�� �����츦 ����ش�.
function SettingButtonToType(Index, NpcButtonIndex,NpcIndex)

	winMgr:getWindow(tButtonTypeNameTable[NpcButtonIndex].."_Text"):setText(tButtonNameTable[NpcButtonIndex])
	winMgr:getWindow(tButtonTypeNameTable[NpcButtonIndex]):setVisible(true)
	winMgr:getWindow(tButtonTypeNameTable[NpcButtonIndex]):setPosition(6, 35+Index*23)

	npcFunctionExtension.OnPlayerTalk(Index,NpcIndex)
end                                                                                                                                                                                                     


local bTextMouseClickEvent = false
-- ���콺 ��ư �ٿ��̺�Ʈ
function Button_Type_MouseDown(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	local winName = eventWindow:getName()
	local pos = winMgr:getWindow(winName.."_Text"):getPosition()
	winMgr:getWindow(winName.."_Text"):setPosition(pos.x.offset + 2, pos.y.offset + 2)
	bTextEvent = true
end

-- ���콺 ��ư ���̺�Ʈ
function Button_Type_MouseUp(args)
	if bTextEvent then
		local eventWindow = CEGUI.toWindowEventArgs(args).window
		local winName = eventWindow:getName()
		local pos = winMgr:getWindow(winName.."_Text"):getPosition()
		winMgr:getWindow(winName.."_Text"):setPosition(pos.x.offset - 2, pos.y.offset - 2)
		bTextEvent = false
	end
end


local bTextMouseMoveEvent = false
-- ���콺 ��ư �������̺�Ʈ
function Button_Type_MouseLeave(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	local winName = eventWindow:getName()
	local pos = winMgr:getWindow(winName.."_Text"):getPosition()
	winMgr:getWindow(winName.."_Text"):setTextColor(255,198,30, 255)
	bTextMouseMoveEvent = true
end

-- ���콺 ��ư ���� �̺�Ʈ
function Button_Type_MouseEnter(args)
	if bTextMouseMoveEvent then
		local eventWindow = CEGUI.toWindowEventArgs(args).window
		local winName = eventWindow:getName()
		local pos = winMgr:getWindow(winName.."_Text"):getPosition()
		winMgr:getWindow(winName.."_Text"):setTextColor(255, 255, 255, 255)
		bTextEvent = false
	end
end


-- ��ư Ŭ�������� �̺�Ʈ ��
function Button_Type_ClickEvent(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	local Index = tonumber(eventWindow:getUserString("Index"))
	
	-- ��ưŬ���� �ε����� ���̿� �ִٸ�
	if NPC_FUNCTION_COMMUNICATION <= Index and Index < NPC_FUNCTION_MAX then
		VirtualImageSetVisible(true)	-- ���� �̹����� ����ش�.
	end
	
	if Index == NPC_FUNCTION_COMMUNICATION then				-- ��ȭ
		ShowTownNpcTelling()
	elseif Index == NPC_FUNCTION_STORE then					-- ����
		CloseSetVisualWindow() -- ����� ����â�� �ݴ´١�
		ShowTownStore()
	elseif Index == NPC_FUNCTION_PARTY then					-- ��Ƽ
		ShowPartyWindow()
	elseif Index == NPC_FUNCTION_CHALLENGEMISSION then		-- ç�����̼�
		ShowChallengeMission(true)
	elseif Index == NPC_FUNCTION_SLOT_MACHINE then			-- ORB ���Ըӽ�
		ShowOrbSlotMachine()
		ClickObject_ORBSLOT(true)
	elseif Index == NPC_FUNCTION_COSTUME_CRAFTING then		-- �ڽ�Ƭ ����
		--ShowNotifyOKMessage_Lua(PreCreateString_1273)
		--CloseTownNpcTelling()
		--return
		CloseSetVisualWindow() -- ����� ����â�� �ݴ´١�
		ShowItemCrafting()
	elseif Index == NPC_FUNCTION_CHANGE_CLASS then			-- ����
		ShowMissionInfo()
	elseif Index == NPC_FUNCTION_CLUB then					-- Ŭ��
		IsQualifiedCreateClub()
	elseif Index == NPC_FUNCTION_RANK then					-- ��ŷ
	
	elseif Index == NPC_FUNCTION_ARCADE_PORTAL then			-- �����̵� ��Ż
	
	elseif Index == NPC_FUNCTION_FIGHT_PORTAL then			-- ������Ż
	
	elseif Index == NPC_FUNCTION_TRAINING_PORTAL then		-- ������ ��Ż
	
	elseif Index == NPC_FUNCTION_CLUB_WAR then				-- ������
		OnClickShowNpcUiBtn()
	elseif Index == NPC_FUNCTION_STORAGE then				-- ������
		CloseSetVisualWindow() -- ����� ����â�� �ݴ´�
		ShowMyStorage()
	elseif Index == NPC_FUNCTION_COSTUME_UPGRADE then		-- �ڽ�Ƭ ���׷��̵�
		ShowItemUpgradeWindow()
	elseif Index == NPC_FUNCTION_RESOLVE then				-- ����
		CloseSetVisualWindow() -- ����� ����â�� �ݴ´�
		RequestResolveItemList()
	elseif Index == NPC_FUNCTION_CHARACTER_ATTRIBUTE then	-- ĳ���ͼӼ��ο�
		ShowCharacterAttributeWindow()
	elseif Index == NPC_FUNCTION_SKILL_ATTRIBUTE then		-- ��ų�Ӽ��ο�
		ShowSkillAttributeWindow()
	elseif Index == NPC_FUNCTION_PROPOSE_FRIEND then		-- ģ����õ �̺�Ʈ
		ShowRecommendFriendSendWindow()
	elseif Index == NPC_FUNCTION_QUEST then
		ShowMyQuestSelectList()
	elseif Index == NPC_FUNCTION_MAIL then
		ShowMail()
	elseif Index == NPC_FUNCTION_SKILL_UPGRADE then
		ShowNotifyOKMessage_Lua("Please use [My Room]")
		CloseTownNpcTelling()
		return
	elseif Index == NPC_FUNCTION_TOUR_REQUEST then
		ShowTeamChampionshipNotice()
		GetChampionshipProgressState()
		--RequestChampionshipInfo()						   -- ��ȸ ���� ��û
	elseif Index == NPC_FUNCTION_ORB_UPGRADE then
		SettingCommonUpgradeItemListEnable(24)
		ShowOrbUpgradeEvent()					           -- ORB ���׷��̵�
	elseif Index == NPC_FUNCTION_ORB_EQUIP then
		SettingCommonUpgradeItemListEnable(24)
		ShowOrbEquipEvent()								   -- ORB ����
	elseif Index == NPC_FUNCTION_MAKE_COSTUME_AVATAR then  -- �ڽ�Ƭ �ƹ�Ÿ ������
		CloseSetVisualWindow() -- ����� ����â�� �ݴ´�
		UseCreateCloneAvatarItem()
	elseif Index == NPC_FUNCTION_CHECK_EVENT then		   -- (�Ϲ�) �̺�Ʈ ��÷ üũ?
		DebugStr("����Ŀ�� : �̺�Ʈ ��÷ Ȯ��")
	elseif Index == NPC_FUNCTION_DECO_CHANGE then
		DecoChageSystemStart()
	elseif Index == NPC_FUNCTION_RPSGAME then
		RPSgame_SetVisible(true)
	elseif Index == NPC_FUNCTION_DICEPLAY then
		Diceplay_SetVisible(true)
	elseif Index == NPC_FUNCTION_GEUPGRADE then
		ShowGEUpgrade()
	else
		return
	end

	CloseNPCServiceListWindow()	-- ���Ǿ� ���� ��� �����츦 �ݾ��ش�.
	SelectedNpcFunction(Index)	-- �ε��� ����
	-- npcFunctionExtension.OnPlayerClicked(Index)
--	ResetTownNPCTalkButton()		-- NPC�� ������ ����鿡 ���� ��ư �ʱ�ȭ
--	m_selectedType
end


function NPC_ModeEvent()
	g_CurrentCameraMagState = true
	bTownNpcMode = true
	ShowMiniMap(0)
	Offcontroller()			-- �Ʒ��� ��ư ��Ʈ�ѷ� off
	CloseHelpButton()
	winMgr:getWindow('doChatting'):setVisible(false)		-- ��ȭâ false
end


function NPC_EscModeEvent()
	g_CurrentCameraMagState = false
	bTownNpcMode = false
	ShowMiniMap(1)
	Oncontroller()			-- �Ʒ��� ��ư ��Ʈ�ѷ� off
	--ShowHelp()
	
--	Util_SettingWinAlpha(tAlphaSettingWinName, 0);
	ShowChatViewVisible(false);
	winMgr:getWindow('multichat_list_1'):setVisible(true)
	winMgr:getWindow('doChatting'):setText("");
	if winMgr:getWindow('doChatting'):isVisible() then
		winMgr:getWindow('doChatting'):activate()
	end	
	Chatting_SelectTab( CHATTYPE_ALL )
	MailBallonSearch()
end

-- ���Ǿ� ������� üũ�Ѵ�.
function CheckNpcModeforLua()
	return bTownNpcMode
end

--[[


NPC_TYPE_NORMAL		= 0,	// �׳� ���忡 ��ġ�Ǿ��ִ� npc
	NPC_TYPE_ABILITY	= 1,	// ����� �ִ� npc
	NPC_TYPE_EXPLAIN	= 2,	// �����ϴ� ������ִ� npc
	NPC_TYPE_ANIMATION	= 4,	// �ִϸ��̼��� �ִ� npc
	NPC_TYPE_SOUND		= 8,	// ����(������ ��������)�� �ִ� npc
	NPC_TYPE_STORE		= 16,	// ������ �����Ǿ��ִ� npc
	NPC_TYPE_MOVING		= 32,	// �̵��ϴ� npc
	NPC_TYPE_OBJECT		= 64	// ������Ʈ

local NPC_CHALLANGE_MISSION	= 0
local NPC_PARTY1			= 1
local NPC_PARTY2			= 2
local NPC_CLUB				= 3
local NPC_CHANGE_JOB		= 4
local NPC_MERCHANT			= 5
local NPC_CLUB2				= 6 -- ������ �ӽ�
local NPC_COSTUME_CRAFTING	= 7 -- �ڽ�Ƭ ���� ���Ǿ�




--]]





-----------------------------------------
-- NPC ��ȭ ����
-----------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownNPC_TellingBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(7);
mywindow:setPosition(0, 501)
mywindow:setSize(1024, 267)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("TownNPC_TellingBack", "CloseTownNpcTelling")

---------------------------------------------------------
-- NPC ��ȭ �̹���.
---------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownNPC_TellingImage")
mywindow:setTexture("Enabled", "UIData/tutorial001.tga", 0, 2)
mywindow:setTexture("Disabled", "UIData/tutorial001.tga", 0, 2)
mywindow:setPosition(0, 43)
mywindow:setSize(1024, 224)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownNPC_TellingBack"):addChildWindow(mywindow)


-- npc ��ȭ �ؽ�Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownNPC_TellingText")
--mywindow:setTexture("Enabled", "UIData/nm0.tga", 0, 2)
mywindow:setPosition(245, 45)
mywindow:setSize(700, 153)
mywindow:setViewTextMode(2)
mywindow:setLineSpacing(7)
mywindow:setVisible(true);
winMgr:getWindow('TownNPC_TellingImage'):addChildWindow(mywindow);


---------------------------------------------------------
-- NPC ��ȭ �̸� �̹���.
---------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownNPC_TellingNameImage")
mywindow:setTexture("Enabled", "UIData/tutorial001.tga", 587, 336)
mywindow:setTexture("Disabled", "UIData/tutorial001.tga", 587, 336)
mywindow:setPosition(0, -8)
mywindow:setSize(273, 43)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownNPC_TellingImage"):addChildWindow(mywindow)


-- NPC ��ȭ �̸� �ؽ�Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownNPC_TellingNameText")
mywindow:setPosition(50, 12)
mywindow:setSize(400, 30)
mywindow:setAlign(0)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setVisible(true)
winMgr:getWindow('TownNPC_TellingNameImage'):addChildWindow(mywindow);

-- �׳� �����ִ� �̹���.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownNPC_Tellingdeco")
mywindow:setTexture("Disabled", "UIData/tutorial001.tga", 587, 458)
mywindow:setPosition(0, 35)
mywindow:setSize(183, 8)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownNPC_TellingImage"):addChildWindow(mywindow)


----------------------------------------------------------------------
-- NPC ��ȭ���� ��ư
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CommunicateClose")

mywindow:setTexture("Normal", "UIData/Arcade_lobby.tga", 421, 308)
mywindow:setTexture("Hover", "UIData/Arcade_lobby.tga", 421, 360)
mywindow:setTexture("Pushed", "UIData/Arcade_lobby.tga", 421, 410)
mywindow:setTexture("PushedOff", "UIData/Arcade_lobby.tga", 421, 308)

mywindow:setPosition(905, 200)
mywindow:setSize(103, 49)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "ClickCloseTownNpcTelling")
winMgr:getWindow("TownNPC_TellingBack"):addChildWindow(mywindow)




---------------------------------------------------------
-- NPC��ȭ�� ���� ������ư
---------------------------------------------------------
local MAX_TALKBUTTON = 6
for i = 0, MAX_TALKBUTTON-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "TownNPC_TalkButton"..i)
	mywindow:setTexture("Normal", "UIData/tutorial001.tga", 587, 467)
	mywindow:setTexture("Hover", "UIData/tutorial001.tga", 587, 495)
	mywindow:setTexture("Pushed", "UIData/tutorial001.tga", 587, 523)
	mywindow:setTexture("SelectedNormal", "UIData/tutorial001.tga", 587, 551)
	mywindow:setTexture("SelectedHover", "UIData/tutorial001.tga", 587, 551)
	mywindow:setTexture("SelectedPushed", "UIData/tutorial001.tga", 587, 551)	
	mywindow:setProperty("GroupID", 3250)
	mywindow:setSize(204, 27)
	mywindow:setPosition(15, 43 + (i * 35))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("SelectStateChanged", "TownNPC_TalkingButtonEvent")
	winMgr:getWindow("TownNPC_TellingImage"):addChildWindow(mywindow)
	
	-- �׳� �����ִ� �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownNPC_Tellingdeco"..i)
	mywindow:setTexture("Disabled", "UIData/tutorial001.tga", 587, 458)
	mywindow:setPosition(15, 70 + (i * 35))
	mywindow:setSize(183, 8)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownNPC_TellingImage"):addChildWindow(mywindow)
	
	-- NPC ��ȭ �̸� �ؽ�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownNPC_TalkButtonText"..i)
	mywindow:setPosition(12, 7)
	mywindow:setSize(204, 27)
	mywindow:setAlign(1)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	winMgr:getWindow("TownNPC_TalkButton"..i):addChildWindow(mywindow);

end



-- ���Ǿ� ��ȭâ�� ���� ó�� ������ ���ش�.
function SetTownNpcCommunication(ButtonCount, NpcName, firstString)
	for i = 0, ButtonCount - 1 do
		winMgr:getWindow("TownNPC_TalkButton"..i):setVisible(true)
		winMgr:getWindow("TownNPC_Tellingdeco"..i):setVisible(true)
	end
	
	for i = 0, ButtonCount - 1 do
		local NameString = GetNpcCommunicationButtonName(i)
		winMgr:getWindow("TownNPC_TalkButtonText"..i):setTextExtends(NameString, g_STRING_FONT_GULIM, 14, 250,250,0,255, 1, 60,60,60,255)
	end	
	winMgr:getWindow("TownNPC_TellingNameText"):setTextExtends(NpcName, g_STRING_FONT_GULIM, 18, 87,242,9,255, 0, 60,60,60,255)
	
	local TellingText_window = winMgr:getWindow('TownNPC_TellingText')
	CEGUI.toGUISheet(TellingText_window):setTextViewDelayTime(11)
	TellingText_window:setTextExtends(firstString, g_STRING_FONT_GULIM, 16, 255,255,255,255,   0, 0,0,0,255 )
	
end





----------------------------------------------------------------------
-- NPC��ȭâ�� ��ư�� �� �ʱ�ȭ ��Ų��.
----------------------------------------------------------------------
function ResetTownNPCTalkButton()
	for i = 0, MAX_TALKBUTTON-1 do
		winMgr:getWindow("TownNPC_TalkButton"..i):setVisible(false)
		winMgr:getWindow("TownNPC_Tellingdeco"..i):setVisible(false)
		
		if CEGUI.toRadioButton(winMgr:getWindow("TownNPC_TalkButton"..i)):isSelected() then
			winMgr:getWindow("TownNPC_TalkButton"..i):setProperty("Selected", "false")			
		end
	end
end


----------------------------------------------------------------------
-- NPC��ȭâ�� ��ư �̺�Ʈ(��ư �������� ����)
----------------------------------------------------------------------
function TownNPC_TalkingButtonEvent(args)
	for i = 0, MAX_TALKBUTTON-1 do
		if CEGUI.toRadioButton(winMgr:getWindow("TownNPC_TalkButton"..i)):isSelected() then
			
			local TellingText_window = winMgr:getWindow('TownNPC_TellingText')
			local StringIndex = GetNpcCommunicationSelectButton(i)
			if StringIndex <= 0 then
				break
			end
			local String = GetSStringInfo(StringIndex)
			DebugStr("GetSStringInfo�� �����ϰ� �ֽ��ϴ�" .. StringIndex)
			CEGUI.toGUISheet(TellingText_window):setTextViewDelayTime(11)			
			TellingText_window:setTextExtends(String, g_STRING_FONT_GULIM, 16, 255,255,255,255,   0, 0,0,0,255 )
			break
		end
	end
end


-- npc�̾߱⸦ �����Ѵ�.
function PlayNPCTelling()
	

end



function ShowTownNpcTelling()
	ResetTownNPCTalkButton()	-- ��ư�� �ʱ�ȭ��Ų��.
	winMgr:getWindow("TownNPC_TellingBack"):setVisible(true)
	winMgr:getWindow("TownNPC_TellingBack"):setAlwaysOnTop(false)
	GetCommunicationCount()
end

-- ���Ǿ� ��ȭâ�� �ݾ��ش�.
function CloseTownNpcTelling()
	VirtualImageSetVisible(false)
	winMgr:getWindow("TownNPC_TellingBack"):setVisible(false)
end

-- ���Ǿ� ��ȭâ Ŭ������
function ClickCloseTownNpcTelling()
	VirtualImageSetVisible(false)
	TownNpcEscBtnClickEvent()
	winMgr:getWindow("TownNPC_TellingBack"):setVisible(false)
end


------------------------------------------------------------------------------
-- �����̽��� �̹����� �������ش�.(npc, object�� ������ �°� �������ִ���.)
-- �����̽��� �ִϸ��̼��� �ֱ����� ��������
------------------------------------------------------------------------------
function CreateSpacebarImage(index)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BackSpaceImage"..index)	
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setSize(80, 41)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", index)
	root:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FirstSpaceImage"..index)	
	mywindow:setTexture("Enabled", "UIData/tutorial001.tga", 925, 327)
	mywindow:setTexture("Disabled", "UIData/tutorial001.tga", 925, 327)
	mywindow:setSize(80, 41)
	mywindow:setPosition(0,0)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("BackSpaceImage"..index):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondSpaceImage"..index)	
	mywindow:setTexture("Enabled", "UIData/tutorial001.tga", 925, 327)
	mywindow:setTexture("Disabled", "UIData/tutorial001.tga", 925, 327)
	mywindow:setSize(80, 41)
	mywindow:setPosition(0,0)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("BackSpaceImage"..index):addChildWindow(mywindow)
end



----- npc���� �Ÿ��� ���� �̹����� �����ְ� �����ش� -----
-- �����̽��� �̹����� �����ش�.
function ShowSpacebarImage(index)
	if winMgr:getWindow("BackSpaceImage"..index) then
		winMgr:getWindow("BackSpaceImage"..index):setVisible(true)
	end
end


-- �����̽��� �̹����� �����ش�.
function HideSpacebarImage(index)
	if winMgr:getWindow("BackSpaceImage"..index) then
		winMgr:getWindow("BackSpaceImage"..index):setVisible(false)
	end
end



function CheckEventEnableRange(index, bcheck)
	if winMgr:getWindow("BackSpaceImage"..index) then
		
			
	end
end

function DrawNpcUI(index, x, y, Name, Title)
	local SPACE_X = 0
	local SPACE_Y = 0

	local	TitleSize = GetStringSize(g_STRING_FONT_GULIM, 12, Title)
	local	NameSize = GetStringSize(g_STRING_FONT_GULIM, 12, Name)
	
	common_DrawOutlineText1(drawer, Title, x-(TitleSize/2), y-35, 0,0,0,255, 97,230,240,255)
	common_DrawOutlineText1(drawer, Name, x-(NameSize/2), y-15, 0,0,0,255, 255,205,86,255)
	
	SPACE_X = x-40
	SPACE_Y = y-80
	
	winMgr:getWindow("BackSpaceImage"..index):setPosition(SPACE_X, SPACE_Y)
	
end


-- �������� �������� �̹����� �������ش�.
function VirtualImageSetVisible(bVisible)
	winMgr:getWindow("TownNPC_VirtualImage"):setVisible(bVisible)
end





































