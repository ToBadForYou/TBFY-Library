TBFY_LIB.CachedImages = TBFY_LIB.CachedImages or {}

local NoPic = Material("vgui/avatar_default")
function TBFY_LIB.GetImgurImage(ImgurID)
	if TBFY_LIB.CachedImages[ImgurID] then
		return TBFY_LIB.CachedImages[ImgurID]
	elseif file.Exists("tbfy_lib/imgur/"..ImgurID..".png", "DATA") then
		TBFY_LIB.CachedImages[ImgurID] = Material("data/tbfy_lib/imgur/"..ImgurID..".png", "noclamp smooth")
	else
		http.Fetch("https://i.imgur.com/"..ImgurID..".png",function(Body, Len, Headers)
			file.Write("tbfy_lib/imgur/"..ImgurID..".png", Body)
			TBFY_LIB.CachedImages[ImgurID] = Material("data/tbfy_lib/imgur/"..ImgurID..".png", "noclamp smooth")
		end)
	end
	return TBFY_LIB.CachedImages[ImgurID]
end
