local player_uid = UnitGUID("player")
local player_faction, local_faction = UnitFactionGroup("player")

local level = {}
local nameplate = {}

local active = true

DN_Data_Sorting = {}

DN_Data_Sorting.data = {}
DN_Data_Sorting.value = 5
DN_Data_Sorting.bool = true

DN_Main_Func = {}
DN_Data_Func = {}
DN_Tip_Func = {}
DN_Nameplate = {}

function DN_Main_Func:DN_Initial()
	DN_Data = {}
	SendSystemMessage(DN_Locale.string["SYSTEM_INITIAL"])
end
function DN_Main_Func:DN_Refresh()
	local listOffset = FauxScrollFrame_GetOffset(DN_MainScrollFrame)
	if not listOffset then
		listOffset = 0
	end
	local i = 1
	local maxScroll = 0
	if table.getn(DN_Data_Sorting.data) ~= 0 then
		for k, v in pairs(DN_Data_Sorting.data) do
			if (maxScroll+1) > listOffset and (maxScroll+1) < (1+ DN_Setting_Data.view_line + listOffset) then
				_G["DN_MainRow"..i]:Show()
				_G["DN_MainRow"..i.."GUIDText"]:SetText(DN_Data[v[1]].guid)
				_G["DN_MainRow"..i.."GUIDText"]:SetTextColor(1,1,1,0)
				_G["DN_MainRow"..i.."NameText"]:SetText(DN_Data[v[1]].name)
				if DN_Data[v[1]].timelength == 1 then
					_G["DN_MainRow"..i.."TimeText"]:SetText(DN_Data[v[1]].time[0])
				else
					local temp = DN_Data[v[1]].timelength-1
					_G["DN_MainRow"..i.."TimeText"]:SetText(DN_Data[v[1]].time[0].." 외 "..temp.."개")
				end
				_G["DN_MainRow"..i.."LevelText"]:SetText(DN_Data[v[1]].level)
				_G["DN_MainRow"..i.."ClassText"]:SetText(DN_Data[v[1]].class)
				if DN_Data[v[1]].eng_class == "WARRIOR" then
					_G["DN_MainRow"..i.."ClassText"]:SetTextColor(0.78,0.61,0.43)
				elseif DN_Data[v[1]].eng_class == "PALADIN" then
					_G["DN_MainRow"..i.."ClassText"]:SetTextColor(0.96,0.55,0.73)
				elseif DN_Data[v[1]].eng_class == "HUNTER" then
					_G["DN_MainRow"..i.."ClassText"]:SetTextColor(0.67,0.83,0.45)
				elseif DN_Data[v[1]].eng_class == "ROGUE" then
					_G["DN_MainRow"..i.."ClassText"]:SetTextColor(1,0.96,0.41)
				elseif DN_Data[v[1]].eng_class == "PRIEST" then
					_G["DN_MainRow"..i.."ClassText"]:SetTextColor(1,1,1)
				elseif DN_Data[v[1]].eng_class == "SHAMAN" then
					_G["DN_MainRow"..i.."ClassText"]:SetTextColor(0,0.44,0.87)
				elseif DN_Data[v[1]].eng_class == "MAGE" then
					_G["DN_MainRow"..i.."ClassText"]:SetTextColor(0.41,0.8,0.94)
				elseif DN_Data[v[1]].eng_class == "WARLOCK" then
					_G["DN_MainRow"..i.."ClassText"]:SetTextColor(0.58,0.51,0.79)
				else
					_G["DN_MainRow"..i.."ClassText"]:SetTextColor(1,0.49,0.04)
				end
				_G["DN_MainRow"..i.."RaceText"]:SetText(DN_Data[v[1]].race)
				if DN_Data[v[1]].gender == 2 or DN_Data[v[1]].gender == "남성" then
					_G["DN_MainRow"..i.."GenderText"]:SetText(DN_Locale.string["DATA_GENDER1"])
					_G["DN_MainRow"..i.."GenderText"]:SetTextColor(0,0,1)
				elseif DN_Data[v[1]].gender == 3 or DN_Data[v[1]].gender == "여성" then
					_G["DN_MainRow"..i.."GenderText"]:SetText(DN_Locale.string["DATA_GENDER2"])
					_G["DN_MainRow"..i.."GenderText"]:SetTextColor(1,0,0)
				end
				if DN_Data[v[1]].attack == nil or DN_Data[v[1]].attack[0] == 0 then
					if DN_Data[v[1]].attack == nil then
						DN_Data[v[1]].attack = {}
						DN_Data[v[1]].attack[0] = 0
					end				
					_G["DN_MainRow"..i.."AttackText"]:SetText("모름")
				elseif DN_Data[v[1]].attack[0] == 1 then
					_G["DN_MainRow"..i.."AttackText"]:SetText(DN_Locale.string["DATA_COMBAT_FORMAT2"])
				else
					_G["DN_MainRow"..i.."AttackText"]:SetText(DN_Locale.string["DATA_COMBAT_FORMAT3"])
				end
				if DN_Data[v[1]].death == nil or DN_Data[v[1]].death[0] == 0 then
					if DN_Data[v[1]].death == nil then
						DN_Data[v[1]].death = {}
						DN_Data[v[1]].attack[0] = 0
					end
					_G["DN_MainRow"..i.."DeathText"]:SetText(DN_Locale.string["DATA_COMBAT_FORMAT1"])
				elseif DN_Data[v[1]].death[0] == 1 then
					_G["DN_MainRow"..i.."DeathText"]:SetText(DN_Locale.string["DATA_COMBAT_FORMAT2"])
				else
					_G["DN_MainRow"..i.."DeathText"]:SetText(DN_Locale.string["DATA_COMBAT_FORMAT3"])
				end
				i = i+1
			end			
			maxScroll = maxScroll + 1
		end	
	end
	for i=i, 20 do
		_G["DN_MainRow"..i]:Hide()
	end
	FauxScrollFrame_Update(DN_MainScrollFrame, maxScroll, DN_Setting_Data.view_line, 30)
end
function DN_CmdHandler(msg)
	local cmd = 0
	msg = strtrim(msg);
	if string.find(msg, "시작") ~= nil or string.find(msg, "start") ~= nil then
		cmd = 1
	end
	if string.find(msg, "중지") ~= nil or string.find(msg, "stop") ~= nil then
		cmd = 2
	end
	if cmd == 1 then
		DN_Main_Func:Activate_Event()
	elseif cmd == 2 then
		DN_Main_Func:Deactivate_Event()	
	else
		ShowUIPanel(DN_Main)
		DN_Data_Sorting:DN_Filter(DN_Data_Sorting.value, true)
	end
end

DN_Locale:Localization()

function DN_Data_Sorting:DN_Filter(value, bool)
	local i = 1
	DN_Data_Sorting.data = {}
	for k,v in pairs(DN_Data) do
		if value == 0 then
			DN_Data_Sorting.data[i] = {k, v.level}
		elseif value == 1 then
			DN_Data_Sorting.data[i] = {k, v.name}
		elseif value == 2 then
			DN_Data_Sorting.data[i] = {k, v.race}
		elseif value == 3 then
			DN_Data_Sorting.data[i] = {k, v.class}
		elseif value == 4 then
			DN_Data_Sorting.data[i] = {k, v.gender}
		elseif value == 5 then
			DN_Data_Sorting.data[i] = {k, v.time[0]}
		end
		i = i+1
	end
	if bool == false then
		if DN_Data_Sorting.value == value then
			DN_Data_Sorting.bool = not DN_Data_Sorting.bool
		else
			DN_Data_Sorting.bool = true
		end
	end
	if DN_Data_Sorting.bool then
		table.sort(DN_Data_Sorting.data, function(a,b) return a[2] > b[2] end)
	else
		table.sort(DN_Data_Sorting.data, function(a,b) return a[2] < b[2] end)
	end
	DN_Main_Func:DN_Refresh()
end
CreateFrame("Frame", "DN_level")
DN_level:RegisterEvent("NAME_PLATE_UNIT_ADDED")
DN_level:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
DN_level:SetScript("OnEvent", function(selt, event, arg1, ...)
	if event == "NAME_PLATE_UNIT_ADDED" then
		local temp, temp2 = UnitFactionGroup(arg1)
		if  temp ~= player_faction then
			nameplate[arg1] = UnitGUID(arg1)
			if UnitLevel(arg1) == -1 then
				level[UnitGUID(arg1)] = "??"
			else
				level[UnitGUID(arg1)] = UnitLevel(arg1)
			end
			if DN_Data[nameplate[arg1]] ~= nil then
				if DN_Nameplate[nameplate[arg1]] == nil then
					if DN_Setting_Data.bgm then
						PlaySound(3332, "SFX")
					end
					SendSystemMessage(DN_Locale.string["SYSTEM_ENEMY1"]..DN_Data[nameplate[arg1]].name..DN_Locale.string["SYSTEM_ENEMY2"])
					DN_Nameplate[nameplate[arg1]] = CreateFrame("Frame")
					DN_Nameplate[nameplate[arg1]]:SetFrameStrata("LOW")
					DN_Nameplate[nameplate[arg1]]:SetFrameLevel(10)
					DN_Nameplate[nameplate[arg1]]:SetWidth(30)
					DN_Nameplate[nameplate[arg1]]:SetHeight(30)
					DN_Nameplate[nameplate[arg1]]:EnableMouse(false)

					DN_Nameplate[nameplate[arg1]].icon = DN_Nameplate[nameplate[arg1]]:CreateTexture(nil, "ARTWORK");
					DN_Nameplate[nameplate[arg1]].icon:SetTexture("interface/worldmap/glowskull_64.blp", true)
					DN_Nameplate[nameplate[arg1]].icon:SetTexCoord(0, 0.5, 0.5, 1)
					DN_Nameplate[nameplate[arg1]].icon:ClearAllPoints()
					DN_Nameplate[nameplate[arg1]].icon:SetAllPoints(DN_Nameplate[nameplate[arg1]])
				end
				DN_Nameplate[nameplate[arg1]]:SetParent(C_NamePlate.GetNamePlateForUnit(arg1))
				if DN_Setting_Data.icon == 1 then
					DN_Nameplate[nameplate[arg1]]:SetPoint("CENTER", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
				elseif DN_Setting_Data.icon == 2 then
					DN_Nameplate[nameplate[arg1]]:SetPoint("TOP", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
				elseif DN_Setting_Data.icon == 3 then
					DN_Nameplate[nameplate[arg1]]:SetPoint("BOTTOM", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
				elseif DN_Setting_Data.icon == 4 then
					DN_Nameplate[nameplate[arg1]]:SetPoint("LEFT", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
				else
					DN_Nameplate[nameplate[arg1]]:SetPoint("RIGHT", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
				end
			end
		end
	else
		if nameplate[arg1] ~= nil and DN_Nameplate[nameplate[arg1]] ~= nil then
			DN_Nameplate[nameplate[arg1]]:Hide()
		end
	end
end)
CreateFrame("Frame", "DN_Window")
DN_Window:RegisterEvent("PLAYER_REGEN_DISABLED")
DN_Window:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
local list = {}
DN_Window:SetScript("OnEvent", function(self, event, ...)	
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, auratype = CombatLogGetCurrentEventInfo()
		if type == "SWING_DAMAGE" or type == "RANGE_DAMAGE" or type == "SPELL_DAMAGE" or type == "SPELL_PERIODIC_DAMAGE" or type == "SPELL_BUILDING_DAMAGE" 
or type == "SWING_MISSED" or type == "RANGE_MISSED" or type == "SPELL_MISSED" or type == "SPELL_PERIODIC_MISSED" or type == "SPELL_BUILDING_MISSED" or type == "SPELL_AURA_APPLIED" or type == "UNIT_DIED" then
			if type ~= "SPELL_AURA_APPLIED" or (type == "SPELL_AURA_APPLIED" and auratype == "DEBUFF") then
				if type ~= "UNIT_DIED" then
					if destGUID == player_uid and sourceGUID ~= player_uid then
						if bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
							if DN_Data ~= nil then
								local value = -1
								for k,v in pairs(list) do
									if v == sourceGUID then
										value = k
										break
									end
								end
								if value == -1 then
									local date = date(DN_Locale.string["DATE_FORMAT"], timestamp)
									if DN_Data[sourceGUID] ~= nil then
										table.insert(list ,sourceGUID)
										DN_Data[sourceGUID].time[DN_Data[sourceGUID].timelength] = date
										DN_Data[sourceGUID].timelength = DN_Data[sourceGUID].timelength + 1
										DN_Data[sourceGUID].death[DN_Data[sourceGUID].deathlength] = 0
										DN_Data[sourceGUID].deathlength = DN_Data[sourceGUID].deathlength + 1
										DN_Data[sourceGUID].attack[DN_Data[sourceGUID].attacklength] = 2
										DN_Data[sourceGUID].attacklength = DN_Data[sourceGUID].attacklength + 1
										DN_Data[sourceGUID].name = sourceName
									else
										local temp = {}
										table.insert(list ,sourceGUID)
										temp.name = sourceName
										temp.time = {}
										temp.timelength = 1
										temp.time[0] = date
										temp.guid = sourceGUID
										temp.level = level[sourceGUID]
										temp.attacklength = 1
										temp.attack = {}
										temp.attack[0] = 1
										temp.deathlength = 1
										temp.death = {}
										temp.death[0] = 0
										temp.class, temp.eng_class, temp.race, temp.eng_race, temp.gender = GetPlayerInfoByGUID(sourceGUID)
										if temp.gender == 2 then
											temp.gender = DN_Locale.string["DATA_GENDER1"]
										else
											temp.gender = DN_Locale.string["DATA_GENDER2"]
										end
										DN_Data[sourceGUID] = temp
										SendSystemMessage(sourceName..DN_Locale.string["SYSTEM_SAVE_DATA1"])
										level[sourceGUID] = nil
									end
								end	
							end
						end	
					elseif sourceGUID == player_uid and destGUID ~= player_uid then
						if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
							if DN_Data ~= nil then
								local value = -1
								for k,v in pairs(list) do
									if v == destGUID then
										value = k
										break
									end
								end
								if value == -1 then
									local date = date(DN_Locale.string["DATE_FORMAT"], timestamp)
									if DN_Data[destGUID] ~= nil then
										table.insert(list ,destGUID)
										DN_Data[destGUID].time[DN_Data[destGUID].timelength] = date
										DN_Data[destGUID].timelength = DN_Data[destGUID].timelength + 1
										DN_Data[destGUID].death[DN_Data[destGUID].deathlength] = 0
										DN_Data[destGUID].deathlength = DN_Data[destGUID].deathlength + 1
										DN_Data[destGUID].attack[DN_Data[destGUID].attacklength] = 2
										DN_Data[destGUID].attacklength = DN_Data[destGUID].attacklength + 1
										DN_Data[destGUID].name = destName
									else
										local temp = {}
										table.insert(list ,destGUID)
										temp.name = destName
										temp.time = {}
										temp.timelength = 1
										temp.time[0] = date
										temp.guid = destGUID
										temp.level = level[destGUID]
										temp.attacklength = 1
										temp.attack = {}
										temp.attack[0] = 2
										temp.deathlength = 1
										temp.death = {}
										temp.death[0] = 0
										temp.memo =""
										temp.class, temp.eng_class, temp.race, temp.eng_race, temp.gender = GetPlayerInfoByGUID(destGUID)
										if temp.gender == 2 then
											temp.gender = DN_Locale.string["DATA_GENDER1"]
										else
										temp.gender = DN_Locale.string["DATA_GENDER2"]
										end
										DN_Data[destGUID] = temp
										SendSystemMessage(destName..DN_Locale.string["SYSTEM_SAVE_DATA2"])
										level[destGUID] = nil
									end
								end
							end
						end	
					end
				else
					if destGUID == player_uid then
						if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
							for k,v in pairs(list) do
								if DN_Data[v].death[DN_Data[v].deathlength-1] == 0 then
									DN_Data[v].death[DN_Data[v].deathlength-1] = 2
								end
							end
							list = {}
						end
					else
						if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
							if DN_Data[destGUID] ~= nil then
								DN_Data[destGUID].death[DN_Data[destGUID].deathlength-1] = 1
							end
						end
					end	
				end	
			end			
		end	
	else
		list = {}
	end
end)	

SlashCmdList["DNWINDOW"] = DN_CmdHandler;
SLASH_DNWINDOW1 = "/dn"
SLASH_DNWINDOW2 = "/DN"
SLASH_DNWINDOW3 = "/우"

function DN_Main_Func:Activate_Event()
	SendSystemMessage(DN_Locale.string["SYSTEM_START"])
	DN_Window:RegisterEvent("PLAYER_REGEN_ENABLED")
	DN_Window:RegisterEvent("COMBAT_LOG_EVENT")
end
function DN_Main_Func:Deactivate_Event()
	SendSystemMessage(DN_Locale.string["SYSTEM_STOP"])
	DN_Window:UnregisterEvent("PLAYER_REGEN_ENABLED")
	DN_Window:UnregisterEvent("COMBAT_LOG_EVENT")
end


function DN_Tip_Func:Time(frame)
	local number = _G[string.sub(frame:GetName(), 1, 11).."GUIDText"]:GetText()
	local msg = ""
	for i = 1, DN_Data[number].timelength-1, 1 do
		if i ~= 1 then
			msg = msg.."\n"
		end
		msg = msg..DN_Data[number].time[i]
		if DN_Data[number].attack == nil then
			msg = msg.." 모름"
		elseif DN_Data[number].attack == 1 then
			msg = msg.." "..DN_Locale.string["DATA_COMBAT_FORMAT2"]
		else
			msg = msg.." "..DN_Locale.string["DATA_COMBAT_FORMAT3"]
		end
		if DN_Data[number].death == 0 then
			msg = msg.." "..DN_Locale.string["DATA_COMBAT_FORMAT1"]
		elseif DN_Data[number].death == 1 then
			msg = msg.." "..DN_Locale.string["DATA_COMBAT_FORMAT2"]
		else
			msg = msg.." "..DN_Locale.string["DATA_COMBAT_FORMAT3"]
		end
	end
	GameTooltip:SetOwner(frame, 'ANCHOR_BOTTOMRIGHT');
	GameTooltip:ClearLines();
	GameTooltip:AddLine(msg);
	GameTooltip:Show();
end

function DN_Data_Func:remove(frame)
	local number = _G[string.sub(frame:GetName(), 1, 11).."GUIDText"]:GetText()
	DN_Data[number] = nil
	DN_Data_Sorting:DN_Filter(DN_Data_Sorting.value, true)
end

function DN_Tip_Func:Tooltip(msg, frame)
	if msg == "START" then
		if active == true then
			msg = DN_Locale.string["TOOLTIP_STOP"]
		else
			msg = DN_Locale.string["TOOLTIP_START"]
		end
	elseif msg == "BGM" then
		if DN_Setting_Data.bgm == true then
			msg = DN_Locale.string["TOOLTIP_BGMOFF"]
		else
			msg = DN_Locale.string["TOOLTIP_BGMON"]
		end
	elseif msg == "INITIAL" then
		msg = DN_Locale.string["TOOLTIP_INITIAL"]
	elseif msg == "CLOSE" then
		msg = DN_Locale.string["TOOLTIP_CLOSE"]
	elseif msg == "LINEDEC" then
		msg = DN_Locale.string["TOOLTIP_LINEDEC"]
	elseif msg == "LINEINC" then
		msg = DN_Locale.string["TOOLTIP_LINEINC"]
	elseif msg == "MAXIMIZE" then
		msg = DN_Locale.string["TOOLTIP_MAXIMIZE"]
	elseif msg == "MINIMIZE" then
		msg = DN_Locale.string["TOOLTIP_MINIMIZE"]
	elseif msg == "DELETE" then
		msg = DN_Locale.string["TOOLTIP_DELETE"]
	elseif msg == "MEMO" then
		local number = _G[string.sub(frame:GetName(), 1, 11).."GUIDText"]:GetText()
		msg = DN_Data[number].memo
	elseif msg == "SETUP" then
		msg = DN_Locale.string["TOOLTIP_SETUP"]
	end
	GameTooltip:SetOwner(frame, 'ANCHOR_TOPRIGHT');
	GameTooltip:ClearLines();
	GameTooltip:AddLine(msg);
	GameTooltip:Show();
end

function DN_Data_Func:Memo_Window(frame)
	local number = _G[string.sub(frame:GetName(), 1, 11).."GUIDText"]:GetText()
	if DN_Data[number].memo == nil then
		DN_Data[number].memo = ""
	end
	_G[string.sub(frame:GetName(), 1, 11).."EditBox"]:SetText(DN_Data[number].memo)
	_G[string.sub(frame:GetName(), 1, 11).."EditBox"]:Show()
end

function DN_Data_Func:Memo_Saved(frame)
	local number = _G[string.sub(frame:GetName(), 1, 11).."GUIDText"]:GetText()
	DN_Data[number].memo = frame:GetText()
	frame:Hide()
end

function DN_Data_Func:Menu_Clicked(menu, mouse, frame)
	if menu == "MAX" then
		DN_Setting_Data.view_line = DN_Setting_Data.max_line
	elseif menu == "MIN" then
		DN_Setting_Data.view_line = 1
	elseif menu == "DEC" then
		if DN_Setting_Data.view_line > 1 then
			DN_Setting_Data.view_line = DN_Setting_Data.view_line - 1
		end
	elseif menu == "INC" then
		if DN_Setting_Data.view_line < DN_Setting_Data.max_line then
			DN_Setting_Data.view_line = DN_Setting_Data.view_line +1		
		end
	elseif menu == "ON" then
		if active == true then
			DN_Main_Func:Deactivate_Event()
			frame:SetNormalTexture("Interface\\WorldMap\\Skull_64Red")
			active = false
		else
			DN_Main_Func:Activate_Event()
			frame:SetNormalTexture("Interface\\WorldMap\\Skull_64Green")
			active = true
		end
	elseif menu == "BGM" then
		if DN_Setting_Data.bgm == true then
			DN_Setting_Data.bgm = false
			frame:SetNormalTexture("Interface\\COMMON\\VOICECHAT-MUTED")
		else
			DN_Setting_Data.bgm = true
			frame:SetNormalTexture("Interface\\COMMON\\VOICECHAT-SPEAKER")
		end
	else
		DN_Main_Func:DN_Initial()
	end
	DN_Main:SetHeight(32 * DN_Setting_Data.view_line + 60)
	DN_Data_Sorting:DN_Filter(DN_Data_Sorting.value, true)
end

CreateFrame("Frame", "DN_Loaded")
DN_Loaded:RegisterEvent("ADDON_LOADED")
DN_Loaded:SetScript("OnEvent", function(self,event,arg1)
		if arg1 == "DeathNote" then
			if not DN_Data then
				DN_Main_Func:DN_Initial()
				DN_Setting_Data = {}
				local line = math.ceil((GetScreenHeight()-80-200) /  30)
				DN_Setting_Data.max_line = line
				DN_Setting_Data.view_line = line
			end
			if not DN_Setting_Data then
				DN_Setting_Data = {}
				local line = math.ceil((GetScreenHeight()-80-400) /  30)
				DN_Setting_Data.max_line = line
				DN_Setting_Data.view_line = line

			end
			if not DN_Setting_Data.icon then
				DN_Setting_Data.icon = 1
				DN_Setting_Data.iconX = 0
				DN_Setting_Data.iconY = 0								
			end
			_G["DN_SettingNameplateCheckButton"..DN_Setting_Data.icon]:SetChecked(true)
			_G["DN_SettingNameplateX"]:SetValue(	DN_Setting_Data.iconX)
			_G["DN_SettingNameplateY"]:SetValue(	DN_Setting_Data.iconY)
			if DN_Setting_Data.icon == 1 then
				DN_SettingNameplateExampleicon:SetPoint("CENTER", DN_SettingNameplateExamplenameText, "CENTER", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
			elseif DN_Setting_Data.icon == 2 then
				DN_SettingNameplateExampleicon:SetPoint("BOTTOM", DN_SettingNameplateExamplenameText, "TOP", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
			elseif DN_Setting_Data.icon == 3 then
				DN_SettingNameplateExampleicon:SetPoint("TOP", DN_SettingNameplateExamplenameText, "BOTTOM", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
			elseif DN_Setting_Data.icon == 4 then
				DN_SettingNameplateExampleicon:SetPoint("RIGHT", DN_SettingNameplateExamplenameText, "LEFT", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
			else
				DN_SettingNameplateExampleicon:SetPoint("LEFT", DN_SettingNameplateExamplenameText, "RIGHT", DN_Setting_Data.iconX, DN_Setting_Data.iconY)
			end
			local line = math.ceil((GetScreenHeight()-80-400) /  30)
			DN_Setting_Data.max_line = line
			DN_Main:SetHeight(32 * DN_Setting_Data.view_line + 60)
			if DN_Setting_Data.bgm == nil then
				DN_Setting_Data.bgm = true
			end
			if DN_Setting_Data.bgm == true then
				DN_MainTitleSoundButton:SetNormalTexture("Interface\\COMMON\\VOICECHAT-SPEAKER")
			else
				DN_MainTitleSoundButton:SetNormalTexture("Interface\\COMMON\\VOICECHAT-MUTED")
			end				
			DN_Data_Sorting:DN_Filter(5, false)
			SendSystemMessage("Load Active")
		end
	end)


	
			
			


