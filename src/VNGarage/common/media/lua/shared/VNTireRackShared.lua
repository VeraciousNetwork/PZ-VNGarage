---
--- Common functions and utilities for Veracious Network's Garage
---
--- @see https://github.com/VeraciousNetwork/PZ-VNGarage
--- Copyright (C) 2024-2025  Charlie Powell <cdp1337@veraciousnetwork.com>
---
--- This program is free software: you can redistribute it and/or modify
--- it under the terms of the GNU Affero General Public License as
--- published by the Free Software Foundation, either version 3 of the
--- License, or (at your option) any later version.
---
--- This program is distributed in the hope that it will be useful,
--- but WITHOUT ANY WARRANTY; without even the implied warranty of
--- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--- GNU Affero General Public License for more details.
---
--- You should have received a copy of the GNU Affero General Public License
--- along with this program.  If not, see <https://www.gnu.org/licenses/>.
---
--- Load order of scripts: `shared`, then `client`, then `server`.

---@global
VNGarage = VNGarage or {}
VNGarage.TireRack = VNGarage.TireRack or {}
-- Persistent storage of all tire racks in the game
-- Used to walk through in the cron job.
VNGarage.TireRack.Racks = {}


--- Simple list of valid tire KeyNames within the game.
--- To expand support for mods, just add the modded tire names here,
--- To help with maintainability, please ensure the results are sorted alphabetically
--- within the appropriate group.  (0-9, A-Z, then a-z)
--- or add to this list with .insert() or VNTireRackCommon.ValidTireNames[#VNTireRackCommon.ValidTireNames+1] = '...'
VNGarage.TireRack.ValidTireNames = {
	-- Vanilla tires
	'ModernTire1',
	'ModernTire2',
	'ModernTire3',
	'NormalTire1',
	'NormalTire2',
	'NormalTire3',
	'OldTire1',
	'OldTire2',
	'OldTire3',
	-- Bounder by Kang
	'ModernTire8',
	'NormalTire8',
	'OldTire8',
	-- KI5 Vehicles (WHY SO MANY?!??!?)
	'49ford8NFrontTire2',
	'49ford8NRearTire2',
	'49powerWagonApocalypseTire',
	'49powerWagonTire',
	'63Type2VanTireOffroad',
	'63beetleTire',
	'63beetleTireOffroad',
	'63beetleTireSlick',
	'67gt500Tire3',
	'69miniTire',
	'69miniTirePS1',
	'73fordFalconTire3',
	'73fordFalconPSTire3',
	'75grandPrixH17Tire3',
	'75grandPrixR215Tire1',
	'75grandPrixR217Tire3',
	'75grandPrixR215Tire1',
	'75grandPrixR215Tire3',
	'76chevyKseriesTire2',
	'77firebirdTire3',
	'80chevyCKseriesTire1',
	'80chevyCKseriesTire2',
	'80sOffroadTireA',
	'81deloreanDMC12Tire3',
	'82firebirdTire3',
	'82porsche911TurboTire',
        '84jeepXJTire2',
	'85clubManTire1',
	'85gmBbodyTire0',
	'85gmBbodyTire1',
	'85gmBbodyTire2',
	'85gmBbodyTire3',
	'85gmBbodyTire4',
	'85gmBbodyTire5',
	'85gmBbodyTire6',
	'86chevyCUCVTire1',
	'87chevySuburbanTire2',
	'87fordB700DoubleTires2',
	'87fordB700Tire2',
	'87toyotaMR2TireT13',
	'87toyotaMR2TireT23',
	'88toyotaHiluxTire2',
	'89dodgeCaravanTire',
	'89dodgeCaravanTireOffroad',
	'89trooperTire2',
	'89volvo200Tire0',
	'89volvo200Tire1',
	'89volvo200Tire2',
	'90bmwE30Tire3',
	'90bmwE30mTire3',
	'90chevyCKseriesTire1',
	'90chevyCKseriesTire2',
	'90fordF250Tire2',
	'90fordF350DoubleTires2',
	'90pierceArrowDoubleTires2',
	'90pierceArrowTire2',
	'91geoMetroTire1',
	'91nissan240sxOEM13',
        '91nissan240sxOEM23',
        '91nissan240sxG73',
        '91nissan240sxGT3',
	'91rangeTire2',
	'92jeepYJTire2',
	'93chevySuburbanTire1',
	'93chevySuburbanTire2',
	'93fordCF8000DoubleTires2',
	'93fordCF8000Tire2',
	'93fordF350DoubleTires2',
	'93fordF350DoubleTires',
	'93fordF350DoubleTires2',
	'93fordF350Tire',
	'93fordF350Tire2',
	'93fordF350Tire2',
	'93fordTaurusSHOTire1',
	'93fordTaurusTire1',
	'93mustangSSPTire1',
	'93townCarTire1',
	'98stageaTire3',
	'04vwTouranTire1',
	'BushmasterTire',
	'CUDAtire',
	'CUDAtire3',
	'CamaroSStire',
	'CamaroSStire3',
	'DodgeRTtire',
	'DodgeRTtire3',
	'DodgeRTtireA',
	'E150Tire2',
	'ECTO1tire1_Item',
	'ECTO1tire2_Item',
	'Large2TireAxle',
	'Large4TireAxle',
	'LargeDoubleTires',
	'LargeTire',
	'M923Axle2',
	'Medium4TireAxle',
	'MediumTire',
	'ModernTire',
	'R32Tire0',
	'R32Tire1',
	'R32Tire2',
	'R32TireA',
	'SS100modernTire',
	'SS100normalTire',
	'SS100oldTire',
	'SmallTire',
	'SmallTire1',
	'SmallTire2',
	'SteelTire1',
	'V100Axle2',
	'V100AxleSmall2',
	'V100Tire2',
	'V100Tires2',
	'V101Tire2',
	'V102Tire2',
	'V103Axle2',
	'V103Tire2',
	'W460ModernTire2',
	'W460NormalTire2',
	'W460WideTire2',
	'ZNL50modernTire',
	'ZNL50normalTire',
	'ZNL50oldTire',
	'fordCVPITire1',
	'vic92_tire',
	'vic91_tire',
}


--- Check if a given Item is a tire
---@param itemName string The name of the item to check
---@return boolean
function VNGarage.TireRack.ScriptItemIsTire(itemName)
	for index, value in ipairs(VNGarage.TireRack.ValidTireNames) do
		if value == itemName then
			return true
		end
	end

	return false
end


--- Check if a given Sprite name is a tire rack
---@param spriteName string The name of the sprite to check
---@return boolean
function VNGarage.TireRack.SpriteNameIsTireRack(spriteName)
	if spriteName == nil or spriteName == '' then
		-- Failsafe for if an empty sprite is passed in.
		-- This happens with transfers from vehicles, corpses, etc.
		return false
	end

	-- Submitted sprite name contains "vn_tire_rack_";
	-- while this is not a 100% guarantee, it's a good enough check for now.
	return string.find(spriteName, "vn_tire_rack_") ~= nil
end


--- Check if the given isoObject is a Tire Rack
---@param isoObject IsoObject
---@return boolean
function VNGarage.TireRack.ObjectIsTireRack(isoObject)
	---@type IsoSprite
	local sprite = isoObject:getSprite()
	if not sprite then
		-- Ensure the object has a sprite, (items cannot be placed)
		return false
	end

	---@type ItemContainer
	if not isoObject:getContainer() then
		-- This is a container type object, probably a redundant check, but doesn't harm anything.
		return false
	end

	return VNGarage.TireRack.SpriteNameIsTireRack(sprite:getName())
end


--- Update the tire sprite based on how many tires are stored.
--- Will automatically send the "updateSprite" notification to clients when in server mode
---@param isoObject IsoObject
function VNGarage.TireRack.UpdateTireRackSprite(isoObject)
	---@type ItemContainer
	local container = isoObject:getContainer()
	---@type IsoSprite
	local sprite = isoObject:getSprite()

	-- Retrieve the facing orientation of the default Sprite,
	-- 0 = North, 1 = East, 2 = South, 3 = West
	-- This is dependent on the spritemap, and is used to adjust the QTY offset to the correct orientation sprite.
	-- The sprite name is "vn_tire_rack_unpainted_[0-3]",
	-- string.sub(...) trims off to just the last character.
	local orientation = tonumber(string.sub(sprite:getName(), -1))

	-- Retrieve the base sprite name, this will be the "type" of tire rack.
	-- ie: trims off the [0-3] orientation value.
	local base = 'vn_tire_rack_tires_'

	-- Use the number of items currently in the inventory to adjust the sprite position.
	-- Positions 0 - 3 are 1 qty,
	-- Positions 4 - 7 are 2 qty,
	-- etc.  (P + 4*len) will provide the accurate positional sprite.
	local len = container:getItems():size()

	if isServer() then
		if isoObject:getModData().VNTireRackCount == len then
			-- Do not perform unnecessary spriteUpdates, (they'd just clutter up the network traffic)
			return
		end

		-- Cache the number of tires last sent, so the next tick can check & will know whether or not to send the sprite
		isoObject:getModData().VNTireRackCount = len
	end

	if len > 12 then
		-- Failsafe as there are only 12 sets of sprites in the spritemap (plus one overflow)
		isoObject:setOverlaySprite(base .. tostring(orientation + (4 * 13) - 4))
	elseif len > 0 then
		-- At least 1 tire, but less than 13.  Standard sprites.
		isoObject:setOverlaySprite(base .. tostring(orientation + (4 * len) - 4))
	else
		-- No tires, just remove the sprite overlay.
		isoObject:setOverlaySprite(nil)
	end

	if isServer() then
		-- Sprite only needs sent when in server/client mode (from the server)
		isoObject:transmitUpdatedSprite()
	end
end


--- Called as soon as the player completes a craft of a tire rack from a recipe
---@param thumpable Thumpable
function VNGarage.TireRack.OnCreateRecipe(thumpable)
	VNGarage.TireRack.SetupPlacedTile(thumpable)
end


--- Check to see if the placed item is a tire rack, and attach the expected functionality if so
---@param isoObject IsoThumpable
function VNGarage.TireRack.SetupPlacedTile(isoObject)
	if VNGarage.TireRack.ObjectIsTireRack(isoObject) then
		---@type ItemContainer
		local container = isoObject:getContainer()

		container:setAcceptItemFunction('VNGarage.TireRack.AcceptItemFunction')

		if isServer() then
			isoObject:getModData().VNTireRackCount = nil
			VNGarage.TireRack.Racks[#VNGarage.TireRack.Racks+1] = isoObject
		end
	end
end


--- Handle accepting only tires on the tire rack
---@param container IsoThumpable
---@param item InventoryItem
---@return boolean
function VNGarage.TireRack.AcceptItemFunction(container, item)
	local sItem = item:getScriptItem()

	if not sItem then
		-- Failsafe if the source item doesn't have a script item
		return false
	end

	return VNGarage.TireRack.ScriptItemIsTire(sItem:getName())
end


--- Since the server handles updateSprites in Java and does not expose a mechanism for triggering this,
--- manually watch the containers and check if they need to be refreshed every so often.
function VNGarage.TireRack.ScheduledUpdateCheck()
	for index, value in ipairs(VNGarage.TireRack.Racks) do
		if value then
			--- Only update sprites if the object is valid, should address issue #4
			VNGarage.TireRack.UpdateTireRackSprite(value)
		end
	end
end


--- Update the global index of container icons to include the tire rack.
---@global
ContainerButtonIcons = ContainerButtonIcons or {}
ContainerButtonIcons.TireRackUnpainted = getTexture("media/textures/Item_TireRackUnpainted.png")
ContainerButtonIcons.TireRackBlue = getTexture("media/textures/Item_TireRackBlue.png")
ContainerButtonIcons.TireRackGreen = getTexture("media/textures/Item_TireRackGreen.png")
ContainerButtonIcons.TireRackOrange = getTexture("media/textures/Item_TireRackOrange.png")
ContainerButtonIcons.TireRackPink = getTexture("media/textures/Item_TireRackPink.png")
ContainerButtonIcons.TireRackPurple = getTexture("media/textures/Item_TireRackPurple.png")
ContainerButtonIcons.TireRackRed = getTexture("media/textures/Item_TireRackRed.png")
ContainerButtonIcons.TireRackYellow = getTexture("media/textures/Item_TireRackYellow.png")



--- Check to see if any newly placed Tile is a tire rack and perform the adjustments if necessary.
--- This only applies to NEWLY placed tiles, not existing ones.
Events.OnObjectAdded.Add(VNGarage.TireRack.SetupPlacedTile)


--- Handle EXISTING objects already on the map at the time of game load.
local tile_tags = {
	'vn_tire_rack_unpainted',
	'vn_tire_rack_blue',
	'vn_tire_rack_green',
	'vn_tire_rack_orange',
	'vn_tire_rack_pink',
	'vn_tire_rack_purple',
	'vn_tire_rack_red',
	'vn_tire_rack_yellow',
}
for _, value in ipairs(tile_tags) do
	MapObjects.OnLoadWithSprite(value .. '_0', VNGarage.TireRack.SetupPlacedTile, 5)
	MapObjects.OnLoadWithSprite(value .. '_1', VNGarage.TireRack.SetupPlacedTile, 5)
	MapObjects.OnLoadWithSprite(value .. '_2', VNGarage.TireRack.SetupPlacedTile, 5)
	MapObjects.OnLoadWithSprite(value .. '_3', VNGarage.TireRack.SetupPlacedTile, 5)
end

