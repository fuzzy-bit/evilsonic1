--PRIVATE VARIABLES--
local TitleText = "PASSED"
local Offset = Vector2.new(0xB8, 0xF8)

local FirstLetterPosition = 0x2D
local TileIncrement = 0x4
local TileSpacing = 0xF

local FirstASCIILetter = 97
local GlobalSpacing = 0

local Comment = "\t\t; "



--PRIVATE FUNCTIONS--
local function DecimalToHex(Number)
	local HexString = string.format("%x", Number)
	HexString = string.upper(HexString)

	return HexString
end

local function ConvertLetter(Letter, Index)
	local Shape = 5
	local AdditionalSpacing = 0
	local TrueLetter = ((Letter - FirstASCIILetter) * TileIncrement) + FirstLetterPosition
		
	if Letter == 105 then
		AdditionalSpacing = 0x4
	elseif Letter == 32 then
		return "\n"
	end

	return "\t\tdc.b\t" .. string.upper(string.format(
		"$%x, %d, 0, $%x, $%x\n", 
		Offset.Y,
		Shape,
		TrueLetter,
		(Offset.X + (TileSpacing * (Index - 1)) + AdditionalSpacing) % 0xFF
	))
end

local function ConvertString(Text)
	local Output = ""

	for i = 1, #Text do
		local CurrentLetter = string.sub(Text, i, i)
		local ASCIILetter = string.byte(string.lower(CurrentLetter))
		Output = Output .. ConvertLetter(ASCIILetter, i)
	end
		
	return string.format("dc.w %d%s%s\n%s\n\t\t%s", 
		#Text, 
		Comment, 
		Text,
		Output,
		"even"
	)
end



--INIT--
print(ConvertString(TitleText))