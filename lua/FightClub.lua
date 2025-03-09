function FightClub_Execute()


guiSystem = CEGUI.System:getSingleton();
winMgr = CEGUI.WindowManager:getSingleton();
mouseCursor = CEGUI.MouseCursor:getSingleton();
root = winMgr:getWindow("DefaultWindow");
guiSystem:setGUISheet(root);


g_curPage_ClubList = 1
g_maxPage_ClubList = 1
g_curPage_ClubMember = 1
g_maxPage_ClubMember = 1
g_curPage_ClubManage = 1
g_maxPage_ClubManage = 1
g_curPage_ClubBoard = 1
g_maxPage_ClubBoard = 1
local My_CurrentGrade = 1
local My_CharacterName = ""
local My_ProposedClubName = ""
local My_SearchIndex = 0

local ClubGradeName1 = ""
local ClubGradeName2 = ""
local ClubGradeName3 = ""
local ClubGradeName4 = ""
local ClubGradeName5 = ""
local ClubGradeName6 = ""
local Emblemload     = false
root:addChildWindow(winMgr:getWindow("sj_club_createWindow"))   -- 클럽정보 이미지
root:addChildWindow(winMgr:getWindow("ClubCreateNotice"))       -- 클럽 가입 NPC 이미지

-- 와이드 모드때문에 한번더 설정
winMgr:getWindow("ClubCreateNotice"):setPosition(480, 117)
winMgr:getWindow("sj_club_createWindow"):setPosition(480, 117)
winMgr:getWindow("FightClub_ClubNameWindow"):setPosition(400 ,80);
winMgr:getWindow("FightClub_ClubListWindow"):setPosition(50 ,200);
winMgr:getWindow("ClubManage_InviteImage"):setPosition(30 ,200);
winMgr:getWindow("ClubManage_TransImage"):setPosition(30 ,200);

--클럽 정보 관련 윈도우
winMgr:getWindow("sj_club_createWindow"):addChildWindow(winMgr:getWindow("sj_club_createConfirmBtn"))
winMgr:getWindow("sj_club_createWindow"):addChildWindow(winMgr:getWindow("sj_club_name_duplicateBtn"))
winMgr:getWindow("sj_club_createWindow"):addChildWindow(winMgr:getWindow("sj_club_loadClubEmblemBtn"))
winMgr:getWindow("sj_club_createWindow"):addChildWindow(winMgr:getWindow("sj_club_title_duplicateBtn"))
winMgr:getWindow("sj_club_createWindow"):addChildWindow(winMgr:getWindow("sj_club_clubName_editbox"))
winMgr:getWindow("sj_club_createWindow"):addChildWindow(winMgr:getWindow("sj_club_clubEmblemName_editbox"))
winMgr:getWindow("sj_club_createWindow"):addChildWindow(winMgr:getWindow("sj_club_clubTitle_editbox"))
winMgr:getWindow("sj_club_createWindow"):addChildWindow(winMgr:getWindow("sj_club_clubEmblemImage"))

winMgr:getWindow("FightClub_ClubNameWindow"):setVisible(false)
root:addChildWindow(winMgr:getWindow("FightClub_ClubNameWindow"))
winMgr:getWindow("FightClub_ClubNameWindow"):addChildWindow(winMgr:getWindow("ClubName_titlebar"))
winMgr:getWindow("FightClub_ClubListWindow"):setVisible(false)
root:addChildWindow(winMgr:getWindow("FightClub_ClubListWindow"))
winMgr:getWindow("FightClub_ClubListWindow"):addChildWindow(winMgr:getWindow("ClubList_titlebar"))
winMgr:getWindow('FightClub_ClubNameWindow'):addChildWindow(winMgr:getWindow("Club_clubEmbleImage"))


winMgr:getWindow('sj_club_clubName_editbox'):setPosition(113, 71)
winMgr:getWindow('sj_club_clubTitle_editbox'):setPosition(113, 148)
winMgr:getWindow('sj_club_name_duplicateBtn'):setPosition(329, 70)
winMgr:getWindow('sj_club_title_duplicateBtn'):setPosition(329, 148)
winMgr:getWindow('sj_club_clubEmblemImage'):setPosition(117, 236)
winMgr:getWindow('sj_club_clubEmblemName_editbox'):setPosition(156, 226)
winMgr:getWindow('sj_club_loadClubEmblemBtn'):setPosition(329, 226)
winMgr:getWindow('Club_clubEmbleImage'):setPosition(14, 4)



RegistEscEventInfo("FightClub_ClubNameWindow", "OnClickClubName_Close")
RegistEscEventInfo("FightClub_ClubListWindow", "OnClickClubList_Close")
RegistEscEventInfo("ClubManage_SetGradeNameWindow", "OnClickClubGradeName_Close")
RegistEscEventInfo("ClubManage_InviteImage", "OnClickClubInvite_Close")
RegistEscEventInfo("ClubManage_TransImage", "OnClickClubGive_Close")


-------------------------------------------------------------
--시스템메세지-
-------------------------------------------------------------
function ClubSystemMsg(msg)
	local systemMessage = '[!] '..msg
	SeparatesProperly('', systemMessage, 5)
end

-------------------------------------------------------------
--메인 백판에 붙는 라디오 버튼 및 이벤트 핸들추가
-------------------------------------------------------------
FightClubNameRadio	= { ["protecterr"]=0, "ClubName_1", "ClubName_2", "ClubName_3", "ClubName_4", "ClubName_5"}
ClubEventHandler	= { ['err'] = 0, "Club_Info", "Club_Member" ,"Club_Stats" ,"Club_Board" , "Club_Manager"}
for i=1, #FightClubNameRadio do
	winMgr:getWindow('FightClub_ClubNameWindow'):addChildWindow(winMgr:getWindow(FightClubNameRadio[i]));
	winMgr:getWindow(FightClubNameRadio[i]):subscribeEvent("SelectStateChanged", ClubEventHandler[i])
end

-----------------------------------------------------------------------------------------------------------------------------------------
--메인 백판에 붙는 서브 백판및 클럽 이름
-------------------------------------------------------------------------------------------------------------------------------------------
Club_Menu_BackImage =
{ ["protecterr"]=0, "Club_Info_BackImage", "Club_Member_BackImage", "Club_Stats_BackImage", "Club_Board_BackImage", "Club_Manage_BackImage"}

for i=1, #Club_Menu_BackImage do
	winMgr:getWindow('FightClub_ClubNameWindow'):addChildWindow(winMgr:getWindow(Club_Menu_BackImage[i]));
end

winMgr:getWindow('FightClub_ClubNameWindow'):addChildWindow(winMgr:getWindow("Main_ClubName"));  -- 클럽이름
---------------------------------------------------------------------------------------------------------------------------------------
--Club_Info_BackImage 에 붙는 StaticText-----------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
Club_Info_Text =	{ ["protecterr"]=0,  "Club_Info_Master", "Club_Info_ChinHo", "Club_Info_Level", "Club_Info_Introduce" ,"Club_Info_Member", 
					"Club_Info_Stats" , "Club_Info_Rank" , "Club_Info_Exp"}

winMgr:getWindow('Club_Info_BackImage'):addChildWindow(winMgr:getWindow("Club_Info_BackImageTop"))

winMgr:getWindow('Club_Info_BackImage'):addChildWindow(winMgr:getWindow("Club_Info_EXPBar")); -- 클럽 레벨 바
for i=1, #Club_Info_Text do
	winMgr:getWindow('Club_Info_BackImage'):addChildWindow(winMgr:getWindow(Club_Info_Text[i]));
end


winMgr:getWindow('Club_Info_BackImage'):addChildWindow(winMgr:getWindow("ClubOutBtn")); -- 클럽탈퇴버튼
winMgr:getWindow('Club_Info_BackImage'):addChildWindow(winMgr:getWindow("ClubListShowBtn")); -- 다른클럽리스트 보여주는버튼
winMgr:getWindow("ClubOutBtn"):setPosition(380, 202)
winMgr:getWindow("ClubListShowBtn"):setPosition(380, 180)
winMgr:getWindow('Club_Info_Master'):setPosition(130, 18)
winMgr:getWindow('Club_Info_ChinHo'):setPosition(130, 90)
winMgr:getWindow('Club_Info_Level'):setPosition(94, 56)
winMgr:getWindow('Club_Info_Member'):setPosition(391, 18)
winMgr:getWindow('Club_Info_EXPBar'):setPosition(126, 51 )
winMgr:getWindow('Club_Info_EXPBar'):setSize(0, 20)
winMgr:getWindow('Club_Info_Stats'):setPosition(391, 55 )
winMgr:getWindow('Club_Info_Rank'):setPosition(391, 92 )
winMgr:getWindow('Club_Info_Exp'):setPosition(120, 55)


---------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------
--Club_Member_BackImager에 붙는 Radio버튼  멤버 리스트
---------------------------------------------------------------------------------------------------------------------------------------
Club_Member_Radio = 
{ ["protecterr"]=0, "Club_Member_Radio1", "Club_Member_Radio2", "Club_Member_Radio3" , "Club_Member_Radio4", "Club_Member_Radio5",
					"Club_Member_Radio6", "Club_Member_Radio7", "Club_Member_Radio8" , "Club_Member_Radio9", "Club_Member_Radio10",
					"Club_Member_Radio11", "Club_Member_Radio12", "Club_Member_Radio13" , "Club_Member_Radio14", "Club_Member_Radio15"}

ClubMemberText	= {['err'] = 0, 'MemberLevelText', 'MemberLadderText', 'MemberNickText',    'MemberClassText',
								'MemberGradeText', 'MemberhelpText'  , 'MemberLastLogText', 'MemberPositionText'}
								

winMgr:getWindow('Club_Member_BackImage'):addChildWindow(winMgr:getWindow("Club_Member_BackImageTop"))
						
Club_MemberList_BtnName  = {["err"]=0, "Club_MemberList_LBtn", "Club_MemberList_RBtn"}  --페이지 앞뒤 버튼

for i=1, #Club_Member_Radio do  -- 라디오버튼에 텍스트와 래더이미지를 붙인다
	
	winMgr:getWindow('Club_Member_BackImage'):addChildWindow(winMgr:getWindow(Club_Member_Radio[i]));
	
	
	for j=1, #ClubMemberText do
		winMgr:getWindow(Club_Member_Radio[i]):addChildWindow(winMgr:getWindow(Club_Member_Radio[i]..ClubMemberText[j]));
	end
	
	
	winMgr:getWindow(Club_Member_Radio[i]):addChildWindow(winMgr:getWindow(Club_Member_Radio[i].."ClubMemberLadderImage"));
	
	winMgr:getWindow(Club_Member_Radio[i]):addChildWindow(winMgr:getWindow(Club_Member_Radio[i].."ClubMemberClassImage"));
end




for i=1, #Club_MemberList_BtnName do
	winMgr:getWindow('Club_Member_BackImage'):addChildWindow(winMgr:getWindow(Club_MemberList_BtnName[i]));
end

winMgr:getWindow('Club_Member_BackImage'):addChildWindow(winMgr:getWindow('Club_MemberList_PageText'));



----------------------------------------------------------------------------------------------------------------------------------------
--Club_Stats_BackImage에 붙는 텍스트
----------------------------------------------------------------------------------------------------------------------------------------
Club_Stats_Text =	{ ["protecterr"]=0, "Club_Stats_Ranking", "Club_Stats_Stat", "Club_Stats_RivalName", "Club_Stats_RivalStat"}

for i=1, #Club_Stats_Text do
	
	winMgr:getWindow('Club_Stats_BackImage'):addChildWindow(winMgr:getWindow(Club_Stats_Text[i]));
	
end
------------------------------------------------------------------------------------------------------------------------------------------
--Club_Board_BackImage에 붙는 텍스트
------------------------------------------------------------------------------------------------------------------------------------------
	
Club_Board_Radio = 
{ ["protecterr"]=0, "Club_Board_Radio1", "Club_Board_Radio2", "Club_Board_Radio3" , "Club_Board_Radio4", "Club_Board_Radio5",
					"Club_Board_Radio6", "Club_Board_Radio7", "Club_Board_Radio8" , "Club_Board_Radio9", "Club_Board_Radio10"}


ClubBoardText	= {['err'] = 0, 'BoardName', 'BoardMsg', 'BoardDay'}	

for i=1, #Club_Board_Radio do
	winMgr:getWindow('Club_Board_BackImage'):addChildWindow(winMgr:getWindow(Club_Board_Radio[i]))
	
	for j=1, #ClubBoardText do
		winMgr:getWindow(Club_Board_Radio[i]):addChildWindow(winMgr:getWindow(Club_Board_Radio[i]..ClubBoardText[j]));
	end
	winMgr:getWindow(Club_Board_Radio[i]):addChildWindow(winMgr:getWindow(Club_Board_Radio[i].."Club_Board_Delete"));
end
	
winMgr:getWindow('Club_Board_BackImage'):addChildWindow(winMgr:getWindow("Club_Board_InputImage"));
winMgr:getWindow('Club_Board_BackImage'):addChildWindow(winMgr:getWindow("Club_Board_EditBox"));
winMgr:getWindow('Club_Board_BackImage'):addChildWindow(winMgr:getWindow("Club_Board_Button"));
	
	--페이지 버튼 및 텍스트
winMgr:getWindow('Club_Board_BackImage'):addChildWindow(winMgr:getWindow("Club_BoardList_LBtn"));
winMgr:getWindow('Club_Board_BackImage'):addChildWindow(winMgr:getWindow("Club_BoardList_RBtn"));
winMgr:getWindow('Club_Board_BackImage'):addChildWindow(winMgr:getWindow("Club_BoardList_PageText"));
	
---------------------------------------------------------------------------------------------------------------------------------------------
--Club_Manage_BackImage에 붙는 라디오및 버튼
---------------------------------------------------------------------------------------------------------------------------------------------
Club_Manage_Radio = 
{ ["protecterr"]=0, "Club_Manage_Radio1", "Club_Manage_Radio2", "Club_Manage_Radio3" , "Club_Manage_Radio4", "Club_Manage_Radio5",
					"Club_Manage_Radio6", "Club_Manage_Radio7", "Club_Manage_Radio8" , "Club_Manage_Radio9", "Club_Manage_Radio10"}

winMgr:getWindow('Club_Manage_BackImage'):addChildWindow(winMgr:getWindow("Club_Manage_BackImageTop"))
winMgr:getWindow('Club_Manage_BackImage'):addChildWindow(winMgr:getWindow("Club_Manage_BackImageBottom"))


ClubManageText	= {['err'] = 0, 'ManageLevelText', 'ManageLadderText', 'ManageNickText',    'ManageClassText',
								'ManageGradeText', 'ManagehelpText'  , 'ManageLastLogText', 'ManagePositionText'}

for i=1, #Club_Manage_Radio do
	
	winMgr:getWindow('Club_Manage_BackImage'):addChildWindow(winMgr:getWindow(Club_Manage_Radio[i]));
	
	
	for j=1, #ClubManageText do
		winMgr:getWindow(Club_Manage_Radio[i]):addChildWindow(winMgr:getWindow(Club_Manage_Radio[i]..ClubManageText[j]));
	end
	
	winMgr:getWindow(Club_Manage_Radio[i]):addChildWindow(winMgr:getWindow(Club_Manage_Radio[i].."ClubManageLadderImage"));
	winMgr:getWindow(Club_Manage_Radio[i]):addChildWindow(winMgr:getWindow(Club_Manage_Radio[i].."ClubManageClassImage"));

end



Club_Manage_Button	  = {["err"]=0, "Club_Manage_Button_Delete",   "Club_Manage_Button_Save",   "Club_Manage_Button_Invite", 
									 "Club_Manage_Button_SetGrade" ,"Club_Manage_Button_Trans" , "Club_Manage_Button_Close"}
								 

for i=1, #Club_Manage_Button do   -- (초대, 직위설정, 클럽양도, 클럽폐쇄버튼)

   winMgr:getWindow('Club_Manage_BackImage'):addChildWindow(winMgr:getWindow(Club_Manage_Button[i]));
end

for i=1, #Club_ManageList_BtnName do   -- 페이지 앞뒤버튼
	winMgr:getWindow('Club_Manage_BackImage'):addChildWindow(winMgr:getWindow(Club_ManageList_BtnName[i]));
end

winMgr:getWindow('Club_Manage_BackImage'):addChildWindow(winMgr:getWindow('Club_ManageList_PageText')); --페이지 표시 텍스트

for i=1, 3 do
	winMgr:getWindow('Club_Manage_BackImage'):addChildWindow(winMgr:getWindow(ClubIntroWrite[i]));
end
winMgr:getWindow('Club_Manage_BackImage'):addChildWindow(winMgr:getWindow("ClubIntroImage"));

-------------------------------------------------------------------------------------------------------------------------------------------------------
--ClubManage_InviteImage ,ClubManage_TransImage  클럽원 초대하기, 양도하기 백판
---------------------------------------------------------------------------------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow("ClubManage_InviteImage"))
winMgr:getWindow('ClubManage_InviteImage'):addChildWindow(winMgr:getWindow('ClubManage_InviteEditbox'));
winMgr:getWindow('ClubManage_InviteImage'):addChildWindow(winMgr:getWindow('Club_Invite_Btn'));
winMgr:getWindow('ClubManage_InviteImage'):addChildWindow(winMgr:getWindow('ClubManage_InviteText'));
winMgr:getWindow('ClubManage_InviteText'):clearTextExtends()
winMgr:getWindow('ClubManage_InviteText'):addTextExtends(PreCreateString_2165, g_STRING_FONT_DODUM, 115,    230,230,230,255,     0,     0,0,0,255)
															--GetSStringInfo(LAN_LUA_INVITECLUBNAME)

root:addChildWindow(winMgr:getWindow("ClubManage_TransImage"))
winMgr:getWindow('ClubManage_TransImage'):addChildWindow(winMgr:getWindow('ClubManage_TransEditbox'));
winMgr:getWindow('ClubManage_TransImage'):addChildWindow(winMgr:getWindow('Club_Give_Btn'));
winMgr:getWindow('ClubManage_TransImage'):addChildWindow(winMgr:getWindow('ClubManage_TransText'));
winMgr:getWindow('ClubManage_TransText'):clearTextExtends()
winMgr:getWindow('ClubManage_TransText'):addTextExtends(PreCreateString_2166, g_STRING_FONT_DODUM, 115,    230,230,230,255,     0,     0,0,0,255)
															--GetSStringInfo(LAN_LUA_MASTER_CHANGE_NAME)
-------------------------------------------------------------------------------------------------------------------------------------------------------
--ClubMange_SetGradeNameWindow  클럽 등급관리 등급 이름지정
---------------------------------------------------------------------------------------------------------------------------------------------
ClubManage_SetGradeEditBox  = {["err"]=0, "ClubManage_SetGradeEditBox1", "ClubManage_SetGradeEditBox2" ,"ClubManage_SetGradeEditBox3",
										  "ClubManage_SetGradeEditBox4", "ClubManage_SetGradeEditBox5" , "ClubManage_SetGradeEditBox6"}
										  
root:addChildWindow(winMgr:getWindow("ClubManage_SetGradeNameWindow"))

for i=1 , #ClubManage_SetGradeEditBox do
	winMgr:getWindow("ClubManage_SetGradeNameWindow"):addChildWindow(winMgr:getWindow(ClubManage_SetGradeEditBox[i]))
end

winMgr:getWindow("ClubManage_SetGradeNameWindow"):addChildWindow(winMgr:getWindow("ClubManage_SetGradeBtn"))

-------------------------------------------------------------------------------------------------------------------------------------------------------
--팝업윈도우 붙이기
---------------------------------------------------------------------------------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow("Club_PopupWindow"))
winMgr:getWindow("Club_PopupWindow"):addChildWindow(winMgr:getWindow("pu_Topline"))
winMgr:getWindow("Club_PopupWindow"):addChildWindow(winMgr:getWindow("pu_Bottomline"))

root:addChildWindow(winMgr:getWindow("Club_PopupSubWindow"))
winMgr:getWindow("Club_PopupSubWindow"):addChildWindow(winMgr:getWindow("pu_SubTopline"))
winMgr:getWindow("Club_PopupSubWindow"):addChildWindow(winMgr:getWindow("pu_SubBottomline"))

for i=7 , #Club_PopupButtonName do
	winMgr:getWindow(Club_PopupButtonName[i]):addChildWindow(winMgr:getWindow(Club_PopupButtonName[i].."ClubPopupText"))
end


---------------------------------------------------------------------------------------------------------------------------------------------
--FightClub_ClubListWindow에 붙는 라디오버튼 , 페이지 앞뒤버튼, 페이지 텍스트
---------------------------------------------------------------------------------------------------------------------------------------------
Club_List_Radio = 
{ ["protecterr"]=0, "Club_List_Radio1", "Club_List_Radio2", "Club_List_Radio3" , "Club_List_Radio4", "Club_List_Radio5",
					"Club_List_Radio6", "Club_List_Radio7", "Club_List_Radio8" , "Club_List_Radio9", "Club_List_Radio10"}

Club_List_ClickInfo  = {["err"]=0, "Club_ClickInfo_Name", "Club_ClickInfo_Level","Club_ClickInfo_Master","Club_ClickInfo_ChingHo",
								   "Club_ClickInfo_Member","Club_ClickInfo_Ranking","Club_ClickInfo_Introduce"}

ClubListText	= {['err'] = 0, 'ListRanKingText', 'ListLevelText', 'ListClubName', 'ListMemberText',
								'ListMasterText', 'ListChinghoText', 'ListIntroText' , 'ListClubEmblemKey' , 'ListClubKey' , 'ListClubStats'}


for i=1, #Club_List_Radio do
	
	winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow(Club_List_Radio[i]));
	
	
	for j=1, #ClubListText do   --4개 이상은 가지고만 있는 값이라 attach생략해준다
		winMgr:getWindow(Club_List_Radio[i]):addChildWindow(winMgr:getWindow(Club_List_Radio[i]..ClubListText[j]));
	end
	winMgr:getWindow(Club_List_Radio[i]):addChildWindow(winMgr:getWindow(Club_List_Radio[i]..ClubListText[10]));
end


Club_List_BtnName  = {["err"]=0, "Club_List_LBtn", "Club_List_RBtn"}
Club_List_10BtnName  = {["err"]=0, "Club_List_10LBtn", "Club_List_10RBtn"}
for i=1, #Club_List_BtnName do

   winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow(Club_List_BtnName[i]));
   winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow(Club_List_10BtnName[i]));
end
   winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow("Club_List_PageText"));

for i=1, #Club_List_ClickInfo do
	winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow(Club_List_ClickInfo[i]))
end

winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow("Club_Join_Want"))
winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow("Club_Join_Cancel"))

winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow("Club_List_EditBox"))
winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow("Club_Search_Button"))
winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow("Club_List_ProposeName"))


winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow("Club_List_Emble"))
winMgr:getWindow("Club_List_Emble"):setPosition(12, 288)
----------------------------------------------------------------------------------------------------------------------------------------------------
--클럽리스트 , 클럽메인윈도우, 초대하기, 양도하기에 붙는 종료버튼

Club_Close_BtnName  = {["err"]=0, "Club_Close_List", "Club_Close_Name", "Club_Close_Invite" ,"Club_Close_Give" , "Club_Close_GradeName"}

winMgr:getWindow('FightClub_ClubListWindow'):addChildWindow(winMgr:getWindow(Club_Close_BtnName[1]));
winMgr:getWindow('FightClub_ClubNameWindow'):addChildWindow(winMgr:getWindow(Club_Close_BtnName[2]));
winMgr:getWindow('ClubManage_InviteImage'):addChildWindow(winMgr:getWindow(Club_Close_BtnName[3]));
winMgr:getWindow('ClubManage_TransImage'):addChildWindow(winMgr:getWindow(Club_Close_BtnName[4]));
winMgr:getWindow('ClubManage_SetGradeNameWindow'):addChildWindow(winMgr:getWindow(Club_Close_BtnName[5]));

-----------------------------------------------------------------------------------------------------------------------------------------------------

function CheckClubJoined()
	CheckJoinClub()
end
---------------------------------------------
--클럽리스트 또는 클럽메인 창을 띄워준다
---------------------------------------------
								   
function ShowClubListWindow(JoinResult)
    
    
    winMgr:getWindow("FightClub_ClubNameWindow"):setVisible(false)
    winMgr:getWindow("FightClub_ClubListWindow"):setVisible(false)
    
  
	if JoinResult < 6 then  -- 클럽에 가입되있을때 
	root:addChildWindow(winMgr:getWindow("FightClub_ClubNameWindow"))
	winMgr:getWindow("FightClub_ClubNameWindow"):setVisible(true)
	g_curPage_ClubManage = 1 -- 초기화
	g_curPage_ClubMember = 1
	g_curPage_ClubBoard  = 1
	if CEGUI.toRadioButton( winMgr:getWindow('ClubName_1') ):isSelected() == false then
		winMgr:getWindow("ClubName_1"):setProperty('Selected', 'True');
	else
		Club_Info()
	end
	--Club_Info()
	
		if JoinResult > 1 then
			winMgr:getWindow("ClubName_5"):setEnabled(false)
		else
			winMgr:getWindow("ClubName_5"):setEnabled(true)
		end
	else   -- 클럽이 없을경우
		root:addChildWindow(winMgr:getWindow("FightClub_ClubListWindow"))
		winMgr:getWindow("FightClub_ClubListWindow"):setVisible(true)
		g_curPage_ClubList = 1
		ClubListMarkReset()
		if JoinResult > 6 then  -- 가입신청중인 클럽이 없을경우
			winMgr:getWindow("Club_Join_Cancel"):setEnabled(false)
			winMgr:getWindow("Club_Join_Want"):setEnabled(true)
			winMgr:getWindow('Club_List_ProposeName'):clearTextExtends()
		else  -- 클럽 가입 대기중일 경우
			winMgr:getWindow("Club_Join_Cancel"):setEnabled(true)
			winMgr:getWindow("Club_Join_Want"):setEnabled(false)
		end
		RefreshClubList()
		ChangedClubListCurrentPage(g_curPage_ClubList)
	end
	My_CurrentGrade = JoinResult
	
	Mainbar_ClearEffect(BAR_BUTTONTYPE_CLUB)
end

--클럽메인에서 클럽리스트를 누를때
function ShowClubListInfo()
	root:addChildWindow(winMgr:getWindow("FightClub_ClubListWindow"))
	winMgr:getWindow("FightClub_ClubListWindow"):setVisible(true)
	g_curPage_ClubList = 1
	winMgr:getWindow("Club_Join_Cancel"):setEnabled(false)
	winMgr:getWindow("Club_Join_Want"):setEnabled(false)
	RefreshClubList()
	ChangedClubListCurrentPage(g_curPage_ClubList)
	ClubListMarkReset()
	winMgr:getWindow('Club_List_ProposeName'):clearTextExtends()
end

-- 클럽 가입 및 가입취소버튼 활성/비활성화
function ClubLisJointEnabled()
	winMgr:getWindow("Club_Join_Cancel"):setEnabled(false)
	winMgr:getWindow("Club_Join_Want"):setEnabled(true)
end

function ClubListCancelEnabled()
	winMgr:getWindow("Club_Join_Cancel"):setEnabled(true)
	winMgr:getWindow("Club_Join_Want"):setEnabled(false)
end



function ClubProposedInfoSet(ProposeName , SearchIndex)
	My_ProposedClubName = ProposeName
	My_SearchIndex = SearchIndex
end

----------------------------------------------------------------
-- 종료버튼-------------------------------------------
-----------------------------------------------------------------
--클럽리스트
function OnClickClubList_Close()

	winMgr:getWindow("FightClub_ClubListWindow"):setVisible(false)
end

--클럽메인
function OnClickClubName_Close()

	winMgr:getWindow("FightClub_ClubNameWindow"):setVisible(false)
	OnClickClubInvite_Close()
	OnClickClubGive_Close()
	OnClickClubGradeName_Close()
	RefreshPopupButton()
	if winMgr:getWindow('pu_btnContainer'):isVisible() then
		root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	end
end

--클럽초대
function OnClickClubInvite_Close()
	
	
	winMgr:getWindow("ClubManage_InviteEditbox"):setText("")
	winMgr:getWindow("ClubManage_InviteImage"):setVisible(false)
end

--클럽양도
function OnClickClubGive_Close()
	
	winMgr:getWindow("ClubManage_TransEditbox"):setText("")
	winMgr:getWindow("ClubManage_TransImage"):setVisible(false)
end

function OnClickClubGradeName_Close()

	winMgr:getWindow("ClubManage_SetGradeNameWindow"):setVisible(false)
end

--------------------------------------------------------------------
------------------------------------
---클럽 리스트 이전 페이지 이벤트
------------------------------------
		 
function  OnClickClubList_PrevPage()
    
     DebugStr('OnClickClubList_PrevPage');
     DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
	if	g_curPage_ClubList > 1 then
			g_curPage_ClubList = g_curPage_ClubList - 1
			DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
			RefreshClubList()
			ChangedClubListCurrentPage(g_curPage_ClubList)
			winMgr:getWindow("Club_List_PageText"):clearTextExtends()
            winMgr:getWindow("Club_List_PageText"):addTextExtends( tostring(g_curPage_ClubList)..' / '..tostring(g_maxPage_ClubList), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	
end
------------------------------------
--클럽 리스트 다음 페이지 이벤트----
------------------------------------
function OnClickClubList_NextPage()

	DebugStr('OnClickClubList_NextPage');
	DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
	if	g_curPage_ClubList < g_maxPage_ClubList then
			g_curPage_ClubList = g_curPage_ClubList + 1
			DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
			RefreshClubList()
			ChangedClubListCurrentPage(g_curPage_ClubList)
			winMgr:getWindow("Club_List_PageText"):clearTextExtends()
            winMgr:getWindow("Club_List_PageText"):addTextExtends( tostring(g_curPage_ClubList)..' / '..tostring(g_maxPage_ClubList), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	
end
--------------------------------------------------------------------
------------------------------------
---클럽 리스트 이전 10페이지 이벤트
------------------------------------
		 
function  OnClickClubList_10PrevPage()
    
     DebugStr('OnClickClubList_10PrevPage');
     DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
	if	g_curPage_ClubList > 10 then
			g_curPage_ClubList = g_curPage_ClubList - 10
			DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
			RefreshClubList()
			ChangedClubListCurrentPage(g_curPage_ClubList)
			winMgr:getWindow("Club_List_PageText"):clearTextExtends()
            winMgr:getWindow("Club_List_PageText"):addTextExtends( tostring(g_curPage_ClubList)..' / '..tostring(g_maxPage_ClubList), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
    else
			g_curPage_ClubList = 1
			DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
			RefreshClubList()
			ChangedClubListCurrentPage(g_curPage_ClubList)
			winMgr:getWindow("Club_List_PageText"):clearTextExtends()
            winMgr:getWindow("Club_List_PageText"):addTextExtends( tostring(g_curPage_ClubList)..' / '..tostring(g_maxPage_ClubList), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)  
	end
	
end
------------------------------------
--클럽 리스트 다음 10페이지 이벤트----
------------------------------------
function OnClickClubList_10NextPage()

	DebugStr('OnClickClubList_10NextPage');
	DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
	if	g_curPage_ClubList+9 < g_maxPage_ClubList then
			g_curPage_ClubList = g_curPage_ClubList + 10
			DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
			RefreshClubList()
			ChangedClubListCurrentPage(g_curPage_ClubList)
			winMgr:getWindow("Club_List_PageText"):clearTextExtends()
            winMgr:getWindow("Club_List_PageText"):addTextExtends( tostring(g_curPage_ClubList)..' / '..tostring(g_maxPage_ClubList), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
    else
			g_curPage_ClubList = g_maxPage_ClubList
			DebugStr('g_curPage_ClubList:'..g_curPage_ClubList);
			RefreshClubList()
			ChangedClubListCurrentPage(g_curPage_ClubList)
			winMgr:getWindow("Club_List_PageText"):clearTextExtends()
            winMgr:getWindow("Club_List_PageText"):addTextExtends( tostring(g_curPage_ClubList)..' / '..tostring(g_maxPage_ClubList), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	
end

------------------------------------
--클럽 리스트 목록 업데이트 
------------------------------------
function Setting_ClubList(RadioIndex ,ClubRanking, ClubRankingLevel, Clubname, Clubmember, Club_Master, 
		 Club_Chinho, Club_Intro , ClubEmblemKey, ClubListKey , ClubWinCount , ClubLoseCount)

	
	winMgr:getWindow(Club_List_Radio[RadioIndex+1]):setEnabled(true)
	winMgr:getWindow(Club_Member_Radio[RadioIndex+1]):setEnabled(true)
	
	for i=1, #ClubListText do	
	winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[i]):clearTextExtends()	
	end
	
	if ClubRanking > 9998 then
		winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[1]):addTextExtends('-', g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	else
		winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[1]):addTextExtends(ClubRanking, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[2]):addTextExtends(ClubRankingLevel, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[3]):addTextExtends(Clubname, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[4]):addTextExtends(Clubmember, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[5]):addTextExtends(Club_Master, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[10]):addTextExtends(ClubWinCount..' / '..ClubLoseCount, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	
    winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[1]):setText(ClubRanking)
    winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[2]):setText(ClubRankingLevel)
    winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[3]):setText(Clubname)
    winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[4]):setText(Clubmember)
	winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[5]):setText(Club_Master)
	winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[6]):setText(Club_Chinho)
    winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[7]):setText(Club_Intro)
    winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[8]):setText(ClubEmblemKey)
    winMgr:getWindow(Club_List_Radio[RadioIndex+1]..ClubListText[9]):setText(ClubListKey)
   
 
    
   -- DebugStr('My_SearchIndex:'..My_SearchIndex)
    if My_SearchIndex ~= 0 then
		winMgr:getWindow(Club_List_Radio[My_SearchIndex]):setProperty('Selected', 'false')
		winMgr:getWindow(Club_List_Radio[My_SearchIndex]):setProperty('Selected', 'true')
    end
    
    
end

function Setting_MyProposeClubName(ProposeClubName)
	 --DebugStr('Setting_MyProposeClubName')
	-- DebugStr('ProposeClubName:'..ProposeClubName)
	 winMgr:getWindow('Club_List_ProposeName'):clearTextExtends()	
	 winMgr:getWindow('Club_List_ProposeName'):addTextExtends(ProposeClubName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)	
end


------------------------------------
--클럽 리스트 최대 페이지 업데이트 
------------------------------------

function Setting_ClubMaxPageIndex(CurPageIndex , MaxPageIndex)

    g_maxPage_ClubList = MaxPageIndex
    g_curPage_ClubList = CurPageIndex
    winMgr:getWindow("Club_List_PageText"):clearTextExtends()
    winMgr:getWindow("Club_List_PageText"):addTextExtends( tostring(g_curPage_ClubList)..' / '..tostring(g_maxPage_ClubList), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
    
end

--------------------------------------------
--클럽 리스트 라디오 버튼 클릭시 호출 이벤트
--------------------------------------------

function OnSelectedClubList(args)	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		
		local IndextCount=tonumber(local_window:getUserString('Index'))	
		local RankingText = winMgr:getWindow(Club_List_Radio[IndextCount]..ClubListText[1]):getText()
		local LevelText = winMgr:getWindow(Club_List_Radio[IndextCount]..ClubListText[2]):getText()
		local ClubNameText = winMgr:getWindow(Club_List_Radio[IndextCount]..ClubListText[3]):getText()
		local ClubMemeberText = winMgr:getWindow(Club_List_Radio[IndextCount]..ClubListText[4]):getText()
		local ClubMasterText = winMgr:getWindow(Club_List_Radio[IndextCount]..ClubListText[5]):getText()
		local ClubChinhoText = winMgr:getWindow(Club_List_Radio[IndextCount]..ClubListText[6]):getText()
		local ClubIntroText = winMgr:getWindow(Club_List_Radio[IndextCount]..ClubListText[7]):getText()
		local ClubEmblemNumber = tonumber(winMgr:getWindow(Club_List_Radio[IndextCount]..ClubListText[8]):getText())
		DebugStr('ClubEmblemNumber:'..ClubEmblemNumber);
		
		for i=1, #Club_List_ClickInfo do	
		  winMgr:getWindow(Club_List_ClickInfo[i]):clearTextExtends()	
		end
	
		winMgr:getWindow(Club_List_ClickInfo[1]):setText(ClubNameText)
		winMgr:getWindow(Club_List_ClickInfo[5]):setText(ClubMemeberText)
		winMgr:getWindow(Club_List_ClickInfo[7]):addTextExtends(ClubIntroText, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
		
		if ClubEmblemNumber > 0 then
			ClubListMark(ClubEmblemNumber)
		else
			ClubListMarkReset()
		end
		
		
	end
end
-------------------------------------------------
--클럽 가입신청 버튼 클릭시 이벤트
------------------------------------------------ 
function OnClickClubJoinWant()

	DebugStr("OnClickClubJoinWant")
	local ClubName = winMgr:getWindow(Club_List_ClickInfo[1]):getText()
	local ClubMember = tonumber(winMgr:getWindow(Club_List_ClickInfo[5]):getText())
	if ClubName == "" then
		return
	end
	ProPoseClubJoin(ClubName)  -- 가입신청
	
end
-------------------------------------------------
--가입신청 중인 클럽이름을 표시해준다
------------------------------------------------ 
function ClubProposeSetting(settingproposename)
	winMgr:getWindow('Club_List_ProposeName'):clearTextExtends()
	winMgr:getWindow('Club_List_ProposeName'):addTextExtends(settingproposename, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	ClubListCancelEnabled()
end
-------------------------------------------------
--클럽 가입취소 버튼 클릭시 이벤트
------------------------------------------------ 
function OnClickClubJoinCancel()

	DebugStr("OnClickClubJoinCancel")
	BreakClubUser(My_CharacterName)
	winMgr:getWindow('Club_List_ProposeName'):clearTextExtends()
	ClubLisJointEnabled()
	
  
end
-------------------------------------------------
--클럽 검색 버튼 클릭시 이벤트
------------------------------------------------ 
function OnClickSearchClub()

	DebugStr("OnClickSearchClub()")
	SearchClubName = winMgr:getWindow("Club_List_EditBox"):getText()
	if SearchClubName == "" then
		return
	end
	Search_ClubList(SearchClubName)
	winMgr:getWindow("Club_List_EditBox"):setText("")
end
-------------------------------------------------
--클럽 정보 받아오기 
------------------------------------------------ 
function Setting_MyClubInfo(ClubNameInfo, MasterNameInfo, ClubTitleInfo, ClubLevelInfo, ClubCurretExpInfo, ClubMaxExpInfo, ClubExpPercent , ClubIntroInfo 
, ClubMemberInfo  , ClubMaxMemberInfo , ClubEmblemKey , ClubWinCount ,ClubLoseCount , ClubRank)

	DebugStr("Setting_MyClubInfo")
	
	--DebugStr('ClubLevelInfo:'..ClubLevelInfo);
	--DebugStr('ClubExpInfo:'..ClubExpInfo);
	--DebugStr('ClubWinCount:'..ClubWinCount);
	--DebugStr('ClubLoseCount:'..ClubLoseCount);
	for i=1, #Club_Info_Text do	
		winMgr:getWindow(Club_Info_Text[i]):clearTextExtends()	
	end
	
	DebugStr('ClubExpPercent:'..ClubExpPercent)
	winMgr:getWindow("Club_Info_Master"):addTextExtends(MasterNameInfo, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow("Club_Info_ChinHo"):addTextExtends(ClubTitleInfo, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow("Club_Info_Level"):addTextExtends('Lv.'..ClubLevelInfo, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow("Club_Info_Introduce"):addTextExtends(ClubIntroInfo, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow("Club_Info_Member"):addTextExtends(ClubMemberInfo.." / "..ClubMaxMemberInfo, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow("Club_Info_Stats"):addTextExtends(ClubWinCount.." / "..ClubLoseCount, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	if ClubRank > 9998 then
		winMgr:getWindow("Club_Info_Rank"):addTextExtends('-', g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	else
		winMgr:getWindow("Club_Info_Rank"):addTextExtends(ClubRank, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	winMgr:getWindow("Club_Info_Exp"):addTextExtends(ClubCurretExpInfo.." / "..ClubMaxExpInfo , g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     1,     20,20,0,255)
	winMgr:getWindow("Main_ClubName"):clearTextExtends()
	winMgr:getWindow("Main_ClubName"):addTextExtends(ClubNameInfo, g_STRING_FONT_GULIMCHE, 118,    230,230,230,255,     0,     0,0,0,255)
	if ClubEmblemKey > 0 then
		RegiClubMark(ClubEmblemKey) --클럽마크를 등록한다
		
	else
		ResetClubMark()  -- 클럽마크 리셋
	end
	--143
	winMgr:getWindow('Club_Info_EXPBar'):setSize(ClubExpPercent, 20)
end
-------------------------------------------------
--클럽 탈퇴 버튼 이벤트 호출 
------------------------------------------------
function OnClickClubOutEvent()
	DebugStr("OnClickClubOutEvent()")
	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2157, 'OnClickBreakOk', 'OnClickBreakNo');
end												--GetSStringInfo(LAN_LUA_CLUB_BREAKAWAY)


-------------------------------------------------
--클럽 탈퇴 이벤트 ok 
------------------------------------------------

function OnClickBreakOk()
	DebugStr("OnClickBreakOk()")
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickBreakOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	BreakClubUser(My_CharacterName)
end
-------------------------------------------------
--클럽 탈퇴 이벤트 cancel
------------------------------------------------
function OnClickBreakNo()
	DebugStr("OnClickBreakNo()")
	local noFunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if noFunc ~= "OnClickBreakNo" then
		return
	end
	
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
end

-------------------------------------------------
--클럽 멤버리스트 목록 업데이트 -- 클럽원메뉴
------------------------------------------------ 

function Setting_ClubMemberList(RadioIndex , MemberListLevel, MemberListLadder, MemberListName, MemberListClass, MemberListStyle,  MemberListGrade, 
								MemberListPoint, MemberListDay, MemberListPosition, attributeType)

	DebugStr('MemberListGrade:'..MemberListGrade);
	DebugStr('MemberListPoint:'..MemberListPoint);
	--길드 등급
	if MemberListGrade == 0 then
		RealGrade = ClubGradeName1	
	elseif MemberListGrade == 1 then
		RealGrade = ClubGradeName2
	elseif MemberListGrade == 2 then
		RealGrade = ClubGradeName3
	elseif MemberListGrade == 3 then
		RealGrade = ClubGradeName4
	elseif MemberListGrade == 4 then
		RealGrade = ClubGradeName5
	elseif MemberListGrade == 5 then
		RealGrade = ClubGradeName6
	else
		RealGrade = 'NewMember'
	end
	
	
	if CEGUI.toRadioButton( winMgr:getWindow('ClubName_2') ):isSelected() == true then    -- 클럽멤버를 보고있을경우
	
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1]):setEnabled(true)
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1].."ClubMemberLadderImage"):setTexture("Enabled", "UIData/numberUi001.tga", 113, 600 + 21 * MemberListLadder )
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1].."ClubMemberLadderImage"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600 + 21* MemberListLadder )
			
		if MemberListStyle == 'chr_strike' then
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1].."ClubMemberClassImage"):setTexture("Enabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[0][attributeType], tAttributeImgTexYTable[0][attributeType])
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1].."ClubMemberClassImage"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[0][attributeType], tAttributeImgTexYTable[0][attributeType])
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1].."ClubMemberClassImage"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[0], promotionImgTexYTable[MemberListClass])
		else
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1].."ClubMemberClassImage"):setTexture("Enabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[1][attributeType], tAttributeImgTexYTable[1][attributeType])
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1].."ClubMemberClassImage"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[1][attributeType], tAttributeImgTexYTable[1][attributeType])
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1].."ClubMemberClassImage"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[1], promotionImgTexYTable[MemberListClass])
		end			
			
		for i=1, #ClubMemberText do	
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1]..ClubMemberText[i]):clearTextExtends()	 
		end
		
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1]..ClubMemberText[1]):addTextExtends(MemberListLevel, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1]..ClubMemberText[3]):addTextExtends(MemberListName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1]..ClubMemberText[5]):addTextExtends(RealGrade, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1]..ClubMemberText[6]):addTextExtends(MemberListPoint, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1]..ClubMemberText[7]):addTextExtends(MemberListDay, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1]..ClubMemberText[3]):setText(MemberListName)
		winMgr:getWindow(Club_Member_Radio[RadioIndex+1]..ClubMemberText[5]):setText(MemberListGrade)
		
		
    elseif CEGUI.toRadioButton( winMgr:getWindow('ClubName_5') ):isSelected() == true then -- 관리자가 클럽관리를 보고있을 경우
    
		if RadioIndex > 9 then
			return 
		end
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]):setEnabled(true)
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1].."ClubManageLadderImage"):setTexture("Enabled", "UIData/numberUi001.tga", 113, 600 + 21 * MemberListLadder )
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1].."ClubManageLadderImage"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600 + 21* MemberListLadder )
		
		if MemberListStyle == 'chr_strike' then
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1].."ClubManageClassImage"):setTexture("Enabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[0][attributeType], tAttributeImgTexYTable[0][attributeType])
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1].."ClubManageClassImage"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[0][attributeType], tAttributeImgTexYTable[0][attributeType])
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1].."ClubManageClassImage"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[0], promotionImgTexYTable[MemberListClass])
		else
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1].."ClubManageClassImage"):setTexture("Enabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[1][attributeType], tAttributeImgTexYTable[1][attributeType])
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1].."ClubManageClassImage"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[1][attributeType], tAttributeImgTexYTable[1][attributeType])
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1].."ClubManageClassImage"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[1], promotionImgTexYTable[MemberListClass])
		end			
						
		for i=1, #ClubManageText do	
		winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[i]):clearTextExtends()	
		end
		
		if MemberListGrade < 6 then
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[1]):addTextExtends(MemberListLevel, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[3]):addTextExtends(MemberListName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[5]):addTextExtends(RealGrade, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[6]):addTextExtends(MemberListPoint, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[7]):addTextExtends(MemberListDay, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[3]):setText(MemberListName)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[5]):setText(MemberListGrade)
		else
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[1]):addTextExtends(MemberListLevel, g_STRING_FONT_GULIMCHE, 112,    150,100,100,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[3]):addTextExtends(MemberListName, g_STRING_FONT_GULIMCHE, 112,     150,100,100,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[5]):addTextExtends(RealGrade, g_STRING_FONT_GULIMCHE, 112,     150,100,100,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[6]):addTextExtends(MemberListPoint, g_STRING_FONT_GULIMCHE, 112,     150,100,100,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[7]):addTextExtends(MemberListDay, g_STRING_FONT_GULIMCHE, 112,     150,100,100,255,     0,     0,0,0,255)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[3]):setText(MemberListName)
			winMgr:getWindow(Club_Manage_Radio[RadioIndex+1]..ClubManageText[5]):setText(MemberListGrade)
		end
		
    end
       
end


------------------------------------
--클럽 멤버리스트 최대 페이지 업데이트 
------------------------------------

function Setting_ClubMemberMaxPageIndex(CurrentPageIndex, MaxPageIndex)  -- 클럽인원의 최대 페이지를 저장해준다

	if CEGUI.toRadioButton( winMgr:getWindow('ClubName_2') ):isSelected() == true then
		g_curPage_ClubMember = CurrentPageIndex
		g_maxPage_ClubMember = MaxPageIndex
		winMgr:getWindow("Club_MemberList_PageText"):clearTextExtends()
		winMgr:getWindow("Club_MemberList_PageText"):addTextExtends( tostring(g_curPage_ClubMember)..' / '..tostring(g_maxPage_ClubMember), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	
    elseif CEGUI.toRadioButton( winMgr:getWindow('ClubName_5') ):isSelected() == true then
		g_curPage_ClubManage = CurrentPageIndex
    	g_maxPage_ClubManage = MaxPageIndex
		winMgr:getWindow("Club_ManageList_PageText"):clearTextExtends()
		winMgr:getWindow("Club_ManageList_PageText"):addTextExtends( tostring(g_curPage_ClubManage)..' / '..tostring(g_maxPage_ClubManage), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)   
    end
end




------------------------------------
---클럽 멤버리스트 이전 페이지 이벤트
------------------------------------
		 
function  OnClickClubMemberList_PrevPage()
    
    DebugStr('OnClickClubMemberList_PrevPage');
	if	g_curPage_ClubMember > 1 then
			g_curPage_ClubMember = g_curPage_ClubMember - 1
			DebugStr('g_curPage_ClubMember:'..g_curPage_ClubMember);
			RefreshMemberRadio()
			RequestClubMember(g_curPage_ClubMember, 1)
			winMgr:getWindow("Club_MemberList_PageText"):clearTextExtends()
            winMgr:getWindow("Club_MemberList_PageText"):addTextExtends( tostring(g_curPage_ClubMember)..' / '..tostring(g_maxPage_ClubMember), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	
end
------------------------------------
--클럽 멤버리스트 다음 페이지 이벤트
------------------------------------
function OnClickClubMemberList_NextPage()

	DebugStr('OnClickClubMemberList_NextPage');
	if	g_curPage_ClubMember < g_maxPage_ClubMember then
			g_curPage_ClubMember = g_curPage_ClubMember + 1
			DebugStr('g_curPage_ClubMember:'..g_curPage_ClubMember);
			RefreshMemberRadio()
			RequestClubMember(g_curPage_ClubMember, 1)
			winMgr:getWindow("Club_MemberList_PageText"):clearTextExtends()
            winMgr:getWindow("Club_MemberList_PageText"):addTextExtends( tostring(g_curPage_ClubMember)..' / '..tostring(g_maxPage_ClubMember), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	
end



------------------------------------
---클럽 보드리스트 이전 페이지 이벤트
------------------------------------

function  OnClickClubBoardList_PrevPage()
    
    DebugStr('OnClickClubBoardList_PrevPage');
	if	g_curPage_ClubBoard > 1 then
			g_curPage_ClubBoard = g_curPage_ClubBoard - 1
			DebugStr('g_curPage_ClubBoard:'..g_curPage_ClubBoard);
			RefreshBoard()
			RequestBoardList(g_curPage_ClubBoard)
			winMgr:getWindow("Club_BoardList_PageText"):clearTextExtends()
            winMgr:getWindow("Club_BoardList_PageText"):addTextExtends( tostring(g_curPage_ClubBoard)..' / '..tostring(g_maxPage_ClubBoard), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	
end
------------------------------------
--클럽 보드리스트 다음 페이지 이벤트
------------------------------------
function OnClickClubBoardList_NextPage()

	DebugStr('OnClickClubBoardList_NextPage');
	if	g_curPage_ClubBoard < g_maxPage_ClubBoard then
			g_curPage_ClubBoard = g_curPage_ClubBoard + 1
			RefreshBoard()
			RequestBoardList(g_curPage_ClubBoard)
			winMgr:getWindow("Club_BoardList_PageText"):clearTextExtends()
            winMgr:getWindow("Club_BoardList_PageText"):addTextExtends( tostring(g_curPage_ClubBoard)..' / '..tostring(g_maxPage_ClubBoard), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	
end

function Setting_ClubBoardMaxPageIndex(BoardMaxPage)

    g_maxPage_ClubBoard = BoardMaxPage
    
    if g_curPage_ClubBoard > g_maxPage_ClubBoard then
		g_curPage_ClubBoard = g_curPage_ClubBoard -1 
	end
    winMgr:getWindow("Club_BoardList_PageText"):clearTextExtends()
    winMgr:getWindow("Club_BoardList_PageText"):addTextExtends( tostring(g_curPage_ClubBoard)..' / '..tostring(g_maxPage_ClubBoard), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
    
end

function Setting_ClubBoardCurIndex()
   
    if  g_curPage_ClubBoard > g_maxPage_ClubBoard then
		g_curPage_ClubBoard = g_maxPage_ClubBoard
	end 
end

------------------------------------
--클럽 보드 목록 업데이트 
------------------------------------
function Setting_ClubBoardList( BoardCount, BoardTextIndex , BoardCharName , BoardMsg,  BoardDay  )

	winMgr:getWindow(Club_Board_Radio[BoardCount+1]..ClubBoardText[1]):clearTextExtends()	
	winMgr:getWindow(Club_Board_Radio[BoardCount+1]..ClubBoardText[2]):clearTextExtends()
	winMgr:getWindow(Club_Board_Radio[BoardCount+1]..ClubBoardText[3]):clearTextExtends()
	
	if My_CharacterName == BoardCharName then
		winMgr:getWindow(Club_Board_Radio[BoardCount+1]..ClubBoardText[1]):addTextExtends(BoardCharName, g_STRING_FONT_GULIMCHE, 112,    200,170,10,255,     0,     0,0,0,255)
	else
		winMgr:getWindow(Club_Board_Radio[BoardCount+1]..ClubBoardText[1]):addTextExtends(BoardCharName, g_STRING_FONT_GULIMCHE, 112,    200,200,150,255,     0,     0,0,0,255)
	end
	winMgr:getWindow(Club_Board_Radio[BoardCount+1]..ClubBoardText[2]):addTextExtends(BoardMsg, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Club_Board_Radio[BoardCount+1]..ClubBoardText[3]):addTextExtends(BoardDay, g_STRING_FONT_GULIMCHE, 112,    80,150,200,255,     0,     0,0,0,255)
	
	
    local Realcount = BoardCount+1
   
    winMgr:getWindow(Club_Board_Radio[Realcount].."Club_Board_Delete"):setVisible(true);
    winMgr:getWindow(Club_Board_Radio[Realcount].."Club_Board_Delete"):setUserString("DelIndex", BoardTextIndex );
   
  
   
end

function OnClickInsertBoard()
	 DebugStr('OnClickInsertBoard()');
	 InsertMsg =winMgr:getWindow("Club_Board_EditBox"):getText()
	 DebugStr('InsertMsg:'..InsertMsg);
	 InsertBoardList(InsertMsg)  
end

function OnClickBoardDelete(args)
	 DebugStr('OnClickBoardDelete()');
	 local local_window = CEGUI.toWindowEventArgs(args).window;	
	 local win_name = local_window:getName();
	 DebugStr('win_name : '..win_name);
	 local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("DelIndex"))
	 DebugStr('index : '..index);
	 DeleteBoardList(index)
end

function RefreshBoard()

	for i=1 , 10 do
		
		winMgr:getWindow(Club_Board_Radio[i]..ClubBoardText[1]):clearTextExtends()
		winMgr:getWindow(Club_Board_Radio[i]..ClubBoardText[2]):clearTextExtends()
		winMgr:getWindow(Club_Board_Radio[i]..ClubBoardText[3]):clearTextExtends()
		winMgr:getWindow(Club_Board_Radio[i].."Club_Board_Delete"):setUserString("DelIndex",  tostring(-1) );
		winMgr:getWindow(Club_Board_Radio[i].."Club_Board_Delete"):setVisible(false);
		winMgr:getWindow("Club_Board_EditBox"):setText("");
	end
	
	
end

function RefreshClubList()

	for i=1 , #Club_List_Radio do
		winMgr:getWindow(Club_List_Radio[i]):setEnabled(false)
		winMgr:getWindow(Club_List_Radio[i]):setProperty('Selected', 'false')
	end
	
	for i=1, #Club_List_Radio do
		for j=1, #ClubListText do
			winMgr:getWindow(Club_List_Radio[i]..ClubListText[j]):clearTextExtends()
		end
	end
	
	for i=1, #Club_List_ClickInfo do
		winMgr:getWindow(Club_List_ClickInfo[i]):setText("")
	end
	winMgr:getWindow(Club_List_ClickInfo[7]):clearTextExtends()
	
end

function RefreshManageRadio()

	for i=1 , #Club_Manage_Radio do
		winMgr:getWindow(Club_Manage_Radio[i]):setEnabled(false)
	end
	
	for i=1 , #Club_Manage_Radio do
		for j=1 , #ClubManageText do
			winMgr:getWindow(Club_Manage_Radio[i]..ClubManageText[j]):clearTextExtends()
		end
		winMgr:getWindow(Club_Manage_Radio[i].."ClubManageLadderImage"):setTexture("Enabled", "UIData/invisible.tga",113, 600)
		winMgr:getWindow(Club_Manage_Radio[i].."ClubManageLadderImage"):setTexture("Disabled", "UIData/invisible.tga",113, 600)
		
		winMgr:getWindow(Club_Manage_Radio[i].."ClubManageClassImage"):setTexture("Enabled", "UIData/invisible.tga",113, 600)
		winMgr:getWindow(Club_Manage_Radio[i].."ClubManageClassImage"):setTexture("Disabled", "UIData/invisible.tga",113, 600)
		winMgr:getWindow(Club_Manage_Radio[i].."ClubManageClassImage"):setTexture("Layered", "UIData/invisible.tga",113, 600)
		
	end
	
	
end

function RefreshMemberRadio()

	for i=1 , #Club_Member_Radio do
		winMgr:getWindow(Club_Member_Radio[i]):setEnabled(false)
	end

	for i=1 , #Club_Member_Radio do
		for j=1 , #ClubMemberText do
		winMgr:getWindow(Club_Member_Radio[i]..ClubMemberText[j]):clearTextExtends()
		end
		winMgr:getWindow(Club_Member_Radio[i].."ClubMemberLadderImage"):setTexture("Enabled", "UIData/invisible.tga",113, 600)
		winMgr:getWindow(Club_Member_Radio[i].."ClubMemberLadderImage"):setTexture("Disabled", "UIData/invisible.tga",113, 600)
		
		winMgr:getWindow(Club_Member_Radio[i].."ClubMemberClassImage"):setTexture("Enabled", "UIData/invisible.tga",113, 600)
		winMgr:getWindow(Club_Member_Radio[i].."ClubMemberClassImage"):setTexture("Disabled", "UIData/invisible.tga",113, 600)
		winMgr:getWindow(Club_Member_Radio[i].."ClubMemberClassImage"):setTexture("Layered", "UIData/invisible.tga",113, 600)
	end
	
	
end
------------------------------------
---클럽 Manage 이전 페이지 이벤트
------------------------------------
		 
function  OnClickClubManageList_PrevPage()
    
    DebugStr('OnClickClubManageList_PrevPage');
	if	g_curPage_ClubManage > 1 then
			g_curPage_ClubManage = g_curPage_ClubManage - 1
			DebugStr('g_curPage_ClubManage:'..g_curPage_ClubManage);
			RefreshManageRadio()
			RequestClubMember(g_curPage_ClubManage, 2)
			winMgr:getWindow("Club_ManageList_PageText"):clearTextExtends()
            winMgr:getWindow("Club_ManageList_PageText"):addTextExtends( tostring(g_curPage_ClubManage)..' / '..tostring(g_maxPage_ClubManage), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	
end
------------------------------------
--클럽 Manage리스트 다음 페이지 이벤트
------------------------------------
function OnClickClubManageList_NextPage()

	DebugStr('OnClickClubManageList_NextPage');
	if	g_curPage_ClubManage < g_maxPage_ClubManage then
			g_curPage_ClubManage = g_curPage_ClubManage + 1
			DebugStr('g_curPage_ClubManage:'..g_curPage_ClubManage);
			RefreshManageRadio()
			RequestClubMember(g_curPage_ClubManage, 2)
			winMgr:getWindow("Club_ManageList_PageText"):clearTextExtends()
            winMgr:getWindow("Club_ManageList_PageText"):addTextExtends( tostring(g_curPage_ClubManage)..' / '..tostring(g_maxPage_ClubManage), g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	end
	
end

------------------------------------
--클럽 Manage 클럽소개창 이벤트
------------------------------------

function NextClubIntroEdit1()
	winMgr:getWindow("ClubIntroWrite_1"):setEnabled(false);
	winMgr:getWindow("ClubIntroWrite_1"):deactivate();
	winMgr:getWindow("ClubIntroWrite_2"):setEnabled(true);
	winMgr:getWindow("ClubIntroWrite_2"):setText("")
	
	winMgr:getWindow("ClubIntroWrite_2"):activate()
end

function NextClubIntroEdit2()
	winMgr:getWindow("ClubIntroWrite_2"):setEnabled(false);
	winMgr:getWindow("ClubIntroWrite_2"):deactivate();
	winMgr:getWindow("ClubIntroWrite_3"):setEnabled(true);
	winMgr:getWindow("ClubIntroWrite_3"):setText("")
	winMgr:getWindow("ClubIntroWrite_3"):activate()
end

function NextClubIntroEdit3()
	winMgr:getWindow("ClubIntroWrite_3"):activate()
end

--------------------------------------------
-- 클럽 소개 줄바꾸기
--------------------------------------------
function ClubIntroEditFull(args)

	for i = 1, #ClubIntroWrite do
		if winMgr:getWindow(ClubIntroWrite[i]):isActive() then
			winMgr:getWindow(ClubIntroWrite[i]):deactivate();
			winMgr:getWindow(ClubIntroWrite[i]):setEnabled(false);
				if i==3 then
					winMgr:getWindow(ClubIntroWrite[i]):activate();
					winMgr:getWindow(ClubIntroWrite[i]):setEnabled(true);
					return;
				end
			    winMgr:getWindow(ClubIntroWrite[i + 1]):setEnabled(true);
				winMgr:getWindow(ClubIntroWrite[i + 1]):activate();
				winMgr:getWindow(ClubIntroWrite[i + 1]):setText("")
				return;
		end
	end
end   
--------------------------------------------
-- 클럽 소개 지울때
--------------------------------------------
function ClubIntroEditEventBack(args)

	for i = 2, 3 do
	    local Debugwritebox =winMgr:getWindow(ClubIntroWrite[i]):getText()
	    DebugStr('Debugwritebox:'..Debugwritebox..i)
		if winMgr:getWindow(ClubIntroWrite[i]):isActive() and winMgr:getWindow(ClubIntroWrite[i]):getText()==""  then
			    winMgr:getWindow(ClubIntroWrite[i]):setEnabled(false);
			    winMgr:getWindow(ClubIntroWrite[i-1]):setEnabled(true);
				winMgr:getWindow(ClubIntroWrite[i-1]):activate();
				winMgr:getWindow(ClubIntroWrite[i]):deactivate();
				return;
		end
	end
end   
---------------------------------
--클럽관리 클럽소개 삭제
---------------------------------
function Club_Manage_Delete_Event()

	DebugStr('Club_Manage_Delete_Event()')
	for i = 1, 3 do
		winMgr:getWindow(ClubIntroWrite[i]):setText("")
		winMgr:getWindow(ClubIntroWrite[i]):deactivate();
		winMgr:getWindow(ClubIntroWrite[i]):setEnabled(false);
	end
	winMgr:getWindow(ClubIntroWrite[1]):setEnabled(true);
	winMgr:getWindow(ClubIntroWrite[1]):activate();
end
-------------------------------- 
--클럽관리 클럽소개 저장
--------------------------------
function Club_Manage_Save_Event()

	DebugStr('Club_Manage_Save_Event()')
	IntroText1 = winMgr:getWindow("ClubIntroWrite_1"):getText()
	IntroText2 = winMgr:getWindow("ClubIntroWrite_2"):getText()
	IntroText3 = winMgr:getWindow("ClubIntroWrite_3"):getText()
	
	
	IntroText = IntroText1.."\\n"..IntroText2.."\\n"..IntroText3  --.."\\n"..IntroText4.."\\n"..IntroText5
	DebugStr('IntroText:'..IntroText)
	SetUpClubIntro(IntroText)
end
--------------------------------
--클럽관리 초대하기 이벤트버튼
--------------------------------
function Club_Manage_Invite_Event()

	DebugStr('Club_Manage_Invite_Event()')
	root:addChildWindow(winMgr:getWindow("ClubManage_InviteImage"))
	winMgr:getWindow("ClubManage_InviteImage"):setVisible(true)
	winMgr:getWindow("ClubManage_TransImage"):setVisible(false)
	winMgr:getWindow("ClubManage_InviteEditbox"):activate()
end
--------------------------------
--클럽관리 직위설정
--------------------------------
function Club_Manage_SetGrade_Event()
	
	DebugStr('Club_Manage_SetGrade_Event()')
	winMgr:getWindow("ClubManage_SetGradeEditBox1"):setText(ClubGradeName1)
	winMgr:getWindow("ClubManage_SetGradeEditBox2"):setText(ClubGradeName2)
	winMgr:getWindow("ClubManage_SetGradeEditBox3"):setText(ClubGradeName3)
	winMgr:getWindow("ClubManage_SetGradeEditBox4"):setText(ClubGradeName4)
	winMgr:getWindow("ClubManage_SetGradeEditBox5"):setText(ClubGradeName5)
	winMgr:getWindow("ClubManage_SetGradeEditBox6")	:setText(ClubGradeName6)
	
	root:addChildWindow(winMgr:getWindow("ClubManage_SetGradeNameWindow"))
	winMgr:getWindow("ClubManage_SetGradeNameWindow"):setVisible(true)
	winMgr:getWindow("ClubManage_SetGradeEditBox1"):activate()
	
end
----------------------------------------------------------
--클럽 등급에 따라 클럽관리라디오 버튼 활성화 시킬지 결정
----------------------------------------------------------
function ChangeManageEnable(myclubgrade)

	if myclubgrade > 1 then
		OnClickClubName_Close()
	else
		winMgr:getWindow("ClubName_5"):setEnabled(true)
	end
	
end




--------------------------------
--클럽관리 클럽양도
--------------------------------
function Club_Manage_Trans_Event()

	DebugStr('Club_Manage_Trans_Event()')
	root:addChildWindow(winMgr:getWindow("ClubManage_TransImage"))
	winMgr:getWindow("ClubManage_InviteImage"):setVisible(false)
	winMgr:getWindow("ClubManage_TransImage"):setVisible(true)
	winMgr:getWindow("ClubManage_TransEditbox"):activate()
end
--------------------------------
--클럽관리 클럽폐쇄
--------------------------------
function Club_Manage_Close_Event()

	DebugStr('Club_Manage_Close_Event()')

	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2159, 'OnClickRemoveClubOk', 'OnClickRemoveClubCancel');
												--GetSStringInfo(LAN_LUA_DELETE_CLUB)
end

function OnClickRemoveClubOk()

	DebugStr('OnClickRemoveClubOk()')
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickRemoveClubOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	RemoveClub()
	
end

function OnClickRemoveClubCancel()

	DebugStr('OnClickRemoveClubCancel()')
	local noFunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if noFunc ~= "OnClickRemoveClubCancel" then
		return
	end
	
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	
end

--------------------------------------------
--클럽 관리자가 클럽원을 강제탈퇴 확인할때
--------------------------------------------
function OnClickBreakUserOk()

	DebugStr('OnClickBreakUserOk()')
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickBreakUserOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	BreakClubUser(OnClickCharName)
	RefreshPopupButton()
	
end
-------------------------------------------
--클럽 관리자가 클럽원을 강제탈퇴 취소할때
-------------------------------------------
function OnClickBreakUserCancel()

	DebugStr('OnClickBreakUserCancel()')
	local noFunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if noFunc ~= "OnClickBreakUserCancel" then
		return
	end
	
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	
end

--매니저 라디오 버튼 우클릭으로 팝업창을 호출
OnClickCharName = "Name"
function OnClubManageMouseRButtonUp(args)
	DebugStr('OnClubManageMouseRButtonUp() start');

	-- 캐릭터 네임을 알아온다.
	for i=1, #Club_PopupButtonName do
		winMgr:getWindow(Club_PopupButtonName[i]):setProperty('Selected', 'false')
	end
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	DebugStr('win_name : '..win_name);
	OnClickCharName = winMgr:getWindow(win_name..'ManageNickText'):getText();
	CharGrade = tonumber(winMgr:getWindow(win_name..'ManageGradeText'):getText());
	CharPosition = winMgr:getWindow(win_name..'ManagePositionText'):getText();
	DebugStr('CharGrade : '..CharGrade);
	DebugStr('My_CurrentGrade :'..My_CurrentGrade)
	if CharGrade == 6 then
		MakeClubPopup("Club_Popup_agreeJoin", "Club_Popup_refuseJoin")
	elseif CharGrade == 0 then
		MakeClubPopup("Club_Popup_Info")
	elseif CharGrade == 1 then
		if My_CurrentGrade == 0 then
			MakeClubPopup( "Club_Popup_AdMin", "Club_Popup_Info", "Club_Popup_out")
		elseif My_CurrentGrade == 1 then
			MakeClubPopup( "Club_Popup_Info")
		else
			MakeClubPopup( "Club_Popup_AdMin", "Club_Popup_Info")
		end
	
	else
		MakeClubPopup( "Club_Popup_AdMin", "Club_Popup_Info", "Club_Popup_out")
	end
	
end


function OnClubMemberMouseRButtonUp(args)
	DebugStr('OnClubManageMouseRButtonUp() start');
	
	-- 캐릭터 네임을 알아온다.
	for i=1, #Club_PopupButtonName do
		winMgr:getWindow(Club_PopupButtonName[i]):setProperty('Selected', 'false')
	end
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	DebugStr('win_name : '..win_name);
	OnClickCharName = winMgr:getWindow(win_name..'MemberNickText'):getText();
	CharGrade = tonumber(winMgr:getWindow(win_name..'MemberGradeText'):getText());
	CharPosition = winMgr:getWindow(win_name..'MemberPositionText'):getText();
	DebugStr('CharGrade : '..CharGrade);
	--[[
	local isMyMessengerFriend = IsMyMessengerFriend(OnClickCharName);
	if	OnClickCharName == My_CharacterName then
			MakeClubPopup("Club_Popup_Info")
	elseif isMyMessengerFriend == true then
			MakeClubPopup("Club_Popup_Info")
				
	else
			MakeClubPopup("Club_Popup_Info", "Club_Popup_AddFriend")
	end
	--]]
	
	
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	
	-- 광장일때만 체크 해준다.	
	local messenger_window = winMgr:getWindow('sj_messengerBackWindow');
	
	if messenger_window ~= nil then
	
		local messenger_visible = messenger_window:isVisible()
		if messenger_visible == false then
			local name
			name = OnClickCharName
					
			-- 나일경우 내정보만 띄운다.
			local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
			if name == _my_name then
				local m_pos = mouseCursor:getPosition()
				ShowPopupWindow(m_pos.x, m_pos.y, 1)
				g_strSelectRButtonUp = name
				winMgr:getWindow('pu_myInfo'):setProperty('Disabled', 'False')
				MakeMessengerPopup("pu_windowName", "pu_myInfo" ,"pu_profile")
				
			-- 다른사람 일 경우
			else
				local m_pos = mouseCursor:getPosition();
				ShowPopupWindow(m_pos.x, m_pos.y, 1);
				g_strSelectRButtonUp = name;
				
				local isMyMessengerFriend = IsMyMessengerFriend(name);
				
				if GetFriendState(name) == true then
					winMgr:getWindow('pu_showInfo'):setEnabled(true)
				else
					winMgr:getWindow('pu_showInfo'):setEnabled(false)
				end
				
				-- 현재 내 친구 목록 리스트에 있는지 확인한다.
				-- 내 친구 목록 리스트에 있으면
				if isMyMessengerFriend == true then
					winMgr:getWindow('pu_addFriend'):setEnabled(false)	-- 비활성
					winMgr:getWindow('pu_deleteFriend'):setEnabled(true)	-- 활성
					
				else -- 내친구 목록리스트에 없으면
					winMgr:getWindow('pu_addFriend'):setEnabled(true)	-- 활성
					winMgr:getWindow('pu_deleteFriend'):setEnabled(false)	-- 비활성
				end
				
				-- 귓속말도 왠만하면 돼긴하는데..
				winMgr:getWindow('pu_privatChat'):setEnabled(true)
				
				-- 파티 초대는 상대가 파티가 속해 있는지 없는지 확인해야 한다.
				winMgr:getWindow('pu_inviteParty'):setEnabled(false)
				winMgr:getWindow('pu_vanishParty'):setEnabled(false)	-- 비활성
				
				MakeMessengerPopup("pu_windowName", "pu_showInfo","pu_profile",  "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty");
			end
			return
				
			
		end
	end

end






function OnSelectedClubPopup(args)

	DebugStr('OnSelectedClubPopup start');
	
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
	
		local win_name = local_window:getName();
		DebugStr('win_name : ' .. win_name);
		if win_name == 'Club_Popup_agreeJoin' then
			DebugStr('Club_Popup_agreeJoin');
			
			DebugStr('OnClickCharName:'..OnClickCharName);
			ClubGradeChage(OnClickCharName, 5)
			RefreshPopupButton()
		
		elseif win_name == 'Club_Popup_refuseJoin' then
			DebugStr('Club_Popup_refuseJoin');
			BreakClubUser(OnClickCharName)
			RefreshPopupButton()
			
		elseif win_name ==  'Club_Popup_AdMin' then
			DebugStr('Club_Popup_AdMin');
			
		elseif win_name == 'Club_Popup_Info' then   -- 정보보기
			DebugStr('Club_Popup_Info');
			--InfoVisibleCheck(true);	
			GetCharacterInfo(OnClickCharName, 1);
			ShowUserInfoWindow()
			RefreshPopupButton()
			
		elseif win_name == 'Club_Popup_AddFriend' then --친구추가
			DebugStr('Club_Popup_AddFrien');
			local bRet = RequestNewFriend(OnClickCharName);
			DebugStr('bRet : ' .. tostring(bRet));
			if bRet == false then
				--ShowCommonAlertOkBoxWithFunction('친구추가를 실패했습니다.', 'OnClickAlertOkSelfHide');
				ShowCommonAlertOkBoxWithFunction(PreCreateString_1173,'OnClickAlertOkSelfHide');
													--GetSStringInfo(LAN_LUA_WND_MESSENGER_5)
			end	
			RefreshPopupButton()
			
		elseif win_name == 'Club_Popup_out' then      --강제탈퇴
			DebugStr('Club_Popup_AddFrien');
			RefreshPopupButton()
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_2169, OnClickCharName),  'OnClickBreakUserOk', 'OnClickBreakUserCancel');
																		--GetSStringInfo(LAN_LUA_AWAY_USER)
			
		elseif win_name == 'Club_Popup_grade1' then 
			DebugStr('Club_Popup_grade1');
		    ClubGradeChage(OnClickCharName, 1)
		    
		elseif win_name == 'Club_Popup_grade2' then 
			DebugStr('Club_Popup_grade2');
		    ClubGradeChage(OnClickCharName, 2)
		    
		elseif win_name == 'Club_Popup_grade3' then  
			DebugStr('Club_Popup_grade3');
		    ClubGradeChage(OnClickCharName, 3)
		    
		elseif win_name == 'Club_Popup_grade4' then  
			DebugStr('Club_Popup_grade4');
		    ClubGradeChage(OnClickCharName, 4)
		    
		elseif win_name == 'Club_Popup_grade5' then 
			DebugStr('Club_Popup_grade5');    
			ClubGradeChage(OnClickCharName, 5)
			
		end
		
	
	end
	
	
end



function RefreshPopupButton()
	for i=1, #Club_PopupButtonName do
		winMgr:getWindow(Club_PopupButtonName[i]):setProperty('Selected', 'false')
		winMgr:getWindow(Club_PopupButtonName[i]):setVisible(false);
		--root:removeChildWindow(winMgr:getWindow(Club_PopupButtonName[i]))
	end
	winMgr:getWindow('Club_PopupWindow'):setVisible(false);
	winMgr:getWindow('Club_PopupSubWindow'):setVisible(false);
end


-- 매니저 우클릭 팝업창
function MakeClubPopup(...)
	
	DebugStr('MakeClubPopup start');
	m_pos = mouseCursor:getPosition()
	-- 타입을 지정해준다.
	DebugStr('MakeClubPopup start');
	winMgr:getWindow('Club_PopupWindow'):setVisible(false);
	winMgr:getWindow('pu_Topline'):setVisible(false);
	winMgr:getWindow('pu_Topline'):setVisible(false);
	root:removeChildWindow(winMgr:getWindow('Club_PopupWindow'))
	winMgr:getWindow("Club_PopupWindow"):removeChildWindow(winMgr:getWindow("pu_Topline"))
	winMgr:getWindow("Club_PopupWindow"):removeChildWindow(winMgr:getWindow("pu_Bottomline"))
	
	for i=1, #Club_PopupButtonName do
		winMgr:getWindow(Club_PopupButtonName[i]):setVisible(false);
		winMgr:getWindow('Club_PopupWindow'):removeChildWindow(winMgr:getWindow(Club_PopupButtonName[i]))
	end
	
	local para_count = select('#', ...)
	local win_name = 'none';
	
	if para_count > 0 then
		
		for i=1, para_count do
		
			win_name = select(i, ...);
			winMgr:getWindow(win_name):setPosition(0, (i-1)*22)
			winMgr:getWindow(win_name):setVisible(true)
			winMgr:getWindow('Club_PopupWindow'):addChildWindow(winMgr:getWindow(win_name))
		end
	end	
	
	root:addChildWindow(winMgr:getWindow('Club_PopupWindow'))
	winMgr:getWindow('Club_PopupWindow'):setVisible(true);
	winMgr:getWindow('Club_PopupWindow'):setPosition(m_pos.x, m_pos.y);

	winMgr:getWindow('pu_Topline'):setPosition(0, 0)
	winMgr:getWindow('pu_Bottomline'):setPosition(0, para_count*22)
	winMgr:getWindow("Club_PopupWindow"):addChildWindow(winMgr:getWindow("pu_Topline"))
	winMgr:getWindow("Club_PopupWindow"):addChildWindow(winMgr:getWindow("pu_Bottomline"))
	winMgr:getWindow('pu_Topline'):setVisible(true);
	winMgr:getWindow('pu_Bottomline'):setVisible(true);
	
	DebugStr('MakeClubPopup end');
end


function MakeSubClubPopup(...)
	
	DebugStr('MakeClubPopup start');
	-- 타입을 지정해준다.
	DebugStr('MakeClubPopup start');
	winMgr:getWindow('Club_PopupSubWindow'):setVisible(false);
	root:removeChildWindow(winMgr:getWindow('Club_PopupSubWindow'))
	winMgr:getWindow("Club_PopupSubWindow"):removeChildWindow(winMgr:getWindow("pu_SubTopline"))
	winMgr:getWindow("Club_PopupSubWindow"):removeChildWindow(winMgr:getWindow("pu_SubBottomline"))
	
	for i=1, #Club_PopupButtonName do
		--winMgr:getWindow(Club_PopupButtonName[i]):setVisible(false);
		winMgr:getWindow('Club_PopupSubWindow'):removeChildWindow(winMgr:getWindow(Club_PopupButtonName[i]))
	end
	
	local para_count = select('#', ...)
	local win_name = 'none';
	
	if para_count > 0 then
		
		for i=1, para_count do
		
			win_name = select(i, ...);
			winMgr:getWindow(win_name):setPosition(0, (i-1)*22)
			winMgr:getWindow(win_name):setVisible(true)
			winMgr:getWindow('Club_PopupSubWindow'):addChildWindow(winMgr:getWindow(win_name))
		end
	end	
	
	root:addChildWindow(winMgr:getWindow('Club_PopupSubWindow'))
	winMgr:getWindow('Club_PopupSubWindow'):setVisible(true);
	winMgr:getWindow('Club_PopupSubWindow'):setPosition(m_pos.x+94, m_pos.y);
	
	winMgr:getWindow('pu_SubTopline'):setPosition(0, 0)
	winMgr:getWindow('pu_SubBottomline'):setPosition(0, para_count*22)
	winMgr:getWindow("Club_PopupSubWindow"):addChildWindow(winMgr:getWindow("pu_SubTopline"))
	winMgr:getWindow("Club_PopupSubWindow"):addChildWindow(winMgr:getWindow("pu_SubBottomline"))
	winMgr:getWindow('pu_SubTopline'):setVisible(true);
	winMgr:getWindow('pu_SubBottomline'):setVisible(true);
	
	DebugStr('MakeSubClubPopup end');
end

function OnPopupMouseMove(args)

	DebugStr('OnPopupMouseMove() start');
	
	local local_window = CEGUI.toMouseEventArgs(args).window;
	local win_name = local_window:getName();
	DebugStr('win_name : ' .. win_name);
	
	
	if win_name == 'Club_Popup_AdMin' then
		DebugStr('Club_Popup_Admin');
		if My_CurrentGrade == 0 then
			MakeSubClubPopup("Club_Popup_grade1", "Club_Popup_grade2", "Club_Popup_grade3", "Club_Popup_grade4", "Club_Popup_grade5")
		else
			MakeSubClubPopup("Club_Popup_grade2", "Club_Popup_grade3", "Club_Popup_grade4", "Club_Popup_grade5")
		end
	else
		DebugStr('Not Club_Popup_Admin');
		winMgr:getWindow('Club_PopupSubWindow'):setVisible(false);
		root:removeChildWindow(winMgr:getWindow('Club_PopupSubWindow'))
		winMgr:getWindow("Club_PopupSubWindow"):removeChildWindow(winMgr:getWindow("pu_SubTopline"))
		winMgr:getWindow("Club_PopupSubWindow"):removeChildWindow(winMgr:getWindow("pu_SubBottomline"))
		
		for i=1, #Club_PopupButtonName do
			--winMgr:getWindow(Club_PopupButtonName[i]):setVisible(false);
			winMgr:getWindow('Club_PopupSubWindow'):removeChildWindow(winMgr:getWindow(Club_PopupButtonName[i]))
		end
	end
	
	
end


--매니저 라디오버튼 선택
function OnSelectedClubMember()
	
	for i=1, #Club_PopupButtonName do
		winMgr:getWindow(Club_PopupButtonName[i]):setVisible(false);
		winMgr:getWindow('Club_PopupWindow'):removeChildWindow(winMgr:getWindow(Club_PopupButtonName[i]))
	end

end
-----------------------------------------------------------------------------------------------------
--------------------------------------------
--클럽 초대하기 에디트박스 입력후 버튼 누를시
--------------------------------------------
function OnClickInviteMember()
	
	DebugStr('OnClickInviteMember()');
	InviteMemberID = winMgr:getWindow("ClubManage_InviteEditbox"):getText()
	if InviteMemberID == "" then
		return
	end
	DebugStr('InviteMemberID:'..InviteMemberID);
	InviteClubMember(InviteMemberID)
end

ReturnCharName = 'name'
ReturnClubName  = 'club'
function RequestInviteClubMember(InvitedCharName, InviteClubName)
	
	
	DebugStr('RequestInviteClubMember()');
	DebugStr('InvitedCharName:'..InvitedCharName);
	DebugStr('InviteClubName:'..InvitedCharName);
	ReturnCharName = InvitedCharName
	ReturnClubName = InviteClubName
    ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_2152, ReturnCharName, ReturnClubName),  'OnClickInviteClubQuestOk', 'OnClickInviteClubQuestCancel');
																--GetSStringInfo(LAN_LUA_INVITE_CLUB)
end

------- 검색된 멤버한테 양도하기 이벤트

function OnClickIGive()

	DebugStr('OnClickIGive()');
	
	ChangeMasterName = winMgr:getWindow('ClubManage_TransEditbox'):getText()
	if ChangeMasterName == "" then
		return
	end
	ChangeClubMaster(ChangeMasterName)
	
end

------ 등급 이름 변경하기 이벤트

function OnClickSetGrade()
	DebugStr('OnClickSetGrade()');
	ClubManage_SetGradeEditBox  = {["err"]=0, "ClubManage_SetGradeEditBox1", "ClubManage_SetGradeEditBox2" ,"ClubManage_SetGradeEditBox3",
										  "ClubManage_SetGradeEditBox4", "ClubManage_SetGradeEditBox5" , "ClubManage_SetGradeEditBox6"}
										  
	local GradeName1 = winMgr:getWindow('ClubManage_SetGradeEditBox1'):getText()
	local GradeName2 = winMgr:getWindow('ClubManage_SetGradeEditBox2'):getText()
	local GradeName3 = winMgr:getWindow('ClubManage_SetGradeEditBox3'):getText()
	local GradeName4 = winMgr:getWindow('ClubManage_SetGradeEditBox4'):getText()
	local GradeName5 = winMgr:getWindow('ClubManage_SetGradeEditBox5'):getText()
	local GradeName6 = winMgr:getWindow('ClubManage_SetGradeEditBox6'):getText()
	
	DebugStr('GradeName1:'..GradeName1);
	DebugStr('GradeName1:'..GradeName2);
	DebugStr('GradeName1:'..GradeName3);
	DebugStr('GradeName1:'..GradeName4);
	DebugStr('GradeName1:'..GradeName5);
	DebugStr('GradeName1:'..GradeName6);
	
	UpdateClubSetGradeName(GradeName1, GradeName2, GradeName3, GradeName4, GradeName5, GradeName6)
	
end

function Setting_ClubGradeList(GradeNameList1, GradeNameList2, GradeNameList3, GradeNameList4, GradeNameList5, GradeNameList6)

	
	ClubGradeName1 = GradeNameList1
	ClubGradeName2 = GradeNameList2
	ClubGradeName3 = GradeNameList3
	ClubGradeName4 = GradeNameList4
	ClubGradeName5 = GradeNameList5
	ClubGradeName6 = GradeNameList6
	
	for i=7, #Club_PopupButtonName do
		winMgr:getWindow(Club_PopupButtonName[i].."ClubPopupText"):clearTextExtends()
	end
		
	winMgr:getWindow(Club_PopupButtonName[7].."ClubPopupText"):addTextExtends(GradeNameList2, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Club_PopupButtonName[8].."ClubPopupText"):addTextExtends(GradeNameList3, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Club_PopupButtonName[9].."ClubPopupText"):addTextExtends(GradeNameList4, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Club_PopupButtonName[10].."ClubPopupText"):addTextExtends(GradeNameList5, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Club_PopupButtonName[11].."ClubPopupText"):addTextExtends(GradeNameList6, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
end



function NextGradeEdit2()
	winMgr:getWindow("ClubManage_SetGradeEditBox2"):activate()
end

function NextGradeEdit3()
	winMgr:getWindow("ClubManage_SetGradeEditBox3"):activate()
end

function NextGradeEdit4()
	winMgr:getWindow("ClubManage_SetGradeEditBox4"):activate()
end

function NextGradeEdit5()
	winMgr:getWindow("ClubManage_SetGradeEditBox5"):activate()
end

function NextGradeEdit6()
	winMgr:getWindow("ClubManage_SetGradeEditBox6"):activate()
end

function NextGradeEdit1()
	winMgr:getWindow("ClubManage_SetGradeEditBox1"):activate()
end



------------------------------------------
-- 클럽초대 수락--------------------------
------------------------------------------
function OnClickInviteClubQuestOk()
	 DebugStr('OnClickInviteClubQuestOk()');
	 local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickInviteClubQuestOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	
	 RequestResult = 0
	 ReturnInviteClub(RequestResult, ReturnCharName, ReturnClubName)
end
------------------------------------------
-- 클럽초대 거절--------------------------
------------------------------------------
function OnClickInviteClubQuestCancel()
	DebugStr('OnClickInviteClubQuestCancel()');
	
	local noFunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if noFunc ~= "OnClickInviteClubQuestCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	
	RequestResult = 1
	ReturnInviteClub(RequestResult, ReturnCharName, ReturnClubName)
end
---------------------------------------------------------------------------------------------------------
------------------------------------------
-- 클럽마스터 변경요청이 왔을시
------------------------------------------
function RequestNewClubMaster()

	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2158, 'OnClickMasterOk', 'OnClickMasterNo');
end												--GetSStringInfo(LAN_LUA_CLUBMASTER_REQUEST)

------------------------------------------
-- 클럽마스터 수락
------------------------------------------
function OnClickMasterOk()
	 DebugStr('OnClickMasterOk()');
	 local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickMasterOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	ChangeClubMasterAnswer(0)
end
------------------------------------------
-- 클럽마스터 거절------------------------
------------------------------------------
function OnClickMasterNo()
	DebugStr('OnClickMasterNo()');
	local noFunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if noFunc ~= "OnClickMasterNo" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	ChangeClubMasterAnswer(1)
	
end

-- 클럽 생성창 관련 등록
function CreateClubWindows()
	winMgr:getWindow("sj_club_createWindow"):setVisible(true)
	winMgr:getWindow("ClubCreateNotice"):setVisible(false)
	RegistEscEventInfo("sj_club_createWindow", "CloseFightClubInfo")
end

function CreateNoticeWindows()
	winMgr:getWindow("sj_club_createWindow"):setVisible(false)
	winMgr:getWindow("ClubCreateNotice"):setVisible(true)
	--winMgr:getWindow("sj_debugBtn_222"):setVisible(false)
	RegistEscEventInfo("ClubCreateNotice", "CloseClubCreateNotice")
end


-- 클럽 생성창 닫기
function CloseCreateClubWindows()
	winMgr:getWindow("sj_club_createWindow"):setVisible(false)
	winMgr:getWindow("ClubCreateNotice"):setVisible(false)
	winMgr:getWindow("sj_club_clubName_editbox"):setText("")
	winMgr:getWindow("sj_club_clubUrl_editbox"):setText("")
	winMgr:getWindow("sj_club_clubTitle_editbox"):setText("")
	winMgr:getWindow("sj_club_clubEmblemName_editbox"):setText("basic.tga")
	winMgr:getWindow("sj_club_clubEmblemImage"):setVisible(false)
	VirtualImageSetVisible(false)
	TownNpcEscBtnClickEvent()
	--winMgr:getWindow("sj_debugBtn_222"):setVisible(true)
end

function CloseFightClubInfo()
	CloseCreateClubWindows()
	CancelCreateClub()
end

-- 클럽 생성불가창 닫기
function CloseClubCreateNotice()
	winMgr:getWindow("ClubCreateNotice"):setVisible(false)
	VirtualImageSetVisible(false)
	TownNpcEscBtnClickEvent()
end


-- 클럽이름 중복확인
function ConfirmDuplicatusClubInfos(args)
	local clubInfo = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("clubInfo"))
	local strClubInfo = ""
	if clubInfo == 0 then
		strClubInfo = winMgr:getWindow("sj_club_clubName_editbox"):getText()
	elseif clubInfo == 1 then
		strClubInfo = winMgr:getWindow("sj_club_clubUrl_editbox"):getText()
	elseif clubInfo == 2 then
		strClubInfo = winMgr:getWindow("sj_club_clubTitle_editbox"):getText()
	end
	SendToDuplicatusClubInfos(clubInfo, strClubInfo)
end


-- 클럽마크 등록
function LoadClubMark()
	
	local EmblemName = winMgr:getWindow('sj_club_clubEmblemName_editbox'):getText()
	CallFileDialogToLoadClubMark(EmblemName)
end

function ShowClubMark(markName)
	winMgr:getWindow("sj_club_clubEmblemImage"):setVisible(true)
	winMgr:getWindow("sj_club_clubEmblemImage"):setTexture('Enabled', markName, 0, 0)
	winMgr:getWindow("sj_club_clubEmblemImage"):setTexture('Disabled', markName, 0, 0)
	winMgr:getWindow("sj_club_clubEmblemImage"):setSize(32, 32)
	winMgr:getWindow("sj_club_clubEmblemImage"):setScaleWidth(190)
	winMgr:getWindow("sj_club_clubEmblemImage"):setScaleHeight(190)	
end

function RegiClubMark(ClubMarkName)
	winMgr:getWindow("Club_clubEmbleImage"):setVisible(true)
	winMgr:getWindow("Club_clubEmbleImage"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..ClubMarkName..".tga", 0, 0)
	winMgr:getWindow("Club_clubEmbleImage"):setTexture('Disabled', GetClubDirectory(GetLanguageType())..ClubMarkName..".tga", 0, 0)
	winMgr:getWindow("Club_clubEmbleImage"):setSize(32, 32)
	winMgr:getWindow("Club_clubEmbleImage"):setScaleWidth(255)
	winMgr:getWindow("Club_clubEmbleImage"):setScaleHeight(255)	

end

function ResetClubMark()
	winMgr:getWindow("Club_clubEmbleImage"):setVisible(false)
	winMgr:getWindow("Club_clubEmbleImage"):setTexture('Enabled', 'UIData/Invisible.tga', 0, 0)
	winMgr:getWindow("Club_clubEmbleImage"):setTexture('Disabled', 'UIData/Invisible.tga', 0, 0)
	winMgr:getWindow("Club_clubEmbleImage"):setSize(32, 32)
	winMgr:getWindow("Club_clubEmbleImage"):setScaleWidth(255)
	winMgr:getWindow("Club_clubEmbleImage"):setScaleHeight(255)	

end



function ClubListMark(ListMarkName)
	winMgr:getWindow("Club_List_Emble"):setVisible(true)
	winMgr:getWindow("Club_List_Emble"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..ListMarkName..".tga", 0, 0)
	winMgr:getWindow("Club_List_Emble"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..ListMarkName..".tga", 0, 0)

	winMgr:getWindow("Club_List_Emble"):setSize(32, 32)
	winMgr:getWindow("Club_List_Emble"):setScaleWidth(255)
	winMgr:getWindow("Club_List_Emble"):setScaleHeight(255)	

end

function ClubListMarkReset()
	
	winMgr:getWindow("Club_List_Emble"):setVisible(true)
	winMgr:getWindow("Club_List_Emble"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	winMgr:getWindow("Club_List_Emble"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	winMgr:getWindow("Club_List_Emble"):setSize(32, 32)
	winMgr:getWindow("Club_List_Emble"):setScaleWidth(255)
	winMgr:getWindow("Club_List_Emble"):setScaleHeight(255)	

end

-- 파이트 클럽 생성시 확인창
function ConfirmIsCreateFightClub()
	--IsQualifiedCreateClub()
	local strClubName	= winMgr:getWindow("sj_club_clubName_editbox"):getText()
	local strClubTitle	= winMgr:getWindow("sj_club_clubTitle_editbox"):getText()
	if (strClubName == "") or (strClubTitle == "") then
		local STRING_PREPARING = PreCreateString_2183	--GetSStringInfo(LAN_NOT_SHORT_CLUBNAME) -- 클럽이름과 칭호는 4자이상이여야 합니다.
		ShowNotifyOKMessage_Lua(STRING_PREPARING)
	return
	end
	local STRING = PreCreateString_1096	--GetSStringInfo(LAN_LUA_FIGHT_CLUB_1)	-- 클럽을 생성하면 1만그랑이 소모됩니다.\n생성하시겠습니까?
	ShowCommonAlertOkCancelBoxWithFunction('', STRING, 'RegistryFightClub', 'CancelRegistryFightClub')
end



-- 파이트 클럽 등록하기
function RegistryFightClub()
	local okFunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okFunc ~= "RegistryFightClub" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	local strClubName	= winMgr:getWindow("sj_club_clubName_editbox"):getText()
	local strClubURL	= winMgr:getWindow("sj_club_clubUrl_editbox"):getText()
	local strClubTitle	= winMgr:getWindow("sj_club_clubTitle_editbox"):getText()
	REGIST_CREATECLUB(strClubName, strClubURL, strClubTitle)
end


function RegistCreateClub()
	local strClubName	= winMgr:getWindow("sj_club_clubName_editbox"):getText()
	local strClubURL	= winMgr:getWindow("sj_club_clubUrl_editbox"):getText()
	local strClubTitle	= winMgr:getWindow("sj_club_clubTitle_editbox"):getText()
	SendCreateClub(strClubName, strClubURL, strClubTitle)
end

-- 파이트 클럽 생성 취소
function CancelRegistryFightClub()
	local noFunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if noFunc ~= "CancelRegistryFightClub" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	--CloseFightClubInfo()
end

function RefreshClub()
	
end

-- 파이트클럽 생성창 Tap 이벤트
function ClubInputChinho()
	winMgr:getWindow('sj_club_clubTitle_editbox'):activate()
end
function ClubInputName()
	winMgr:getWindow('sj_club_clubName_editbox'):activate()
end

function ClubInputMark()
	winMgr:getWindow('sj_club_clubEmblemName_editbox'):activate()
end


-- 메인 라디오버튼 탭 선택시 호출되는 이벤트들 ---------------------------------------------------------
function Club_Info()
	if CEGUI.toRadioButton( winMgr:getWindow('ClubName_1') ):isSelected() == true then
		DebugStr('Club Info Click')
		Club_Menu_BackImage_Defualt()
		winMgr:getWindow(Club_Menu_BackImage[1]):setVisible(true)
		RequestClubInfo()
		RefreshPopupButton()
	end
end

function Club_Member()
	if CEGUI.toRadioButton( winMgr:getWindow('ClubName_2') ):isSelected() == true then
		DebugStr('Club_Member Click')
		Club_Menu_BackImage_Defualt()
		winMgr:getWindow(Club_Menu_BackImage[2]):setVisible(true)
		RequestClubGradeList()
		RefreshMemberRadio()
		RequestClubMember(g_curPage_ClubMember, 1)
		RefreshPopupButton()
	end
end

function Club_Stats()
	if CEGUI.toRadioButton( winMgr:getWindow('ClubName_3') ):isSelected() == true then
		DebugStr('Club_Stats Click')
		Club_Menu_BackImage_Defualt()
		winMgr:getWindow(Club_Menu_BackImage[3]):setVisible(true)
		RefreshPopupButton()
	end
end

function Club_Board()
	if CEGUI.toRadioButton( winMgr:getWindow('ClubName_4') ):isSelected() == true then
		DebugStr('Club_Board Click')
		Club_Menu_BackImage_Defualt()
		winMgr:getWindow(Club_Menu_BackImage[4]):setVisible(true)
		RefreshBoard()
		RequestBoardList(g_curPage_ClubBoard)
		RefreshPopupButton()
		
	end
end

function Club_Manager()
	if CEGUI.toRadioButton( winMgr:getWindow('ClubName_5') ):isSelected() == true then
		DebugStr('Club_Manager')
		Club_Menu_BackImage_Defualt()
		winMgr:getWindow(Club_Menu_BackImage[5]):setVisible(true)
		RequestClubGradeList()
		RefreshManageRadio()
		RequestClubMember(g_curPage_ClubManage, 2)
		RefreshPopupButton()
	end
end
---------------------------------------------------------------------------------------------------------

-- 서브 백판 이미지 false
function Club_Menu_BackImage_Defualt()

	for i=1, #Club_Menu_BackImage do
		winMgr:getWindow(Club_Menu_BackImage[i]):setVisible(false)
	end
  
end

function Setting_MyName(MyCharacterName)
	My_CharacterName = MyCharacterName
	DebugStr('My_CharacterName:'..My_CharacterName)
end

function OnBaloonEffect()
	
	local Balloon_Visible = winMgr:getWindow('MainBar_Club_EffectImage'):isVisible()
	local clubName_visible = winMgr:getWindow('FightClub_ClubNameWindow'):isVisible()
	if Balloon_Visible == false and clubName_visible == false then
		DebugStr('Club Balloon on')
		Mainbar_ActiveEffect(BAR_BUTTONTYPE_CLUB)
	end
end

function checktime()
DebugStr('보내기')
end

----------------------------------------------------------------클럽전용---------------------------------------
function ResponseInviteClubTeam(leaderName)
	ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_2268, leaderName), 'OnClickInviteTeamOk', 'OnClickInviteTeamCancel');
end																--GetSStringInfo(LAN_CLUBMATCH_INVITE)

------------------------------------------
-- 클럽팀 초대 수락
------------------------------------------
function OnClickInviteTeamOk()
	 DebugStr('OnClickInviteTeamOk()');
	 local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickInviteTeamOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	ResponseInviteAccecpt()
end

------------------------------------------
-- 클럽팀 초대 거절------------------------
------------------------------------------
function OnClickInviteTeamCancel()
	DebugStr('OnClickInviteTeamCancel()');
	local noFunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if noFunc ~= "OnClickInviteTeamCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
end

end