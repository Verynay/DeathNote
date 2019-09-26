DN_Set_Func = {}

function DN_Set_Func:DN_value_Changed(frame)
	_G[frame:GetName().."Text2"]:SetText(frame:GetValue())
	if strsub(frame:GetName(), 20) == "X" then
		DN_Setting_Data.iconX = frame:GetValue()
	else
		DN_Setting_Data.iconY = frame:GetValue()		
	end
	DN_Set_Func:Example_Initial()
end

function DN_Set_Func:Check_Button(value)
	_G["DN_SettingNameplateCheckButton"..DN_Setting_Data.icon]:SetChecked(false)
	_G["DN_SettingNameplateCheckButton"..value]:SetChecked(true)
	DN_Setting_Data.icon = value
	DN_Set_Func:Example_Initial()
end

function DN_Set_Func:Example_Initial()
	if DN_Setting_Data.icon == 1 then
		DN_SettingNameplateExampleicon:ClearAllPoints()
		DN_SettingNameplateExampleicon:SetPoint("CENTER", DN_SettingNameplateExamplenameText, "CENTER", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
	elseif DN_Setting_Data.icon == 2 then
		DN_SettingNameplateExampleicon:ClearAllPoints()
		DN_SettingNameplateExampleicon:SetPoint("BOTTOM", DN_SettingNameplateExamplenameText, "TOP", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
	elseif DN_Setting_Data.icon == 3 then
		DN_SettingNameplateExampleicon:ClearAllPoints()
		DN_SettingNameplateExampleicon:SetPoint("TOP", DN_SettingNameplateExamplenameText, "BOTTOM", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
	elseif DN_Setting_Data.icon == 4 then
		DN_SettingNameplateExampleicon:ClearAllPoints()
		DN_SettingNameplateExampleicon:SetPoint("RIGHT", DN_SettingNameplateExamplenameText, "LEFT", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
	else
		DN_SettingNameplateExampleicon:ClearAllPoints()
		DN_SettingNameplateExampleicon:SetPoint("LEFT", DN_SettingNameplateExamplenameText, "RIGHT", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
	end
end
