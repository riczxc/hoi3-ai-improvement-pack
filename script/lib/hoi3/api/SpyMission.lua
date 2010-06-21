require('hoi3.Hoi3Object')

SpyMissionObject = Hoi3Object:subclass('hoi3.SpyMission')

SpyMissionObject.SPYMISSION_BOOST_OUR_PARTY  = 1
SpyMissionObject.SPYMISSION_BOOST_RULING_PARTY = 2
SpyMissionObject.SPYMISSION_COUNTER_ESPIONAGE  = 3
SpyMissionObject.SPYMISSION_DISRUPT_PRODUCTION  = 4
SpyMissionObject.SPYMISSION_DISRUPT_RESEARCH  = 5
SpyMissionObject.SPYMISSION_INCREASE_THREAT  = 6
SpyMissionObject.SPYMISSION_LOWER_NATIONAL_UNITY = 7
SpyMissionObject.SPYMISSION_LOWER_NEUTRALITY = 8
SpyMissionObject.SPYMISSION_MAX  = 9
SpyMissionObject.SPYMISSION_MILITARY   = 10
SpyMissionObject.SPYMISSION_NONE   = 11
SpyMissionObject.SPYMISSION_POLITICAL   = 12
SpyMissionObject.SPYMISSION_RAISE_NATIONAL_UNITY  = 13
SpyMissionObject.SPYMISSION_SUPPORT_RESISTANCE  = 14
SpyMissionObject.SPYMISSION_TECH   = 15

-- SpyMission has static methods and properties
-- we need to declare a SpyMission table
SpyMission = SpyMissionObject