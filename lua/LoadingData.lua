LANGUAGECODE_ENG = 0
LANGUAGECODE_KOR = 1
LANGUAGECODE_THAI = 2
LANGUAGECODE_MAS = 3
LANGUAGECODE_IDN = 4
LANGUAGECODE_GSP = 5

-- 북미 
tLoadingList_eng = {["protectErr"]=0,

0,
1,
2,
3,
4,
5,
6,

}



-- 한국
tLoadingList_kor = {["protectErr"]=0,
0,
1,
2,
3,
4,
}



-- 태국
tLoadingList_thai = {["protectErr"]=0,
0,
1,
2,
3,
4,
5,
6,
}

-- 말레이시아
tLoadingList_mas = {["protectErr"]=0,

0,
1,
2,
3,
4,
5,
6,

}

-- 인도네시아
tLoadingList_idn = {["protectErr"]=0,

0,
1,
2,
3,
4,
5,
6,

}

-- GSP
tLoadingList_GSP = {["protectErr"]=0,

0,
1,
2,
3,
4,
5,
6,

}

function SetEnableLoadingList(language)

	if language == LANGUAGECODE_ENG then
		for i=1, #tLoadingList_eng do
			ReadEnableLoadingList(tLoadingList_eng[i])
		end
	
	-- 한국은 현재 제외
	elseif language == LANGUAGECODE_KOR then
		for i=1, #tLoadingList_kor do
			ReadEnableLoadingList(tLoadingList_kor[i])
		end
		
	elseif language == LANGUAGECODE_THAI then
		for i=1, #tLoadingList_thai do
			ReadEnableLoadingList(tLoadingList_thai[i])
		end
		
	elseif language == LANGUAGECODE_MAS then
		for i=1, #tLoadingList_mas do
			ReadEnableLoadingList(tLoadingList_mas[i])
		end
		
	elseif language == LANGUAGECODE_IDN then
		for i=1, #tLoadingList_idn do
			ReadEnableLoadingList(tLoadingList_idn[i])
		end
				
	elseif language == LANGUAGECODE_GSP then
		for i=1, #tLoadingList_GSP do
			ReadEnableLoadingList(tLoadingList_GSP[i])
		end
				
	end
	
end
