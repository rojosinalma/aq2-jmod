#
# Action makefile 
# Intended for gcc/Linux, may need modifying for other platforms
#

ARCH=x86_64
# /* ndit-dev change 
#CC=gcc
CC=x86_64-w64-mingw32-gcc
# */
BASE_CFLAGS=-Dstricmp=strcasecmp

#use these cflags to optimize it
CFLAGS=$(BASE_CFLAGS) -O6 -ffast-math -funroll-loops \
	-fomit-frame-pointer -fexpensive-optimizations -falign-loops=2 \
	-falign-jumps=2 -falign-functions=2
#use these when debugging 
#CFLAGS=$(BASE_CFLAGS) -g

LDFLAGS=-ldl -lm
SHLIBEXT=dll
SHLIBCFLAGS=-fPIC
SHLIBLDFLAGS=-shared

DO_CC=$(CC) $(CFLAGS) $(SHLIBCFLAGS) -o $@ -c $<

#############################################################################
# SETUP AND BUILD
# GAME
#############################################################################

.c.o:
	$(DO_CC)

GAME_OBJS = \
	g_ai.o g_cmds.o g_combat.o g_func.o g_items.o g_main.o g_misc.o \
	g_monster.o g_phys.o g_save.o g_spawn.o g_svcmds.o \
	g_target.o g_trigger.o g_turret.o g_utils.o g_weapon.o g_chase.o \
	p_client.o p_hud.o p_trail.o p_view.o p_weapon.o q_shared.o \
	m_move.o a_team.o a_game.o a_items.o a_cmds.o a_radio.o a_menu.o \
	cgf_sfx_glass.o a_doorkick.o \
	g_puppet.o g_lasertrail.o g_mapvote.o g_marker.o g_puppetdemo.o

game$(ARCH).$(SHLIBEXT) : $(GAME_OBJS)
	$(CC) $(CFLAGS) $(SHLIBLDFLAGS) -o $@ $(GAME_OBJS)


#############################################################################
# MISC
#############################################################################

clean:
	-rm -f $(GAME_OBJS)

depend:
	gcc -MM $(GAME_OBJS:.o=.c)


install:
	cp gamei386.so ../quake2/action

#
# From "make depend"
#

g_ai.o: g_ai.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_cmds.o: g_cmds.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h m_player.h
g_combat.o: g_combat.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h cgf_sfx_glass.h
g_puppet.o: g_puppet.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h m_player.h
g_func.o: g_func.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_items.o: g_items.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_lasertrail.o: g_lasertrail.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_main.o: g_main.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_mapvote.o: g_mapvote.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_marker.o: g_marker.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_misc.o: g_misc.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h cgf_sfx_glass.h
g_monster.o: g_monster.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_phys.o: g_phys.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h cgf_sfx_glass.h
g_puppetdemo.o: g_puppetdemo.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_save.o: g_save.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h cgf_sfx_glass.h
g_spawn.o: g_spawn.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_svcmds.o: g_svcmds.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_target.o: g_target.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_trigger.o: g_trigger.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_turret.o: g_turret.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_utils.o: g_utils.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
g_weapon.o: g_weapon.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h cgf_sfx_glass.h
g_chase.o: g_chase.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
p_client.o: p_client.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h m_player.h cgf_sfx_glass.h
p_hud.o: p_hud.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
###unused### p_trail.o: p_trail.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
p_view.o: p_view.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h m_player.h
p_weapon.o: p_weapon.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h m_player.h
q_shared.o: q_shared.c q_shared.h
m_move.o: m_move.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
a_team.o: a_team.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h cgf_sfx_glass.h
a_game.o: a_game.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h cgf_sfx_glass.h
###unused### a_items.o: a_items.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
a_cmds.o: a_cmds.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
###unused### a_radio.o: a_radio.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
a_menu.o: a_menu.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
cgf_sfx_glass.o: cgf_sfx_glass.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h cgf_sfx_glass.h
a_doorkick.o: a_doorkick.c g_local.h q_shared.h game.h a_team.h a_game.h a_menu.h
