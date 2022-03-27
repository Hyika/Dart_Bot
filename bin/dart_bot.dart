import "package:nyxx/nyxx.dart"; // nyxx 패키지 출처: https://github.com/nyxx-discord/nyxx
import "Option_Bot.dart";
import "construction_bot.dart";

void main() {
  Options botSettings = Options(); // Option_Bot에 있는 내용을 가져옵니다.
  CommandAll botConstruct = CommandAll();
  // 새로운 봇 인스턴스 생성
  final bot = NyxxFactory.createNyxxWebsocket(
      botSettings.token, GatewayIntents.allUnprivileged)
    ..registerPlugin(Logging()) // Default logging plugin
    ..registerPlugin(
        CliIntegration()) // Cli integration for nyxx allows stopping application via SIGTERM and SIGKILl
    ..registerPlugin(
        IgnoreExceptions()) // Plugin that handles uncaught exceptions that may occur
    ..connect();

  // Ready 이벤트를 출력합니다. 봇이 모든 샤드에 연결될 때 호출됩니다. 캐시는 비어 있거나 불완전하지 않을 수 있습니다.
  bot.eventsWs.onReady.listen((e) {
    print("봇이 준비되었어요!");
  });

// 명령어 목록

  bot.eventsWs.onMessageReceived.listen((e) {
    botConstruct.userCommandPing(e, bot); // ping
    botConstruct.userCommandDisconnect(e, bot); // disconnect
    botConstruct.userCommandHelp(e, bot); // help
  });
}
