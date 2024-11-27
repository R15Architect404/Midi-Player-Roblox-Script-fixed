-- App
-- 0866
-- November 03, 2020

local App = {}

local CoreGui = game:GetService("CoreGui")

local midiPlayer = script:FindFirstAncestor("MidiPlayer")
assert(midiPlayer, "MidiPlayer folder not found. Ensure the script is within the proper hierarchy.")

-- Module requirements
local FastDraggable = require(midiPlayer:WaitForChild("FastDraggable"))
local Components = midiPlayer:WaitForChild("Components")
local Controller = require(Components:WaitForChild("Controller"))
local Sidebar = require(Components:WaitForChild("Sidebar"))
local Preview = require(Components:WaitForChild("Preview"))

-- GUI asset
local gui = midiPlayer:WaitForChild("Assets"):WaitForChild("ScreenGui")
assert(gui:IsA("ScreenGui"), "Expected ScreenGui in Assets folder.")

-- Function to retrieve GUI
function App:GetGUI()
    return gui
end

-- Initialize the app
function App:Init()
    -- Ensure FastDraggable is initialized correctly
    if not gui.Frame or not gui.Frame:FindFirstChild("Handle") then
        error("GUI Frame or its Handle is missing. Ensure the structure matches expectations.")
    end

    FastDraggable(gui.Frame, gui.Frame.Handle)

    -- Protect the GUI for exploits if Synapse is available
    if syn and syn.protect_gui then
        syn.protect_gui(gui)
    end

    -- Parent the GUI to CoreGui for visibility
    gui.Parent = CoreGui

    -- Initialize individual components
    Controller:Init(gui.Frame)
    Sidebar:Init(gui.Frame)
    Preview:Init(gui.Frame)
end

return App
