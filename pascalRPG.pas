PROGRAM pascalrpg;//Desactivar bloq mayus
USES Crt,sysutils;
CONST
  si1 = 3;
  sf1 = 10;
  error1 = 'Invalid intruction.';
  inv_max= 8;
TYPE
  hud_id =(inventory,main);
  bparts =(W,A);
  stats = record
    name:string;
    hp,hp_max,atk,exp,gold:integer;
    END;
  items = record
    name:string;
    END;
VAR
  imp:char;
  room:string;
  i,chance,wherenext,exp_max,lvl,explored,depth,more:integer;
  inv:array[1..inv_max]of string;
  hud_at:hud_id;
  p,e:stats;
  equipped:array[bparts] of string;
  b:bparts;

//Prequsito para display<-------------------------------------------------------
PROCEDURE _write_(j1:integer;s:string;j2:integer);
    BEGIN
    for i:= 1 to j1 do
    write(' ');
    write(s);
    for i:= 1 to(j2-length(s)) do
    write(' ')
    END;//space(j1 times)string space (j-length of the string))

PROCEDURE DISPLAY;
  //-----------------------------START-UP Menus-------------------------------//
  PROCEDURE display_logo;
    BEGIN
    writeln('-------------------------------------------------------------------------------------------------------');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('    _____                                        ___                  _____       _____    _____      ');
    writeln('   /\  __`\                                     /\_ \                /\  _ `\    /\  _ `\ /\  _ `\     ');
    writeln('   \ \ \L\ \   __       ____    ___      __     \//\ \               \ \ \L\ \   \ \ \L\ \\ \ \ \_\    ');
    writeln('    \ \ ,__/ /,__`\    /,,__\  /,___\  /,__`\     \ \ \               \ \ ,  /    \ \ ,__/ \ \ \L_ \   ');
    writeln('     \ \ \/ /\ \L\.\_ /\__, `\/\ \__/ /\ \L\.\_    \_\ \_              \ \ \\ \    \ \ \/   \ \ \/, \  ');
    writeln('      \ \_\ \ \__/.\_\\/\____/\ \____\\ \__/.\_\   /\____\              \ \_\ \_\   \ \_\    \ \____/  ');
    writeln('       \/_/  \/__/\/_/ \/___/  \/____/ \/__/\/_/   \/____/               \/_/\/ /    \/_/     \/___/   ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                        Press "s" to start                                             ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('-------------------------------------------------------------------------------------------------------');
    END;
  PROCEDURE display_main_menu;
    BEGIN
    writeln('-------------------------------------------------------------------------------------------------------');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('    ____                                         ___                  ____        ____     ____        ');
    writeln('   /\  _`\                                      /\_ \                /\  _`\     /\  _`\  /\  _`\      ');
    writeln('   \ \ \L\ \   __       ____    ___      __     \//\ \               \ \ \L\ \   \ \ \L\ \\ \ \L\_\    ');
    writeln('    \ \ ,__/ /,__`\    /,,__\  /,___\  /,__`\     \ \ \               \ \ ,  /    \ \ ,__/ \ \ \L_L    ');
    writeln('     \ \ \/ /\ \L\.\_ /\__, `\/\ \__/ /\ \L\.\_    \_\ \_              \ \ \\ \    \ \ \/   \ \ \/, \  ');
    writeln('      \ \_\ \ \__/.\_\\/\____/\ \____\\ \__/.\_\   /\____\              \ \_\ \_\   \ \_\    \ \____/  ');
    writeln('       \/_/  \/__/\/_/ \/___/  \/____/ \/__/\/_/   \/____/               \/_/\/ /    \/_/     \/___/   ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                 Press:                                                                                ');
    writeln('                                                                                                       ');
    writeln('                   p - To play        h - For help          esc - To quit                              ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('-------------------------------------------------------------------------------------------------------');
    END;

  //--------------------------------HUD stuff---------------------------------//
  PROCEDURE display_hud;
    PROCEDURE display_hud_main;
      BEGIN
      If p.hp< p.hp_max*0.2 THEN TextColor(lightred)else TextColor(LightBlue);//llow hp
      writeln('-------------------------------------------------------------------------------------------------------');
      _write_(si1,p.name,sf1);   _write_(si1,'LVL: '+ inttostr(lvl),sf1);   _write_(0,'   EXP: '+ inttostr(p.exp)+'/'+inttostr(exp_max),50); writeln(' ');
      _write_(si1,'HP: '+ inttostr(p.hp)+'/'+inttostr(p.hp_max),sf1);    writeln;
      _write_(si1,'Atk: '+ inttostr(p.atk),sf1);                       writeln;
      writeln('');
      _write_(si1,'Gold: '+inttostr(p.gold),70);         write('Explored: ');   _write_(0,inttostr(explored)+' %',6); writeln(' Depth: ', depth);
      writeln('-------------------------------------------------------------------------------------------------------');
      END;
    PROCEDURE display_hud_inv;
      BEGIN
      If p.hp< p.hp_max*0.2 THEN TextColor(lightred)else TextColor(LightBlue);//llow hp
      writeln('-------------------------------------------------------------------------------------------------------');
      _write_(3,'INVETORY:',0);_write_(3 ,'1. '+inv[1],20);  _write_(0,'2. '+inv[2],30);_write_(0,'EQUIPPED:',0);_write_(3 ,'Weapon: '+equipped[W],25);writeln;
                               _write_(15,'3. '+inv[3],20);  _write_(0,'4. '+inv[4],30);                        _write_(12 ,'Armor : '+equipped[A],25);writeln;
                               _write_(15,'5. '+inv[5],20);  _write_(0,'6. '+inv[6],30);writeln;
                               _write_(15,'7. '+inv[7],20);  _write_(0,'8. '+inv[8],30);writeln;
      _write_(si1,'Gold: '+inttostr(p.gold),70); write('Explored: ');   _write_(0,inttostr(explored)+' %',6); writeln(' Depth: ', depth);
      writeln('-------------------------------------------------------------------------------------------------------');
      END;
    BEGIN
    case hud_at of
      inventory:display_hud_inv;
      main:display_hud_main;
    END;
    END;

  PROCEDURE display_enemy_stats;
    BEGIN
    If e.hp< e.hp_max*0.2 THEN TextColor(lightred)else TextColor(LightBlue);//Low hp
    writeln('--------------------------------------------------------------------------------------------------------');
    _write_(si1,e.name,sf1);                   writeln();
    _write_(si1,'HP: '+ inttostr(e.hp)+'/'+inttostr(e.hp_max),sf1);writeln();
    _write_(si1,'Atk: '+ inttostr(e.atk),sf1);writeln();
    writeln('--------------------------------------------------------------------------------------------------------');
    END;

  //--------------------------------EVENTS------------------------------------//
  PROCEDURE display_fight;
    BEGIN
    case depth of
    0:
      BEGIN
      display_enemy_stats;
      TextColor(green);
      writeln('   .    .          .          .    .       .    .                   .                 .        .       ');
      writeln('      .      .                 .                             .                       .                .');
      writeln('                 .                      .                       .         .                 .          ');
      writeln('      .                  .                 .               .                            .              ');
      writeln('   .             .    .           .     .           .          .      .        .     .                 ');
      writeln('  .   .    .oo689o   .oo689ou.  .     .   . .    .    .     .   .oo689ou.    .     .oo689ou.    .   .  ');
      writeln('.   .oo689ou.PS96889ou9PS9688oo689ou.  .  .    .   .      .oo6898O9P.oo689ou.oo689ou.PS968.oo689ou.    ');
      writeln(' . 98O9PS9689PD8O9S9689PD8O98O9PS9689P .   .  .  .   .  98O9PSS99698O9PS9689P8O9PS9689PD8O98O9PS9689P .');
      writeln('. S9968D8O88698SD8O886 98S9968D8O88686.  .   .   .    . S9968D`9O8S9968D8O886988D8O8869898S9968D8O886  ');
      writeln('  `9O89S9889 |&|`S9889  |&|`9O89S9889  .   .  .     .    .`9O89S98``+9+89S988O89S9888|&|9878O89S9889  .');
      writeln(' . . ``|&|   |%|  |&|   |%|   ``|&|     .   .   .    .    .   |&|   |%|`|&| ``|&|    |%|   ``|&|.   .  ');
      writeln('_______|%|___|%|__|%|___|%|_____|%|___________________________|%|___|%|_|%|___|%|____|%|_____|%|_______');
      writeln('  ,,   |%|  .:%:. |%|  .:%:.    |%|  ,,      /     /      ,,  |%|  .:%:.|%|   |%|   .:%:.    |%|     ,,');
      writeln(',,    .:%:.   ,, .:%:.     ,,  .:%:.    ,,  /     /   ,,     .:%:.  ,, .:%:.   ,,   ,,      .:%:. ,,   ');
      writeln('   ,,     ,,    ,,     ,,          ,,      /     / ,,      ,,     ,,          ,,           ,,         ,');
      END;
    1:
      BEGIN
      display_enemy_stats;
      TextColor(brown);
      writeln('_______________________________________________________________________________________________________');
      writeln('___________________________________________._____________________._____________________________________');
      writeln('_______________________________________.   |                     |  .__________________________________');
      writeln('___________________________________.       |                     |      .______________________________');
      writeln('________________________________.          |                     |         .___________________________');
      writeln('_____________________________.             |                     |            .________________________');
      writeln('__________________________.                |                     |              .______________________');
      writeln('________________________.                  |                     |         _( _  ._____________________');
      writeln('                        |                  |                     |         \ )/  |                     ');
      writeln('                        |                  |                     |          ||   |                     ');
      writeln('                        |                  |_____________________|          ||=  |                     ');
      writeln('                        |                .///////||||||||||\\\\\\\\.        ||   |                     ');
      writeln('                        |           . //////////||||||||||||\\\\\\\\\\\.         |                     ');
      writeln('                        |     .//////////////||||||||||||||||||\\\\\\\\\\\\.     |                     ');
      writeln('                        |.////////////////||||||||||||||||||||||||\\\\\\\\\\\\\\.|                     ');
        END
        END;
    display_hud
    END;
  PROCEDURE display_boss;
    BEGIN//alive
      IF e.hp>0 then
      BEGIN
      display_enemy_stats;
      TextColor(white);
      writeln('             /                  /             ___,@              \                    \     \   _   |  ');
      writeln('|  _     |  |           |      /   ((        /  <                 \     |      |       |     |   | _   ');
      writeln('      |    /      _  |        /     ))  ,_  /    \  _,             \         |          \     \        ');
      writeln(' _      _ /       |   _      |     ((    \`/______\`/               |     _       _      \     \  |    ');
      writeln('     |   |    |      _   |   |   ,_(*).  |;(o\  /o);|               |   _    |            |     \  _   ');
      writeln('|  _    /        |           |    \___ \ \/\   >  /\/               |             |        \     | _   ');
      writeln('       /       |     |  _    |        \/\   \ __ /                  |     |    _            \    |   | ');
      writeln('______|           _          |         \ \___)--(__                 |            _   |       \   |_____');
      writeln('      |       _        |     |          \___  ()  _ \               |   |      |       _      | /      ');
      writeln('      |______________________|_____________/  ()  \| |______________|_________________________|/       ');
      writeln('          ,,            ,,  /             /   ()   \ |             /        ,,       ,,           ,,   ');
      writeln(' ,,     ,,        ,,   ,,  /             |-.______.-|)            /   ,,        ,,    ,,   ,           ');
      writeln('     ,,         ,,        /            _    |_||_|    _          /       ,,                  ,,        ');
      writeln('  ,,      ,,         ,,  /            (@____) || (____@)        /  ,,        ,,       ,,               ');
      writeln('                        /              \______||______/        /       ,,        ,,             ,,     ');
      END//alive
    else//DEATH
      BEGIN
      display_enemy_stats;
      TextColor(white);
      writeln('             /                  /             ___,@              \                    \     \   _   |  ');
      writeln('|  _     |  |           |      /             /  <                 \     |      |       |     |   | _   ');
      writeln('      |    /      _  |        /         ,_  /    \  _,             \         |          \     \        ');
      writeln(' _      _ /       |   _      |           \`/______\`/               |     _       _      \     \  |    ');
      writeln('     |   |    |      _   |   |   ,____.  |;|x    x|;|               |   _    |            |     \  _   ');
      writeln('|  _    /        |           |    \___ \ \/\   >  /\/               |             |        \     | _   ');
      writeln('       /       |     |  _    |        \/\   \  o /                  |     |    _            \    |   | ');
      writeln('______|           _          |         \ \___)--(__                 |            _   |       \   |_____');
      writeln('      |       _        |     |          \___  ()  _ \               |   |      |       _      | /      ');
      writeln('      |______________________|_____________/  ()  \| |______________|_________________________|/       ');
      writeln('          ,,            ,,  /             /   ()   \ |             /        ,,       ,,           ,,   ');
      writeln(' ,,     ,,        ,,   ,,  /             |-.______.-|)            /   ,,        ,,    ,,   ,           ');
      writeln('     ,,         ,,        /            _    |_||_|    _          /       ,,                  ,,        ');
      writeln('  ,,      ,,         ,,  /            (@____) || (____@)        /  ,,        ,,       ,,               ');
      writeln('                           /              \______||______/        /       ,,        ,,             ,,     ');
      END;
    display_hud
    END;

  PROCEDURE display_fountain;
    BEGIN
    writeln('-------------------------------------------------------------------------------------------------------');
    case depth of
    0:
      BEGIN
      TextColor(white);
      writeln('   .    .          .          .    .       .    .                   .                 .        .     ');
      writeln('      .      .                 .                             .                       .              .');
      writeln('                 .                      .                       .         .                 .        ');
      writeln('      .                  .                 .               .                            .            ');
      writeln('   .             .    .           .     .           .          .      .        .     .               ');
      writeln('        .    .                  .    .           .  .  .           .          .               .     .');
      writeln('        .          .                            . . : . .               .      .        .     .      ')
      writeln('        .       .          .    .             _.___.:.___._     .        .           .            .  ')
      writeln('                                             (_____________)                                         ');
      writeln('_________________________________________________(     )_____________________________________________');
      writeln('   ,,         ,,       ,,             ,,     /   _)   (_   \     ,,                 ,,           ,,  ');
      writeln('        ,,          ,,           ,,         |   (_______)   |          ,,                    ,,      ');
      writeln(' ,,             ,,          ,,          ,,   \             /              ,,           ,,            ');
      writeln('                        ,,          ,,        |           |       ,,            ,,               ,,  ');
      writeln('        ,,                                    |           |                                   ,,     ');
      END;
    1:
      BEGIN
      TextColor(brown);
      writeln('                                                                                                     ');
      writeln('                                                                                                     ');
      writeln('                                     _________________________________                               ');
      writeln('                                    |                                 |                              ');
      writeln('                                    |            .  .  .              |                              ');
      writeln('                                    |           . . : . .             |                              ');
      writeln('                                    |         _.___.:.___._           |                              ');
      writeln('                                    |        (_____________)          |                              ');
      writeln('____________________________________|____________(     )______________|______________________________');
      writeln('                                             /   _)   (_   \                                         ');
      writeln('                                            |   (_______)   |                                        ');
      writeln('                                             \             /                                         ');
      writeln('                                              |           |                                          ');
      writeln('                                              |           |                                          ');
      END;
      END;
    display_hud
    END;
  //--------------------------------MISC--------------------------------------//
  PROCEDURE display_game_over;
    BEGIN
    TextColor(lightred);
    writeln('-------------------------------------------------------------------------------------------------------');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                       ____     _     __  __  _____    ___ __     __ _____  ____                       ');
    writeln('                      / ___|   / \   |  \/  || ____|  / _ \\ \   / /| ____||  _ \                      ');
    writeln('                     | |  _   / _ \  | |\/| ||  _|   | | | |\ \ / / |  _|  | |_) |                     ');
    writeln('                     | |_| | / ___ \ | |  | || |___  | |_| | \ V /  | |___ |  _ <                      ');
    writeln('                      \____|/_/   \_\|_|  |_||_____|  \___/   \_/   |_____||_| \_\o                    ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                         Press any key to quit.                                        ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('Explored: '+inttostr(explored)+'% of Depth: ',depth+'                                                  ');
    writeln('-------------------------------------------------------------------------------------------------------');
    END;
  BEGIN
    ClrScr;
    if CompareText(room,'Logo') = 0 then
      display_logo;
    else if CompareText(room,'main_menu') = 0 then
      display_main_menu;
    else if CompareText(room,'fight') = 0 then
      display_fight;
    else if CompareText(room,'fountain') = 0 then
      display_fountain;
    else if CompareText(room,'boss') = 0 then
      display_boss;
    else if CompareText(room,'game_over') = 0 then
      display_game_over;
    END;

//---------------------------->UTILILES<-----------------------------------------
PROCEDURE write_until_Keypressed(s:string);
  var aux:string; i:integer;
  BEGIN
  i:=1;
  repeat
    aux:=s;
    Delete(aux,i,length(s));
    Delay(25);
    DISPLAY;
    write(aux);
    i:=i+1
    until (i > length(s)) or keypressed;
  DISPLAY;
  if not(i > length(s)) then aux:=lowercase(ReadKey);
  write(s);
  repeat until lowercase(ReadKey)<>char(0);
  DISPLAY
  END;//escribe hasta apretar cualquier tecla(menos esc)

FUNCTION between(a,b,c:integer):boolean;
  BEGIN
  between:=(a<=b)AND(b<c)
  END;//a<=b<c?

FUNCTION y_or_n_boss:boolean;
  BEGIN
  write_until_Keypressed('You can fight the boss and move deeper into the dungeon or keep exploring what is left.');
  write('Do you wan''t to cotinue exploring?(y/n)');
  repeat
    imp:= lowercase(ReadKey);
    case imp of
      'y':
        BEGIN
        y_or_n_boss:= FALSE;
        more:=more + 20;
        exit
        END;
      'n':
        BEGIN
        y_or_n_boss:= TRUE;
        exit
        END;
      END
  until FALSE
  END;

//---------------------------->used in multiples events<------------------------
PROCEDURE player_normal_atk;
  BEGIN
  e.hp:=e.hp - p.atk;
  write_until_Keypressed('Dmg dealt: '+inttostr(p.atk)+'.');//msg
  END;

PROCEDURE enemy_normal_atk;
  BEGIN
  if e.hp >0 then
    BEGIN
    p.hp:= p.hp - e.atk;
    write_until_Keypressed('Dmg recived: '+inttostr(e.atk)+ '.')
    END
  END;

PROCEDURE use;
  VAR num:integer;
  PROCEDURE use_inv;
    BEGIN
    If CompareText(inv[num],'Empty') = 0 then
      write_until_Keypressed('Nothing here.');

    If CompareText(inv[num],'HP potion') = 0 then
      BEGIN
      p.hp:= p.hp + 25;
      if p.hp > p.hp_max then p.hp:=p.hp_max;
      inv[num]:= 'Empty';
      write_until_Keypressed('You drink the potion and it restores 25 hp.');
      END;

    If CompareText(inv[num],'Dull knife') = 0 then
      BEGIN
      write_until_Keypressed('You w.');
      END;
    END;
  BEGIN
  num:= ord(imp)-48;//combertir imp a integer
  case hud_at of
  inventory:
    use_inv;
  else
    write_until_Keypressed(error1)
    END;
  END;

//------------------------------->EVENTS<---------------------------------------
PROCEDURE fight(area_id:integer);
  PROCEDURE enemy_find;
    PROCEDURE enemy_set(na:string;hp,at,ex,go:integer);
      VAR tness:real;
      BEGIN
      tness:=0.75+random*0.5;
      e.name:= na + ' ' + FloatToStrF(tness, ffGeneral,3, 0);
      e.hp_max:= round(hp*tness);e.hp:=e.hp_max;
      e.atk:= round(at*tness);
      e.exp:= round(ex*tness);
      e.gold:= round(go*tness)
      END;
    BEGIN
    chance:=round(random*100);
    case area_id of
      0:
        BEGIN
        if between(0,chance,20) THEN
          enemy_set('Hairy Bear',17,3,12,15);
        if between(20,chance,70) THEN
          enemy_set('Lost Bandit',10,3,8,4);
        if between(30,chance,100) THEN
          enemy_set('Rabid Bunny',7,2,2,1);
        END;
      1:
        BEGIN
        if between(0,chance,20) THEN
          enemy_set('Spooky Scary Skeleton',30,10,22,34);
        if between(20,chance,70) THEN
          enemy_set('Average Rat',20,6,17,22);
        if between(30,chance,100) THEN
          enemy_set('Tiny Slime',14,3,9,14);
        END;
      else
        write_until_Keypressed('ERROR: zona no existente.')
      END
    END;

  FUNCTION player_run:boolean;
    VAR aux:boolean;
    BEGIN
    chance:=round(random*100);
    aux:= chance<=35;
    if aux then
      BEGIN
      write_until_Keypressed('Got away safely!')
      END
    else
      BEGIN
      write_until_Keypressed('Couldn'+char(39)+'t get away!')
      END;
      player_run:= aux;
    END;

  PROCEDURE enemy_drops;
    BEGIN
    write_until_Keypressed(e.name+' has perished.');
    p.exp := p.exp + e.exp;
    p.gold:= p.gold+ e.gold;
    write_until_Keypressed('Exp won: '+ inttostr(e.exp)+'. Gold won: '+inttostr(e.gold)+'.')
    END;

  BEGIN
    room:='fight';
    enemy_find;
    write_until_Keypressed(e.name+' attacks!');
    REPEAT
      imp:=lowercase(ReadKey);
      case imp of
        'a':
          BEGIN
          player_normal_atk;
          enemy_normal_atk
          END;
        'r':if player_run then exit else enemy_normal_atk;
        'q':p.hp:=0;
        'i':
          BEGIN
           if hud_at = inventory then hud_at:=main else hud_at:=inventory;
           DISPLAY;
           END;
        '1','2','3','4','5','6','7','8':
          BEGIN
          use;
          END;
        else//invalid
          BEGIN
          write_until_Keypressed(error1)
          END
        END;
      until (e.hp < 1) OR (p.hp < 1);
    if p.hp>0 then
    enemy_drops
    else
      BEGIN
      write_until_Keypressed('You can''t take it any more, everything fades to black...')
      END
    END;

PROCEDURE fight_boss(area_id:integer);
  PROCEDURE boss_encounter;
    PROCEDURE boss_set(na:string;hp,at,ex,go:integer);
      VAR tness:real;
      BEGIN
      tness:=1;
      e.name:= na;
      e.hp_max:= round(hp*tness);e.hp:=e.hp_max;
      e.atk:= round(at*tness);
      e.exp:= round(ex*tness);
      e.gold:= round(go*tness)
      END;
    BEGIN
    case area_id of
      0:boss_set('Angry Elf',50,5,100,175);
      else
        write_until_Keypressed('ERROR: non existent zone.')
      END
    END;

  PROCEDURE boss_drops;
    BEGIN
    write_until_Keypressed(e.name+' has been deafeated.');
    p.exp := p.exp + e.exp;
    p.gold:= p.gold+ e.gold;
    write_until_Keypressed('Exp won: '+ inttostr(e.exp)+'. Gold won: '+inttostr(e.gold)+'.');
    depth:= depth+1;
    explored:= 0
    END;

  BEGIN
    room:='boss';
    boss_encounter;
    write_until_Keypressed(e.name+' apears!');
    REPEAT
      imp:=lowercase(ReadKey);
      case imp of
        'a':
          BEGIN
          player_normal_atk;
          enemy_normal_atk
          END;
        'r':write_until_Keypressed('You sense that you won''t be able to escape, so you don''t even try.');
        'q':p.hp:=0;
        'i':BEGIN
          if hud_at = inventory then hud_at:=main else hud_at:=inventory;
          DISPLAY;
          END;
        else//invalid
          write_until_Keypressed(error1)
        END;
      until (e.hp < 1) OR (p.hp < 1);
    if p.hp>0 then
    boss_drops
    else
      BEGIN
      write_until_Keypressed('You can''t take it any more, everything fades to black...')
      END
    END;

PROCEDURE fountain;
  BEGIN
  room:='fountain';
  write_until_Keypressed('You find a fountain.');
  p.hp:=p.hp+ p.hp_max div 3;
  if p.hp > p.hp_max then
    p.hp:= p.hp_max;
  write_until_Keypressed('Drinking from the fountain fills you with determination.');
  END;

PROCEDURE shop;
  PROCEDURE buy(s:string;val:integer);
    BEGIN
    i:=1;
    WHILE (i <= inv_max) AND (inv[i] <> 'Empty') do
      i:=i+1;
    If i <= inv_max then
      BEGIN
      inv[i] := s;
      p.gold := p.gold - val;
      write_until_Keypressed('Bought '+ s +' for '+ inttostr(val)+' gold.')
      END
    else
    write_until_Keypressed('You are carrying too much.');
    END;
  BEGIN
    write_until_Keypressed('You found a shop!');
    write_until_Keypressed('p -> HP potion - 20 gold | s-> Dull knife- 50 gold | x to leave');
    REPEAT
      imp:=lowercase(ReadKey);
      case imp of
        'p':
          buy('HP potion',20);
        's':
          buy('Dull knife',50);
        'x':
          BEGIN
          write_until_Keypressed('You left the shop.');
          exit;
          END;
        'i':
          BEGIN
          if hud_at = inventory then hud_at:=main else hud_at:=inventory;
          DISPLAY;
          END;
        else//invalid
          write_until_Keypressed(error1)
          write_until_Keypressed('p -> HP potion - 20 gold | s-> Dull knife- 50 gold | x to leave');
        END;
      UNTIl p.hp<1
  END;

PROCEDURE lvlup;
  var aux,stat_points:integer;
  PROCEDURE statup(var a:integer;b:integer);
    BEGIN
    a:= a + b;
    stat_points:=stat_points-1
    END;
  BEGIN
  aux:= p.exp - exp_max;
  lvl:=lvl+1;
  exp_max:=round((5*(sqr(lvl+2)*(lvl+2)))/4);
  p.exp:=aux;
  write_until_Keypressed('Level up!');
  stat_points:=3;
  REPEAT
    DISPLAY;
    writeln('Upgrade points remaining: '+inttostr(stat_points));
    write('K - upgrades attack / H - upgrades hp');
    imp:= lowercase(ReadKey);
    case imp of
      'k': statup(p.atk,1);
      'h':
        BEGIN
        statup(p.hp_max,p.hp_max div 5);
        p.hp:=p.hp+ p.hp_max div 6
        END;
      END
    until stat_points<1
  END;

//------------------------------->MAIN<-----------------------------------------
BEGIN
  BEGIN//inicializacion
    RANDOMIZE;
    TextColor(LightBlue);
    Highvideo;

    for i:=1 to inv_max do
      inv[i]:='Empty';
    equipped[W]:='Stick';
    equipped[A]:='Cloth';
    hud_at:=main;
    more:=0;
    depth:=0;
    explored:=0;
    p.gold:=999;
    p.hp_max:=50;
    p.hp:=p.hp_max;
    lvl:=1;
    p.exp:=0;
    exp_max:=21;
    p.atk:=5;
    END;

  room:='Logo';
    REPEAT
      DISPLAY;
      imp:=lowercase(lowercase(ReadKey));
      if imp <> 's' then //error msg
        BEGIN
        write_until_Keypressed(error1)
        END
      until imp = 's';

  room:='main_menu';
    REPEAT
      DISPLAY;
      imp:=lowercase(ReadKey);
      case imp of//options and error msg
        'p':;
        'h':write_until_Keypressed('Inside the game: a-attack / r-run / q-suicide.');
        char(27):exit
        else
        write_until_Keypressed(error1)
        END
      until imp='p';

  write_until_Keypressed('Name your character.');
    readln(p.name);
    WHILE (length(p.name) >15) do
      BEGIN
      DISPLAY;
      write_until_Keypressed('Name too long.');
      readln(p.name)
      END;//valid name pls.

  repeat//<---------------------------------------EVENTS
    if p.exp >= exp_max THEN lvlup;
    if (explored >= 100) OR ((explored > (45 + round(random*15) +more)) AND ((y_or_n_boss)))  then
    BEGIN
      IF explored>100 then explored := 100;
      fight_boss(depth);
      END
    else
    BEGIN
      wherenext:=round(random*100);
      if      between(0 ,wherenext,85 ) THEN fight(depth);
      else if between(85,wherenext,95 ) THEN fountain;
      else if between(95,wherenext,100) THEN shop;
      explored:= explored + 4 + round(random);
    END;
    until p.hp< 1;

  room:='game_over';
    DISPLAY;
    repeat until keypressed
    END.//Main
