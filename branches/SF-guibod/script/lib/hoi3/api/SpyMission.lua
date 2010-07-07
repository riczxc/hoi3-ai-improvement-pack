require('hoi3')

module("hoi3.api", package.seeall)

SpyMission = hoi3.AbstractObject:subclass('hoi3.api.SpyMission')

SpyMission.SPYMISSION_BOOST_OUR_PARTY  = 1
SpyMission.SPYMISSION_BOOST_RULING_PARTY = 2
SpyMission.SPYMISSION_COUNTER_ESPIONAGE  = 3
SpyMission.SPYMISSION_DISRUPT_PRODUCTION  = 4
SpyMission.SPYMISSION_DISRUPT_RESEARCH  = 5
SpyMission.SPYMISSION_INCREASE_THREAT  = 6
SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY = 7
SpyMission.SPYMISSION_LOWER_NEUTRALITY = 8
SpyMission.SPYMISSION_MAX  = 9
SpyMission.SPYMISSION_MILITARY   = 10
SpyMission.SPYMISSION_NONE   = 11
SpyMission.SPYMISSION_POLITICAL   = 12
SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY  = 13
SpyMission.SPYMISSION_SUPPORT_RESISTANCE  = 14
SpyMission.SPYMISSION_TECH   = 15