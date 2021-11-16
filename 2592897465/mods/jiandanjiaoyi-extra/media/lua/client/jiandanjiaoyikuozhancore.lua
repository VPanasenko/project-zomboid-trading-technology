local shoushiitemlist = {"tradecore","Necklace_Gold","Necklace_GoldRuby","Necklace_GoldDiamond","Necklace_Silver","Necklace_SilverSapphire","Necklace_SilverCrucifix","Necklace_SilverDiamond","Necklace_Crucifix","Necklace_YingYang","Necklace_Pearl","NecklaceLong_Gold","NecklaceLong_GoldDiamond","NecklaceLong_Silver","NecklaceLong_SilverEmerald","NecklaceLong_SilverSapphire","NecklaceLong_SilverDiamond",
"NecklaceLong_Amber","Necklace_Choker","Necklace_Choker_Sapphire","Necklace_Choker_Amber","Necklace_Choker_Diamond","NoseRing_Gold","NoseRing_Silver","NoseStud_Gold","NoseStud_Silver","Earring_LoopLrg_Gold","Earring_LoopLrg_Silver","Earring_LoopMed_Silver","Earring_LoopMed_Gold","Earring_LoopSmall_Silver_Both","Earring_LoopSmall_Silver_Top","Earring_LoopSmall_Gold_Both","Earring_LoopSmall_Gold_Top","Earring_Stud_Gold",
"Earring_Stud_Silver","Earring_Stone_Sapphire","Earring_Stone_Emerald","Earring_Stone_Ruby","Earring_Pearl","Earring_Dangly_Sapphire","Earring_Dangly_Emerald","Earring_Dangly_Ruby","Earring_Dangly_Diamond","Earring_Dangly_Pearl","Ring_Right_MiddleFinger_Gold","Ring_Left_MiddleFinger_Gold","Ring_Right_RingFinger_Gold","Ring_Left_RingFinger_Gold","Ring_Right_MiddleFinger_Silver",
"Ring_Left_MiddleFinger_Silver","Ring_Right_RingFinger_Silver","Ring_Left_RingFinger_Silver","Ring_Right_MiddleFinger_SilverDiamond","Ring_Left_MiddleFinger_SilverDiamond","Ring_Right_RingFinger_SilverDiamond","Ring_Left_RingFinger_SilverDiamond","Ring_Right_MiddleFinger_GoldRuby","Ring_Left_MiddleFinger_GoldRuby","Ring_Right_RingFinger_GoldRuby","Ring_Left_RingFinger_GoldRuby",
"Ring_Right_MiddleFinger_GoldDiamond","Ring_Left_MiddleFinger_GoldDiamond","Ring_Right_RingFinger_GoldDiamond","Ring_Left_RingFinger_GoldDiamond","Bracelet_BangleRightGold","Bracelet_BangleLeftGold","Bracelet_ChainRightGold","Bracelet_ChainLeftGold","Bracelet_BangleRightSilver","Bracelet_BangleLeftSilver","Bracelet_ChainRightSilver","Bracelet_ChainLeftSilver","Bracelet_RightFriendshipTINT","Bracelet_LeftFriendshipTINT"}


function shasijiangshi2(zombiea)

    local inv = getPlayer():getInventory()
    local wanjia = getPlayer()
    local zombieinv = zombiea:getInventory()
    if inv:contains("tt_shihuangzhezhinan", true) then
        for k, v in pairs(shoushiitemlist) do
            if zombieinv:contains(v) then
                zombieinv:Remove(v)
                inv:AddItem(v)
            end
        end
        
    end

end

function jianshaoshoushizhongliang()
    for k , v in pairs(shoushiitemlist) do
        -- ScriptManager.instance:getItem(v):setActualWeight(0)
        ScriptManager.instance:getItem(v):setActualWeight(0.001)
    end
    -- UIManager.AddUI(RadarPanel.new(getPlayer()))
    -- RadarPanel:New(getPlayer())


end


Events.OnGameBoot.Add(jianshaoshoushizhongliang)
Events.OnZombieDead.Add(shasijiangshi2)