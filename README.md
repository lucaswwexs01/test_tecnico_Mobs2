# Telemetria App - MOBS2

## O que é este app?

Este é um aplicativo de telemetria que coleta dados do seu celular em tempo real. Basicamente, ele mostra onde você está no mapa, quão rápido você está se movendo, e detecta quando você acelera ou muda de direção. É como ter um painel de carro no seu celular, mas usando os sensores do próprio dispositivo.

## O que o app faz?

**Mostra sua localização no mapa**: Usa o GPS do celular para mostrar exatamente onde você está em um mapa do Google Maps.

**Mede sua velocidade**: Calcula quão rápido você está se movendo baseado no GPS.

**Detecta movimento**: Usa o acelerômetro do celular para saber quando você está acelerando ou freando.

**Mostra direção**: Usa a bússola digital para indicar para onde você está olhando (Norte, Sul, Leste, Oeste).

**Interface simples**: Tudo isso em uma tela limpa e fácil de usar.

## Como funciona?

O app funciona de forma bem simples:

1. **Você abre o app** e ele pede permissão para usar o GPS
2. **Você autoriza** e ele começa a mostrar sua localização no mapa
3. **Você clica no botão verde** para iniciar a coleta de dados
4. **O app começa a coletar** informações dos sensores do celular
5. **Você vê tudo em tempo real** na tela: mapa, velocidade, aceleração e direção

É isso. Não tem complicação. O app faz tudo automaticamente depois que você autoriza.

## Tecnologias usadas

O app foi feito em Flutter, usa algumas bibliotecas prontas para:

- Mostrar mapas do Google
- Pegar dados do GPS
- Ler os sensores do celular (acelerômetro, bússola)
- Pedir permissões ao usuário

## Como rodar o projeto

### O que você precisa ter instalado

- Flutter (versão 3.9.2 ou mais nova)
- Android Studio ou VS Code com a extensão do Flutter
- Um celular ou emulador para testar

### Passo a passo

1. **Baixe o código**
   ```bash
   git clone https://github.com/lucaswwexs01/test_tecnico_Mobs2.git
   cd telemetry_app
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Configure as permissões do GPS**
   
   No Android, você precisa adicionar estas linhas no arquivo `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
   ```

   No iPhone, adicione no arquivo `ios/Runner/Info.plist`:
   ```xml
   <key>NSLocationWhenInUseUsageDescription</key>
   <string>Este app precisa de acesso à localização para telemetria</string>
   ```

4. **Configure o Google Maps**
   
   Você precisa de uma chave da API do Google Maps. Depois de conseguir, adicione ela nos arquivos:
   - `android/app/src/main/AndroidManifest.xml`
   - `ios/Runner/AppDelegate.swift`

5. **Rode o app**
   ```bash
   flutter run
   ```

## Como testar o app

Depois que você conseguir rodar o projeto, você pode testar se está funcionando:

```bash
# Roda todos os testes
flutter test

# Verifica se o código está ok
flutter analyze
```

## Deploy automático

O projeto está configurado para fazer deploy automático no Codemagic. Isso significa que quando você faz uma mudança no código, ele automaticamente:

- Roda os testes
- Verifica se o código está bom
- Compila o app para iPhone
- Envia para o TestFlight (que é onde você testa apps do iPhone antes de publicar)

## Privacidade

O app não envia nenhum dado seu para lugar nenhum. Tudo fica no seu celular. Ele só usa:

- GPS para saber onde você está
- Sensores para medir movimento
- Permissões básicas do sistema

Nada disso sai do seu dispositivo.

## Agradecimentos

Quero agradecer à MOBS2 pela oportunidade de participar deste processo seletivo. Foi muito legal desenvolver este app de telemetria e aprender coisas novas no processo.


### Tecnologias que usei:

- Flutter para fazer o app funcionar no Android e iPhone
- Google Maps para mostrar onde você está
- Geolocator para pegar dados do GPS
- Sensors Plus para ler os sensores do celular
- Provider para gerenciar os dados na tela
- Codemagic para fazer deploy automático

Foi uma experiência muito boa e me ajudou a crescer como desenvolvedor. Obrigado pela confiança!

---<img width="379" height="883" alt="image" src="https://github.com/user-attachments/assets/e268ffaa-20d0-4fc5-afcc-068051028a16" />


*Desenvolvido para MOBS2*
