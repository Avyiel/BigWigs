﻿------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.0")("Baron Geddon")
local L = AceLibrary("AceLocale-2.0"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	trigger1 = "^([^%s]+) ([^%s]+) afflicted by Living Bomb",

	you = "You",
	are = "are",

	warn1 = "You are the bomb!",
	warn2 = " is the bomb!",

	cmd = "Baron",
	
	youbomb_cmd = "youbomb",
	youbomb_name = "You are the bomb alert",
	youbomb_desc = "Warn when you are the bomb",
	
	elsebomb_cmd = "elsebomb",
	elsebomb_name = "Someone else is the bomb alert",
	elsebomb_desc = "Warn when others are the bomb",
	
	icon_cmd = "icon",
	icon_name = "Raid Icon on bomb",
	icon_desc = "Put a Raid Icon on the person who's the bomb. (Requires promoted or higher)",
} end)

L:RegisterTranslations("zhCN", function() return {
	trigger1 = "^(.+)受(.+)了活化炸弹",

	you = "你",
	are = "到",

	warn1 = "你是炸弹人！向着夕阳奔跑吧！",
	warn2 = "是炸弹人！向着夕阳奔跑吧！",
	
	youbomb_name = "玩家炸弹警报",
	youbomb_desc = "你成为炸弹时发出警报",
	
	elsebomb_name = "队友炸弹警报",
	elsebomb_desc = "队友成为炸弹时发出警报",
	
	icon_name = "炸弹图标",
	icon_desc = "在成为炸弹的队友头上标记骷髅图标（需要助理或领袖权限）",
} end)

L:RegisterTranslations("koKR", function() return {
	trigger1 = "^([^|;%s]*)(.*)살아있는 폭탄에 걸렸습니다%.$",

	you = "",
	are = "",

	warn1 = "당신은 폭탄입니다!",
	warn2 = "님이 폭탄입니다!",
	
	youbomb_name = "자신의 폭탄 경고",
	youbomb_desc = "자신이 폭탄 일때 경고",
	
	elsebomb_name = "타인의 폭탄 경고",
	elsebomb_desc = "타인이 폭탄 일때 경고",
	
	icon_name = "폭탄에 공격대 아이콘 표시",
	icon_desc = "폭탄인 사람에게 공격대 아이콘 표시. (승급자 이상 요구)",
} end)

L:RegisterTranslations("deDE", function() return {
	trigger1 = "^([^%s]+) ([^%s]+) von Lebende Bombe betroffen",

	you = "Ihr",
	are = "seid",

	warn1 = "Du bist die Bombe!",
	warn2 = " ist die Bombe!",

	cmd = "Baron",
	
	youbomb_cmd = "youbomb",
	youbomb_name = "Du bist die Bombe",
	youbomb_desc = "Warnung, wenn Du die Bombe bist.",
	
	elsebomb_cmd = "elsebomb",
	elsebomb_name = "X ist die Bombe",
	elsebomb_desc = "Warnung, wenn andere Spieler die Bombe sind",
	
	icon_cmd = "icon",
	icon_name = "Symbol",
	icon_desc = "Platziert ein Symbol \195\188ber dem Spieler, der die Bombe ist. (Ben\195\182tigt Anf\195\188hrer oder Bef\195\182rdert Status.)",
} end)

L:RegisterTranslations("frFR", function() return {
	trigger1 = "^([^%s]+) ([^%s]+) les effets de Bombe vivante.",

	you = "Vous",
	are = "subissez",

	warn1 = "Tu es la bombe !",
	warn2 = " est la bombe !",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsBaronGeddon = BigWigs:NewModule(boss)
BigWigsBaronGeddon.zonename = AceLibrary("Babble-Zone-2.0")("Molten Core")
BigWigsBaronGeddon.enabletrigger = boss
BigWigsBaronGeddon.toggleoptions = {"youbomb", "elsebomb", "icon", "bosskill"}
BigWigsBaronGeddon.revision = tonumber(string.sub("$Revision$", 12, -3))

------------------------------
--      Initialization      --
------------------------------

function BigWigsBaronGeddon:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function BigWigsBaronGeddon:Event(msg)
	local _, _, EPlayer, EType = string.find(msg, L["trigger1"])
	if (EPlayer and EType) then
		if (EPlayer == L"you" and EType == L["are"] and self.db.profile.youbomb) then
			self:TriggerEvent("BigWigs_Message", L["warn1"], "Red", true)
		elseif (self.db.profile.elsebomb) then
			self:TriggerEvent("BigWigs_Message", EPlayer .. L["warn2"], "Yellow")
			self:TriggerEvent("BigWigs_SendTell", EPlayer, L["warn1"])
		end

		if self.db.profile.icon then
			if EPlayer == L["you"] then	EPlayer = UnitName("player") end
			self:TriggerEvent("BigWigs_SetRaidIcon", EPlayer )
		end
	end
end

