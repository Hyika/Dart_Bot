import "dart:io";
import "package:nyxx/nyxx.dart";
import 'Option_Bot.dart';

Options botSettings = Options();

// CMD창에 출력할 내용 입력
void console(String msg) {
  print(msg);
}

// help명령어 안 커멘드 종류 출력
String helpMessage(String command) {
  return "${botSettings.commandPrefix}$command";
}

class CommandAll {
  // Command: ping
  void userCommandPing(e, bot) {
    if (e.message.content == botSettings.commandPrefix + "ping") {
      e.message.channel.sendMessage(MessageBuilder.content("얍얍!"));
      console("PingOkSign: 정상적으로 연결되었습니다.");
    }
  }

  // Command: disconnect
  void userCommandDisconnect(e, bot) {
    if (e.message.content == botSettings.commandPrefix + "disconnect") {
      e.message.channel.sendMessage(MessageBuilder.content("바이바이! 즐거웠어요~"));
      console("DisconnectOkSign: 봇이 종료되었습니다.");
      exit(1);
    }
  }

  // Command: help
  void userCommandHelp(e, bot) {
    if (e.message.content == botSettings.commandPrefix + "help") {
      final embed = EmbedBuilder()
        ..title = "명령어 모음집"
        ..description =
            "해당 명령어가 어떤 명령어인지 궁금하시면,\n ${botSettings.commandPrefix}help <command>를 입력해주세요."
        ..addField(content: helpMessage("ping"))
        ..addField(content: helpMessage("disconnect"))
        ..color = DiscordColor.darkButNotBlack;
      console("HelpOkSign");
      e.message.channel.sendMessage(MessageBuilder.content("찾는 명령어가 있으신가요?"));
      e.message.channel.sendMessage(MessageBuilder.embed(embed));
    }
  }
}
