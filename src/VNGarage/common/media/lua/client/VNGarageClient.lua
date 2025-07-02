---
--- Single-player functions and utilities for Veracious Network's Garage
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


--- Only run this snippet when in single player.
--- This is because single player triggers the updateOverlaySprite locally,
--- whereas in the server it's handled within Java and is not exposed to LUA.
if not isClient() then
	local overload_fn = ItemPickerJava.updateOverlaySprite
	function ItemPickerJava.updateOverlaySprite(isoObject)
		if VNGarage.TireRack.ObjectIsTireRack(isoObject) then
			VNGarage.TireRack.UpdateTireRackSprite(isoObject)
		elseif VNGarage.BatteryShelf.ObjectIsShelf(isoObject) then
			VNGarage.BatteryShelf.UpdateSprite(isoObject)
		else
			overload_fn(isoObject)
		end
	end

	Events.EveryTenMinutes.Add(VNGarage.BatteryShelf.ScheduledCheck)
end
