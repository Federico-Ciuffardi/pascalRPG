unit GRAPHICS;
interface
uses Crt,sysutils

//draws the hole screen
procedure draw(s:string);
//space(j1 times)string space (j-length of the string))
procedure writeCentered(j1:integer;s:string;j2:integer);
//writes preatty and waits for user input to continue
procedure write_until_Keypressed(s:string);
implementation

procedure write_until_Keypressed(s:string);
  var aux:string; i:integer;
  begin
  i:=1;
  repeat
    aux:=s;
    Delete(aux,i,length(s));
    Delay(25);
    DISPLAY;
    write(aux);
    i:=i+1
  until (i > length(s)) or keypressed;
  draw;
  if not(i > length(s)) then begin
    aux:=lowercase(ReadKey)
  end;
  write(s);
  repeat until lowercase(ReadKey)<>char(0);
  draw
end;//escribe hasta apretar cualquier tecla(menos esc)

procedure writeCentered(j1:integer;s:string;j2:integer);begin
  for i:= 1 to j1 do begin
    write(' ')
  end;
  write(s);
  for i:= 1 to(j2-length(s)) do begin
    write(' ')
  end
end;

procedure draw;
  procedure displayLogo; begin
    writeln('-------------------------------------------------------------------------------------------------------');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('    _____                                        ___                  _____       _____    _____       ');
    writeln('   /\  __`\                                     /\_ \                /\  _ `\    /\  _ `\ /\  _ `\     ');
    writeln('   \ \ \L\ \   __       ____    ___      __     \//\ \               \ \ \L\ \   \ \ \L\ \\ \ \ \_\    ');
    writeln('    \ \ ,__/ /,__`\    /,,__\  /,___\  /,__`\     \ \ \               \ \ ,  /    \ \ ,__/ \ \ \L_ \   ');
    writeln('     \ \ \/ /\ \L\.\_ /\__, `\/\ \__/ /\ \L\.\_    \_\ \_              \ \ \\ \    \ \ \/   \ \ \/, \  ');
    writeln('      \ \_\ \ \__/.\_\\/\____/\ \____\\ \__/.\_\   /\____\              \ \_\ \_\   \ \_\    \ \____/  ');
    writeln('       \/_/  \/__/\/_/ \/___/  \/____/ \/__/\/_/   \/____/               \/_/\/ /    \/_/     \/___/   ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                        Press "s" to start                                             ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('-------------------------------------------------------------------------------------------------------');
  end;

  procedure display_main_menu; begin
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
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                 Press:                                                                                ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                   p - To play        h - For help          esc - To quit                              ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('                                                                                                       ');
    writeln('-------------------------------------------------------------------------------------------------------');//27
  end;
  //--------------------------------HUD stuff---------------------------------//
  procedure displayHUD;

    procedure displayMainHUD; begin
      if p.hp< p.hp_max*0.2 then begin
        TextColor(lightred)
      end else begin
        TextColor(LightBlue)//llow hp
      end;
      writeln('-------------------------------------------------------------------------------------------------------');
      writeCentered(si1,p.name,sf1);writeCentered(si1,'LVL: '+inttostr(lvl),sf1);writeCentered(0,'   EXP: '+inttostr(p.exp)+'/'+inttostr(exp_max),50);writeln;
      writeCentered(si1,'HP: '+inttostr(p.hp)+'/'+inttostr(p.hp_max),sf1);writeln;
      writeCentered(si1,'Atk: '+inttostr(p.atk),sf1);writeln;
      writeln;
      writeCentered(si1,'Gold: '+inttostr(p.gold),70);write('Explored: ');writeCentered(0,inttostr(explored)+' %',6);writeln(' Depth: ',depth);
      writeln('-------------------------------------------------------------------------------------------------------');//7
    end;

    procedure display_hud_inv;begin
      if p.hp< p.hp_max*0.2 then begin
        TextColor(lightred)
      end else begin
        TextColor(LightBlue)//llow hp
      end;
      writeln('-------------------------------------------------------------------------------------------------------');
      writeCentered(3,'INVETORY:',0);writeCentered(3 ,'1. '+inv[1],20);  writeCentered(0,'2. '+inv[2],30);writeCentered(0,'EQUIPPED:',0);writeCentered(3 ,'Weapon: '+equipped[W],25);writeln;
      writeCentered(15,'3. '+inv[3],20);  writeCentered(0,'4. '+inv[4],30);writeCentered(12 ,'Armor : '+equipped[A],25);writeln;
      writeCentered(15,'5. '+inv[5],20);  writeCentered(0,'6. '+inv[6],30);writeln;
      writeCentered(15,'7. '+inv[7],20);  writeCentered(0,'8. '+inv[8],30);writeln;
      writeCentered(si1,'Gold: '+inttostr(p.gold),70); write('Explored: ');   writeCentered(0,inttostr(explored)+' %',6); writeln(' Depth: ', depth);
      writeln('-------------------------------------------------------------------------------------------------------');//7
    end;

    begin
      case hud_at of
        inventory:display_hud_inv;
        main:display_hud_main;
      end;
    end;

  procedure display_enemy_stats;begin
    if e.hp< e.hp_max*0.2 then begin
      TextColor(lightred)
    end else begin
      TextColor(LightBlue)//Low hp
    end;
    writeln('--------------------------------------------------------------------------------------------------------');
    writeCentered(si1,e.name,sf1);writeln();
    writeCentered(si1,'HP: '+ inttostr(e.hp)+'/'+inttostr(e.hp_max),sf1);writeln();
    writeCentered(si1,'Atk: '+ inttostr(e.atk),sf1);writeln();
    writeln('--------------------------------------------------------------------------------------------------------');//5
  end;

  //--------------------------------EVENTS------------------------------------//
  procedure display_fight; begin
    case depth of
    0:begin
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
      writeln('   ,,     ,,    ,,     ,,          ,,      /     / ,,      ,,     ,,          ,,           ,,         ,');//15
      end;
    1:begin
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
      end
    end;
    display_hud
  end;

  procedure display_boss;begin
    display_enemy_stats;
    if e.hp>0 then begin
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
    end else begin
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
    end;
    display_hud
  end;

  procedure display_fountain;begin
    writeln('-------------------------------------------------------------------------------------------------------');
    case depth of
    0:begin
      TextColor(white);
      writeln('   .    .          .          .    .       .    .                   .                 .        .     ');
      writeln('      .      .                 .                             .                       .              .');
      writeln('                 .                      .                       .         .                 .        ');
      writeln('      .                  .                 .               .                            .            ');
      writeln('   .             .    .           .     .           .          .      .        .     .               ');
      writeln('        .    .                  .    .           .  .  .           .          .               .     .');
      writeln('        .          .                            . . : . .               .      .        .     .      ');
      writeln('        .       .          .    .             _.___.:.___._     .        .           .            .  ');
      writeln('                                             (_____________)                                         ');
      writeln('_________________________________________________(     )_____________________________________________');
      writeln('   ,,         ,,       ,,             ,,     /   _)   (_   \     ,,                 ,,           ,,  ');
      writeln('        ,,          ,,           ,,         |   (_______)   |          ,,                    ,,      ');
      writeln(' ,,             ,,          ,,          ,,   \             /              ,,           ,,            ');
      writeln('                        ,,          ,,        |           |       ,,            ,,               ,,  ');
      writeln('        ,,                                    |           |                                   ,,     ');
      end;
    1:begin
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
      end;
    end;
    display_hud
  end;
  //--------------------------------MISC--------------------------------------//
  procedure display_game_over;begin
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
    writeln('Explored: '+inttostr(explored)+'% of Depth: '+inttostr(depth)+'                                        ');
    writeln('-------------------------------------------------------------------------------------------------------');
  end;
  begin
    ClrScr;
    if CompareText(room,'Logo') = 0 then
      display_logo
    else if CompareText(room,'main_menu') = 0 then
      display_main_menu
    else if CompareText(room,'fight') = 0 then
      display_fight
    else if CompareText(room,'fountain') = 0 then
      display_fountain
    else if CompareText(room,'boss') = 0 then
      display_boss
    else if CompareText(room,'game_over') = 0 then
      display_game_over
    end;
end.

