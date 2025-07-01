##
# Settings for this mod, used in deployment generally.
##

##
# Name of this mod, used to create the directory in the game
#
export MOD_NAME="VNGarage"

##
# Title for Steam Workshop
#
export MOD_TITLE="Veracious Network's Garage"

##
# Once you have a workshop ID for your mod, put it here.
# leave as 0 for a new mod
#
export WORKSHOP_ID=3133520800

##
# Tags to set for Steam workshop, refer to the currently supported tags
# and separate each tag with a semicolon (;)
export MOD_TAGS="Build 41;Build 42;Building;Multiplayer;Realistic"

##
# Set the visibility for Steam, recommended to be 'public' for published mods.
# Supported values are:
# public
# friends
# private
# unlisted
export MOD_VISIBILITY="public"

##
# Set to the mod version to show inside Project Zomboid.
#
# Should be a string that only contains letters, numbers, periods, underscores, tilde, or dashes.
# Used to set `modversion=` within `mod.info` files.
export MOD_VERSION="2025.07.01"

##
# Newline-separated list of source spritemaps that should get deployed for each Pack.
#
# Format is: source_tilemap:destination_pack
# where source_tilemap refers to "source_tilemap.png" in the Tiles/2x directory,
# and destination_pack refers to "destination_pack.pack" in the Packs/ directory.
export PACK_SOURCES="vn_battery_shelf:vn_garage
vn_tire_rack_tires:vn_garage
vn_tire_rack_blue:vn_garage
vn_tire_rack_green:vn_garage
vn_tire_rack_orange:vn_garage
vn_tire_rack_pink:vn_garage
vn_tire_rack_purple:vn_garage
vn_tire_rack_red:vn_garage
vn_tire_rack_yellow:vn_garage
vn_tire_rack_unpainted:vn_garage
vn_workbench:vn_garage
vn_workbench_items_01:vn_garage"