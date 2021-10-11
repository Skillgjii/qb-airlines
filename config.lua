QBBoatshop = QBBoatshop or {}
QBDiving = QBDiving or {}

--airliner spawn 1
QBBoatshop.PoliceBoat = vector3(-1219.5, -2871.91, 13.95)

QBBoatshop.PoliceBoatSpawn = vector4(-1230.78, -2879.25, 15.11, 330.5)

--airliner spawn 2
QBBoatshop.PoliceBoat2 = vector3(4495.12, -4518.19, 4.41)

QBBoatshop.PoliceBoatSpawn2 = vector4(4489.18, -4499.84, 5.36, 102.88)

--airplane garages
QBBoatshop.Docks = {
    ["Kjeller"] = {
        label = "kjeller",
        coords = {
            take = vector3(1743.27, 3299.07, 41.22),
            put = vector4(1739.02, 3282.29, 41.72, 193.0)
        }
    },
    ["Cuba"] = {
        label = "Cuba",
        coords = {
            take = vector3(4456.26, -4465.64, 4.33),
            put = vector4(4486.88, -4456.28, 4.83, 200.0)
        }
    },
}

QBBoatshop.Depots = {
    [1] = {
        label = "Flyvakten",
        coords = {
            take = vector3(-951.3, -3055.56, 13.95),
            put = vector4(-957.24, -3031.83, 14.58, 60.0)
        }
    },
}
--airplane shop
QBBoatshop.Locations = {
    ["berths"] = {
        [1] = {
            ["boatModel"] = "cuban800",
            ["coords"] = {
                ["boat"] = vector4(-962.28, -2931.13, 14.58, 152.5),
                ["buy"] = vector3(-963.48, -2937.67, 13.95),
            },
            ["inUse"] = false
        },
        [2] = {
            ["boatModel"] = "luxor",
            ["coords"] = {
                ["boat"] = vector4(-943.07, -2996.3, 14.55, 60.0),
                ["buy"] = vector3(-953.99, -2994.25, 13.95),
            },
            ["inUse"] = false
        },
        [3] = {
            ["boatModel"] = "Mammatus",
            ["coords"] = {
                ["boat"] = vector4(-960.0, -2951.49, 14.1, 150.5),
                ["buy"] = vector3(-960.44, -2957.6, 13.95),
            },
            ["inUse"] = false
        },
        [4] = {
            ["boatModel"] = "Vestra",
            ["coords"] = {
                ["boat"] = vector4(-976.78, -2943.24, 14.13, 150.5),
                ["buy"] = vector3(-977.15, -2949.09, 13.95),
            },
            ["inUse"] = false
        },
        [5] = {
            ["boatModel"] = "velum2",
            ["coords"] = {
                ["boat"] = vector4(-941.57, -2979.1, 14.88, 90.5),
                ["buy"] = vector3(-949.88, -2981.75, 13.95),
            },
            ["inUse"] = false
        },
    }
}
--prices
QBBoatshop.ShopBoats = {
    ["cuban800"] = {
        ["model"] = "cuban800",
        ["label"] = "cuban800",
        ["price"] = 500000
    },
    ["luxor"] = {
        ["model"] = "luxor",
        ["label"] = "luxor",
        ["price"] = 10000000
    },
    ["Mammatus"] = {
        ["model"] = "Mammatus",
        ["label"] = "Mammatus",
        ["price"] = 800000
    },
    ["Vestra"] = {
        ["model"] = "Vestra",
        ["label"] = "Vestra",
        ["price"] = 3000000
    },
    ["velum2"] = {
        ["model"] = "velum2",
        ["label"] = "velum2",
        ["price"] = 1300000
    }
}

QBBoatshop.SpawnVehicle = vector4(-985.83, -2971.65, 14.55, 60.0)