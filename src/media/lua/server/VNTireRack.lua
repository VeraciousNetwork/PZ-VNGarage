---@global
VNTireRack = {}


--- Check if a given Sprite name is a tire rack
---@param spriteName string The name of the sprite to check
local SpriteNameIsTireRack = function(spriteName)
	return string.find(spriteName, "vn_tire_rack_") ~= nil
end


--- Check if a given Item is a tire
---@param itemName string The name of the item to check
local ScriptItemIsTire = function(itemName)

	-- Simple list of valid tire KeyNames within the game.
	-- To expand support for mods, just add the modded tire names here.
	local ValidTireNames = {
		'ModernTire1',
		'ModernTire2',
		'ModernTire3',
		'ModernTire8',
		'NormalTire1',
		'NormalTire2',
		'NormalTire3',
		'NormalTire8',
		'OldTire1',
		'OldTire2',
		'OldTire3',
		'OldTire8',
		'ECTO1tire1_item',
		'ECTO1tire2_item',
		'67gt500Tire3',
		'67gt500Tire3',
		'CamaroSStire3',
		'69miniTirePS1',
		'CUDAtire3',
		'DodgeRTtireA',
		'80sOffraodTireA',
		'87fordB700DoubleTires2',
		'87fordB700Tire2',
		'87toyotaMR2TireT13',
		'87toyotaMR2TireT23',
		'89dodgeCaravanTireOffroad',
		'89dodgeCaravanTire',
		'89trooperTire2',
		'90bmwE30Tire3',
		'90bmwE30mTire3',
		'90fordF350DoubleTires2',
		'90fordF250Tire2',
		'90pierceArrowDoubleTires2',
		'90pierceArrowTire2',
		'91geoMetroTire1',
		'91rangeTire2',
		'93fordCF8000DoubleTires2',
		'93fordF350DoubleTIres2',
		'93fordCF8000TIre2,
		'93fordF350Tire2',
		'93mustanfSSPTire1',
		'93fordTaurusSHOTire1',
		'93fordTaurusTire1',
		'93townCarTire1',
		'BushmasterTire',
		'fordCVPITire1',
		'E150Tire2',
		'V103Tire2',
		'V101Tire2',
		'49powerWagonApocalypseTire',
		'49powerWagonTire',
		'R32TireA',
		'R32Tire1',
		'R32Tire2',
		'R32Tire0',
		'V100Tire2',
		'63beetleTireOffroad',
		'63beetleTireSlick',
		'63beetleTire',
		'63Type2VanTireOffroad',
		'W460ModernTire2',
		'W460NormalTire2',
		'W460WideTire2'


		
	}

	for index, value in ipairs(ValidTireNames) do
		if value == itemName then
			return true
		end
	end

	return false

end


--- Check to see if the placed item is a tire rack, (and attach the expected functionality if so)
---@param isoObject IsoThumpable
VNTireRack.SetupPlacedTile = function(isoObject)
	---@type IsoSprite
	local sprite = isoObject:getSprite()
	---@type ItemContainer
	local container = isoObject:getContainer()

	if not sprite then
		-- Failsafe if the source item doesn't have a sprite
		return
	end

	if not container then
		-- Failsafe if the source item doesn't have a container
		return
	end

	if SpriteNameIsTireRack(sprite:getName()) then
		container:setAcceptItemFunction('VNTireRack.AcceptItemFunction')
		container:setCapacity(180) -- 12 items of 15 weight tires
	end
end


--- Handle accepting only tires on the tire rack
---@param isoObject IsoThumpable
VNTireRack.AcceptItemFunction = function(container, item)
	local sItem = item:getScriptItem()

	if not sItem then
		-- Failsafe if the source item doesn't have a script item
		return false
	end

	return ScriptItemIsTire(sItem:getName())
end


VNTireRack.UpdateSprite = function(isoObject)
	---@type ItemContainer
	local container = isoObject:getContainer()
	---@type IsoSprite
	local sprite = isoObject:getSprite()

	-- Retrieve the facing orientation of the default Sprite,
	-- 0 = North, 1 = East, 2 = South, 3 = West
	-- This is dependent on the spritemap, and is used to adjust the QTY offset to the correct orientation sprite.
	local orientation = tonumber(string.sub(sprite:getName(), -1))

	local base = string.match(sprite:getName(), '.*_')

	-- Use the number of items currently in the inventory to adjust the sprite position.
	-- Positions 0 - 3 are 0 qty,
	-- Positions 4 - 7 are 1 qty,
	-- etc.  (P + 4*len) will provide the accurate positional sprite.
	local len = container:getItems():size()

	if len > 12 then
		-- Failsafe as there are only 12 sets of sprites in the spritemap (plus one overflow)
		isoObject:setOverlaySprite(base .. tostring(orientation + (4 * 13)))
	elseif len > 0 then
		isoObject:setOverlaySprite(base .. tostring(orientation + (4 * len)))
	else
		isoObject:setOverlaySprite(nil)
	end
end


--- Check to see if any newly placed Tile is a tire rack and perform the adjustments if necessary.
--- This only applies to NEWLY placed tiles, not existing ones.
Events.OnObjectAdded.Add(VNTireRack.SetupPlacedTile)


--- Handle EXISTING objects already on the map at the time of game load.
MapObjects.OnLoadWithSprite('vn_tire_rack_unpainted_0', VNTireRack.SetupPlacedTile, 5)
MapObjects.OnLoadWithSprite('vn_tire_rack_unpainted_1', VNTireRack.SetupPlacedTile, 5)
MapObjects.OnLoadWithSprite('vn_tire_rack_unpainted_2', VNTireRack.SetupPlacedTile, 5)
MapObjects.OnLoadWithSprite('vn_tire_rack_unpainted_3', VNTireRack.SetupPlacedTile, 5)


--- Overwrite the TransferItem method to provide an artificial hook for updating the inventory.
--- This is not recommended as it checks on EVERY item transfer across EVERY container,
--- but is necessary because there currently is not an event in place.
local oldTransferItem = ISInventoryTransferAction.transferItem
function ISInventoryTransferAction:transferItem(...)
	-- Run the original method first; we have no need to modify that behaviour
	local ret = {oldTransferItem(self, ...)}

	if self.srcContainer then
		---@type IsoObject
		local parent = self.srcContainer:getParent()

		if parent then
			---@type IsoSprite
			local sprite = parent:getSprite()

			if sprite then
				local spriteName = sprite:getName()

				if spriteName and SpriteNameIsTireRack(spriteName) then
					-- Instruct the tire rack to update its sprite
					VNTireRack.UpdateSprite(parent)
				end
			end
		end
	end

	if self.destContainer then

		---@type IsoObject
		local parent = self.destContainer:getParent()

		if parent then
			---@type IsoSprite
			local sprite = parent:getSprite()

			if sprite then
				local spriteName = sprite:getName()

				if spriteName and SpriteNameIsTireRack(spriteName) then
					-- Instruct the tire rack to update its sprite
					VNTireRack.UpdateSprite(parent)
				end
			end
		end
	end

	return unpack(ret)
end
