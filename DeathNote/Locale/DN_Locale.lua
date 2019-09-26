DN_Locale = {}
DN_Locale.string = {}

function DN_Locale:Localization()
	local locale = GetLocale()
	if locale == "koKR" then
		koKR_Localization()
	elseif locale =="ruRU" then
		ruRU_Localization()
	else
		enUS_Localization()
	end
	DN_MainTitleText:SetText(DN_Locale.string["ADDON_TITLE"])
	DN_MainFilterLevelText:SetText(DN_Locale.string["FILTER_LEVEL"])
	DN_MainFilterNameText:SetText(DN_Locale.string["FILTER_NAME"])
	DN_MainFilterClassText:SetText(DN_Locale.string["FILTER_CLASS"])
	DN_MainFilterRaceText:SetText(DN_Locale.string["FILTER_RACE"])
	DN_MainFilterGenderText:SetText(DN_Locale.string["FILTER_GENDER"])
	DN_MainFilterTimeText:SetText(DN_Locale.string["FILTER_TIME"])
	DN_MainFilterAttackText:SetText(DN_Locale.string["FILTER_ATTACK"])
	DN_MainFilterDeathText:SetText(DN_Locale.string["FILTER_DEATH"])
	DN_MainFilterCancelText:SetText(DN_Locale.string["FILTER_CANCEL"])
	DN_MainFilterMemoText:SetText(DN_Locale.string["FILTER_MEMO"])
	DN_SettingNameplateText:SetText(DN_Locale.string["SETUP_NAME_TITLE"])
	DN_SettingNameplateXText1:SetText(DN_Locale.string["SETUP_NAME_X"])
	DN_SettingNameplateYText1:SetText(DN_Locale.string["SETUP_NAME_Y"])
	DN_SettingNameplateCheckButton1Text:SetText(DN_Locale.string["SETUP_NAME_CENTER"])
	DN_SettingNameplateCheckButton2Text:SetText(DN_Locale.string["SETUP_NAME_TOP"])
	DN_SettingNameplateCheckButton3Text:SetText(DN_Locale.string["SETUP_NAME_BOTTOM"])
	DN_SettingNameplateCheckButton4Text:SetText(DN_Locale.string["SETUP_NAME_LEFT"])
	DN_SettingNameplateCheckButton5Text:SetText(DN_Locale.string["SETUP_NAME_RIGHT"])
	DN_SettingNameplateExamplenameText:SetText(DN_Locale.string["SETUP_NAME_EXAMPLE"])
end

