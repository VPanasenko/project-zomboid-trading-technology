-- pull the vehicle distributions into a local table
local distributionTable = VehicleDistributions[1]

VehicleDistributions.helioppsTrunk = {
    rolls = 4,
    items ={
        "Bag_WeaponBag", 3,
        "Vest_BulletArmy", 3,
        "556Clip", 3,
        "556Clip", 3,
        "556Clip", 3,
        "556Box", 3,
        "556Box", 3,
        "556Box", 3,
        "556Box", 3,
        "556Box", 3,
        "Hat_Army", 3,
        "Hat_NBCmask", 3,
        "Hat_NBCmask", 3,
        "Hat_NBCmask", 3,
        "AssaultRifle", 3,
        "AssaultRifle", 2,
        "AssaultRifle", 2,
        "Pistol", 2,
        "Pistol2", 2,
        "Pistol3", 2,
        "9mmClip", 3,
        "45Clip", 3,
        "44Clip", 3,
        "Bullets9mm", 3,
        "Bullets9mm", 3,
        "Bullets45", 3,
        "Bullets45", 3,
        "Bullets44", 3,
		"HolsterSimple", 3,
        "Trousers_CamoUrban", 1,
        "Shirt_CamoUrban", 1,
        "Jacket_ArmyCamoGreen", 1,
        "Hat_BalaclavaFull", 1,
        "Hat_BalaclavaFace", 0.5,
        "Hat_Beany", 0.5,
        "HazmatSuit", 0.5,
        "Shoes_ArmyBoots", 1,
        "Shirt_CamoUrban", 1,
        "Radio.WalkieTalkie5", 3,
        "HuntingKnife", 3,
        "Nightstick", 3,
        "FirstAidKit", 3,
		"PetrolCan", 3,
		"PetrolCan", 2,
		"x2Scope", 0.7,
		"x4Scope", 0.5,
		"x8Scope", 0.3,
        "MakeUp_GreenCamo",1
    }
}


VehicleDistributions.helioppsGloveBox = {
    rolls = 8,
    items ={
        "Pistol", 1,
        "Pistol2", 1,
        "Pistol3", 1,
        "9mmClip", 3,
        "45Clip", 3,
        "44Clip", 3,
        "Bullets9mm", 3,
        "Bullets45", 3,
        "Bullets44", 3,
		"556Clip", 3,
        "556Box", 3,
		"HuntingKnife", 3,
		"Nightstick", 3,
        "FirstAidKit", 5,
        "MakeUp_GreenCamo",1
    }
}



VehicleDistributions.heliopps = {
    TruckBedOpen = VehicleDistributions.helioppsTrunk;
	GloveBox = VehicleDistributions.helioppsGloveBox;
}

-- use the custom SWAT loot table for the police hmmw
distributionTable["advancedhelicopter"] = { Normal = VehicleDistributions.heliopps; }