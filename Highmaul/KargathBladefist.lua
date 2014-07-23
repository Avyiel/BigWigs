
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kargath Bladefist", 766, 1128)
if not mod then return end
mod:RegisterEnableMob(
	85259, -- Kargath Bladefist (Unconfirmed)
)
mod.engageId = 1721

--------------------------------------------------------------------------------
-- Locals
--



--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		
	}
end

function mod:OnBossEnable()
	if self.lastKill and (GetTime() - self.lastKill) < 120 then -- Temp for outdated users enabling us
		self:ScheduleTimer("Disable", 5)
		return
	end

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

--------------------------------------------------------------------------------
-- Event Handlers
--
