------------------------------------------------------------------------

-- Äù½ºÆ®ÀÇ ÁøÇà À§Ä¡¸¦ ¼¼ÆÃÇÑ´Ù

------------------------------------------------------------------------
local QUEST_TYPE_OCCUR		  = 1
local QUEST_TYPE_OCCUR_ACCEPT = 2
local QUEST_TYPE_COMPLETE	  = 3

------------------------------------------------------------------------

local MAX_QUESTNUMBER = 100				-- Äù½ºÆ®ÀÇ °¹¼ö¸¦ ¼¼ÆÃÇÑ´Ù.

------------------------------------------------------------------------

tQuestTargetPos = {['err']=0, }
for i=1, MAX_QUESTNUMBER do
	tQuestTargetPos[i] = {['err']=0, }
end 

-------------------------- Äù½ºÆ® ÁøÇàÀ§Ä¡ ½ÃÀÛ --------------------------

tQuestTargetPos[1][QUEST_TYPE_OCCUR]		= {['err']=0, 0, 0, 0}	-- 
tQuestTargetPos[1][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 0, 0, 0}	-- 
tQuestTargetPos[1][QUEST_TYPE_COMPLETE]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[2][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[2][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- ´ëÀü Æ÷Å»
tQuestTargetPos[2][QUEST_TYPE_COMPLETE]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[3][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[3][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[3][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[4][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[4][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[4][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[5][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[5][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[5][QUEST_TYPE_COMPLETE]		= {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[6][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[6][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -113, 4868, 0}	-- °ø¿ø¾ÆÄÉÀÌµå
tQuestTargetPos[6][QUEST_TYPE_COMPLETE]		= {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[7][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[7][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[7][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[8][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®
tQuestTargetPos[8][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®
tQuestTargetPos[8][QUEST_TYPE_COMPLETE]		= {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®

tQuestTargetPos[9][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®
tQuestTargetPos[9][QUEST_TYPE_COMPLETE]		= {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®

tQuestTargetPos[10][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[10][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2937, 2538, 0}        -- Æ®·¹ÀÌ´× ¼¾ÅÍ
tQuestTargetPos[10][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç





tQuestTargetPos[11][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[11][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -113, 4868, 0}	-- °ø¿ø¾ÆÄÉÀÌµå
tQuestTargetPos[11][QUEST_TYPE_COMPLETE]		= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[12][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[12][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- ´ëÀü Æ÷Å»
tQuestTargetPos[12][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[13][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[13][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[13][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- ´ëÀü Æ÷Å»
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[15][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[15][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[15][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[16][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[16][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[16][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[17][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[17][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -113, 4868, 0}	-- °ø¿ø¾ÆÄÉÀÌµå
tQuestTargetPos[17][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[18][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[18][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[18][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[19][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[19][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[19][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[20][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[20][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[20][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[21][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[21][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[21][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[22][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[22][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[22][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[23][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[23][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -113, 4868, 0}	-- °ø¿ø¾ÆÄÉÀÌµå
tQuestTargetPos[23][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[24][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[24][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[24][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[25][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[25][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[25][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[26][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[26][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[26][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[27][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[27][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[27][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[28][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[28][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[28][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[29][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[29][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[29][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[30][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[30][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[30][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[31][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[31][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[31][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[32][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[32][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[32][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[33][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[33][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[33][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[34][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[34][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[34][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[35][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[35][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[35][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[36][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[36][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[36][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[37][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[37][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[37][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[38][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[38][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[39][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[39][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[39][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[40][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[40][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[40][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[41][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[41][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[41][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[42][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[42][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[42][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[43][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[43][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[43][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[44][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[44][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[44][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[45][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[45][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[45][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[46][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[46][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[46][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[47][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[47][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[47][QUEST_TYPE_COMPLETE]= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[48][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[48][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[48][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[49][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[49][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[49][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[50][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[50][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[50][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[51][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[51][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[51][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[52][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[52][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[52][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[53][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[53][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[53][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[54][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[54][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[54][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[55][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[55][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[55][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[56][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[56][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

--Çø¿À½º·¯¿î ¹°°Ç--
tQuestTargetPos[57][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[57][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[57][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[58][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[58][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[58][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[59][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[59][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[60][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[60][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[60][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[61][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[61][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1381, -1377, 0}	-- ´ÚÅÍ.k
tQuestTargetPos[61][QUEST_TYPE_COMPLETE]	= {['err']=0, -1381, -1377, 0}	-- ´ÚÅÍ.k

tQuestTargetPos[62][QUEST_TYPE_OCCUR]		= {['err']=0, -1381, -1377, 0}	-- ´ÚÅÍ.k
tQuestTargetPos[62][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1381, -1377, 0}	-- ´ÚÅÍ.k
tQuestTargetPos[62][QUEST_TYPE_COMPLETE]	= {['err']=0, -1381, -1377, 0}	-- ´ÚÅÍ.k

tQuestTargetPos[63][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[63][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}    -- ´ëÀü Æ÷Å»
tQuestTargetPos[63][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[64][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[64][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°


--tQuestTargetPos[65][QUEST_TYPE_OCCUR]		= {['err']=0, -2009, 4001, 0}	-- Â÷ÀÌ³ª »óÁ¡ À¯Å°
--tQuestTargetPos[65][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}    -- ´ëÀü Æ÷Å»
--tQuestTargetPos[65][QUEST_TYPE_COMPLETE]	= {['err']=0, -2009, 4001, 0}	-- Â÷ÀÌ³ª »óÁ¡ À¯Å°

--tQuestTargetPos[65][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
--tQuestTargetPos[65][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
--tQuestTargetPos[65][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[65][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç   (ÅÛÇÃ »þ¿ÀÃµ 2È¸ ÀâÀ¸¸é »ç¹«¶óÀÌ 1ÀÏ ±â°£Á¦ ÁÖ´Â Äù)
tQuestTargetPos[65][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=4497, 850, 0, 80}	-- Â÷ÀÌ³ª »ç³ÉÅÍ Æ÷Å»
tQuestTargetPos[65][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[66][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[66][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

--tQuestTargetPos[63][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç (ÆøÅºÀü ÀÌº¥Æ®)
--tQuestTargetPos[63][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}    -- ´ëÀü Æ÷Å»
--tQuestTargetPos[63][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
--------------------------- Äù½ºÆ® ÁøÇàÀ§Ä¡ ³¡ ---------------------------



------------------------------------------------------------------------
-- Äù½ºÆ® Á¶°ÇÀ» ¼¼ÆÃÇÑ´Ù.
------------------------------------------------------------------------

tQuestCondition = {['err']=0, }

for i=1, MAX_QUESTNUMBER do
	tQuestCondition[i] = {['err']=0, }
end


-------------------------- Äù½ºÆ® Á¶°Ç ½ÃÀÛ --------------------------

tQuestCondition[1] = {['err']=0, [0]= 2787	, 0	, 0	, 0	, 0	}
tQuestCondition[2] = {['err']=0, [0]= 2833	, 0	, 0	, 0	, 0	}
tQuestCondition[3] = {['err']=0, [0]= 2788	, 0	, 0	, 0	, 0	}
tQuestCondition[4] = {['err']=0, [0]= 2789	, 0	, 0	, 0	, 0	}
tQuestCondition[5] = {['err']=0, [0]= 2834	, 0	, 0	, 0	, 0	}
tQuestCondition[6] = {['err']=0, [0]= 2835	, 0	, 0	, 0	, 0	}
tQuestCondition[7] = {['err']=0, [0]= 2852	, 0	, 0	, 0	, 0	}
tQuestCondition[8] = {['err']=0, [0]= 2836	, 0	, 0	, 0	, 0	}
tQuestCondition[9] = {['err']=0, [0]= 3366	, 0	, 0	, 0	, 0	}
tQuestCondition[10] = {['err']=0, [0]= 3373	, 0	, 0	, 0	, 0	}


tQuestCondition[11] = {['err']=0, [0]= 2859	, 0	, 0	, 0	, 0	}
tQuestCondition[12] = {['err']=0, [0]= 2888	, 0	, 0	, 0	, 0	}
tQuestCondition[13] = {['err']=0, [0]= 2868	, 0	, 0	, 0	, 0	}
tQuestCondition[14] = {['err']=0, [0]= 2875	, 0	, 0	, 0	, 0	}
tQuestCondition[15] = {['err']=0, [0]= 2882	, 0	, 0	, 0	, 0	}
tQuestCondition[16] = {['err']=0, [0]= 3025	, 0	, 0	, 0	, 0	}
tQuestCondition[17] = {['err']=0, [0]= 3031	, 0	, 0	, 0	, 0	}
tQuestCondition[18] = {['err']=0, [0]= 3039	, 0	, 0	, 0	, 0	}
tQuestCondition[19] = {['err']=0, [0]= 3046	, 0	, 0	, 0	, 0	}
tQuestCondition[20] = {['err']=0, [0]= 3053	, 0	, 0	, 0	, 0	}
tQuestCondition[21] = {['err']=0, [0]= 3060	, 0	, 0	, 0	, 0	}
tQuestCondition[22] = {['err']=0, [0]= 3071	, 0	, 0	, 0	, 0	}
tQuestCondition[23] = {['err']=0, [0]= 3078	, 0	, 0	, 0	, 0	}
tQuestCondition[24] = {['err']=0, [0]= 3085	, 0	, 0	, 0	, 0	}
tQuestCondition[25] = {['err']=0, [0]= 3091	, 0	, 0	, 0	, 0	}
tQuestCondition[26] = {['err']=0, [0]= 3098	, 0	, 0	, 0	, 0	}
tQuestCondition[27] = {['err']=0, [0]= 3105	, 0	, 0	, 0	, 0	}
tQuestCondition[28] = {['err']=0, [0]= 3112	, 0	, 0	, 0	, 0	}
tQuestCondition[29] = {['err']=0, [0]= 3119	, 0	, 0	, 0	, 0	}
tQuestCondition[30] = {['err']=0, [0]= 3126	, 0	, 0	, 0	, 0	}
tQuestCondition[31] = {['err']=0, [0]= 3133	, 0	, 0	, 0	, 0	}
tQuestCondition[32] = {['err']=0, [0]= 3140	, 0	, 0	, 0	, 0	}
tQuestCondition[33] = {['err']=0, [0]= 3147	, 0	, 0	, 0	, 0	}
tQuestCondition[34] = {['err']=0, [0]= 3154	, 0	, 0	, 0	, 0	}
tQuestCondition[35] = {['err']=0, [0]= 3162	, 0	, 0	, 0	, 0	}
tQuestCondition[36] = {['err']=0, [0]= 3169	, 0	, 0	, 0	, 0	}
tQuestCondition[37] = {['err']=0, [0]= 3176	, 0	, 0	, 0	, 0	}
tQuestCondition[38] = {['err']=0, [0]= 3183	, 0	, 0	, 0	, 0	}
tQuestCondition[39] = {['err']=0, [0]= 3189	, 0	, 0	, 0	, 0	}
tQuestCondition[40] = {['err']=0, [0]= 3196	, 0	, 0	, 0	, 0	}
tQuestCondition[41] = {['err']=0, [0]= 3204	, 0	, 0	, 0	, 0	}
tQuestCondition[42] = {['err']=0, [0]= 3211	, 0	, 0	, 0	, 0	}
tQuestCondition[43] = {['err']=0, [0]= 3218	, 0	, 0	, 0	, 0	}
tQuestCondition[44] = {['err']=0, [0]= 3224	, 0	, 0	, 0	, 0	}
tQuestCondition[45] = {['err']=0, [0]= 3230	, 0	, 0	, 0	, 0	}
tQuestCondition[46] = {['err']=0, [0]= 3237	, 0	, 0	, 0	, 0	}
tQuestCondition[47] = {['err']=0, [0]= 5276	, 0	, 0	, 0	, 0	}
tQuestCondition[48] = {['err']=0, [0]= 3251	, 0	, 0	, 0	, 0	}
tQuestCondition[49] = {['err']=0, [0]= 3258	, 0	, 0	, 0	, 0	}
tQuestCondition[50] = {['err']=0, [0]= 3264	, 0	, 0	, 0	, 0	}
tQuestCondition[51] = {['err']=0, [0]= 3272	, 0	, 0	, 0	, 0	}
tQuestCondition[52] = {['err']=0, [0]= 3279	, 0	, 0	, 0	, 0	}
tQuestCondition[53] = {['err']=0, [0]= 3285	, 0	, 0	, 0	, 0	}
tQuestCondition[54] = {['err']=0, [0]= 3291	, 0	, 0	, 0	, 0	}
tQuestCondition[55] = {['err']=0, [0]= 3298	, 0	, 0	, 0	, 0	}
tQuestCondition[56] = {['err']=0, [0]= 3305	, 0	, 0	, 0	, 0	}
tQuestCondition[57] = {['err']=0, [0]= 3310	, 0	, 0	, 0	, 0	}
tQuestCondition[58] = {['err']=0, [0]= 3317	, 0	, 0	, 0	, 0	}
tQuestCondition[59] = {['err']=0, [0]= 3324	, 0	, 0	, 0	, 0	}
tQuestCondition[60] = {['err']=0, [0]= 3331	, 0	, 0	, 0	, 0	}
tQuestCondition[61] = {['err']=0, [0]= 3438	, 0	, 0	, 0	, 0	}
tQuestCondition[62] = {['err']=0, [0]= 3443	, 0	, 0	, 0	, 0	}
tQuestCondition[63] = {['err']=0, [0]= 4242	, 0	, 0	, 0	, 0	} --Á»ºñµðÆæ½º ³ë¸» ÀÔÀå±Ç Äù
tQuestCondition[64] = {['err']=0, [0]= 4263	, 0	, 0	, 0	, 0	} --Á»ºñµðÆæ½º ÇÏµå ÀÔÀå±Ç Äù
--tQuestCondition[65] = {['err']=0, [0]= 4325	, 0	, 0	, 0	, 0	} --¼³³¯ ÀÌº¥Æ® Äù
tQuestCondition[65] = {['err']=0, [0]= 4320	, 0	, 0	, 0	, 0	} --By-x ÅÛÇÃ »þ¿ÀÃµ 2È¸ Á¦¾ÐÄù
--tQuestCondition[65] = {['err']=0, [0]= 4242	, 0	, 0	, 0	, 0	} --Â÷ÀÌ³ª Å×½ºÆ® Äù
--tQuestCondition[63] = {['err']=0, [0]= 4209	, 0	, 0	, 0	, 0	} ÆøÅºÀü
--------------------------- Äù½ºÆ® Á¶°Ç ³¡ ---------------------------
								  	
											  	
											  	



tZone6NpcVillageIndex = {["err"]=0, 2,3,4,5,9,10,11,21,23,25}	-- 6±¸¿ª npc ÀÎµ¦½º (°¢ ±¤Àå¿¡ »õ·Î¿î NPC Ãß°¡½Ã, ÇØ´ç NPC ÀÎµ¦½º ¹øÈ£ Ãß°¡)
tZone3NpcVillageIndex = {["err"]=0, 12,15,16}					-- 3±¸¿ª npc ÀÎµ¦½º(°¢ ±¤Àå¿¡ »õ·Î¿î NPC Ãß°¡½Ã, ÇØ´ç NPC ÀÎµ¦½º ¹øÈ£ Ãß°¡)

local ZONE6 = 1
local ZONE3 = 2
function RegistNpcVillageIndex()
	for i=1, #tZone6NpcVillageIndex do
		RegistNpcVillageIndexMap(ZONE6, tZone6NpcVillageIndex[i])
	end
	
	for i=1, #tZone3NpcVillageIndex do
		RegistNpcVillageIndexMap(ZONE3, tZone3NpcVillageIndex[i])
	end
end



