--[[

  SS_SMPTE - Add a simple SMPTE Timecode overlay to Moho Animations
  
  version: MH12#470210.001    - by Sam Cogheil (SimplSam)
  
]]

--[[ 

    ***** Licence & Warranty *****

    This work is licensed under a MIT License
    Please see: https://choosealicense.com/licenses/mit/
    
    Copyright (c) 2017 SimplSam

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
        
--]] 

--[[

    ***** How To Use *****

    This is a MOHO (Anime Studio) Layer script
        
    - To use:
        (0) - Save this file to your computer file system
        (1) - Add a NOTE Layer to your Moho project
        (2) - Use the Layer properties to Select [General] > [Embedded script file] and choose this file        
        (3) - (Optional::Render) Set Layer properties to render. i.e. Uncheck - [General] > 'Don't render this layer' - If you want overlay on final video output file
        (4) - (Optional::Colorize) Set Layer properties to [General] > [Colorize layer] and choose colour/transparency. This will tint the Note for better visibility
        (5) - (Optional::Position) Move the Note Layer on the screen to a preferred position
]]

--[[

    ***** Known Issues:

        - Occasional 'random text' appearing as the Timecode text. This is a Moho buglet caused by the render process, and can be minimised by using Moho Exporter.
            
    ***** Todo:            
            
        - Maybe ... Set the Render and Colorize options automatically (will await feedback)
            
]]

function LayerScript(moho)

    if (moho.layer:LayerType() ~= MOHO.LT_NOTE) then
         return false     
    end
    
    if (not gFps) then
        gFps = moho.document:Fps()    --< Frames Per Second
    end
    if (not gFrm) then
        gFrm = moho.frame    --< Current Frame
    end

    local iFps = moho.document:Fps()
    local iFrm = moho.frame

    if (iFrm ~= gFrm) then --> Frame has changed, so update display
        local iRatio = iFrm / iFps 
        local iHrs = math.floor(iRatio / 60 / 60)
        local iMin = math.floor((iRatio / 60) % 60)
        local iSec = math.floor(iRatio % 60)
        local iFF  = iFrm % iFps

        -- Set Note Layer text
        local layer = moho:LayerAsNote(moho.layer)
        layer:SetNoteText(string.format(" %02d:%02d:%02d:%02d ", iHrs, iMin, iSec, iFF))

        gFps = iFps
        gFrm = iFrm        
    end
	
end