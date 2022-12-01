# 全体
```mermaid
flowchart TB
Riverpod

subgraph View
direction TB
WeatherView((WeatherView))
WeatherForecastPanel((WeatherForecastPanel))

end

View(View)
UseCase(UseCase)
Repository(Repository)
DataSource(DataSource)
View --> UseCase
UseCase --> View
Repository --> UseCase
UseCase --> Repository
DataSource --> Repository
Repository --> DataSource
```

- View

  - 取得した天気情報の表示や、エラー時にダイアログを表示。
YumemiWeather APIの実行ボタンのUIなどを提供。

- UseCase

  - 取得結果に応じて、各種Providerの更新。

- Repository

  - DataSourceをResultクラスに変換。

- DataSource

  - Weatherを取得するロジックを提供。
  - YumemiWeatherErrorのハンドリング。

## View
- 取得した天気情報の表示したり、エラー時にダイアログを表示させたりする。
### WeatherView
- 画面全体
- WeatherViewUiStateで、「初期 or エラー」を管理
### WeatherForecastPanel
- WeatherViewのコンポーネント
- 以下のUIを提供し、各々状態を管理する。
  - Temperature
  - WeatherImagePanel

## UseCase
- 取得結果に応じて各種Providerの更新。
### 取得成功時
- WeatherForecastPanelを取得結果で更新。
### 取得失敗時
- WeatherViewUiStateを「エラー状態」に更新。
## Repository
- DataSourceをResultクラスに変換。

## DataSource
- Weatherを取得するロジックを提供。
- YumemiWeatherErrorのハンドリング。
- API通信を実行する。
- YumemiWeatherErrorをアプリ内エラークラス（AppError）に変換。

## Riverpodの依存関係
```mermaid
flowchart TB
    subgraph riverpod
        direction TB
        style riverpod fill:transparent;
        style riverpod stroke: none;
        style riverpod color:transparent;
        WeatherView((WeatherView));
        weatherViewUiStateProvider --> WeatherView;
        fetchWeatherUseCaseProvider -.-> WeatherView;
        WeatherImagePanel((WeatherImagePanel));
        weatherImagePanelStateProvider ====> WeatherImagePanel;
        MinTemperatureLabel((MinTemperatureLabel));
        minTemperatureUiStateProvider ====> MinTemperatureLabel;
        MaxTemperatureLabel((MaxTemperatureLabel));
        maxTemperatureUiStateProvider ====> MaxTemperatureLabel;
        weatherRepositoryProvider[[weatherRepositoryProvider]];
        weatherDataSourceProvider ==> weatherRepositoryProvider;
        weatherDataSourceProvider[[weatherDataSourceProvider]];
        fetchWeatherUseCaseProvider[[fetchWeatherUseCaseProvider]];
        weatherRepositoryProvider ==> fetchWeatherUseCaseProvider;
        weatherRequestStateProvider ==> fetchWeatherUseCaseProvider;
        weatherRequestStateProvider[[weatherRequestStateProvider]];
        weatherViewUiStateProvider[[weatherViewUiStateProvider]];
        weatherImagePanelStateProvider[[weatherImagePanelStateProvider]];
        minTemperatureUiStateProvider[[minTemperatureUiStateProvider]];
        maxTemperatureUiStateProvider[[maxTemperatureUiStateProvider]];
    end
    subgraph define
        style define fill:transparent;
        style define stroke: none;
        style define color:transparent;
        direction LR;
        subgraph Type
            direction TB;
            ConsumerWidget((widget));
            Provider[[provider]];
        end
        subgraph Arrows
            direction LR;
            start1[ ] -..->|read| stop1[ ]
            style start1 height:0px;
            style stop1 height:0px;
            start2[ ] --->|listen| stop2[ ]
            style start2 height:0px;
            style stop2 height:0px; 
            start3[ ] ===>|watch| stop3[ ]
            style start3 height:0px;
            style stop3 height:0px; 
        end
    end 

```