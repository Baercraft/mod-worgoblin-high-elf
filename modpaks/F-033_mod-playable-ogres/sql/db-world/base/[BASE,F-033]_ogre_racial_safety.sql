-- Ensure every Ogre class, including Death Knight, receives the Ogre racial package.
INSERT IGNORE INTO `playercreateinfo_spell_custom` VALUES
(@OgreMask, @AllClassMask, @OgreRacial1, 'War Stomp'),
(@OgreMask, @AllClassMask, @OgreRacial2, 'Endurance'),
(@OgreMask, @AllClassMask, @OgreRacial3, 'Hardiness'),
(@OgreMask, @AllClassMask, @OgreRacial4, 'Command');
