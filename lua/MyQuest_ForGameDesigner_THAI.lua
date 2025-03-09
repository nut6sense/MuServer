------------------------------------------------------------------------

-- 퀘스트의 진행 위치를 세팅한다

------------------------------------------------------------------------
local QUEST_TYPE_OCCUR		  = 1
local QUEST_TYPE_OCCUR_ACCEPT = 2
local QUEST_TYPE_COMPLETE	  = 3

------------------------------------------------------------------------

local MAX_QUESTNUMBER = 52				-- 퀘스트의 갯수를 세팅한다.

------------------------------------------------------------------------

tQuestTargetPos = {['err']=0, }
for i=1, MAX_QUESTNUMBER do
	tQuestTargetPos[i] = {['err']=0, }
end

-------------------------- 퀘스트 진행위치 시작 --------------------------
--]]
tQuestTargetPos[1][QUEST_TYPE_OCCUR]		= {['err']=0, 0, 0, 0}	-- 
tQuestTargetPos[1][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 0, 0, 0}	-- 
tQuestTargetPos[1][QUEST_TYPE_COMPLETE]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨

tQuestTargetPos[2][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨
tQuestTargetPos[2][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[2][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨

tQuestTargetPos[3][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- 유키
tQuestTargetPos[3][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 777, 3604, 0}	-- 유키
tQuestTargetPos[3][QUEST_TYPE_COMPLETE]		= {['err']=0, 777, 3604, 0}	-- 유키

tQuestTargetPos[4][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨
tQuestTargetPos[4][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- 대전 포탈
tQuestTargetPos[4][QUEST_TYPE_COMPLETE]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨

tQuestTargetPos[5][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨
tQuestTargetPos[5][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 188, 4349, 0}		-- 안젤라맘슨
tQuestTargetPos[5][QUEST_TYPE_COMPLETE]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨

tQuestTargetPos[6][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨
tQuestTargetPos[6][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -113, 4868, 0}	-- 공원아케이드
tQuestTargetPos[6][QUEST_TYPE_COMPLETE]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨

tQuestTargetPos[7][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- 랜디하트
tQuestTargetPos[7][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[7][QUEST_TYPE_COMPLETE]		= {['err']=0, 1373, -2200, 0}	-- 랜디하트

tQuestTargetPos[8][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- 랜디하트
tQuestTargetPos[8][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[8][QUEST_TYPE_COMPLETE]		= {['err']=0, 1373, -2200, 0}	-- 랜디하트

tQuestTargetPos[9][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- 랜디하트
tQuestTargetPos[9][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- 대전 포탈
tQuestTargetPos[9][QUEST_TYPE_COMPLETE]		= {['err']=0, 1373, -2200, 0}	-- 랜디하트

tQuestTargetPos[10][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- 랜디하트
tQuestTargetPos[10][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- 대전 포탈
tQuestTargetPos[10][QUEST_TYPE_COMPLETE]	= {['err']=0, 1373, -2200, 0}	-- 랜디하트

tQuestTargetPos[11][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- 랜디하트
tQuestTargetPos[11][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- 대전 포탈
tQuestTargetPos[11][QUEST_TYPE_COMPLETE]	= {['err']=0, 1373, -2200, 0}	-- 랜디하트

tQuestTargetPos[12][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- 랜디하트
tQuestTargetPos[12][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 1373, -2200, 0}	-- 랜디하트
tQuestTargetPos[12][QUEST_TYPE_COMPLETE]	= {['err']=0, 1373, -2200, 0}	-- 랜디하트

tQuestTargetPos[13][QUEST_TYPE_OCCUR]		= {['err']=0, -1670, -1256, 0}	-- 닥터.K
tQuestTargetPos[13][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1670, -1256, 0}	-- 닥터.K
tQuestTargetPos[13][QUEST_TYPE_COMPLETE]	= {['err']=0, -1670, -1256, 0}	-- 닥터.K

tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, -1670, -1256, 0}	-- 닥터.K
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1670, -1256, 0}	-- 닥터.K
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, -1670, -1256, 0}	-- 닥터.K

tQuestTargetPos[15][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- 유키
tQuestTargetPos[15][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -113, 4868, 0}	-- 공원아케이드
tQuestTargetPos[15][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- 유키

tQuestTargetPos[16][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨
tQuestTargetPos[16][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}    -- 대전 포탈
tQuestTargetPos[16][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨

tQuestTargetPos[17][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨
tQuestTargetPos[17][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[17][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨

tQuestTargetPos[18][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨
tQuestTargetPos[18][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}    -- 대전 포탈
tQuestTargetPos[18][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨

tQuestTargetPos[19][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨
tQuestTargetPos[19][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- 호텔 아케이드
tQuestTargetPos[19][QUEST_TYPE_COMPLETE]	= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨

tQuestTargetPos[20][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨
tQuestTargetPos[20][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[20][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨

tQuestTargetPos[21][QUEST_TYPE_OCCUR]		= {['err']=0, -1670, -1256, 0}	-- 닥터.K
tQuestTargetPos[21][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- 할렘 아케이드
tQuestTargetPos[21][QUEST_TYPE_COMPLETE]	= {['err']=0, -1670, -1256, 0}	-- 닥터.K

tQuestTargetPos[22][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨
tQuestTargetPos[22][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[22][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨

tQuestTargetPos[23][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨
tQuestTargetPos[23][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[23][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨

tQuestTargetPos[24][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- 유키
tQuestTargetPos[24][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 1961, 3425, 0}	-- H.Road 아케이드
tQuestTargetPos[24][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- 유키

tQuestTargetPos[25][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨
tQuestTargetPos[25][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[25][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨

tQuestTargetPos[26][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨
tQuestTargetPos[26][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[26][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨

tQuestTargetPos[27][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨
tQuestTargetPos[27][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3708, 851, 0}	-- 지하철 아케이드
tQuestTargetPos[27][QUEST_TYPE_COMPLETE]        = {['err']=0, 339, 4401, 0}	-- 안젤라맘슨

tQuestTargetPos[28][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨
tQuestTargetPos[28][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[28][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨

tQuestTargetPos[29][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨 (일일 퀘스트)
tQuestTargetPos[29][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- 대전 포탈
tQuestTargetPos[29][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨 (일일 퀘스트)

tQuestTargetPos[30][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨 (일일 퀘스트)
tQuestTargetPos[30][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- 대전 포탈
tQuestTargetPos[30][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨 (일일 퀘스트)

tQuestTargetPos[31][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (일일 퀘스트)
tQuestTargetPos[31][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- 호텔 아케이드
tQuestTargetPos[31][QUEST_TYPE_COMPLETE]	= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (일일 퀘스트)

tQuestTargetPos[32][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (일일 퀘스트)
tQuestTargetPos[32][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- 할렘 아케이드
tQuestTargetPos[32][QUEST_TYPE_COMPLETE]        = {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (일일 퀘스트)

tQuestTargetPos[33][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (일일 퀘스트)
tQuestTargetPos[33][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 1961, 3425, 0}	-- H.Road 아케이드
tQuestTargetPos[33][QUEST_TYPE_COMPLETE]	= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (일일 퀘스트)

tQuestTargetPos[34][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (일일 퀘스트)
tQuestTargetPos[34][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3708, 851, 0}	-- 지하철 아케이드
tQuestTargetPos[34][QUEST_TYPE_COMPLETE]	= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (일일 퀘스트)

tQuestTargetPos[35][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- 유키 (일일 퀘스트)
tQuestTargetPos[35][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- 호텔 아케이드
tQuestTargetPos[35][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- 유키 (일일 퀘스트)

tQuestTargetPos[36][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- 유키 (일일 퀘스트)
tQuestTargetPos[36][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- 할렘 아케이드
tQuestTargetPos[36][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- 유키 (일일 퀘스트)

tQuestTargetPos[37][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- 유키 (일일 퀘스트)
tQuestTargetPos[37][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 1961, 3425, 0}	-- H.Road 아케이드
tQuestTargetPos[37][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- 유키 (일일 퀘스트)

tQuestTargetPos[38][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- 유키 (일일 퀘스트)
tQuestTargetPos[38][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3708, 851, 0}	-- 지하철 아케이드
tQuestTargetPos[38][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- 유키 (일일 퀘스트)

tQuestTargetPos[39][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- 유키
tQuestTargetPos[39][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- 대전 포탈
tQuestTargetPos[39][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- 유키

tQuestTargetPos[40][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- 안젤라맘슨
tQuestTargetPos[40][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- 할렘 아케이드
tQuestTargetPos[40][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- 안젤라맘슨

tQuestTargetPos[41][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨
tQuestTargetPos[41][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- 사냥터
tQuestTargetPos[41][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨

tQuestTargetPos[42][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨
tQuestTargetPos[42][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- 대전 포탈
tQuestTargetPos[42][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨

tQuestTargetPos[43][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨 (주간 퀘스트)
tQuestTargetPos[43][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- 대전 포탈
tQuestTargetPos[43][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨 (주간 퀘스트)

tQuestTargetPos[44][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- 스피커맨 (주간 퀘스트)
tQuestTargetPos[44][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- 대전 포탈
tQuestTargetPos[44][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- 스피커맨 (주간 퀘스트)

tQuestTargetPos[45][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (주간 퀘스트)
tQuestTargetPos[45][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 1961, 3425, 0}	-- H.Road 아케이드
tQuestTargetPos[45][QUEST_TYPE_COMPLETE]	= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (주간 퀘스트)

tQuestTargetPos[46][QUEST_TYPE_OCCUR]		= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (주간 퀘스트)
tQuestTargetPos[46][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3708, 851, 0}	-- 지하철 아케이드
tQuestTargetPos[46][QUEST_TYPE_COMPLETE]	= {['err']=0, 339, 4401, 0}	-- 안젤라맘슨 (주간 퀘스트)

tQuestTargetPos[47][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨 (티켓 퀘스트)
tQuestTargetPos[47][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- 대전 포탈
tQuestTargetPos[47][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- 엠마맘슨 (티켓 퀘스트)

tQuestTargetPos[48][QUEST_TYPE_OCCUR]		= {['err']=0, -1927, 3919, 0}	-- 밍밍
tQuestTargetPos[48][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 3214, 4134, 0}	-- 템플 아케이드
tQuestTargetPos[48][QUEST_TYPE_COMPLETE]        = {['err']=0, -1927, 3919, 0}	-- 밍밍

tQuestTargetPos[49][QUEST_TYPE_OCCUR]		= {['err']=0, -1927, 3919, 0}	-- 밍밍
tQuestTargetPos[49][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 4389, 904, 0}	-- 차이나 헌팅필드
tQuestTargetPos[49][QUEST_TYPE_COMPLETE]	= {['err']=0, -1927, 3919, 0}	-- 밍밍

tQuestTargetPos[50][QUEST_TYPE_OCCUR]		= {['err']=0, -1790, -3482, 0}	-- 메리맘슨
tQuestTargetPos[50][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1790, -3482, 0}	-- 메리맘슨
tQuestTargetPos[50][QUEST_TYPE_COMPLETE]	= {['err']=0, -1790, -3482, 0}	-- 메리맘슨

tQuestTargetPos[51][QUEST_TYPE_OCCUR]		= {['err']=0, -1790, -3482, 0}	-- 메리맘슨
tQuestTargetPos[51][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -2865, -3641, 0}	-- 카우존
tQuestTargetPos[51][QUEST_TYPE_COMPLETE]	= {['err']=0, -1790, -3482, 0}	-- 메리맘슨

tQuestTargetPos[52][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- 안젤라맘슨
tQuestTargetPos[52][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- 할렘 아케이드
tQuestTargetPos[52][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- 안젤라맘슨



--]]

--------------------------- 퀘스트 진행위치 끝 ---------------------------


------------------------------------------------------------------------
-- 퀘스트 조건을 세팅한다.
------------------------------------------------------------------------

tQuestCondition = {['err']=0, }

for i=1, MAX_QUESTNUMBER do
	tQuestCondition[i] = {['err']=0, }
end


-------------------------- 퀘스트 조건 시작 --------------------------

tQuestCondition[1] = {['err']=0, [0]= 2787	, 0	, 0	, 0	, 0	}
tQuestCondition[2] = {['err']=0, [0]= 2788	, 0	, 0	, 0	, 0	}
tQuestCondition[3] = {['err']=0, [0]= 2789	, 0	, 0	, 0	, 0	}
tQuestCondition[4] = {['err']=0, [0]= 2833	, 0	, 0	, 0	, 0	}
tQuestCondition[5] = {['err']=0, [0]= 2834	, 0	, 0	, 0	, 0	}
tQuestCondition[6] = {['err']=0, [0]= 2835	, 0	, 0	, 0	, 0	}
tQuestCondition[7] = {['err']=0, [0]= 2852	, 0	, 0	, 0	, 0	}
tQuestCondition[8] = {['err']=0, [0]= 4960	, 0	, 0	, 0	, 0	}
tQuestCondition[9] = {['err']=0, [0]= 4967	, 0	, 0	, 0	, 0	}
tQuestCondition[10] = {['err']=0, [0]= 4974	, 0	, 0	, 0	, 0	}
tQuestCondition[11] = {['err']=0, [0]= 4981	, 0	, 0	, 0	, 0	}
tQuestCondition[12] = {['err']=0, [0]= 2836	, 0	, 0	, 0	, 0	}
tQuestCondition[13] = {['err']=0, [0]= 5114	, 0	, 0	, 0	, 0	}
tQuestCondition[14] = {['err']=0, [0]= 4953	, 0	, 0	, 0	, 0	}
tQuestCondition[15] = {['err']=0, [0]= 2859	, 0	, 0	, 0	, 0	}
tQuestCondition[16] = {['err']=0, [0]= 5115	, 0	, 0	, 0	, 0	}
tQuestCondition[17] = {['err']=0, [0]= 2870	, 0	, 0	, 0	, 0	}
tQuestCondition[18] = {['err']=0, [0]= 2877	, 0	, 0	, 0	, 0	}
tQuestCondition[19] = {['err']=0, [0]= 2884	, 0	, 0	, 0	, 0	}
tQuestCondition[20] = {['err']=0, [0]= 4988	, 0	, 0	, 0	, 0	}
tQuestCondition[21] = {['err']=0, [0]= 4995	, 0	, 0	, 0	, 0	}
tQuestCondition[22] = {['err']=0, [0]= 5002	, 0	, 0	, 0	, 0	}
tQuestCondition[23] = {['err']=0, [0]= 5009	, 0	, 0	, 0	, 0	}
tQuestCondition[24] = {['err']=0, [0]= 5016	, 0	, 0	, 0	, 0	}
tQuestCondition[25] = {['err']=0, [0]= 5023	, 0	, 0	, 0	, 0	}
tQuestCondition[26] = {['err']=0, [0]= 5030	, 0	, 0	, 0	, 0	}
tQuestCondition[27] = {['err']=0, [0]= 5037	, 0	, 0	, 0	, 0	}
tQuestCondition[28] = {['err']=0, [0]= 5044	, 0	, 0	, 0	, 0	}
tQuestCondition[29] = {['err']=0, [0]= 5135	, 0	, 0	, 0	, 0	}
tQuestCondition[30] = {['err']=0, [0]= 5142	, 0	, 0	, 0	, 0	}
tQuestCondition[31] = {['err']=0, [0]= 5149	, 0	, 0	, 0	, 0	}
tQuestCondition[32] = {['err']=0, [0]= 5156	, 0	, 0	, 0	, 0	}
tQuestCondition[33] = {['err']=0, [0]= 5163	, 0	, 0	, 0	, 0	}
tQuestCondition[34] = {['err']=0, [0]= 5170	, 0	, 0	, 0	, 0	}
tQuestCondition[35] = {['err']=0, [0]= 5177	, 0	, 0	, 0	, 0	}
tQuestCondition[36] = {['err']=0, [0]= 5184	, 0	, 0	, 0	, 0	}
tQuestCondition[37] = {['err']=0, [0]= 5191	, 0	, 0	, 0	, 0	}
tQuestCondition[38] = {['err']=0, [0]= 5198	, 0	, 0	, 0	, 0	}
tQuestCondition[39] = {['err']=0, [0]= 5205	, 0	, 0	, 0	, 0	}
tQuestCondition[40] = {['err']=0, [0]= 5212	, 0	, 0	, 0	, 0	}
tQuestCondition[41] = {['err']=0, [0]= 5219	, 0	, 0	, 0	, 0	}
tQuestCondition[42] = {['err']=0, [0]= 5226	, 0	, 0	, 0	, 0	}
tQuestCondition[43] = {['err']=0, [0]= 5233	, 0	, 0	, 0	, 0	}
tQuestCondition[44] = {['err']=0, [0]= 5240	, 0	, 0	, 0	, 0	}
tQuestCondition[45] = {['err']=0, [0]= 5247	, 0	, 0	, 0	, 0	}
tQuestCondition[46] = {['err']=0, [0]= 5254	, 0	, 0	, 0	, 0	}
tQuestCondition[47] = {['err']=0, [0]= 5276	, 0	, 0	, 0	, 0	}
tQuestCondition[48] = {['err']=0, [0]= 5311	, 0	, 0	, 0	, 0	}
tQuestCondition[49] = {['err']=0, [0]= 5318	, 0	, 0	, 0	, 0	}
tQuestCondition[50] = {['err']=0, [0]= 5399	, 0	, 0	, 0	, 0	}
tQuestCondition[51] = {['err']=0, [0]= 5406	, 0	, 0	, 0	, 0	}
tQuestCondition[52] = {['err']=0, [0]= 5746	, 0	, 0	, 0	, 0	}


--------------------------- 퀘스트 조건 끝 ---------------------------



tZone6NpcVillageIndex = {["err"]=0, 2,3,4,5,9,10,11,21,22,23,25}	-- 6구역 npc 인덱스 (각 광장에 새로운 NPC 추가시, 해당 NPC 인덱스 번호 추가)
tZone3NpcVillageIndex = {["err"]=0, 12,15,16}					-- 3구역 npc 인덱스 (각 광장에 새로운 NPC 추가시, 해당 NPC 인덱스 번호 추가)

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
